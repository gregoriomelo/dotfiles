# Technique Catalog

Specific visual moves organized by the effect they achieve. These are not theories — they are executable techniques.

---

## To Create Hierarchy & Focus

**Display contrast** — Use an extremely large number or headline (3–5x larger than body) to anchor the page. A single 96px number on a dashboard communicates confidence and creates immediate hierarchy.

**Weight polarity** — Pair ultra-light with bold within the same typographic element. "REVENUE: **$2.4M**" where "REVENUE" is 11px/400 uppercase and "$2.4M" is 32px/700.

**Color scarcity** — Reserve one saturated color for the single most important element on the page. Everything else is neutral. When color is scarce, it becomes meaningful.

**Bleed crops** — Extend an image or color block to the edge of the container. It creates depth and breaks the monotony of bounded boxes.

**Negative space as emphasis** — Surround the most important element with more whitespace than it logically needs. Isolation = importance.

---

## To Create Visual Interest Without Noise

**Asymmetric grid** — Offset the main content block to 60% of the page width, reserve the remaining 40% for metadata, labels, or intentional whitespace. Feels editorial, not corporate.

**Type as texture** — Use large, lightly opaque letterforms as background texture. A faint "Q1" or "SALES" at 200px/10% opacity becomes structural decoration.

**Rule as separator** — A single 1px rule with 40px of padding above and below does more separation work than a divider with background color. Less is more.

**Monochrome photography** — When using images, convert to black and white plus one tint. Eliminates color conflict and creates sophistication.

**Data as hero** — In dashboards, make the key number enormous. Don't bury metrics in tables when you can make one number the entire first impression.

---

## To Signal Quality & Craft

**Optical adjustments** — Mathematically equal spacing often looks unequal. Add 1–2px extra space below a baseline, push icons up slightly, increase padding on caps-only labels. These corrections aren't visible; the absence of them is.

**Micro-borders** — A 1px border on cards with `border-color: rgba(0,0,0,0.08)` in light mode or `rgba(255,255,255,0.08)` in dark mode reads as refined, not heavy.

**Tracking on labels** — All-caps labels at 10–12px should have letter-spacing of 0.08–0.12em. Without it, they feel compressed. This single detail is a reliable design signal.

**Tabular numerals** — In any table, financial figure, or data display, use `font-variant-numeric: tabular-nums` (CSS) or the tabular figure variant of the typeface. Numbers in columns must align.

**Subpixel precision** — Don't round to the nearest 8px if 6px is optically correct. The grid is a guide, not a prison.

---

## To Handle Color Expertly

**Near-black instead of black** — Use `#0f1117` or `#1a1a2e` instead of `#000000`. Pure black creates harsh contrast; near-black feels warmer and more sophisticated.

**Tinted whites** — White backgrounds should be `#fafafa` or `#f8f9fa`. Pure white under artificial light reads as clinical.

**One accent, many neutrals** — Build the full UI in grays, then add one accent color. The restraint makes the accent vibrate.

**Semantic darks** — In dark mode, use at least 3 dark values: background (`#0d0d0d`), surface (`#161616`), elevated (`#1e1e1e`). Flat dark mode looks like an app that was lazy.

**HSL thinking** — When building palettes, work in HSL not hex. Shift hue by 10–20°, lightness by 15–25%, saturation by 20–30%. HSL variations feel more cohesive than arbitrary hex picks.

---

## For Presentations Specifically

**One idea per slide** — If you need a comma in the headline, it's two slides.

**Full-bleed hero** — First slide: full-bleed image or color, one headline, no bullets. Earn the audience's attention before explaining anything.

**Progressive disclosure** — Each slide reveals one more piece of information, not a wall of text at once.

**Data slides: chart + one sentence** — Every chart slide has a chart and exactly one sentence that tells the audience what to conclude from it. Remove the legend; label directly.

**Consistent slide footer** — Company name, slide number, session/date in a 10px muted footer. Never changes. Provides anchor without competing.

---

## For HTML/Web Specifically

**CSS custom properties for design tokens** — `--color-accent`, `--space-base`, `--radius-sm` defined at `:root`. Consistency is only possible when values are centralized.

**Fluid type** — Use `clamp(1rem, 2.5vw, 1.5rem)` for responsive headings that scale smoothly rather than jumping at breakpoints.

**Focus on the scroll** — Design the scrolled state, not just the viewport-fills-the-page state. Where does the user go after the hero?

**Skeleton states** — If data loads, show skeletons not spinners. Skeletons communicate the shape of content; spinners communicate nothing.
