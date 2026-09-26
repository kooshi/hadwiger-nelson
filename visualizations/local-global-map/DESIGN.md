# The Local–Global Map — design record (crunch job J43)

*Brief: `data/crunch-2026-09-25/briefs/J43-unified-map-visualization.md`, with `STANDING-RULES.md` part of it. Owner of this directory:
J43. Stages are saved below as `Stage n — SAVED`; a successor resumes at the first stage not saved.*

## Stage 1 — SAVED: the design

### 1.0 Quotation check (standing rule 5) and the "would have searched here" log

| quotation in the brief | source checked | result |
|---|---|---|
| Kooshi's request ("I'd like a session to create a new visualization … more than the symbols of math.") | the brief is its only copy on disk (`grep -r "somehow unifies our findings"` finds nothing else) | cannot be checked against a second copy; used as the specification, as the brief says |
| G79, "walls often show up as 'the (impossible?) counter-example invariant' …" | `CLAUDE.md` G79 (line 1474) and `plans/CRUNCH-2026-09-25-post-close-inventory.md` row 25 | verbatim in both |
| "tonight's result says such a colouring must 'read infinitely many primes'" | `LEDGER.md` row 113 says "reading infinitely many split places **in aggregate**"; queue §8.5 owner slip 5: "'spectrum reads infinitely many primes' is wider than R88-TCA; literal only after rotation averaging (J37's report)" | **wider than the source.** The page quotes row 113 verbatim ("carries an invariant measure on its orbit closure whose spectrum is carried by no such class, reading infinitely many split places in aggregate") and labels the literal reading "after rotation averaging, one mind (J36 F4)" |
| grade list "kernel, certificate, hand with two derivations, hand with one mind, measured, reading, or open (§ Notation)" | `CLAUDE.md` § Notation | § Notation has more grades ([tools], [measured], [derived], [external], [method]); the page folds them into the brief's seven, rule in §1.3 |
| "`LEDGER.md` § B indexes 675 of them" | `LEDGER.md` § B, counted by splitting on unescaped `\|` | to be recounted by the checker (a naive split reads 714 table lines; the escaped pipes in cells break it) |

**Would have searched here:** none so far. The page computes nothing by search; its one computation (which primes are stable places of
which field) is a Legendre-symbol rule of seconds, checked against `data/fplane/map.json`'s 34 rows as its control.

### 1.1 The frame — WORKFLOW's four parts

**The choice: a skyline board.** Every field is a horizontal *row*. Across the row run the field's *places*, one column per place:
the real place first, then the place above 2, then the primes ≡ 3 (mod 4) in increasing order, then the primes ≡ 1 (mod 4) (which are
split in every field), then a *horizon* standing for "infinitely many places", and past the horizon one last column, *the whole plane over
this field*. Inside each row, **height is the number of colours**, 2 at the row's floor to 7 at its ceiling (8 and above drawn as an
overflow cap). At each place where the field's unit circle is compact (a *stable* place) a bar rises to the chromatic number of that
place's finite target: the plane at 11 needs 5, so the bar at 11 is five high. At a place where the circle is a hyperbola (a *split*
place) there is no finite target and no bar — only a thin hyperbola mark. Past the horizon stands the field's own proven range for its
chromatic number, a bar from the proven lower bound to the proven upper bound.

The local–global conjecture then **is a picture**: the bar past the horizon should be exactly as high as the lowest bar in the row. A
colouring we own lives where the row touches a bar: at height k, a colouring local at one place exists wherever that place's bar is at
most k high. A colouring we do not own, drawn at its height, must pass over every bar that is too tall and every finite group of places
the records carve away, so its **shadow runs off the right edge**, across the horizon, which is exactly what "reads infinitely many split
places" means geometrically. Rows stacked give columns: follow a prime down the board and see what it does in every field.

**Alternative 1 — the colour-count ladder** (one vertical axis k = 2…7; each field a dot or interval at its bracket; each instrument a
band showing where it stops). It would buy the clearest view of the brackets and of where each instrument goes blind. It loses the
places: the 2-adic wall, the 3-adic barrier, the window at six, "local at one place" and "reads infinitely many places" are all
statements about *which* places, and the ladder has no axis for them; nor can a prime be followed.

