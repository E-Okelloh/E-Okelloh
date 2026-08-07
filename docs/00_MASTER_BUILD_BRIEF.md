# GitHub Profile Operating System (GPOS)

> Master Build Brief
> Version: 1.0
> Owner: Erick Okello

---

# Mission

Build a GitHub profile that resembles a **Financial Infrastructure Control Center**.

The final result should feel like a production dashboard used by a company operating payment networks, blockchain infrastructure and distributed financial systems.

This is **not a README**.

This is **a software product**.

---

# Design Philosophy

The interface must communicate engineering maturity through:

* typography
* spacing
* architecture
* animation
* systems thinking
* information hierarchy

The profile should be immediately recognizable and impossible to confuse with common GitHub profile templates.

---

# Brand Identity

Primary Name

**ERICK OKELLO**

Title

**Financial Infrastructure Engineer**

Mission

**Building infrastructure that moves value securely at global scale.**

---

# Required Repository Structure

```
E-Okelloh/

README.md

assets/
dashboard.svg
terminal.svg
footer.svg
logo.svg
divider.svg

.github/
workflows/
snake.yml
metrics.yml
update.yml

docs/
01_VISION.md
02_UI_ARCHITECTURE.md
03_ENGINEERING_SPECIFICATION.md
04_IMPLEMENTATION_GUIDE.md
00_MASTER_BUILD_BRIEF.md
```

---

# Dashboard Architecture

The dashboard must contain these sections in order.

```
Header

↓

System Status

↓

Network Topology

↓

Deployments

↓

Capabilities

↓

Operations Panel
```

The dashboard is contained inside **dashboard.svg**.

README only assembles components.

---

# Header

Display

```
ERICK OKELLO

Financial Infrastructure Engineer

Building infrastructure that moves value securely at global scale.
```

Requirements

* large typography
* centered layout
* significant whitespace
* subtle animation only

---

# System Status

Display

```
SYSTEM STATUS

Infrastructure      ONLINE

Payments            ROUTING

Blockchain          ACTIVE

Open Source         RUNNING

Availability        READY
```

Status indicators should pulse gently.

---

# Network Topology

The network is the centerpiece.

Architecture

```
CLIENTS

↓

API GATEWAY

↓

AUTHENTICATION

↓

PAYMENT ROUTER

↓

ORCHESTRATOR

↓

Settlement

↓

Ledger
```

Secondary services

* Stellar
* Mobile Money
* Bank APIs
* Fraud Engine
* Notification Service

Requirements

* animated packet flow
* glowing connections
* pulsing nodes
* responsive SVG
* no JavaScript

---

# Deployments

Replace traditional project cards.

Each deployment should appear as a production service.

Deployments

* African Payment Aggregator
* PesaText
* SEP-41 Token
* No Loss Auction
* AI Meeting Assistant

Each deployment displays

```
SERVICE

ROLE

STATUS

STACK

REPOSITORY
```

Status should display **ONLINE**.

---

# Capabilities

Display grouped capabilities.

```
LANGUAGES

Rust

Python

TypeScript

────────────────────

BLOCKCHAIN

Stellar

Soroban

Solana

Move

────────────────────

SYSTEMS

PostgreSQL

Redis

Docker

Linux

Kubernetes
```

Do not use badges or technology logos.

---

# Operations Panel

Create a live production operations summary.

Display

```
OBSERVABILITY

Latency           18 ms

Availability      99.99%

Services          05

Environment       Production

Version           v1.0.0

Pipeline          Healthy

Region            Global
```

Values should be configurable.

---

# Terminal

Create **terminal.svg**.

Display

```
$ systemctl status erick

Infrastructure    running

Payments          routing

Blockchain        synchronized

Open Source       active

System            healthy
```

Requirements

* Linux terminal appearance
* blinking cursor
* no typing animation
* no scrolling animation

---

# Footer

Create **footer.svg**.

Display

```
END OF TRANSMISSION

ERICK OKELLO

BUILDING FINANCIAL INFRASTRUCTURE
```

Minimal design.

Large whitespace.

---

# Color System

Background

`#050816`

Surface

`#0B1020`

Accent

`#00F5FF`

Primary Text

`#F5F7FA`

Secondary Text

`#8A98B5`

Divider

`#1D2638`

Healthy

`#00FF9D`

Warning

`#FFB020`

Critical

`#FF5C5C`

Use only one accent color.

---

# Typography

Primary Font

**JetBrains Mono**

Secondary Font

**IBM Plex Mono**

Hierarchy

* Hero: 56px
* Section: 24px
* Body: 16px
* Caption: 13px

---

# Animation Rules

Allowed

* packet movement
* node pulse
* cursor blink
* connection glow
* status refresh

Forbidden

* bouncing
* spinning
* floating
* rainbow effects
* excessive motion

Animations must feel like infrastructure monitoring.

---

# SVG Engineering Standards

Every SVG must include

* title
* description
* viewBox
* preserveAspectRatio
* semantic grouping
* reusable defs
* optimized paths

Use meaningful IDs.

Example

```
dashboard-root

network-node

network-path

network-packet

deployment-item

status-indicator

terminal-root
```

Avoid IDs such as

```
rect1

path2

group3
```

---

# README Responsibilities

README should be minimal.

It should load

* dashboard.svg
* GitHub Stats
* Top Languages
* Activity Graph
* Contribution Snake
* terminal.svg
* footer.svg

Do not duplicate dashboard content in Markdown.

---

# GitHub Automation

Implement workflows

snake.yml

* updates contribution snake

metrics.yml

* updates repository metrics

update.yml

* regenerates dynamic assets
* updates timestamps
* updates build metadata

Automation should run automatically.

---

# Dynamic Metadata

The dashboard should display

```
Environment

Production

Version

v1.0.0

Branch

main

Last Updated

UTC Timestamp

Build

Generated Automatically
```

These values should be generated where possible.

---

# Performance Targets

dashboard.svg

less than 250 KB

terminal.svg

less than 40 KB

footer.svg

less than 20 KB

Total SVG assets

less than 500 KB

No JavaScript.

No raster images.

---

# Accessibility

Every SVG must

* contain title
* contain description
* have readable contrast
* remain understandable without animation
* support screen readers

No information should depend solely on color.

---

# Quality Standard

The finished profile should feel like software created by a product team at:

* Stripe
* Cloudflare
* OpenAI
* Microsoft
* Stellar Development Foundation
* Datadog
* Vercel

A visitor should immediately think

**This engineer builds infrastructure.**

---

# Final Instruction to the Agent

Treat this repository as a production software project.

Do not generate a generic GitHub README.

Do not use templates.

Do not copy existing GitHub profile designs.

Build a cohesive operating system interface with custom SVG assets, subtle production-grade animations, modular architecture, reusable components, responsive layouts, automated GitHub workflows and engineering-level code quality.

Iterate on typography, spacing, animation timing, alignment and information hierarchy until the result feels like a real financial infrastructure dashboard rather than documentation.

Do not stop at the first working version.

Refine until every component communicates precision, reliability and systems engineering.