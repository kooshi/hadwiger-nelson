# FS131-I3i — `localSectors`, the separation lemma, and the cusp-free four-colour clause

*Job FS131-I3i, de Bruijn the implementer (Opus 5.5), 2026-10-04. Brief: `data/fs131/briefs/FS131-I3i-localsectors.md` (main tree), with
`plans/STANDING-RULES.md`, `LEAN.md`, `RUNNING.md` § Building and § Make the gate fail. Worktree `.claude/worktrees/fs131-w3b`, branch `fs131-w3b`,
from `origin/main` at `0ff8f659`. Working files `data/fs131/i3i/`. No agents, no search.*

## Theorems this phase proved

*(Filled at the gate, from the saved audit log.)*

## Stage 1 — SAVED: readback

**The quotation.** The brief quotes I3h's handoff:

> **Not done: `localSectors`, `Simple.coneAt_eq_angleIcc_sep`, `four_of_bothKind_simple` without `hnc`** (brief item 8; the budget's hand-back line was reached at

Source: `plans/FS131-I3-implementation.md` § Stage 11, line 413 on this branch. **Matches verbatim** (the brief cuts the sentence where the source
continues "the landing).").

**The other addresses the brief names**, each read:
- the draft `data/fs131/i3/h/LS.lean` — `branchPt`, `sectorBetween`, `BranchGerms` (`nextβ`, `nextκ`, `sector`, `Sorted`), `ArcMap.IsSectorChart`,
  `localSectors : ∃ r₀ n G, F.IsSectorChart G v r₀` with one `sorry`; **elaborates** against the landed module (`lake env lean data/fs131/i3/h/LS.lean`:
  one warning, "declaration uses `sorry`" at line 93, nothing else);
- inventory item 136 (main tree `plans/FS131-close-inventory.md` l. 814): branch germs with direction and signed curvature, sectors between consecutive
  branches, finite and constant in `r`, each sector's cone an interval — the draft's fields carry each;
- `plans/FS131-E2-derivation.md` § 2.7: the statement of `Simple.coneAt_eq_angleIcc_sep`; § 2.4: the proof shape of the four-colour clause; § 2.2–2.3:
  FS131-E2-SECT, -ONESECT, -SEP;
- inventory item 139 (l. 837): the ruling — `hnc` is mathematically unnecessary; restore `05cb0a3e`'s statement;
- `git show 05cb0a3e:Proofs/HadwigerNelson/Plane/RingGerm.lean`, l. 300–303: `four_of_bothKind_simple (hF : F.Valid) (hN : F.NonSiamese) (hS : F.Simple)
  {z : ℂ} (hz : z ∈ F.dom) {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc z θ₁ θ₂ c c') (hc : c ∈ F.coloursAt z) (hc' : c' ∈ F.coloursAt z) :
  4 ≤ (F.coloursAt z).ncard` — the landed statement differs only by the extra hypothesis `hnc`.

**The build as given.** `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from the worktree at `0ff8f659`: "OK — all 1737
modules already up to date, nothing built, 0 module(s) with warnings, 3s" (`data/fs131/i3i/build-stage1.log`; `build/gate/build/20261004T140251Z-4044353.log`).
The copied build directory is current.
