# FS131-LCH1 — the five-colour chain's landing, part 1: the join with `main`, and the ruled integrations

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-LCH1-join.md` (with its two amendments of 2026-10-14 21:34
and 21:36 UTC). Branch `fs131-wlc`, cut from `fs131-wm15` at `77d9d27ce` in the tree `.claude/worktrees/fs131-wq1`.*

## Theorems this phase proved

*(filled at the hand-back)*

## Stage 1 — SAVED (the readback)

**Quotations.** `tools/fs131_lch1_quotes.py` checks each `> …` block of the brief against its named source at
`bd3bd9541`: **7/7 match** (`data/fs131/lch1/quotes.out`); its control mutates one character of every block and
requires every block to fail: **7/7 failed** (`quotes-plant.out`). No mismatch: no finding about the brief.

**The stored statements, dumped before any edit was compiled** (`data/fs131/lch1/lean/StatementDump.lean`, every constant
of every `Proofs.*` module; full text for the modules named in `$LCH1_FULL`, hashes for the rest), run by
`data/fs131/lch1/dump-before.sh` inside one slot:
- the chain tree, its compiled library current for `fs131-wm15` at `77d9d27ce` (`lake build --no-build` under the slot:
  "All targets up-to-date (6125 jobs)", `nobuild-before.log`): **1,938 modules, 27,186 constants**, 2,480 in full-text
  modules (`Rigidity/*`, `Plane/WindowDensity`, `Plane/OneAvoidingDensity`, `Instances/SqrtFortySeven*`,
  `Instances/SqrtClassValues`, `Outside/OAI015*`, `Arith/UpperHalf`, `SpectralChain`);
- `main`'s gated build (`fs131-w10g`): **2,010 modules, 32,014 constants**, 634 in full-text modules
  (`Plane/OneAvoidingDensity`, `Plane/OneClass/*`, `Arith/ThreeFourColours`, `Instances/SqrtFortySeven`, `Arith/UpperHalf`,
  `SpectralChain`, `Plane/DensityBound/Theorem`).

The raw dumps (474 MB and 1.59 GB, `statements-before-{chain,main}.txt`, sha256 in `statements-before.sha256`) stay on
disk uncommitted; what is committed is `data/fs131/lch1/split_dump.py`'s split of each: an index of every constant
(module, kind, name, flags, type hash, value hash, data hash: `statements-before-*.index.tsv.xz`) and the full text of
the full-text modules (`statements-before-*.full.txt.xz`). M13's line (`fs131-wcm3`) is read from FS131-ICM3's own last
dump on that branch (`data/fs131/icm3/statements-after4.txt.xz`, copied to `data/fs131/lch1/m13-icm3-after4.txt`), made
in its worktree (LEAN.md § Searching — Lean: "a module from another branch with a dump made in that branch's worktree").

**The collision scan, predicted and read.** Prediction, written before the kernel-side scan from a source-level prescan
of the 783 names the chain's added files declare against the 3,907 main's added files declare: two names declared in two
modules — `Plane.mOne` (known, item 916) and `Plane.mOne_le_one` (`Plane/WindowDensity` l. 378 against
`Plane/OneClass/Defs` l. 217) — and nothing else. `tools/fs131_lch1_collisions.py` on the three dumps: the chain lines'
57 modules (2,416 constants) and the add/add copy against main's 2,010 modules (32,014 constants): **2 collisions,
exactly the predicted two** (`data/fs131/lch1/collisions.out`); in the add/add module, the chain's copy holds one name
main's lacks (`DEF Plane.mOne`) and main's holds two the chain's lacks (`mOne_eq_iSup_bandFree`, `BandFree.eq_1`). The
control plants one collision and one dropped name and requires both reported: **both reported**
(`collisions-plant.out`). Both collisions were sent to the coordinator at once; ruled (the brief's amendment of 21:36
UTC). The eleven `InvariantLaw` helpers to be made public and `UpperHalf.exists_I_integer` are names neither dump
declares publicly (checked by name in both dumps): making them public collides with nothing.

**Integration 6 does not go through as ruled** (sent at once; ruled in the amendment of 21:34 UTC): `Plane.oneAvoidingDensityBound`
is declared in `Plane/DensityBound/Theorem`, which imports `Plane/DensityBound/Window`, which imports
`Plane/OneAvoidingDensity`; the two corollaries live in a new module `Plane/MOneBound`.

## Stage 2 — SAVED (the merges)

1. **`main` at `bd3bd9541`**, merged as `f50277130`. Conflicts, each resolved by `data/fs131/lch1/resolve_main.py`
   (decisions printed to `resolve-main.out`):
   - `Plane/OneAvoidingDensity` (add/add): **main's whole** (`git diff bd3bd9541 -- <file>` empty).
   - `Proofs.lean`: both sides (the chain's five `OAI015` imports, main's 32 port imports); one duplicate
     `import Proofs.HadwigerNelson.Plane.OneAvoidingDensity` (both lines added it) removed.
   - `ARCHITECTURE.md`, four hunks: (1) main's (the OneAvoidingDensity row and the density bound's 82 rows; the chain's
     skeleton row dropped); (2), (3) both sides (the chain's Rigidity and Instances rows with main's Arith rows; the chain's
     `OAI015` rows with main's 32 port rows); (4) the trust table: the chain's `positive_entropy_rigidity` row kept, its
     `proper_to_borel_weak` row dropped (a theorem on main since FS131-LP1), main's sentence with its count three.
   - `scripts/Axioms.lean`, one hunk of prose: joined — three imports (Weil's bound, `no_proper_five_coloring`,
     `positive_entropy_rigidity`), the transfer a theorem. The `declareImport` lines auto-merged to exactly those three.
   - `scripts/assumptions-ledger.txt`: the chain's nine `RESTS` rows on `positive_entropy_rigidity` kept; its twelve
     `RESTS` rows on the transfer dropped (main's deletion). The counts are part 2's.
2. **M13's line `fs131-wcm3` at `c0b6798ed`**, merged as `06840bd6a`. One conflict, `ARCHITECTURE.md`'s Rigidity rows
   (`resolve-wcm3.out`): the chain's six current rows kept, M13's `ClassRatio` row taken (its imports cell names
   `Arith/GapSeven` and `Arith/CircleCos`, as the merged module does). `Rigidity/ClassRatio` and `Proofs.lean` auto-merged.

**Neither merge builds alone, by construction**: main's `Plane/OneAvoidingDensity` declares no `mOne`, so the chain's
readers of KR1's definition by its shape (`Plane/WindowDensity`) fail until integration 1; and integration 3 needs M13's
`ratioAtMost_of_two_notMem`. The first build is therefore of both merges with the integrations; every upstream edit
(`Arith/UpperHalf`, `Plane/OneClass/InvariantLaw`) is made before it, so that main's modules are compiled once.
