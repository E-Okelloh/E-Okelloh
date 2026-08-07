#!/usr/bin/env bash
# generate-metrics.sh
#
# Regenerates the three GPOS metric panels from the GitHub API:
#   metrics/metrics.svg          account-level statistics
#   metrics/repositories.svg     top repositories by stargazers
#   metrics/languages.svg        language profile of public repositories
#
# Requires: curl, jq
# Auth:     optional GH_TOKEN / GITHUB_TOKEN (avoids rate limits)
#
# Run locally:
#   bash .github/scripts/generate-metrics.sh
#
# Scheduled: .github/workflows/metrics.yml

set -euo pipefail

USER_NAME="${GITHUB_REPOSITORY_OWNER:-E-Okelloh}"
TOKEN="${GH_TOKEN:-${GITHUB_TOKEN:-}}"
API="https://api.github.com"
OUT="metrics"

AUTH=()
if [ -n "$TOKEN" ]; then
  AUTH=(-H "Authorization: Bearer $TOKEN")
fi

mkdir -p "$OUT"

fetch() {
  curl -fsSL "${AUTH[@]}" "$1"
}

user="$(fetch "$API/users/$USER_NAME")"
repos="$(fetch "$API/users/$USER_NAME/repos?per_page=100&sort=updated")"

public_repos="$(jq -r '.public_repos' <<<"$user")"
followers="$(jq -r '.followers' <<<"$user")"
following="$(jq -r '.following' <<<"$user")"
stars="$(jq '[.[] | select(.fork | not) | .stargazers_count] | add // 0' <<<"$repos")"
forks="$(jq '[.[] | select(.fork | not) | .forks_count] | add // 0' <<<"$repos")"

langs_json="$(jq -c '[.[] | select(.fork | not) | (.language // "OTHER")] | group_by(.) | map({ name: .[0], count: length }) | sort_by(-.count, .name) | .[0:6]' <<<"$repos")"
repos_json="$(jq -c '[.[] | select(.fork | not)] | sort_by(-.stargazers_count, .name) | .[0:4]' <<<"$repos")"
lang_total="$(jq '[.[] | .count] | add' <<<"$langs_json")"
lang_max="$(jq '[.[] | .count] | max' <<<"$langs_json")"

SYNC_DATE="$(date -u +%d.%m.%y)"
SYNC_TIME="$(date -u +%H:%M)"
SYNC="$SYNC_DATE $SYNC_TIME"

fmt() {
  sed -E ':a; s/([0-9])([0-9]{3})([^0-9]|$)/\1,\2\3/; ta'
}

esc() {
  sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g'
}

lang_color() {
  case "$1" in
    Rust)       echo "#DEA584" ;;
    TypeScript) echo "#3178C6" ;;
    Python)     echo "#3776AB" ;;
    JavaScript) echo "#F7DF1E" ;;
    Go)         echo "#00ADD8" ;;
    Move)       echo "#7D9AF8" ;;
    HTML)       echo "#E34F26" ;;
    Solidity)   echo "#B8B8B8" ;;
    *)          echo "#8A98B5" ;;
  esac
}

svg_head() {
  local id="$1" h="$2" title="$3" desc="$4"
  cat <<SVG
<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="$h" viewBox="0 0 1200 $h" role="img" preserveAspectRatio="xMidYMid meet" aria-labelledby="${id}-title ${id}-desc">
  <!--
    Component : $id
    Purpose   : generated from the GitHub API by generate-metrics.sh
    Author    : Erick Okello
    Version   : 1.2
    Dependencies : curl, jq
  -->
  <title id="${id}-title">$title</title>
  <desc id="${id}-desc">$desc</desc>
  <style>
    :root {
      --bg: #050816;
      --panel: #0B1020;
      --accent: #00F5FF;
      --text: #F5F7FA;
      --muted: #8A98B5;
      --divider: #1D2638;
      --healthy: #00FF9D;
      --warning: #FFB020;
      --critical: #FF5C5C;
      --font: 'JetBrains Mono', 'IBM Plex Mono', monospace;
    }
    svg { font-family: var(--font); }

    .bg      { fill: var(--bg); }
    .panel   { fill: var(--panel); }
    .text    { fill: var(--text); }
    .muted   { fill: var(--muted); }
    .accent  { fill: var(--accent); }
    .healthy { fill: var(--healthy); }
    .warning { fill: var(--warning); }
    .divider { fill: var(--divider); }
    .stroke-div { stroke: var(--divider); }

    @keyframes load {
      0% { transform: scaleX(0); }
      45% { transform: scaleX(1); }
      55% { transform: scaleX(1); }
      100% { transform: scaleX(0); }
    }
    @keyframes grow { from { transform: scaleX(0); } to { transform: scaleX(1); } }
    .load { transform-box: fill-box; transform-origin: left center; animation: load 3.6s ease-in-out infinite; }
    .grow { transform-box: fill-box; transform-origin: left center; animation: grow 1s ease both; }
  </style>
  <rect class="bg" x="0" y="0" width="1200" height="$h"/>
SVG
}

