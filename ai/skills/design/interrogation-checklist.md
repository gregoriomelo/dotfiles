# Design Interrogation Checklist

Run through this before delivering any visual output. These are not suggestions — they are requirements.

---

## Typography

- [ ] Is the typeface choice intentional, not default? (System fonts are fine; defaulting to them without thought is not.)
- [ ] Is there a clear type scale with at least 3 distinct size steps?
- [ ] Are weights used to create hierarchy, not just aesthetics? (Bold should mean important, not decorative.)
- [ ] Is line height appropriate? Body: 1.5–1.6. Headlines: 1.1–1.2. Display: 0.95–1.0.
- [ ] Is letter spacing (tracking) correct? Body copy: 0 or slight negative. Uppercase labels: +0.05–0.1em. Never tracked loose on body text.
- [ ] Are there widows or orphans in text blocks? Fix them.
- [ ] Is the measure (line length) between 45–75 characters for body text?
- [ ] Are numbers in data contexts tabular (fixed-width)? Column-aligned numbers must not drift.

## Color

- [ ] Is the palette restrained? 2–3 colors maximum for functional UI. A 4th only for a specific, justified reason.
- [ ] Is there a single primary action color? It should appear rarely, so it retains meaning.
- [ ] Are neutrals thoughtful — not pure black/white, but slightly warm or cool depending on context?
- [ ] Does all text pass WCAG AA contrast ratios? (4.5:1 for normal, 3:1 for large text)
- [ ] Is color the only way information is conveyed? If yes, add a second indicator (shape, label, position).
- [ ] Does the palette have enough tonal range? You need lights, mids, and darks.
- [ ] In dark mode: are backgrounds using multiple dark tones (not one flat dark), and are colors slightly desaturated vs. light mode?

## Layout & Grid

- [ ] Is there a defined grid? Even informal layouts should follow an implicit grid.
- [ ] Is alignment consistent? Elements should align to the same invisible lines.
- [ ] Is there a clear visual hierarchy from most to least important?
- [ ] Is the layout interesting, or is it just stacked boxes? Consider: asymmetry, scale contrast, overlap.
- [ ] Are related elements visually grouped? (Gestalt: proximity, similarity)
- [ ] Is the layout mobile-considered, or does it assume infinite width?
- [ ] Are tables scannable? Headers distinct, rows have enough breathing room, alternating treatment if >5 rows.

## Spacing & Rhythm

- [ ] Is there a consistent spacing system? (Base unit of 4px or 8px, everything a multiple thereof.)
- [ ] Is whitespace used intentionally to create breathing room and group content?
- [ ] Are component internals (padding) generous enough that nothing feels cramped?
- [ ] Is there enough negative space between sections to create a sense of breathing?
- [ ] Does the page have visual rhythm — repeating spatial patterns that feel coherent?

## Components & Details

- [ ] Do interactive elements look interactive? (Buttons should look tappable, links look clickable.)
- [ ] Is the border radius consistent and appropriate to the brand character?
- [ ] Are icon sizes optically correct? (Icons often need to be slightly larger than text to feel the same size.)
- [ ] Are all edges, borders, and dividers consistent in weight and color?
- [ ] Are states handled? (Hover, active, disabled, error, empty, loading)
- [ ] Are data visualizations labeled directly on the chart, not in a legend requiring eye travel?

## Overall Impression

- [ ] If you saw this without context, would you know who made it (distinctive) or would it look like a template (generic)?
- [ ] Is there one deliberate "moment" — a design choice that shows craft? (A pull quote, a display number, a color decision that surprises.)
- [ ] Would a senior designer be proud to have their name on this?
