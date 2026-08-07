# GitHub Profile Operating System (GPOS)

> **Version:** 1.2
> **Document:** Part 3 — Engineering Standards & Asset Specifications
> **Owner:** Erick Okello

---

# Purpose

This document defines how every asset within the GitHub Profile Operating System must be engineered.

It establishes coding standards, SVG architecture, animation principles, repository organization, accessibility requirements, optimization rules and quality expectations.

This document is considered the engineering contract for the project.

No implementation should violate these standards.

---

# Design Goals

Every asset should satisfy the following characteristics.

- Minimal
- Modular
- Accessible
- Responsive
- Lightweight
- Deterministic
- Production Ready

The profile should feel engineered rather than designed.

---

# Repository Architecture

```
E-Okelloh/

├── README.md

├── assets/

│ ├── dashboard.svg
│ ├── terminal.svg
│ ├── footer.svg
│ ├── divider.svg
│ └── logo.svg

├── docs/

│ ├── 00_MASTER_BUILD_BRIEF.md
│ ├── 01_VISION.md
│ ├── 02_UI_ARCHITECTURE.md
│ ├── 03_ENGINEERING_SPECIFICATION.md
│ └── 04_IMPLEMENTATION_GUIDE.md

├── .github/

│ └── workflows/

│ ├── snake.yml
│ ├── metrics.yml
│ └── update.yml

└── metrics/
```

Each file has exactly one responsibility.

---

# SVG Standards

Every SVG must include

```
<title>

<desc>

viewBox

role="img"

preserveAspectRatio

semantic grouping
```

Example

```xml
<svg
viewBox="0 0 1600 900"
role="img"
preserveAspectRatio="xMidYMid meet">

<title>
Financial Infrastructure Dashboard
</title>

<desc>
Animated production dashboard representing payment infrastructure.
</desc>

</svg>
```

---

# SVG Structure

Every SVG follows the same hierarchy.

```xml
svg

defs

background

grid

dividers

content

animations

labels
```

Never mix structural and visual elements.

---

# Layer Order

Always render layers in this order.

```
Background

↓

Grid

↓

Panels

↓

Connections

↓

Animations

↓

Labels

↓

Foreground
```

Nothing should violate this order.

---

# Coordinate System

Use a consistent grid.

```
8px spacing
```

All `$x$` and `$y$` coordinates should align to the grid whenever possible.

Avoid arbitrary values.

---

# Typography Rules

Allowed fonts

```
JetBrains Mono

IBM Plex Mono
```

No additional fonts.

Text hierarchy

```
Hero        56px
Section     24px
Body        16px
Caption     13px
```

Text alignment

- Left alignment for system information.
- Center alignment only for the hero.
- Never justify text.

---

# Color Tokens

Define reusable variables.

| Token | Hex |
|-------|-----|
| Background | `#050816` |
| Panel | `#0B1020` |
| Accent | `#00F5FF` |
| Text | `#F5F7FA` |
| Muted | `#8A98B5` |
| Divider | `#1D2638` |
| Healthy | `#00FF9D` |
| Warning | `#FFB020` |
| Critical | `#FF5C5C` |

Never hardcode colors repeatedly.

---

# Motion Principles

Animations exist only when they communicate state.

Allowed

```
Packet movement
Node pulse
Cursor blink
Status refresh
Glow
```

Forbidden

```
Bounce
Rotate
Shake
Zoom
Explosion
Confetti
```

Animation duration

| Animation | Duration |
|-----------|----------|
| Packet | 2–4 seconds |
| Pulse | 3–5 seconds |
| Cursor | 700 milliseconds |
| Fade | 250 milliseconds |

Use ease-in-out unless another easing improves clarity.

---

# Packet Animation

Packets represent value moving through infrastructure.

Packets

```
Small circles
Accent color
Constant speed
Loop forever
Disappear naturally
Restart from origin
```

Never overlap excessively.

---

# Node Animation

Nodes should scale between

```
1 → 1.03
```

with opacity

```
0.85 → 1
```

Never exceed a 3% scale increase.

---

# Dashboard Rules

Dashboard contains

```
Header

System Status

Network

Deployments

Capabilities
```

Nothing else.

---

# Terminal Rules

Terminal resembles a Linux shell.

```
Background  Panel color
Border      Divider color
Prompt      $
Cursor      Blinking
```

No scrolling animation.

No fake typing animation.

---

# Footer Rules

Footer should be extremely minimal.

Only

```
END OF TRANSMISSION

ERICK OKELLO

BUILDING FINANCIAL INFRASTRUCTURE
```

No quotes.

No social links.

No copyright.

---

# README Responsibilities

README is an orchestrator.

It must

```
Load dashboard
Load GitHub metrics
Load activity graph
Load contribution snake
Load terminal
Load footer
```

Nothing else.

---

# Performance

Target

```
Less than 500 KB total SVG assets
```

No embedded raster images.

No JavaScript.

Prefer SVG animation.

Reuse symbols.

Optimize paths.

---

# Accessibility

Every SVG must

```
Contain title
Contain description
Have readable contrast
Remain understandable without animation
Support screen readers
No information depend solely on color
```

---

# Naming Convention

IDs

```
dashboard-root

network-node

network-path

network-packet

deployment-section

status-indicator

terminal-root

footer-root
```

Classes

```
panel
divider
label
packet
node
connection
metric
```

Avoid

```
rect1
circle2
path12
group99
```

---

# Documentation

Every SVG begins with

```xml
<!--

Component

Purpose

Author

Version

Dependencies

-->
```

Every major section should contain comments.

---

# Engineering Principles

Follow these principles throughout.

- Single Responsibility — every component does one thing.
- Composition — small components build larger systems.
- Consistency — spacing, colors, typography predictable.
- Scalability — new components integrate without redesign.
- Maintainability — readable code over clever code.
- Performance — optimize first.
- Accessibility — never optional.

---

# Definition of Done

The project is complete only when

```
The profile is immediately recognizable.
Every animation communicates state.
The interface resembles production software.
The SVGs are modular.
The repository structure is clean.
The code is documented.
Animations remain smooth on GitHub.
The interface remains readable when animation is disabled.
Nothing appears copied from existing GitHub profile templates.
The design communicates engineering excellence before visitors read any content.
```

---

# Final Engineering Principle

The GitHub Profile Operating System is not a personal homepage.

It is a software product.

Every file, animation, layout decision and line of code should be held to the same engineering standards as a production infrastructure platform.