svg_tail() {
  cat <<SVG
</svg>
SVG
}

# ---------------------------------------------------------------- metrics.svg

{
  svg_head \
    "metrics" 300 \
    "Account metrics" \
    "Account-level GitHub statistics: public repositories, followers, following, total stars, total forks, and data synchronization timestamp."

  cat <<SVG
  <text class="accent" x="48" y="36" font-size="13" letter-spacing="2">// ACCOUNT METRICS</text>

  <g class="metric">
    <rect class="panel stroke-div" x="48" y="56" width="258" height="88" rx="8"/>
    <text class="muted" x="68" y="84" font-size="13">PUBLIC REPOS</text>
    <text class="accent" x="238" y="84" text-anchor="end" font-size="13">API</text>
    <text class="text" x="68" y="122" font-size="20" font-weight="600">$(printf '%s' "$public_repos" | fmt)</text>

    <rect class="panel stroke-div" x="330" y="56" width="258" height="88" rx="8"/>
    <text class="muted" x="350" y="84" font-size="13">FOLLOWERS</text>
    <text class="accent" x="520" y="84" text-anchor="end" font-size="13">API</text>
    <text class="text" x="350" y="122" font-size="20" font-weight="600">$(printf '%s' "$followers" | fmt)</text>

    <rect class="panel stroke-div" x="612" y="56" width="258" height="88" rx="8"/>
    <text class="muted" x="632" y="84" font-size="13">FOLLOWING</text>
    <text class="accent" x="802" y="84" text-anchor="end" font-size="13">API</text>
    <text class="text" x="632" y="122" font-size="20" font-weight="600">$(printf '%s' "$following" | fmt)</text>

    <rect class="panel stroke-div" x="894" y="56" width="258" height="88" rx="8"/>
    <text class="muted" x="914" y="84" font-size="13">TOTAL STARS</text>
    <text class="accent" x="1084" y="84" text-anchor="end" font-size="13">API</text>
    <text class="text" x="914" y="122" font-size="20" font-weight="600">$(printf '%s' "$stars" | fmt)</text>
  </g>

  <text class="muted" x="48" y="200" font-size="13">// TOTAL FORKS $forks</text>
  <text class="muted" x="1152" y="200" text-anchor="end" font-size="13">SOURCE: GITHUB API V3</text>

  <rect class="divider" x="48" y="220" width="1104" height="3" rx="1.5"/>
  <rect class="accent load" x="48" y="220" width="1104" height="3" rx="1.5" opacity="0.8"/>

  <text class="muted" x="48" y="268" font-size="13">DATA SYNCED $SYNC UTC</text>
  <text class="muted" x="1152" y="268" text-anchor="end" font-size="13">SNAPSHOT</text>
SVG

  svg_tail
} > "$OUT/metrics.svg"

# -------------------------------------------------------- repositories.svg

