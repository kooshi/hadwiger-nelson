# FS132-Z1 — the record job, part 1: FS-132's derivation file and the dated corrections

*Ephodos (the record job, first half), 2026-10-07 (UTC). Brief: `data/fs132/briefs/FS132-Z1-record.md`. Report:
`data/fs132/reports/FS132-Z1.md`. Working files: `data/fs132/z1/` (`extract_entries.py`, the six `entries-E*.txt`,
`entries-index.tsv`, `assemble.py`). Each stage is saved and committed before the next starts.*

## Theorems this phase proved

None: a record job. It derives nothing and raises no grade. The milestone's theorems are the entries of
`plans/FS132-derivation.md`, each at the grade and the number of minds its source gives it; where this job lowered a count
or entered a statement as a gap, the prose under that entry says so and why.

## Stage 1 — SAVED: the readback, the brief's quotations, what was read

### 1.1 Readback

FS-132's night produced six derivers' records, one search record, a kernel planner's record on an unmerged branch and two
records of the asking lane. My job is its first half of the record job: (1) a table of every entry of the six records and
of the planner's, with what later entries did to each; (2) `plans/FS132-derivation.md`, in which every derived statement
stands once in its strongest merged form with its weaker forms named under it, every stall and gap is an entry of its own,
every posed and unstarted claim is named as that, every grade and count of minds is exactly its source's, and every entry
is placed on one side of one line — whether it holds where a boundary is an arc of the unit circle about a point of the
centre's own ring, or only where none is; (3) the dated corrections the night's records owe each other and earlier
milestones' derivation files, each appended under the text it corrects with the original left standing; (4) drafts, with
their slots, for the files that are not mine (`LEDGER.md` row 133's sharpening; a note for rows 148–149); (5) the gates,
before and after, on every file I append to. Not mine: the stubs, the scored predictions, the front page — part 2's. I
start no agents; I raise nothing; a statement the night called derived that its record does not carry is a finding for
the coordinator at once.

### 1.2 The brief's quotations against their sources

| quotation | source | result |
|---|---|---|
| Kooshi, "[…] …" | `data/external/EXT-OAI1-request.md` § Kooshi's fourth word | matches, character for character |
| Kooshi, "[…] I'll hand the reins over to you […]. …" | the same file, § Kooshi's fifth word | matches |
| inventory item 6, first line | `plans/FS132-close-inventory.md` l. 147 | matches (`grep -F`) |
| inventory item 21, first line | l. 648 | matches |
| inventory item 25, first line | l. 779 | matches |
| inventory item 28, first line | l. 848 | matches |
| inventory item 30, first line | l. 904 | matches |

No mismatch. The brief's § What Kooshi asked says the inventory's own wording "was wrong twice tonight (its items 21 and 23
say where)": read — item 21 withdraws ruling 16 (c) and replaces ruling 18 (d)'s sentence; item 23 corrects item 21's point
(4) about the one tight seven-colouring held by formula.

### 1.3 What was read, and how

- **Whole**: the brief; `plans/STANDING-RULES.md`; `plans/FS132-close-inventory.md` items 1–30; `data/fs132/claims.md`;
  the six reports `data/fs132/reports/FS132-E1.md` … `-E6.md`.
- **Every entry block of the six records, whole and verbatim** (51 `derivation:` blocks, 32 `control:` blocks), extracted
  by `data/fs132/z1/extract_entries.py` into `data/fs132/z1/entries-E1.txt` … `-E6.txt` with `entries-index.tsv`.
