# FS121-D4 — the singular set: C121-REGJ (Ephodos, derivation job, round 3)

*Ephodos (Opus 5.5), job FS121-D4, brief `data/fs121/briefs/FS121-D4-regj.md` with `plans/STANDING-RULES.md` as part of it. Claim:
`data/fs121/claims.md` § 4, C121-REGJ (frozen 2026-09-29 05:41 UTC). Plan: `plans/FS121-map-step.md`. I write only this record,
`data/fs121/d4/`, `tools/fs121_d4_*.py` and `data/fs121/reports/FS121-D4.md`. Entries use my identity's grammar: `hand` is [hand],
`derived from` is [derived], `computed over` is [tools]; verdict `derived` is TRUE, `gap:` is GAP, `refuted:` is FALSE. Started
2026-09-29 07:18 UTC; stopped at 07:42 UTC by an account halt before any commit; resumed 2026-10-03 14:36 UTC (the coordinator's
message). Nothing was lost but the record itself, which is written fresh from the stopped session's notes.*

**Words used below** (this record's, not the list's). A **piece** of colour `c` is a path-connected set of points of density 1 of `S_c`
(FS111-M-HULL2's word). A **region** of colour `c` is a connected component of the interior of `S̃_c` (an open set). `∂_e S_c = A*_c ∖ S̃_c`
(`data/fs111/claims.md` § 0) is the essential boundary of `c`; **saturated** means every point of `∂_e S_c` is a `c`-contact point (some point of
`supp S_c` at distance exactly 1), for every `c` (FS-111's definition, quoted in the claim list § 0). `T₁(w)` is the unit circle about `w`.

## Theorems this phase proved

*(filled at each stage; one line per theorem, grade, minds, address)*

- FS121-D4-QT — the brief's quotation and the record's seven definitions are verbatim (10 of 10) — [tools], one mind — § 1.1.

## Would-have-searched-here log (standing rule 5)

- Stage 1: would have searched for a saturated colouring with an accumulating singular set (a finder over periodic rectangle colourings with a
  refined cell near a point). Did not; the recognition derives what any such colouring must carry first, and every object below is given by formula.
- *Note:* the ban ran to 2026-10-01, and this job resumed on 2026-10-03. The brief and its standing rules are "unchanged" (the coordinator's
  message), and no step of this job needs a search, so I keep the log and run none.

## Fence log (standing rule 8)

No path is fenced for this job. I read no session transcript, no `chats-bak/`, no auto-memory beyond the index the harness showed at launch.
I read `data/fs116/claims.md` (headings and § 10's two statements, to check the brief's pointer), a frozen claim list, not a record of a
blind job. I write nothing where FS121-V3, FS121-V4 or FS116-V3 read: only the four paths above.

## Slips

- **Stage 1:** I built `tools/fs121_d4_quotes.py` before reading `RUNNING.md` § Make the gate fail (standing rule 7 asks for the reading first),
  the opening job's slip repeated. I read it straight after and checked the tool against it: a missing quote exits 1, an unreadable source or an
  empty input exits 2, and the plant (the first quote altered by one character) is reported missing.

## Stage 1 — SAVED: the readback, and the recognition

### 1.1 Readback of the brief

The brief's one verbatim quotation is C121-REGJ, a block quote "— source: data/fs121/claims.md § 4". I checked it, its last sentence and
heading, and every definition this record quotes, with `tools/fs121_d4_quotes.py` (whitespace normalised, nothing else): input
`data/fs121/d4/quotes-brief.tsv`, output `data/fs121/d4/quotes-brief.out`, **10 of 10 found, exit 0**, re-run on resuming (no input changed:
`git log` shows no commit to the claim list or `plans/FS111-derivation.md` since the stop). The plant fires:
`python3 tools/fs121_d4_quotes.py data/fs121/d4/quotes-brief.tsv --plant` reports one missing and exits 0.

- **No mismatch.** Two reading notes, not mismatches. (1) The brief's sentence on the plan's handle ("what every end carries bounds the ends in
  a bounded set; M-EXTREME's two points of Σ per region") is a paraphrase, outside quotation marks; the plan's § 4.2 D4 row reads, verbatim,
  "REG-J′'s universal form: what every end carries bounds the ends in a bounded set. Uses C121-ENDS (every end is a point of Σ of ≥ 3 colours),
  SATPIN's partners on `ω(z)`, M-EXTREME's two points of Σ per region", and the plan's own stage-5 correction strikes its C121-ENDS clause as
  circular — the brief already omits it. (2) The brief says FS-116's RING-GERM and RING-TWIST-C "hold at two minds (`data/fs116/claims.md` § 10)";
  § 10 holds both statements, and a claim list carries no grades, so the "two minds" is the brief's report and not checkable there. I use neither.
derivation: FS121-D4-QT
  statement: the brief's quotation of C121-REGJ, its last sentence and section heading, and the seven definitions this record quotes, occur
    verbatim in their sources (10 of 10, whitespace normalised)
  uses only: string comparison after collapsing runs of whitespace
  not claimed: that a paraphrase outside quotation marks is faithful (the plan's handle, read separately above)
  argument: § 1.1 Readback of the brief
  verdict: derived
  grade: computed over: the 10 rows of data/fs121/d4/quotes-brief.tsv
  minds: 1
  model: row 1, C121-REGJ in data/fs121/claims.md § 4
  prior art: known — a bookkeeping check, not mathematics
  handoff: none — a readback

control: FS121-D4-QT-RUN
  of: FS121-D4-QT — all ten quotations found; with the first quote altered by one character the checker reports it missing
  run: python3 ../tools/fs121_d4_quotes.py ../data/fs121/d4/quotes-brief.tsv | tail -1
  expect: quotes: 10  found: 10  missing: 0
  fault: python3 ../tools/fs121_d4_quotes.py ../data/fs121/d4/quotes-brief.tsv --plant | tail -2 | head -1

- **My claim, restated beside the quotation.** C121-REGJ, verbatim: "in every honest saturated colouring in D-NF, with any number of colours, the
  singular set Σ is locally finite and each point of Σ meets finitely many interface arcs." It may not rest on C121-ENDS, C121-OUT, C121-PER or
  C121-LRA-LINE. I owe one entry with its verdict, its colour count and its inhabitants, an entry for every lemma, and the report.

### 1.2 Recognition (`ephodos-recognition`, invoked fresh at this stage)

**The stall.** No derivation has been attempted: the claim is posed universal at every `k`, with three inhabitants (R7, SQ9, HEX9) and no
refuting object held. Its shape is the plan's own: a wall that describes a counterexample (the stub's existence form), with the structural form
asking what every end carries. The plan's handle — M-EXTREME's two singular points per region — counts Σ per region, so it bounds Σ only if
regions are counted; nothing held counts them.

**For a stranger** (a geometer who works on sets avoiding one distance, and on parallel curves): *Partition the plane, up to a null set, into
finitely many measurable classes so that no class contains a positive-measure set of pairs at distance exactly 1. Call the partition saturated if
every point where a class has positive upper density but not density 1 lies at distance exactly 1 from a point of that class's support. Off a
"singular set" — the boundary points where more than two classes meet, or a class is locally disconnected, or a class has density 0 but is
present — each boundary is a curve squeezed between two tangent unit discs, one of each class. Is the singular set locally finite?*

**Features, sorted** (the receipt in brackets):
- *No monochromatic unit pair* — **determines** [every step below consumes it, through FS111-C-HULL's first clause: a piece meets no unit
  circle about a point of its own colour's density set].
- *Saturation* — **determines**, split: consumed only as "a boundary point of a class has a point of that class's support at distance exactly 1"
  [the facing lemma of stage 2 consumes exactly this at one point].
- *Finiteness of `k`* — **determines**; *the value of `k`* — **accompanies** [the grid argument of stage 2 uses a pigeonhole on finitely many
  colours, and never their number; with infinitely many colours the product construction of stage 2 accumulates freely].
- *The dimension two — the curvature of the unit circle, read as lateral extent* — **determines**, and this is the recognition's finding [the
  analogue on the line, the unit graph `x ~ x ± 1`, whose "unit circle" is two points, is FALSE with two colours (stage 2, FS121-D4-LINE); in the
  plane the obstruction that bounds ends needs a same-colour piece with lateral extent `ρ` facing a flat side across a gap `g < ρ²/2`
  (FS121-D4-FACE)].
- *Honesty* — **accompanies** the facing lemma (it needs one colour at one point only) and **determines** where M-PINCH is used (the hole lemma).
- *The colour count per region (M-EXTREME's two points)* — **accompanies** [regions can be arbitrarily small in a saturated colouring, by formula
  at `k = 16` (stage 2, FS121-D4-TINY16), so a per-region count bounds nothing per unit area].
- *The complexity bound, measurability's details* — **accompany** (no step reads them).

**Homes, each with its test:**
1. **Free-boundary regularity of optimal partitions** (Caffarelli–Lin; spectral minimal partitions in the plane, whose singular set is locally
   finite). Dictionary: class ↔ cell; saturation ↔ optimality; Σ ↔ the singular set. *Killed* as a theorem home: its proofs run on monotonicity
   formulas for an energy, and the dictionary line "first variation" is blank here (the opening killed it on the same line).
2. **Totally separable packings** (the Fejes Tóths, 1973; Bezdek): a packing in which every two bodies are separated by a line meeting no body.
   Dictionary: below the unit scale, properness and saturation say that the unit circles through a piece's boundary points (nearly lines at small
   scale) cut no piece of the same colour — a separability condition. *Test:* it predicts a neighbour: **separable families accumulate freely**
   (tiny squares in a grid), so no argument that reads only a neighbourhood of radius below 1/2 can prove local finiteness — any proof is
   non-local, through the partners at distance 1. Kept as the reason the argument must be non-local; not a theorem home.
3. **Parallel curves and the ladder** (the opening's home): a flat side's partner is its unit translate along the normal. *Test:* the old proofs
   apply (the facing lemma is the ladder's first rung read against a second piece), and it **predicts** the lateral-extent obstruction: the unit
   circles about the partners curve back by `t²/2` at lateral offset `t`, so a same-colour piece in front at gap `g` is crossed once its lateral
   half-width exceeds `√(2g)`. **Adopted as the working home.**
4. **One-dimensional dynamics** (`x ↦ x + 1` on the line; skew products with colour shifts): the line analogue. *Test:* its proofs apply verbatim
   and give the opposite answer — FALSE — which sorts the dimension as a determiner. Kept as the calibration.

**The recognition sentence:** *a saturated colouring's ladder translates every flat side by one unit along its normal, and the unit circle's
curvature turns a same-colour piece of lateral half-width `ρ` lying in front of that side, at a gap below `ρ²/2`, into a positive measure of
monochromatic unit pairs; so what bounds the ends in a bounded set is the finite colour count read through lateral extent — a pigeonhole on
pieces with width — and what escapes it is accumulation of pieces that shrink in every direction.*

**It differs from the plan's handle.** The plan's § 4.2 aims at a per-region count (M-EXTREME). The recognition says the bound is a count of
colours against lateral extent, and that per-region counts bound nothing per unit area (TINY16). Reported to Keryx.

**What it predicts, to be derived at stage 2:** (a) the facing lemma, universal; (b) TRUE on colourings constant on the cells of a grid, by (a)
and a pigeonhole; (c) FALSE on the line; (d) regions as small as wished at a fixed `k`; (e) a region with a hole has its whole shore singular
(the same ladder read inward, where the curvature has no room) — so islands accumulating in one sea are excluded unless every shore is singular.

## Stage 1 — SAVED