REPO_ROWS=""
row=1
while IFS= read -r r; do
  name="$(jq -r '.name' <<<"$r")"
  desc="$(jq -r 'if .description then .description else "no description available" end' <<<"$r")"
  lang="$(jq -r '.language // "OTHER"' <<<"$r")"
  nstars="$(jq -r '.stargazers_count' <<<"$r")"
  nforks="$(jq -r '.forks_count' <<<"$r")"
  color="$(lang_color "$lang")"

  y="$(printf '%s' "$((120 + (row - 1) * 68))")"
  name="$(printf '%s' "$name" | esc)"
  desc="$(printf '%s' "$desc" | tr -d '\n' | cut -c1-66 | esc)"
  lang="$(printf '%s' "$lang" | esc)"
  nstars_fm="$(printf '%s' "$nstars" | fmt)"
  nforks_fm="$(printf '%s' "$nforks" | fmt)"

  REPO_ROWS="${REPO_ROWS}
    <text class=\"muted\" x=\"84\" y=\"$y\" font-size=\"13\">0${row}</text>
    <text class=\"text\" x=\"128\" y=\"$((y - 8))\" font-size=\"16\">${name}</text>
    <circle cx=\"130\" cy=\"$((y + 12))\" r=\"4\" fill=\"${color}\"/>
    <text class=\"muted\" x=\"146\" y=\"$((y + 16))\" font-size=\"13\">${lang}</text>
    <text class=\"muted\" x=\"1128\" y=\"$((y - 8))\" text-anchor=\"end\" font-size=\"13\">STAR $nstars_fm · FORK $nforks_fm</text>
    <text class=\"muted\" x=\"128\" y=\"$((y + 16))\" font-size=\"13\" opacity=\"0.85\">${desc}</text>"

  if [ "$row" -lt 4 ]; then
    REPO_ROWS="${REPO_ROWS}
    <rect class=\"divider\" x=\"84\" y=\"$((y + 32))\" width=\"1028\" height=\"1\"/>"
  fi

  row=$((row + 1))
done <<< "$(jq -c '.[]' <<<"$repos_json")"

{
  svg_head \
    "repositories" 400 \
    "Top repositories" \
    "Top four repositories sorted by stargazers, excluding forks. Each row shows rank, name, language, description, stars and forks."

  cat <<SVG
  <text class="accent" x="48" y="36" font-size="13" letter-spacing="2">// TOP REPOSITORIES</text>

  <rect class="panel stroke-div" x="48" y="48" width="1104" height="304" rx="8"/>
  <g class="metric">
$REPO_ROWS
  </g>

  <text class="muted" x="48" y="380" font-size="13">// SORTED BY STARGAZERS | NON-FORK ONLY</text>
SVG

  svg_tail
} > "$OUT/repositories.svg"

# ---------------------------------------------------------- languages.svg

LANG_ROWS=""
idx=0
while IFS= read -r l; do
  lname="$(jq -r '.name' <<<"$l")"
  lcount="$(jq -r '.count' <<<"$l")"
  pct="$(awk -v a="$lcount" -v b="$lang_total" 'BEGIN { printf "%.0f", a * 100 / b }')"
  bar="$(awk -v a="$lcount" -v b="$lang_max" 'BEGIN { printf "%.1f", a * 640 / b }')"
  color="$(lang_color "$lname")"

  y="$(printf '%s' "$((84 + idx * 36))")"
  delay="$(awk -v i="$idx" 'BEGIN { printf "%.2f", i * 0.08 }')"
  lname="$(printf '%s' "$lname" | esc)"

  LANG_ROWS="${LANG_ROWS}
    <circle cx=\"72\" cy=\"$((y - 7))\" r=\"4\" fill=\"${color}\"/>
    <text class=\"text\" x=\"88\" y=\"$y\" font-size=\"16\">${lname}</text>
    <text class=\"muted\" x=\"272\" y=\"$y\" text-anchor=\"end\" font-size=\"13\">${pct}%</text>
    <rect class=\"divider\" x=\"300\" y=\"$((y - 10))\" width=\"640\" height=\"6\" rx=\"3\"/>
    <rect class=\"accent grow\" x=\"300\" y=\"$((y - 10))\" width=\"${bar}\" height=\"6\" rx=\"3\" opacity=\"0.85\" style=\"animation-delay:${delay}s\"/>"

  idx=$((idx + 1))
done <<< "$(jq -c '.[]' <<<"$langs_json")"

{
  svg_head \
    "languages" 300 \
    "Language profile" \
    "Distribution of languages across public repositories, computed from GitHub API repository data. Each row shows the language, percentage and a proportional bar."

  cat <<SVG
  <text class="accent" x="48" y="36" font-size="13" letter-spacing="2">// LANGUAGE PROFILE</text>

  <g class="metric">
$LANG_ROWS
  </g>

  <text class="muted" x="48" y="288" font-size="13">// BASED ON PUBLIC REPOSITORIES | N=$lang_total</text>
SVG

  svg_tail
} > "$OUT/languages.svg"

printf 'metrics regenerated: metrics.svg repositories.svg languages.svg (%s UTC)\n' "$SYNC"