**Alternative 2 — the character torus** (bands `[1/k, 1−1/k]` on a circle, torsion points, archimedean discs). It would make band
rigidity, the pyjama problem and the one-prime failure literal pictures. It loses almost everything else: the residue planes, the wall
at six, the fields' brackets and the 2-adic wall appear only as torsion points; and the wanted posters' remaining classes are *exactly
the colourings no character gives* (`LEDGER.md` rows 96, 100), so the torus is the one frame in which the shadows cannot be drawn.

**Alternative 3 — a fields × places table with colour count as a hue** (a periodic table). It would buy compactness (30 rows fit one
screen). It loses geometry in the one direction Kooshi asked for it: a wall "at six colours" becomes a boundary between two hues rather
than a line at a height, and "the global value equals the lowest local value" is no longer visible as equal heights.

**Why the skyline won.** Against the ladder: the skyline keeps the ladder (it is the vertical axis inside each row, and the
bracket past the horizon is the ladder's interval) and adds the places. Against the torus: the torus is one place's view of one kind of
colouring; the skyline shows where characters live (they sit above the plain colourings at their targets, rows 100–101) and still has
room for the non-character shadows. Against the table: height is geometry, hue is a symbol. It is the only one of the four in which the
conjecture, the walls at a colour count, and "one place / finitely many / infinitely many" are all distances.

**Confidence: medium.** It changes if 30 rows at phone width are unreadable; the fallback is already in the design (§1.6: a *focus
panel* that shows one row large, with the board as its index).

### 1.2 Encodings — which dimension goes to which channel

| data dimension | channel | notes |
|---|---|---|
| field | row (vertical position); grouped by the arithmetic of 2 and 3, then ordered by local bound | group headers say the reason in words ("the place above 2 caps it at four") |
| place | column (horizontal position), fixed across rows | real place ∞ at the left; 2; primes ≡ 3 (mod 4); primes ≡ 1 (mod 4); horizon; the whole plane |
| colour count k | height within a row (2 at the row floor, 7 at the row ceiling, overflow cap for 8+) | faint gridlines at k = 4, 5, 6 run the full width, so the walls at a colour count are lines |
| a place's local chromatic number | two facts, two marks: the **bar** rises to the proven floor ("fewer colours than this are refused"); the **cap**, a dot, sits at the proven ceiling ("a colouring with this many exists" — a colouring we own); between them a bare thin line, the open gap | the window's gap (bar 6, cap 8 at 23) is visibly what the line at six crosses; exact values put the cap on the bar |
| stable / split place | bar vs a thin hyperbola mark | split = "this place gives no bound"; not blank: it is known |
| the field's own chromatic number | the same bar-and-cap past the horizon: bar = proven lower bound, cap = the colouring we own; the conjecture's prediction L(F) is a tick | the shadows live exactly in this column's gap |
| grade (how solid) | **solidity**: fill opacity and edge — kernel: solid fill + solid edge; certificate: solid fill + double edge; hand, two derivations: 80 % fill; hand, one mind: 45 % fill + hatching; measured: outline only, dotted; reading: dashed outline, no fill; open: a hollow "?" frame | one legend, the same on every mark type |
| colour count as colour (secondary, redundant with height) | a sequential ramp, 2 (cool) → 7 (hot), on bar tops only | redundant so that a reader who sees only hue still reads the value; never the only carrier |
| a colouring we own | a lit dot on the bar top where it lives, in the ink colour; a window colouring over several places is a line joining its places | kinds: residue, dyadic pullback, character (a ring, drawn above the plain bar at its own higher count), periodic (= residue, G69), window, the hexagonal seven at the real place, Fischer's additive four over K |
| a colouring we do not own (the wanted posters) | a **shadow**: a translucent violet ribbon at its height across its row, **cut away** under every carved format, surviving only where the records leave room, fading off past the horizon | each cut carries the carving theorem, its grade and address |
| wall, standing | a solid dark rule with a padlock glyph; its label is the *counterexample invariant*: what anything getting past it would have to carry | G79: "walls often show up as 'the (impossible?) counter-example invariant'" |
| wall, broken | the same rule with a breach and a key glyph; its label is what broke it — an *example invariant* (an invariant every actual solution carries) or a *construction* | the page says which, so G79's count can be read off it |
| theorem density | a stipple under each row (one dot per theorem that mentions the field) and above each column (per place), dots coloured by grade; a region no theorem mentions gets an explicit "unworked" hatch, never blank | tags by a keyword rule over `LEDGER.md` § B and the ledger rows; the rule is on the page and in the checker |
| changed on 2026-09-25 (the crunch) | a toggle that dims everything minted before and outlines everything minted in it | rows 98–115, § B entries of FS-91, M2, M3, row 88, FS-67; G77–G79; the posters; FS-100 |

### 1.3 Grades — the page's seven, and the fold

| page grade | folds in (`CLAUDE.md` § Notation and `LEDGER.md` § B's free-text grades) |
|---|---|
| kernel | [kernel] |
| certificate | [cert]; exact certificates accepted by a standalone checker |
| hand, two derivations | "two/three derivations", "blind", "re-derived" |
| hand, one mind | [hand], [derived], "proof, GPT Astra", "(one mind)", "Poros" |
| measured | [tools], [tools exact], [measured], [solver], [search] — **a measured null is never drawn as a refusal** |
| reading | [reading] |
| open | a question the records name as open |

A mixed grade takes its weakest part ("hand + tools exact, one mind" is *hand, one mind*); [external] marks keep their grade and add
"in print, not re-checked here".

### 1.4 What "standing" and "broken" mean for a wall (from the records)

A **wall** is a no-go the records state as a theorem: *nothing of kind X can do Y*. It is **standing** when the records hold it as true
and nothing has got past it; **broken** when a later result did the thing the wall said a certain route could not do, by a different
route — and then the page names the result and the route. A wall can be both at once, in different rows (the place above 2 stands in
ℚ(√59)'s row and is broken in ℚ(√47)'s). The walls drawn:

| wall | where on the board | status | counterexample invariant / what broke it | source |
|---|---|---|---|---|
| the 2-adic wall | the column above 2, every row | standing where 2 is inert or ramified in F(i) (a bar of 4 or 2 caps the field); broken where every place above 2 splits | stands: a fifth colour needs an odd square class ≡ 7 (mod 8); broken, by the chain theorem (an invariant of every colouring: periodicity under δR) with the 8/3 forcer — "wall-broken is *sufficient* for five over K" | G1, G35, G55; rows 57, 103, 105 |
| the 3-adic barrier | the column above 3, rows of real quadratic fields | broken | stands for directions integral at 3 (row 72, kernel); broken at the field level by the slope every three-colouring carries (row 82, row 99) — an example invariant | rows 72, 82, 99; G61, G74 |
| the wall at six | the line at height 6, across the columns 23, 27, 31, 43, 47 and the norm-64 dyadic target | standing, open in the window: refused by certificate at 59, 67, 79, 83 and by spectrum above | counterexample invariant: an independent set of ⌈q²/6⌉ in a window plane | G56, G59; rows 68–71 |
| linear instruments go blind above four | a translucent ceiling band at 4.36 across every row | standing | fractional colourings are capped by 4.36 and by every usable plane's fractional number; additive colourings give 2, 3, 4 and then 7 | G38, G41, G44, G60; item 6 |
| the tower never drops | the stable columns 7, 11, 19, 23 | standing (certified at every level) | a deeper residue level with a smaller chromatic number | row 75, G66 |
| one prime is not enough for band rigidity | the lane of primes ≡ 1 (mod 4): between the first and the second | standing at one prime (fails three ways); broken at two, by band rigidity — an example invariant (every band character is torsion plus archimedean) | rows 95, 98, 102 |
| cell-local four-colour certificates | the line at height 4, rows whose planes are triangle-free | standing for its formats (edge heights, loop windings, face fluxes, coindex); broken on de Grey's lattice by a structure-derived certificate — the eigen-equation every colouring satisfies, an example invariant | row 80, row 85; G73, G75 |
| the in-field descent over K | K's row, between the column above 2 and the horizon | standing inside K (Theorem B); broken by adjunction — a construction (Heule's graph in K(√5), the ρ₆₃ arena in K(√7)) | G34, G37; rows 57, 64 |
| characters stop at the window | the character rings over 23 and 43 | standing | a band six-character of a window plane; none exists: χ_char = 8 at 23, 9 at 43 | rows 100–101, G77 |
| the real place refuses four, and only four | the real-place column at height 4 | standing (certificate + hand) | m₁(ℝ²) ≤ 0.246989 < 1/4; at five and above the real place is "thick" and refuses nothing | `plans/FS100-KT1-ambrus-ball.md`; row 112; J36 F7 |
| finitely many places (the horizon wall) | the horizon, in the rows of ℚ(√47) and the type-(B) fields | standing | a four-colouring's invariant measure has spectrum carried by no `T + A + Fin_S` (row 113; Theorem C, row 112) | rows 112–113 |

### 1.5 The facts to extract (one table, `data/viz/local-global-map/facts.json`, each fact value + grade + source address)

1. **Places** (columns): ∞; 2; 3, 7, 11, 19, 23, 27, 31, 43, 47, 59, 67, 71, 79, 83, "103 and up"; 5, 13, 17, 29, "and every larger p ≡ 1 (mod 4)".
2. **Targets**: the chromatic number (range) of each finite target: Γ_q for the stable q above (`data/fplane/map.json` `planes`,
   `data/fs53/window.md`); the dyadic targets (ramified: 2; inert of norm ≤ 32: 4; norm 64: 6–8) (row 70, G56); the real place (5–7, row 33;
   m₁ < 1/4, FS100-KT1); character chromatic numbers where known (row 101).
3. **Fields** (rows, about 30): radicands; which listed places are stable (computed by the Legendre rule, controlled against map.json's
   34 rows); the dyadic state (split / inert / ramified, by G35's congruence, controlled against map.json's `wall_broken`); the field's
   proven range with a grade and source per end; L(F) and the conjecture's prediction.
4. **Colourings we own**: kind, field or family, place(s), colour count, grade, source.
5. **Shadows**: the four wanted posters — four colours over ℚ(√47) (J37), a non-pullback four-colouring over the type-(B) fields (J38), five
   colours over ℚ(√167) (J39), six colours for the plane (G22, G56, G64, row 101) — each as a list of carved formats (what, which places,
   grade, address) and the named remainder (FS-100's MR; the real place at five; 43 at depth).
6. **Walls**: §1.4's table.
7. **Theorems**: every `LEDGER.md` § B entry and every ledger row, with its grade folded (§1.3), its tags (fields, places, colour counts)
   by the keyword rule, its source line, and whether it was minted in the crunch.

The checker `tools/viz_local_global_map_check.py` re-reads every fact from its source (a quoted snippet must appear verbatim, the
value must appear in the snippet, the grade must be the source's), recomputes the stable places, re-parses § B, and fails loudly naming
the fact on a mismatch or an unreadable source. Controls: one planted wrong grade, one planted wrong number, each must fire and name its
fact; the faithful copy must pass; a plant that the checker cannot see is itself a failure (two-sided bound).

### 1.6 The surface (what Kooshi meets)

- **The guided first view.** The board opens with a five-step "how to read this map" strip (one sentence each, a highlighted region
  each): a row is a field; a bar is a place's finite target; the bar past the horizon is the field's own value; a lit dot is a colouring we
  own; a violet ribbon is a colouring nobody owns yet, and where it runs.
- **Hover** on any mark: what it is in plain English, its grade (as a word and as the solidity swatch), and its source address.
  **Click** pins the card and fills the focus panel.
- **Focus panel**: one row drawn large with every mark labelled, the wanted poster's carved formats listed in the order they cut, and the
  theorems that mention this field listed by grade.
- **Filters**: grade (show only marks at or above a solidity), colour count (fade everything off a chosen height), field family, place.
- **Follow**: click a column header to follow a prime down every row; click a row label to follow a field.
- **The crunch toggle**: "what changed on 2026-09-25".
- **Walls toggle**: standing / broken / both; the G79 view colours each wall's label by counterexample-invariant or example-invariant.

### 1.7 Three questions Kooshi could ask of the page, and how it answers

1. **"Why is ℚ(√47) the cheapest place to test the conjecture, and what exactly would a counterexample have to look like?"** Follow
   ℚ(√47)'s row: every bar is at least five high (11, 19 at five; 23, 31, 43, 47 higher), so the lowest bar says five, and the field's own bar
   stands at 4–5. The violet ribbon at four is cut away over every bar, over one-character windows, over every finite group of places, and
   survives only past the horizon: a counterexample reads infinitely many split places in aggregate, and FS-100's one missing lemma (MR)
   would remove what is left.
2. **"Where does the real place matter, and why does it stop mattering at five?"** Look at the real-place column: at height four it is a
   standing wall (the plane's measurable independence ratio is below 1/4, certified), so at four colours the shadows are pushed right,
   into the primes. At five the column is open: ℚ(√167)'s five-colour shadow keeps a door at the real place, which is why that poster ends in
   the plane's own measurable question and not in a finite-place lemma.
3. **"Where is our knowledge thin?"** Switch the density stipple on: each row and each column carries one dot per theorem that
   mentions it, coloured by grade, so a thick kernel-coloured band is solid ground and a sparse pale one is thin; a region no theorem
   mentions shows the "unworked" hatch. *What it will show is not predicted here*: the counts are computed in stage 2 and read off the
   page, never written into this design first (G21).

### 1.8 The experience-modeling pass (`debruijn-experience-modeling`, invoked fresh on this design; the consumer is Kooshi)

*Inhabit the user.* Kooshi arrives holding the project's surface vocabulary — fields, primes, colours, the conjecture, "the wall" — and
not the vocabulary of the crunch's deep domains (spectral measures, `T + A + Fin_S`, orbit closures, stable places). Whatever the page does
not say in his words does not exist for him. What the pass changed:

| smell found in the draft | change |
|---|---|
| **one channel, two meanings**: translucency meant both "a weaker grade" and "the open part of a range" | ranges are now two marks (bar to the proven floor, cap at the proven ceiling, a bare line between); translucency means grade only (§1.2) |
| the colourings we own were a separate glyph beside the caps they coincide with | **the cap is the colouring**: every ceiling is a colouring someone owns; the lowest cap in a row glows as the best colouring of that field |
| "stable place" / "split place" as the nouns | one vocabulary, plain first: **"a place with a finite plane"** (a bar) and **"a split place: no finite plane"** (a hyperbola mark); the literature's word follows in parentheses once, in the legend |
| "counterexample invariant" / "example invariant" as the nouns on wall labels | the labels read **"to get past it, you would need …"** (standing) and **"broken by …"** (broken), with the kind — an invariant every colouring carries, or a construction — as a tag; G79's words appear once, in the walls legend |
| the density stipple implied coverage ("nobody worked here") | it is labelled **"theorems that mention this field or prime, found by a keyword rule — mentions, not coverage"**, and the unworked hatch says "no theorem mentions this by the rule" |
| a field list of about thirty implies completeness | the page states: "every field the records name as an example, test or prediction — not every field" |
| hover cards of varying shape | **one card shape, always in this order**: what it is (one plain sentence) · grade (word + solidity swatch) · source address (copyable) · why it matters (at most one line). Four chunks, no more |
| filters could empty a row silently | an emptied row says so ("nothing at this solidity here"); a hidden shadow leaves its label greyed with "hidden by the grade filter" |
| the legend lived below the board | the legend is sticky beside (desktop) or above (phone) the board; decoding never needs a scroll |
| the checker's failure path unspecified | **exit 0** all facts pass; **exit 1** FAIL, one line per failed fact: `FAIL <fact id>: expected <value/grade> in <path>, found <what was found>`; **exit 2** ERROR, an unreadable or missing source, named; a final count line `checked N, failed M, errors E` is always printed, so a silent run is impossible |
| round trip | every source address on the page is a path the checker has opened; a card never shows an address the checker did not verify |

*Walk the conversation.* The session the page serves is: open → guided view (skippable, remembered as dismissed per viewer) → pick a row
that puzzles → hover → click to pin → the focus panel answers "why" → follow a column or toggle a layer → the next question. Each step's
reply funds the next: a pinned card offers "follow this field" and "follow this prime" as its two buttons.

*Validate as the user* happens at stage 4: a cold read of the published page against §1.7's three questions, each answered by looking
alone, recorded in the README.
