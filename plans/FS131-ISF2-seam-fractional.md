# FS131-ISF2 — the fractional chromatic number over ℚ(√3, √11): the merge of `main`, the ruled docstring edit, the gate

*de Bruijn, the implementer (Opus 5.5), 2026-10-17. Brief: `data/fs131/briefs/FS131-ISF2-seam-fractional.md` (on `main`,
commit `f45252bf8`). Worktree `.claude/worktrees/kcs1`, branch `fs131-ksf1`, at `39a5dd2a4` when this job started (the
predecessor FS131-ISF1's last commit; its record `plans/FS131-ISF1-seam-fractional.md`). Working files: `data/fs131/isf2/`.*

## Theorems this phase proved

None: every proof was done by FS131-ISF1 (its record's "Theorems this phase proved"). This job merges, edits two docstrings,
and runs the gate; the kernel theorems it gates are listed with their axioms at stage 3.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations, checked against their sources

`tools/fs131_isf2_quotes.py` (a copy of FS131-ISF1's `fs131_isf1_quotes.py`, its plant moved to the first quote: this brief
has two) takes each block quotation closed by `— source: <path>`, strips the `>` prefixes, collapses whitespace on both sides,
and requires the quote in its source in `main`'s tree or this branch's. Result (`data/fs131/isf2/quote_check.out`): **2 quotes,
2 FOUND, exit 0** — item 1092 (2,312 characters) and item 1089 (2,778), both in `plans/FS131-close-inventory.md` in `main`'s
tree (this branch predates both items). Planted control (`--plant`: `seam-fractional` → `seam-fractionaI` in the first quote):
it reads MISSING with the longest prefix found, exit 1 (`quote_check_plant.out`).

The words the ruled edit replaces are in `main`'s tree as the brief says: `RationalFour/Compulsion.lean` l. 27–28 and
`RationalFour/Forbid.lean` l. 18–19, each `prior art: pending` at a line end and `` `[KubickiLehelMorayne2002]`). `` on the next,
inside the module docstring's **Not claimed** paragraph.

### 1.2 What the merge must keep

The merge has **two merge bases** (`git merge-base --all`): `6ce038671` and `0c47f7b02`, the planner FS131-KFS1's stage 4,
which holds **both** skeletons, Part A's (`RationalFour/*`) and Part B's (`Instances/SeamFractional`). This branch deleted Part
A's skeleton (`eac56a860`, item 1082 ruling 3); FS131-IRF1 deleted Part B's (its stage 1). A trial merge (`git merge-tree
--write-tree`, `data/fs131/isf2/merge-tree-trial.out`) gives seven conflicts:

| file | conflict | resolution |
|---|---|---|
| `RationalFour/Basic`, `Order`, `Compulsion`, `Forbid` | modify/delete (deleted here, proved on `main`) | `main`'s version — byte-equal in `Proofs/`, `Proofs.lean`, `scripts/` and the package files to IRF1's gated `6ab6248fe` (`git diff 6ab6248fe main` empty there) |
| `Instances/SeamFractional` | modify/delete (proved here, deleted on `main`) | this branch's version — equal to stage 4's `4cb2056c4` |
| `Proofs.lean` | content | both sides' import lines |
| `ARCHITECTURE.md` | content | both sides' rows |

Five of these are proof modules, which the brief says to message at once: messaged; the coordinator confirmed the resolution
(item 1094: "the landed RationalFour from main, byte-equal to 6ab6248fe in Proofs/; this branch's SeamFractional; both sides
kept in ARCHITECTURE.md and Proofs.lean"). No proof or statement of either landing changes; the statement dumps show it (stage 2).

The gate's other inputs move on `main` only (`scripts/Axioms.lean`, `scripts/vacuity-baseline.txt`); this branch adds its own
entries to them at stage 3 (the audit block for `Plane/G27/*` and `SeamFractional`, the vacuity header's counts, and whatever
the assumptions step and the controls ask).

**Build files.** The worktree's `.lake/build` is FS131-ISF1's green build of `39a5dd2a4` (the G27 modules, up to about 5 GB
each to compile, are in it and unchanged by the merge). `main`'s modules that this branch does not have are the four
`RationalFour` modules; their compiled files come from the main tree's build (current for `main`: FS131-IRF1's gated build,
moved there, item 1089), by checksum, those four modules only. `Compulsion` and `Forbid` then recompile for the docstring edit,
and the root for its imports.

### 1.3 The edit

In `Proofs/HadwigerNelson/RationalFour/Compulsion.lean` and `RationalFour/Forbid.lean`, the module docstrings only:
"prior art: pending `[KubickiLehelMorayne2002]`" → "prior art: not found in print (FS131-PAS2, FS131-PAS3;
`CLOSED-QUESTIONS.md` § 3)". Nothing else in them. Shown twice (`LEAN.md` § Searching — Lean, FS131-LC1): in text, the files
with every block comment removed are the same as `main`'s; from the kernel's side, a dump of the two modules made before the
build and after it.

### 1.4 The order of work

1. Merge `main`; resolve as in 1.2; the docstring edit; copy `main`'s four `RationalFour` builds in by checksum (listing
   before and after); the statement dump **before** the build (the merged tree's `SeamFractional`, the four hand-written
   `Plane/G27` modules and the four `RationalFour` modules, from the compiled files as given); the build under the slot; the
   dump **after**; the comparisons — before against after, `SeamFractional`/`G27` against FS131-ISF1's
   `statements-after.txt.gz`, `RationalFour` against FS131-IRF1's. A saved stage.
2. The gate on one commit: the audit block (`data/fs131/isf1/lean/AxiomsAll.lean` over `data/fs131/isf1/modules.txt`), the
   controls, the vacuity header, the assumptions ledger, then the steps of `data/fs131/clone1/run-gate.sh` copied under
   `data/fs131/isf2/`; every count change explained against `main`'s last gate (`data/fs131/irf1/gate/`); the new vacuity
   sites with each structure hypothesis's inhabitant named; `#print axioms` of every head. A saved stage.
3. The drafts' counts, restated with their slots. The report.
