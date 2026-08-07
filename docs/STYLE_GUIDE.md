# GPOS Style Guide

Implementation reference for every SVG in the profile. Apply this guide to new and existing assets.

---

## Brand Identity

| Token | Value |
|-------|-------|
| Name | `ERICK OKELLO` |
| Title | `Financial Infrastructure Engineer` |
| Mission | `Building infrastructure that moves value securely at global scale.` |

All copy derives from or supports these three statements.

---

## Color System

Single accent. Contrast over saturation. Never encode meaning with color alone.

Implemented as CSS custom properties in every asset's `:root` block; presentation
uses the semantic classes. Never hardcode palette hex values (engineering contract §
Color Tokens).

| Token | Hex | Usage |
|-------|-----|-------|
| `--bg` | `#050816` | Canvas behind every asset |
| `--surface` | `#0B1020` | Cards, panels, windows |
| `--text` | `#F5F7FA` | Primary text, values |
| `--text-2` | `#8A98B5` | Captions, labels, secondary data |
| `--accent` | `#00F5FF` | The only accent; routes, highlights, focus |
| `--divider` | `#1D2638` | Lines, strokes, card borders |
| `--ok` | `#00FF9D` | Health, success, live indicators |
| `--warn` | `#FFB020` | Degradation, staging, caution |
| `--crit` | `#FF5C5C` | Failure, errors, terminal close button |

Semantic exception: small language-identity dots in `metrics/*.svg` use the language's canonical color. The paired label always carries the language name in text.

---

## Typography

| Token | Family | Size | Weight |
|-------|--------|------|--------|
| Hero | JetBrains Mono | `56` | 700 |
| Section heading | JetBrains Mono | `24` | 700 |
| Body / value | JetBrains Mono | `16` | 400/600 |
| Caption | IBM Plex Mono | `13` | 400 |

`font-family="'JetBrains Mono','IBM Plex Mono',monospace"` on every text node. SVG assets cannot bundle fonts; fallback is the system monospace stack.

Baseline rules:

- A 60-px "shift" per 100px of height is a good start — tune per asset.
- Keep one baseline per card row; do not mix optical alignment.

---

## Layout

| Token | Value |
|-------|-------|
| Max content width | `1200` viewBox units |
| Side padding | `48` |
| Card radius | `8` |
| Card gap | `24` |
| Rhythm | multiples of `8`: 8 · 16 · 24 · 32 · 48 · 64 |

Standard card grid: 4 columns of `258` (total `1104`), or 3 columns of `352`.

---

## Motion Language

CSS keyframes inside a `<style>` block. No SMIL unless unavoidable. No JavaScript, ever.

### Allowed

- `@keyframes pulse` — status dots (opacity)
- `@keyframes flow` — packet dash movement (`stroke-dashoffset`)
- `@keyframes draw` — sparkline reveal
- `@keyframes load` — progress sweep via `scaleX`
- `@keyframes blink` — cursor (step-end)
- `@keyframes grow` — one-shot bar fill (bars in `languages.svg`)

For `scaleX` animations always set:

```
transform-box: fill-box;
transform-origin: left center;
```

Stagger independent elements with `animation-delay` in 0.3–0.4s steps. Keep every loop idle-friendly: no layout thrash, no huge repaint regions.

Motion must not be the only carrier of state — a pulsing dot always has a text label.

---

## Asset Anatomy

Every SVG:

```svg
<svg xmlns="http://www.w3.org/2000/svg"
     width="1200" height="H" viewBox="0 0 1200 H"
     role="img" aria-labelledby="X-title X-desc">
  <title id="X-title">…</title>
  <desc id="X-desc">…</desc>
  <rect x="0" y="0" width="1200" height="H" fill="#050816"/>
  <g font-family="'JetBrains Mono','IBM Plex Mono',monospace">…</g>
</svg>
```

- Root canvas `#050816` covers the full viewBox for consistent contrast.
- Semantic grouping: one `<g>` per card / section.
- `aria-hidden="true"` only on purely decorative marks.

---

## Section Heading (module label)

Every module label inside an asset:

```
// MODULE NAME          (13px, accent, letter-spacing 2)
```

`dashboard.svg` is a compound asset: it contains the first five IA modules
(Header → Capabilities) in one stacked viewBox, each headed by a `//` label.
`README.md` holds no headings or styling — it assembles images only.

---

## Terminology

Use only: `ONLINE ACTIVE ROUTING CONNECTED READY SYNCHRONIZED DEPLOYED HEALTHY`

Never: `Hi there / About Me / Fun Facts / Passionate / Enthusiast / Let's Connect`

Status strings pair with a state color:

| Status | Color |
|--------|-------|
| `CONNECTED` `HEALTHY` `SYNCED` `NOMINAL` `SUCCESS` | `--ok` |
| `STAGE` `DEGRADED` | `--warn` |
| `FAILED` `CRITICAL` | `--crit` |

---

## Data Presentation

| Element | Font | Style |
|---------|------|-------|
| Labels & captions | 13 | `#8A98B5` |
| Values | 20–24 | 600, `#F5F7FA` |
| Delta | 13 | `--ok` (positive), `--warn` (negative) |
| Timestamps | 13 | `#8A98B5`, format `DD.MM.YY HH:MM UTC` |

---

## Iconography

- No icons, avatars, badges, or logos anywhere in the interface (`COMPONENTS.md` §01).
- State ticks: 4×16px pulsing bars beside labels — always paired with a text label.
- Network nodes: `r` 20–28 circles; the orchestrator node is the accent-focused hub.
- No clip-path dependency in marks (sanitizer strips some constructs).

---

## Accessibility Checklist

- `role="img"` and `aria-labelledby` pointing at `title`/`desc`.
- Information is never conveyed only by color.
- Text contrast ≥ labels against `--surface` and `--bg`.
- Content is fully readable with CSS animation disabled.