- **Sections, by address**: `plans/FS132-E5-derivation.md` § The exclusion, step by step (the step table);
  `plans/FS132-E6-derivation.md` § The gap in clause (ii), § The two things the brief asks to carry visibly, § The two
  riding controls; `plans/FS132-E4-derivation.md` § Where C132-TURN stalls, item (i); `plans/SEARCH-2026-10-07.md`
  § Theorems this phase proved, § 1.3 (head), § 1.5, Stages 3 and 4; the kernel planner's record at
  `origin/fs132-wk1:plans/FS132-kernel-plan.md` (tip `e3695302`) — its head, § 2.2 from C132-M-ORBIT on, § 2.3 whole,
  Stage 3 whole (§§ 3.1–3.7); `plans/POROS-2026-10-07-fs132-round2.md` ll. 66–76 (clause (5)'s consumers);
  `plans/POROS-2026-10-07-fs132-night.md` ll. 74–82 (finding A); `LEDGER.md` rows 133, 148, 149.
- **Not read**: the arguments of the six records beyond the sections named (each statement, `uses only:` and `not
  claimed:` line was read; the proofs were not reworked — this job checks chains of entries, not steps of proofs); the
  asking lane's two records beyond the lines named; the stub beyond the lines quoted in the claim list and ll. 244–254;
  `plans/FS132-six-by-the-nerve.md` beyond its dictionary line; the Lean skeleton on the branch; the search's formulas
  and tables. Every number in the derivation file is copied by script from a source entry or quoted with its address.

## Stage 1 — SAVED

## Stage 2 — SAVED: every entry of the six records and of the planner's, and what later entries did to each

*Columns: verdict, grade and minds are the source entry's own fields, copied (`data/fs132/z1/entries-index.tsv`). "From" is
what the entry's `uses only:` and `grade:` lines name among this milestone's entries. "Later" is what a later entry, record
or lane widened, narrowed, restated or corrected, with its address. E1…E6 are `plans/FS132-E1-derivation.md` …
`-E6-derivation.md`; K1 is the kernel planner's record `plans/FS132-kernel-plan.md` on branch `fs132-wk1` (tip `e3695302`);
"item n" is `plans/FS132-close-inventory.md`.*

### 2.1 Round one

| entry | rec. | verdict | grade | minds | from | later |
|---|---|---|---|---|---|---|
| C132-EXT-DISC | E1 | derived | hand | 1 | — (the release's § 7 read at `k`) | **instances**: C132-EXT (posed form, radius 8), C132-CORES-FREE (the case of no centre), C132-WIT-EX-FIN (E5: clauses (1), (3), (4), (5)). **Used**: its steps S4–S5, S7 by C132-FILL (E2). **Clause (5)**: read by no entry of E3 or E4; its consumers are one remark of E3 (Lemma 6.2 on mixed rings) and the words "forming a cycle of the transition graph" in C132-WIT-EX-FIN; it does not bear on C132-TURN's stall (item 21, correcting ruling 16 (c)). **Unread by a second mind**: S5's merging, S8, S11 (item 3) |
| C132-CORES-FREE | E1 | derived | derived from: C132-EXT-DISC | 1 | C132-EXT-DISC | **widened, posed**: C132-CORES-SQUARE (K1 § 3.5: every closed axis-parallel square of side above 1), by K1's blind route through this library's kernel covering theorem for the square; that route "not compared with the first deriver's S5–S7" (K1 § 3.5). Posed form: C132-CORES |
| C132-EXT | E1 | derived | derived from: C132-EXT-DISC | 1 | C132-EXT-DISC | the claim as posed; nothing later |
| C132-CORES | E1 | derived | derived from: C132-CORES-FREE | 1 | C132-CORES-FREE | the claim as posed; nothing later |
| C132-CONFINE | E1 | derived | hand | 1 | — | **widened**: holds for every set `K`, no compactness, no connectedness, "the direction clauses use neither `H` nor `x ∈ K`" (K1 § 2.3, blind), proved in Lean on the branch, not landed. **Used** by C132-M-ORBIT's M4 (E3) and C132-TURN-EDGE (E4) |
| C132-FILL | E2 | derived | hand | 1 | C132-EXT-DISC's steps S4–S5, S7 | nothing later |
| C132-NOESS | E2 | derived | hand | 1 | — | corrects card 3's frame (item 5 (b)); nothing later |
| C132-REL | E2 | derived | hand | 1 | C132-FILL's setting | E6's riding control: at circumradius 1/2 the unit circle about a vertex passes through three vertices, outside this entry's hypothesis; E2's script compares strictly in floating point (a tool defect, E6's report) |
| C132-INDEX | E2 | derived | hand | 1 | — | **a second derivation, blind**: K1 § 2.3, "one lemma (`sixStep`)" for this entry and C132-RING-WIND, with models (`indexModel`); K1 has not compared it with E2's (its § 3.7 item 2); compared here, § 2.5 below |
| C132-RING-WIND | E2 | derived | derived from: C132-INDEX | 1 | C132-INDEX | **a second route, blind**: K1 § 2.3 — "RING-WIND does not use INDEX" (jumps of the lift at most 1, never matched at `π/3`) |
| C132-ORBIT | E2 | derived | hand | 1 | — | applied to a colouring it rests on the release's Corollary 5.4, taken at its statement by E2; the proof was read by E3 (M0), one mind (item 8 (ii)) |
| C132-TRI-STRIP | E2 | derived | hand | 1 | C132-EXT-DISC's clauses (1)–(3) as hypotheses | **widened**: C132-WIT-STRIP (E5; a fixed witness per edge in place of a continuum with a limiting direction), whose corollary it is; the leaf under both is C132-WIT-SIDE (E5) |
| C132-SEP | E2 | derived | hand | 1 | — | nothing later |
| C132-RING-TAME | E2 | stalls at: the first clause | hand | 1 | — (posed by E2 as the stalled step) | its class split by the asking lane (item 11): the second clause went to the ring card (C132-TURN; C132-ALT and C132-TURN-EDGE derived toward it); the first clause, for all weak colourings, left this milestone for FS-127 and FS-128 (item 23 (b)) |
| C132-LONG | E2 | stalls at: the winding number … | hand | 1 | — | C132-M-CV stalls with it; nothing later |
| C132-M-ORBIT | E3 | derived | hand | 1 | C132-CONFINE; the release's Lemma 5.2 (1) and Cor. 5.4 read locally at six | **restated**: C132-WIT-ORBIT (E5) — the same theorem with four points; K1 § 3.4 makes the four-point form the Lean leaf and proves the compact-set form from it. **Read**: M1–M6 reworked by E5 from the argument; M4–M9 read line by line by K1 after a blind route that stopped at M8 (K1 §§ 2.3, 3.1, 3.2). **Read off, not entered**: K1's blind route gives the label forced outside the ring on the mixed set, `a_{τ(k)+2}` (K1 § 3.1) |
| C132-M-EXCL | E3 | derived | derived from: C132-M-ORBIT | 1 | C132-M-ORBIT | restated: C132-WIT-EXCL (E5); K1 derived it blind from C132-M-ORBIT (§ 2.3; proved in the skeleton from two unproved leaves) |
| C132-M-EMPTY | E3 | derived | derived from: C132-M-EXCL | 1 | C132-M-EXCL | the claim's fixed form; nothing later |
| C132-RUN-EMPTY | E3 | stalls at: V6-HUBS | hand | 1 | — (a reading) | its dictionary term for a tip is too wide (E3's own step table, row V6-TIP; a correction owed to the plan) |
| C132-RUN-CV | E3 | stalls at: FS112-N3-DENSE3 | hand | 1 | — (a reading) | nothing later |
| C132-DIAG-WIDE | E3 | derived | hand | 1 | the release's Lemma 6.4 read at six | **attributed**: for colourings of the whole plane it is an instance of the release's Lean theorem `two_state_impossible`, proved there at every number of labels (K1 § 2.3; item 25; the claim list's dated line); this milestone's part is the reading on an open set containing the closed unit disc |
| C132-DIAG | E3 | derived | derived from: C132-DIAG-WIDE | 1 | C132-DIAG-WIDE | the claim as posed |

### 2.2 Round two

| entry | rec. | verdict | grade | minds | from | later |
|---|---|---|---|---|---|---|
| C132-CROSS | E4 | derived | hand | 1 | — | its step B1 is C132-WIT-SIDE (E5, the same night, another mind: "nothing of either record is wrong", item 18). **Control re-run**: `hex7-crossings` at circumradius 1/2 — own labels near a crossing point 0 → 36 of 432, each inside that vertex's unit circle; the entry untouched, the zero at 2/5 was the margin (E6 § The two riding controls) |
| C132-COMP-SHARP | E4 | derived | derived from: C132-CROSS | 1 | C132-CROSS | nothing later; posed for the kernel lane after the first statements (item 15 (b)) |
| C132-COMP | E4 | derived | derived from: C132-COMP-SHARP | 1 | C132-COMP-SHARP | the claim as posed; E5 reads its proviso as "at a distance other than 1 from each of that centre's three witnesses" (E5's report) |
| C132-WITNESS | E4 | derived | hand | 1 | — | used by E6 (C132-PLACED's line PL5); with C132-WIT-SIDE it gives C132-SHADOW's content (E6's prior-art line), which E6 derives directly |
| C132-PLACE | E4 | derived | hand | 1 | C132-M-ORBIT's M2 (the chart); C132-CROSS's B1 | used by C132-ALT, C132-TURN-EDGE (E4), C132-LENS, -LENS-FOUR, -PLACED-RING (E6). Its read-off for the turning ring corrected in one place: the asking lane's hunch holds on outer-pure ring points only (item 16) |
| C132-ALT | E4 | derived | hand | 1 | C132-PLACE; C132-M-ORBIT's M7 | **second route, read off, not entered**: C132-SHADOW gives its cases O, I and I, O with no unit-pair shift (E6 § The list). **[cert], in a family**: the search refuses the alternating ring in all sixteen variants and finds it satisfiable exactly when this entry's four pair classes are removed together (SEARCH-1007-ALT) |
| C132-TURN-EDGE | E4 | derived | hand | 1 | C132-PLACE; C132-CONFINE | used by C132-PLACED (E6, inherited, read, not reworked). A sentence beside it, not in the entry — "Every pattern of sides has such a point … the side is opposite at antipodes" — is false as written (E6 § The gap in clause (ii)); the entry does not use it |
| C132-TURN | E4 | stalls at: … a witness at the ring point … | hand | 1 | — | **the stall reworded** (item 21; the claim list's dated line): not "the relation of clause (5)" but "that a witnessed triangle given at a point lies in that point's own transition graph — a statement no entry of this list asserts"; the statement carries a defect its poser names; not re-posed |
| C132-WIT-ORBIT | E5 | derived | derived from: C132-M-ORBIT | 1 | C132-M-ORBIT | **the four-point form**: K1's Lean leaf `no_outside_orbit_points`, at the whole plane (K1 § 3.4) |
| C132-WIT-EXCL | E5 | derived | derived from: C132-M-EXCL | 1 | C132-M-EXCL | nothing later |
| C132-WIT-STRIP | E5 | derived | hand | 1 | — (its last clause: the end of the proof of the release's Lemma 8.1) | its strip clauses sit on C132-WIT-SIDE (E5, a later stage) |
| C132-WIT | E5 | derived | derived from: C132-WIT-ORBIT, C132-WIT-EXCL, C132-WIT-STRIP | 1 | the three | the claim as posed; "not a widening" for the two exclusions — the asking lane's `generalization` item is a restatement (E5 § The exclusion, step by step) |
| C132-WIT-SIDE | E5 | derived | hand | 1 | — | the leaf for the strips and for C132-CROSS's B1; the entry that crosses for the strips (items 18 (c), 24) |
| C132-WIT-MARGIN | E5 | derived | hand | 1 | — | **control re-run**: `margin-witness` at circumradius 1/2 — the vertex's labels on the annulus 0 → 6,672: the entry's hypothesis fails there, the entry untouched (E6) |
| C132-WIT-CROSSED | E5 | derived | hand | 1 | — | nothing later |
| C132-WIT-SUPER | E5 | derived | hand | 1 | — (the proof of the extraction's clause (3), reworked from E1's S2, S7, S9) | takes the extraction's place in the kernel lane's queue (item 24) |
| C132-WIT-EX-FIN | E5 | derived | derived from: C132-EXT-DISC | 1 | C132-EXT-DISC | one of clause (5)'s two consumers |
| C132-WIT-EX | E5 | stalls at: the selection of a point … | hand | 1 | — | its open form left this milestone (item 23 (b)); as posed it is met at points where none of the cycle's labels is present (E5's statement defect) |
| C132-GRUNDY7-NOT | E5 | derived | hand | 1 | — | nothing later |
| C132-GRUNDY7-LOCAL | E5 | derived | hand | 1 | — | nothing later |
| C132-GRUNDY7 | E5 | stalls at: the second clause | hand | 1 | — | the second clause withdrawn as posed (item 19 (a)); its two readings left this milestone (item 23 (b)) |

### 2.3 Round three

| entry | rec. | verdict | grade | minds | from | later |
|---|---|---|---|---|---|---|
| C132-SHADOW | E6 | derived | hand | 1 | — | nothing later |
| C132-LENS | E6 | derived | derived from: C132-SHADOW | 1 | C132-SHADOW; C132-PLACE (inherited, its `uses only:`) | nothing later |
| C132-LENS-SIDE | E6 | derived | derived from: C132-LENS | 1 | C132-LENS; C132-WIT-SIDE | nothing later |
| C132-LENS-FOUR | E6 | derived | derived from: C132-LENS | 1 | C132-LENS; C132-PLACE | nothing later |
| C132-LENS-GERM | E6 | derived | derived from: C132-LENS-SIDE | 1 | C132-LENS-SIDE | nothing later |
| C132-LENS-II | E6 | gap: "pure sides are opposite at antipodes …" | hand | 1 | — | stands as a gap, not re-posed (item 29 (a)) |
| C132-PLACED-RING | E6 | derived | hand | 1 | C132-PLACE | nothing later |
| C132-PLACED | E6 | gap: whether any pair containing a label of T is a witnessed edge at y | hand | 1 | C132-LENS, -LENS-FOUR, C132-WIT-SIDE, C132-WITNESS, C132-TURN-EDGE, C132-PLACED-RING | nothing later; C132-ARC, behind it, was not reached |

### 2.4 The kernel planner's record (K1), and the day's search

| statement | where | what it is | status in its own record |
|---|---|---|---|
| C132-CONFINE, for every set | K1 § 2.3 | wider than E1's entry | "TRUE, proved in the skeleton"; built on the branch; not landed |
| C132-DIAG-WIDE at the whole plane | K1 § 2.3 | an instance of the release's `two_state_impossible` (`States.lean:243`, every `k`) | "TRUE at `U = ℂ` given the release's" theorem; the planner's own blind derivation "is the release's proof" |
| C132-INDEX, C132-RING-WIND | K1 § 2.3 | "one lemma (`sixStep`), and RING-WIND does not use INDEX" | "TRUE", by hand, blind; sixteen unproved leaves in the skeleton; one leaf unpriced (path lifting) |
| C132-CORES-FREE's route; C132-CORES-SQUARE | K1 §§ 2.3, 3.5 | every closed axis-parallel square of side above 1 | "route:"; "posed by the planner"; the release's Lemmas 7.3, 7.4, 7.6 at general `k` "read", not re-derived; "not compared with the first deriver's S5–S7 … unread" |
| C132-M-EXCL from C132-M-ORBIT | K1 § 2.3 | the ring form | proved in the skeleton from two unproved leaves |
| C132-M-ORBIT | K1 §§ 2.3, 3.1–3.4 | blind: "OPEN IN PHASE 1 past its first-order steps"; open: "holds by M1–M9 … I found no gap" | "Grade: two minds on M7–M9 (the deriver; this reading), M8 no longer unread"; not done: the derivers' controls re-run; M0's reading of the release's two proofs |
| the four-point form | K1 § 3.4 | `no_outside_orbit_points`; the compact-set form proved from it | the leaf, unproved; "Compactness of the `K j` is not used at all" |
| SEARCH-1007-TURN3, -TURN4, -ALT, and the simple-straight null | `plans/SEARCH-2026-10-07.md` § Theorems, Stage 3 | nulls and models in the seven-flower wedge family F | [cert]: LRAT proofs verified by `cake_lpr`; models re-checked cold at two radii; the four refutations of the requested object re-verified by the coordinator (item 20) |
| SEARCH-1007-TURN3-HAND | the same record § 1.5 | the three-label null by five steps | "[hand, one mind, unchecked by a second]"; **E6**: steps 1–2 hold for measurable germs; step 3's first rule holds and is C132-LENS; **step 3's second rule fails for germs only measurable**; step 4 is of the same kind; step 5 not checked |

### 2.5 The index lemmas, compared (the brief's item)

The planner was given the two statements (`data/fs132/claims-K1.md`) and read them back clause by clause (K1 § 2.2): for
C132-INDEX, "no label has a positive coordinate both at φ(e) and at φ(Re)" as `∀ t i, ¬ (0 < φ t i ∧ 0 < φ (t + sixty) i)`
and the degree as the integer of a continuous lift; for C132-RING-WIND, `J` finite and "`∀ t ∈ J, t + sixty ∉ J`" as
hypotheses and a winding number congruent to 3 modulo 6. **The statements are E2's two, unchanged.** What the planner means
by "one lemma" is a proof: with the triangle's circumference 3 (E2 uses 6), disjoint supports at two positions force a step
in `[1, 2] + 3ℤ`, a step at an end forces a vertex, the step function `g(θ) = f(θ + π/3) − f(θ)` stays in one such
interval — for a continuous lift by continuity, for a ring's step lift because each jump is at most 1, no jump of `f` meets
one of `f(· + π/3)`, and the intervals are 2 apart — and six steps sum to `3d`, the two extreme sums being excluded. E2's
C132-INDEX is that argument for a continuous lift ("the step … lies in [2, 4] modulo 6 with the ends only at vertices, six
steps sum to 6d", as item 7 records it); E2's C132-RING-WIND builds a continuous loop from the step function and applies
C132-INDEX, where the planner applies the six-step sum to the step lift directly. So: **two statements, as E2 has them;
one six-step lemma under both, as the planner has it; for C132-INDEX the same route found twice, the second time blind;
for C132-RING-WIND two routes.** The entries keep `minds: 1` (their source's field): the planner's is a paragraph by hand
whose Lean leaves are unproved, and it has not read E2's entries (its § 3.7 item 2). Whether the count becomes 2 — "blind
to: the deriver's record; method: the same six-step sum" — is held for the coordinator.

### 2.6 Chains, checked against the entries (the brief's list)

- **The exclusion.** C132-M-ORBIT (E3, hand) ⟸⟹ C132-WIT-ORBIT (E5: an instance one way, `Δ({p, q}) ⊂ Δ(K)` the other;
  control `delta-monotone`) — one theorem. C132-M-EXCL from C132-M-ORBIT by Cor. 5.4; C132-M-EMPTY its instance at an
  extracted centre with a four-cycle, reading clauses (1) and (3). K1's leaf is the four-point form at the whole plane.
  Checked: each `grade:` line names its input; no hypothesis is dropped along the chain (the fixed form *adds* the
  extraction's clauses, which the argument does not read).
- **The strips.** C132-WIT-SIDE (E5, hand; one witness, one side, no properness) under C132-WIT-STRIP (E5, hand; three
  witnesses, the majority rule; its last clause needs properness and the release's Lemma 8.1), under C132-TRI-STRIP (E2,
  hand; continua with limiting directions — the witness chosen close to `x` on the wanted side); the ring card's step B1
  (inside C132-CROSS) is C132-WIT-SIDE; C132-SHADOW (E6) is the same rule from an open one-label piece in place of an
  exclusion set. Checked: C132-TRI-STRIP's excluded directions ("perpendicular to a `v_j`", at most six) are the limit of
  C132-WIT-STRIP's (`2 f·(q_j − x) = |q_j − x|²`) as the witness tends to `x`; no entry claims purity of both sides.
- **The complementary pair.** C132-CROSS (hand; a covering count, no properness) ⟹ C132-COMP-SHARP (six labels, disjoint
  triples: one of the six sets lies on the unit circle about the common unit point) ⟹ C132-COMP as posed (its proviso
  makes that impossible at one crossing point). Checked: the posed form's proviso is used exactly once, through clause (2).
- **Centres exist.** C132-EXT-DISC with no centre in the disc ⟹ C132-CORES-FREE (any closed disc of radius above 1) ⟹
  C132-CORES (radius 8, as posed). C132-CORES-SQUARE (the planner's) would give C132-CORES-FREE; it is posed with a route.
- **The extraction.** C132-EXT-DISC ⟹ C132-EXT (posed) and ⟹ C132-WIT-EX-FIN (E5). Clauses (4) and (5) are E1's additions;
  clause (5) is the one that contradicts the manuscript's sentence "The extracted cycle need not consist of edges of Γ_x".
- **The two-pair ring.** C132-DIAG-WIDE ⟹ C132-DIAG; the wide form at the whole plane is the release's Lean theorem.
- **The index lemmas.** § 2.5.

No two entries were found that cannot both hold. One place where two records read against each other give a third
statement, already an entry: the ring card's sentence "at an inner-pure `y` the inside holds `a` and `b` only" (E4 § Where
C132-TURN stalls, (i)) against C132-LENS (the lens between two outer-pure neighbours carries only the centre's labels) —
together they say a ring point between two outer-pure neighbours has no pure inner side, which is C132-LENS-SIDE.

## Stage 2 — SAVED
