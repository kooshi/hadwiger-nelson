# FS131-QA3 — the definitions audit: waves 4 and 5's definitions and source-restating clauses, each read against its source (de Bruijn, Opus)

*Brief: `data/fs131/briefs/FS131-QA3-definitions.md`. Read-only toward every `Proofs/` file, worktree and branch. Started 2026-10-04 22:29 UTC.*

## Theorems this phase proved

None. This is an audit: its results are findings (a definition or clause that says less, more, or other than its source), each with a
counterexample, and verdicts of fidelity.

## Stage 1 — SAVED

### 1.1 The brief's quotations (standing rule 3)

Each quotation in the brief checked against its source by reading the source lines:

| quotation | source | result |
|---|---|---|
| item 231's first line ("**FS131-I5 mid-job, a definition defect in KB's skeleton** (message 2026-10-04): `BaseCtx.retArcs_nested` … cannot be proved by any") | `plans/FS131-close-inventory.md` l. 1656 | verbatim (a truncated first line, marked as such by the brief's "each item continues there") |
| item 241's first line ("… **`cvb_hole_disconnected` is false as written**, because Lean's `IsHoleOf` is weaker") | same, l. 1725 | verbatim |
| item 251's first line ("… `Contact.lean` on `fs131-w4c` at `addcfbf3`, l. 4065): the clause") | same, l. 1797 | verbatim |
| item 255's first line (Kooshi's approval, *"That audit is approved, but no special slot. It must use one of the"*) | same, l. 1828 | verbatim; the sentence continues *"4, as we have no usage headroom for a fifth."* |
| the inhabitant rule ("inhabitant** in the same file, or a one-line note naming the theorem that supplies one. **The inhabitant exercises every clause**: a") | `LEAN.md` § The gate | verbatim |

No mismatch. The "known and ruled" items (142, 158, 213/227, 231/232, 241/242, 251/252) were read in full (l. 866, 1045, 1503, 1629,
1656–1663, 1725–1733, 1797–1807), and items 256–265 for the current state (item 258: `pair_i` gains `h3 : dist u₁ u₂ < 3`; item 263: the
second move into `Cone`).

### 1.2 The code read, and its revisions

Read by `git show <branch>:<path>` at these heads (2026-10-04 22:29 UTC); a later commit on a branch is outside this audit unless named:

| branch | head | modules audited |
|---|---|---|
| `fs131-w5` | `0db34854` | `Plane/ValidMap/Chain`, `Terminal`, `Dense`, `HexRing`, `MapGraph`, `BaseWalk`, `BaseDense` |
| `fs131-w4` | `d391f480` | `Plane/ValidMap/Basic`, `Sectors`, `UnitArc`, `BaseSteps`, `Plane/SVMap`, `Plane/StuckChain` |
| `fs131-w4c` | `9988cbb8` | `Plane/ValidMap/Contact` |
| `fs131-w4m` | `aee53d57` | `Plane/ValidMap/Moves`, `Cone` |

Wave 5 carries older copies of wave 4's modules (`Basic` 690 lines against `fs131-w4`'s 802; the difference is 112 added lines on
`fs131-w4`, no change to a definition read here). Wave 4's definitions are read on `fs131-w4`.

### 1.3 The census instrument

`tools/fs131_qa3_census.py` (imports FS131-QA1's parser read-only): `list` prints every definition and theorem of the audited modules
from the git refs; `check <tsv>` confirms a committed census still names declarations at their refs. Self-test: 4 controls OK; planted
fault (structures dropped from the kinds) **fired** ("missed Bar", exit 1). Output `data/fs131/qa3/census-raw.tsv`: **208 definitions
and constructions, 802 theorems** across 16 modules, no module missing.

Of the 208 definitions, the ones that are **predicates or vocabulary a source defines** (the audit's object) number about 100; the rest
are **constructions** (`bowtie*`, `sevenBrick*`, `holed*`, `cusp*`, `halfDisc*`, `l60*`, `iso*`, `brickCorner*`, `rayParam`, `reul`),
whose fidelity matters only as models and which are sampled, not censused. The clauses audited are those of the **row statements and
supporting lemmas** (the theorems whose docstrings name a row or a source step), not the children an implementer added.

### 1.4 The method, per item

For each definition: (1) find the source sentence that defines the term (the derivation the docstring cites, else the row, else the
planner's read-back); (2) quote it; (3) try to build **an instance the Lean admits and the source excludes** (too weak), **one the source
admits and the Lean excludes, or no non-degenerate instance at all** (too strong), or **an idiom change** (pointwise for directional,
set-level for pathwise, closure-level for boundary, `∀ᶠ r` for "near", `encard` for "number"); (4) a verdict: MATCH, MATCH-WITH-READING
(a reading the planner recorded, which I check is harmless for the consumers), or FINDING. Order: wave 5's definitions that most
statements rest on first (`Chain`, then `Terminal`, `HexRing`, `BaseWalk`, `MapGraph`), then wave 5's row clauses, then wave 4's
`Basic` (which everything rests on), `BaseSteps`, `UnitArc`, `Sectors`, `SVMap`, `StuckChain`, `Contact`, `Cone`, `Moves`.
