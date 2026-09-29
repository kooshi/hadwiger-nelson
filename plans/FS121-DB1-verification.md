# FS121-DB1 — a blind second mind on C121-ENDS, C121-OUT, C121-PER and C121-LRA-LINE

*Job FS121-DB1 (Ephodos, verification form; Opus 5.5), brief `data/fs121/briefs/FS121-DB1-verify.md`, started 2026-09-29 05:45 UTC.
The four statements are FS-121's frozen list's (`data/fs121/claims.md` § 2), each quoted verbatim in its `verification:` block. Blind, the
same model as the minds whose work this record compares against once its verdicts are committed. Addresses in this record resolve from
`plans/`.*

## Theorems this phase proved

*(Filled at stage 2, when the verdicts are committed.)*

## Would-have-searched-here log (standing rule 5)

- None so far. No move of this job is a search: every check is a hand derivation or an exact identity on a formula-given object.

## Fence log (standing rule 8)

- 2026-09-29 05:47 UTC. `ls plans/ | grep -E "FS121|…"` and `ls data/fs121/` printed the names `plans/FS121-close-inventory.md`,
  `plans/FS121-map-step.md` and the directory names `briefs d1 o1 reports`: names only. No fenced file was opened and no content was
  shown. Disclosed for completeness.
- The session's opening git status showed recent commit subjects (`FS-116, FS-121: round 1 briefs`, `FS121-O1: report`, `FS121-O1:
  stage 5`, …): neutral subjects, no content.

## Stage 1 — SAVED: readback, what was given, the registered expectations

### 1.1 Files read, in order (all open to this job)

1. The brief, in full; `plans/STANDING-RULES.md`, in full; my agent file (the identity already loaded).
2. The frozen list `data/fs121/claims.md`, in full: §§ 0–4. **This includes the other claims of the list** (C121-R2-FOUR,
   C121-CURVED, C121-NOLRA, C121-SAT6, C121-REGJ) and their *not claimed*, *Inhabitant* and *Role* lines, which show what the list's
   author expects: that an (R2) centre may carry exactly three colours (R2-FOUR is posed as open), and that no curved tangent inhabitant
   and no LRA inhabitant are held.
3. The held inputs' homes: `plans/FS111-M-regularity.md` lines 176–500 (§§ 2–5.4: M-SATC, M-SLACKFREE, R7, M-DEADLOCK, M-PINCH, M-C11,
   M-EXTREME, M-COVER-SC, M-HALF, M-POLAR, REG-J's verdict, M-REDUCE-I); `plans/FS111-M2-regularity.md` §§ 4.1–4.4 (M2-INTRAD with its
   proof, M2-REDUCE-A, M2-DISCK7); `plans/FS111-derivation.md`, the entries M-PINCH, M-C11, W-NOBEND, W-NOREP, W-NEG, W-SQ9, W-HEX9,
   W-KB-DIR, W-LADDER, W-HEXSAT, M2-INTRAD, M2-REDUCE-A, M4-LADDER, M4-CUT, M4-HC, M4-MOVE and § The named gaps; `plans/FS111-W-wild.md`
   §§ 2.1–2.4 (W-C11, W-NOREP's proof, W-LADDER); `plans/FS112-derivation.md` lines 1–30 and the entries FS112-U1, N3-NOBOTH, N3-FAIL;
   `plans/FS112-N-proof.md` N3-NOBOTH's proof (lines 725–740); `plans/FS112-NB3-verification.md` § NB3-NOBOTH; the top of
   `data/fs111/claims.md`.
4. Preloaded at launch: `CLAUDE.md` (its § The aim and the Frontier's item 31 describe route M, rows 139–141 and the stuck ray) and the
   grokkings, among them **G84** (contact; ladders of unit parallels) and **G85** ("Saturated interfaces have integer radii … What escapes
   is radii → ∞, FS-115's stuck ray").

### 1.2 Given (the cut, recorded as it happened)

- **The statements**, verbatim, with their *not claimed*, *Colours* and *Inhabitant* lines, and the list's definitions and held inputs.
- **No verdict, sketch or route for any of the four** was in the brief; it says "Derive or refute each" and names TRUE, FALSE, GAP and
  MISSTATED as results. The brief's framing sentence "two of these statements say so of their own class" (the vacuity rule) is given.
- **The held derivations** that these statements visibly build on — M-PINCH, M-C11, M2-INTRAD (its proof text includes the sentence
  "*Not proved:* that only finitely many `n` occur near a point … This is FS-112's stuck ray in another form" and "a radius-2 arc would sit
  concentric with a unit arc of kind both"), W-NOREP and its proof, FS112-N3-NOBOTH and FS112-U1 — were read before any derivation of
  mine. They are the list's inputs, open by the brief; a route through them is not a route I brought, and the `method:` lines say where
  mine departs.
- **What I knew before:** nothing of these four statements; the grokkings G84–G85 and CLAUDE.md's Frontier.

### 1.3 Readback (standing rule 3)

`python3 tools/fs121_db1_quotes.py` (output `data/fs121/db1/quotes.out`, exit 0): the brief's four quotations occur verbatim, whitespace
aside, in the frozen list (4 of 4); the list's §§ 0–1 quotations occur verbatim in their open sources (15 of 15; the sixteenth, FS-116's
qualification, has a fenced source and was not checked). With `--plant` (output `data/fs121/db1/quotes_plant.out`, exit 1) one character is
changed in one quotation of each part, and both are reported missing: the check fires. **No mismatch: nothing to report about the brief.**

derivation: DB1-readback
  statement: the brief's four quoted statements occur verbatim, whitespace aside, in data/fs121/claims.md, and every checkable quotation in that list's sections 0 and 1 occurs verbatim in its open source
  uses only: string comparison after collapsing whitespace
  not claimed: anything about the truth of the statements; the quotation of FS-116's opening, whose source is fenced for this job
  argument: § 1.3 Readback (standing rule 3)
  verdict: derived
  grade: computed over: the brief's four quoted blocks and the frozen list's sections 0 and 1 (16 quotations, 15 checkable)
  minds: 1
  model: C121-ENDS's block, 864 characters, found
  prior art: known: the frozen list itself — a textual check, not mathematics
  handoff: none — a readback for the coordinator

control: db1-quotes
  of: DB1-readback — every quotation found; the fault changes one character in one quotation of each part
  run: python3 ../tools/fs121_db1_quotes.py --summary
  expect: failures: 0
  fault: python3 ../tools/fs121_db1_quotes.py --summary --plant

### 1.4 The question sent (2026-09-29 05:58 UTC, to "main")

C121-LRA-LINE's "an interface curve with normal ν there" has two readings at a point of Σ where several interface curves meet: **(a)** ν is
the normal of the curve that carries the accumulating pieces; **(b)** ν is the normal of any interface curve through `x₀`. Off Σ they agree.
Asked which is meant, with two smaller wording points (C121-ENDS's "carrying at least three colours", distinct or counted by sectors;
"tile" in (R2)'s definition inside a saturated colouring), where both readings lead to the same verdict. Keryx acknowledged at 01:03 and
relayed the author's answers (FS121-O1, verbatim as Keryx quoted them), received 01:07, before any derivation in this record:

> "1. C121-LRA-LINE: reading (a). ν is the normal at x₀ of the interface curve on which the accumulating pieces lie, taken as the one-sided
> limit if x₀ ends that curve. It is not the normal of any other curve through x₀.
>
> 2. C121-ENDS, the (R2) branch: the first clause, "at least three colours", counts sectors. It means the outer colour and at least two
> further sectors, of colours other than the arc's two side colours, where those two sectors may carry one colour twice. Distinctness is
> claimed only in the second clause, "at least three distinct colours when no colour at z has density 0".
>
> 3. (R2)'s "an inner-colour tile along the radius-2 circle over the whole arc": your reading is the one meant. It is the inner colour's
> region lying just beyond the radius-2 arc along the whole arc, possibly in several components, not one single component."

So reading (a) counts for C121-LRA-LINE's verdict (reading (b) is recorded too), and the (R2) branch's first clause counts sectors. The
author's answers fix meanings only; they carry no verdict.

### 1.5 Registered expectations (written 2026-09-29 06:05 UTC, before any derivation is written in this record)

*Honest timing:* these are **informed** priors. Before writing them I had read the inputs' homes (§ 1.1) and spent some time reasoning
about the four statements in my head, so they are not naive. They are fixed here, in their own words, before any argument is written.

| statement | expected verdict | probability | likeliest break |
|---|---|---|---|
| C121-ENDS | derived (TRUE) | 0.75 | the clause "at least four when no colour at z has density 0": it needs a no-repeated-colour lemma at a point of Σ. W-NOREP is held only "at a cone vertex of a saturated map without cusps", and its case (ii) uses the density of the partner at the centre of a unit arc. A partner that is only a cusp, at distance 1 from `z`, is where it would fail — GAP there |
| C121-OUT | derived (TRUE) | 0.85 | points of Σ along the successive outer parallels, in case they cut the angular window instead of removing single normals |
| C121-PER | derived (TRUE) | 0.75 | its (Q) clause, which is ENDS's weak step; and the step "doubly periodic with ¬LRA ⟹ finitely many radii" |
| C121-LRA-LINE | derived (TRUE) under reading (a); a GAP under reading (b) | 0.7 | a point `x₀` of Σ where the accumulating pieces lie on a curve whose normal is not the ν named |

Planned route, written before deriving: work in the local picture that REG-J′ gives (finitely many arcs at each point of Σ, curvilinear
sectors between them), and derive the colour counts at a centre from properness straddles, not from maps. Where a held input is used
outside its stated scope, derive the scope's extension or name the gap.

Stage 1 committed: see `git log -- plans/FS121-DB1-verification.md`.
