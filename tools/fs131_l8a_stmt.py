#!/usr/bin/env python3
"""FS131-L8A — no statement of either side changed by the join: the elaborated statement check of the wave, over all
eleven modules of the ring calculus, against either tip.

The instrument is the sibling implementer's `tools/fs131_i8d_stmt.py` (another job's; imported, not edited): for each
module it elaborates the module as it stood at a base commit (`git show <base>:<path>`) and as it stands in the
working tree, each with one appended command that prints every declaration as the kernel has it (name, kind, the
structural hash of its type, a definition's value hash, the type printed with full names), and requires every
declaration of the base to be present now, unchanged. Declarations added since the base are listed, never failed. It
reads `ConstantInfo.type`, not text: an `include … in` that adds a binder under an unchanged text is seen.

What this wrapper changes, and nothing else:
  * the module list gains `Plane/RingCalculus/OuterAdj`, which that tool's list does not hold (eleven modules);
  * the planted faults are in the modules the join brings together — one in each side's module, one in the module
    new at the join, and one in a definition:
      theirs   a hypothesis of `semiHub_places` altered in the text of `SemiHubPlaces` (`ncard = 4` to `ncard = 5`)
      ours     `include hbad in` above `ringArc_star` in `SemiHub`: the text of the statement is unchanged and the
               kernel's statement gains the hypothesis `0 = 1`
      new      a binder added to `not_sole_outer_of_adjacent_changePoints` in `OuterAdj`
      def      the definition `IsEdgeDir` of `SemiHub` altered (`T ≠ T'` weakened to `(T ≠ T' ∨ True)`): read by the
               definition's value hash
    `--self-test` first runs with no fault to learn the changed set, then requires each control's changed set to be
    that set plus exactly the planted declaration (the discriminating form: an exit status alone is not read). A
    control whose module is absent at the base cannot fire there and is reported UNREACHABLE, which fails the
    self-test: run the self-test against a base that holds every module (the sibling's tip, `989a0393`).

Exit 0: every base declaration unchanged, or the changed set is exactly `--expect`. Exit 1: a difference (printed).
Exit 2: the instrument could not run (a source failed to elaborate, or printed no signature) — never read as a pass.

Usage, from the worktree root, after a build:
  tools/fs131_l8a_stmt.py --base <ref> [--expect NAME ...] [--fault NAME] [--self-test] [--out FILE]
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs131_i8d_stmt as base_tool  # noqa: E402

D = base_tool.D
NS = base_tool.NS
OUTERADJ = D + "OuterAdj.lean"
if OUTERADJ in base_tool.MODULES:
    sys.stderr.write("INSTRUMENT FAILURE: the imported tool's module list already holds OuterAdj; re-read this wrapper\n")
    sys.exit(2)
base_tool.MODULES = base_tool.MODULES + [OUTERADJ]
if len(base_tool.MODULES) != 11 or len(set(base_tool.MODULES)) != 11:
    sys.stderr.write(f"INSTRUMENT FAILURE: {len(base_tool.MODULES)} modules listed, eleven expected\n")
    sys.exit(2)

# name: (module, old text, new text, the declaration the fault must make appear in the changed set)
base_tool.FAULTS = {
    "theirs": (D + "SemiHubPlaces.lean",
               "theorem semiHub_places (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1) {ψ : ℝ}\n"
               "    (hS : F.SimpleOn {p, ringPt p ψ, ringPt p (ψ + π / 3), ringPt p (ψ - π / 3)}) (h4 : (F.coloursAt p).ncard = 4)\n",
               "theorem semiHub_places (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1) {ψ : ℝ}\n"
               "    (hS : F.SimpleOn {p, ringPt p ψ, ringPt p (ψ + π / 3), ringPt p (ψ - π / 3)}) (h4 : (F.coloursAt p).ncard = 5)\n",
               NS + "ArcMap.semiHub_places"),
    "ours": (D + "SemiHub.lean",
             "theorem ringArc_star (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})",
             "variable (hbad : 0 = 1)\ninclude hbad in\n"
             "theorem ringArc_star (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})",
             NS + "ArcMap.ringArc_star"),
    "new": (OUTERADJ,
            "(h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' Y Y' : Fin k}\n"
            "    (hy : F.IsChangePoint p ψ X X') (hy' : F.IsChangePoint p (ψ + π / 3) Y Y')\n"
            "    (hv : ¬ F.GermOnQ p (ψ - π / 3) .ccw) (hu : ¬ F.GermOnQ p (ψ + 2 * π / 3) .cw) (c : Fin k) :\n"
            "    ¬ (F.outerTileColours p (ringPt p ψ) = {c} ∧ F.outerTileColours p (ringPt p (ψ + π / 3)) = {c}) := by\n"
            "  rintro ⟨hO, hO'⟩",
            "(h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' Y Y' : Fin k}\n"
            "    (hy : F.IsChangePoint p ψ X X') (hy' : F.IsChangePoint p (ψ + π / 3) Y Y') (hextra : 0 < ψ)\n"
            "    (hv : ¬ F.GermOnQ p (ψ - π / 3) .ccw) (hu : ¬ F.GermOnQ p (ψ + 2 * π / 3) .cw) (c : Fin k) :\n"
            "    ¬ (F.outerTileColours p (ringPt p ψ) = {c} ∧ F.outerTileColours p (ringPt p (ψ + π / 3)) = {c}) := by\n"
            "  rintro ⟨hO, hO'⟩",
            NS + "ArcMap.not_sole_outer_of_adjacent_changePoints"),
    "def": (D + "SemiHub.lean",
            "  F.TileAt p T ∧ F.TileAt p T' ∧ T ≠ T' ∧ δ ∈ coneAt T p ∧ δ ∈ coneAt T' p",
            "  F.TileAt p T ∧ F.TileAt p T' ∧ (T ≠ T' ∨ True) ∧ δ ∈ coneAt T p ∧ δ ∈ coneAt T' p",
            NS + "ArcMap.IsEdgeDir"),
}

if __name__ == "__main__":
    if "--base" not in sys.argv:
        sys.stderr.write("usage: tools/fs131_l8a_stmt.py --base <ref> [--expect NAME ...] [--fault NAME] [--self-test] [--out FILE]\n"
                         "(no default base: a join has two tips, and the reader says which)\n")
        sys.exit(2)
    base_tool.main()
