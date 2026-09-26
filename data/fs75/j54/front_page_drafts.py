#!/usr/bin/env python3
"""FS-75 close (J54, stage 5): the front-page drafts for CLAUDE.md, LEDGER.md and plans/FRONTIER-STUBS.md, machine-checked.

The pattern is J53's (data/fs100/j53/front_page_drafts.py). Each draft is an (anchor, replacement) pair. Because one front-page job
applies FS-100's drafts and these together, the check first applies FS-100's drafts (imported from J53's file) in memory, then these,
and asserts every one of these anchors occurs EXACTLY ONCE in the post-FS-100 text; it also reports, for information, whether each
anchor is present before FS-100's drafts. CLAUDE.md's net (these drafts only) must be at most 1,500 bytes (J54's brief). Nothing is
written to any file: this script only reads.

    python3 data/fs75/j54/front_page_drafts.py            # the check; exit 0 iff every anchor is unique and the budget holds
    python3 data/fs75/j54/front_page_drafts.py --plant    # plants an anchor that does not exist; must exit 1
    python3 data/fs75/j54/front_page_drafts.py --markdown # prints the drafts as the plan's §R-close shows them
"""
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / "data" / "fs100" / "j53"))
import front_page_drafts as fs100  # noqa: E402  (J53's drafts; read only)

CLAUDE = [
    ("What the kernel holds — FS-75 (row 119)",
     "and Lemma NP (row 107);",
     "and Lemma NP (row 107); **FS-75** — `χ(ℚ(√167)²) ≥ 4`, the first field-level lower bound at an exposed field of the "
     "conjecture, with no finite graph: the criterion's ⟹ in winding form and a checker for `Θ₃` certificates (row 119);"),
    ("Open milestones — FS-75's minimal instance closed",
     "`plans/FRONTIER-STUBS.md`'s closed list): row 88's question",
     "`plans/FRONTIER-STUBS.md`'s closed list): FS-75's minimal instance (row 119; `plans/FS75-derivation.md`; the stub "
     "re-aimed); row 88's question"),
    ("Last updated — FS-75's close (after FS-100's clause)",
     "(`plans/FS100-three-field-lemma.md` §R-close).",
     "(`plans/FS100-three-field-lemma.md` §R-close). Then FS-75's minimal instance (row 119) — **Paid (kernel)** "
     "(`plans/FS75-kernel-167.md` §R-close)."),
    ("Paths forward — FS-75's row (rank 5; no rank moves)",
     "S1 and no mixing in the kernel (row 99), with FS81-T2 and T22's ⟹ as the named hand inputs … | none; the falsification "
     "field's best bound from a checker's word to the kernel's |",
     "**minimal instance landed** (row 119: `χ(ℚ(√167)²) ≥ 4`); next the family theorem (row 82), the winding its first input; "
     "then S1 and no mixing (row 99) … | none; the falsification field's best bound is now the kernel's |"),
    ("Paths forward — FS-60's row",
     "row 83's structural certificates are the per-field fallback) …",
     "row 83's structural certificates are the per-field fallback); V2-format `Θ₃` certificates are one line each through "
     "FS-75's consumer (row 119) …"),
    ("G79 — FS-75's record (after FS-100's)",
     "row 116).*",
     "row 116); so did FS-75's kernel port (the winding every three-colouring carries, row 119).*"),
    ("What compute actually helps — the price instance",
     "(`plans/M2-kernel-lane.md` §R-close 3e).",
     "(`plans/M2-kernel-lane.md` §R-close 3e). **FS-75 once more** (4.5 h planned, 45 minutes): even the re-price from the "
     "first two leaves ran 2–3× high, and the saving came from the obligation pass cutting the statement's analytic half, not "
     "from Mathlib (`plans/FS75-kernel-167.md` §R-close 4d)."),
    ("Trust ledger — the audit's count (inventory 33; the fact audit needs the reviewed transition ('1130','5') → ('1193','5'))",
     "current audit reads 1130 clean and 5 declared purchases (and 11 axiom-free; 1,146 records at M2's close)",
     "current audit reads 1193 clean and 5 declared purchases (and 11 axiom-free; 1,209 records at FS-75's close)"),
    ("The gate — the vacuity counts (inventory 47)",
     "`declarations=7051 refutations-skipped=304",
     "`declarations=7279 refutations-skipped=309"),
]

ROW119 = (
    "| 119 | **`χ(ℚ(√167)²) ≥ 4` in the kernel, with no finite graph: a proper three-colouring of any abelian Cayley graph "
    "carries a winding — an additive `W` on the relation lattice with `Σ_j min(r_j, 2r_j) ≤ 3W(r)` — and a passing "
    "relation-branching `Θ₃` certificate leaves none; T41's 36-vector certificate passes, so the plane over every real field "
    "holding `√167` needs four colours** (FS-75's minimal instance, 2026-09-26, J52 and J52K; `plans/FS75-kernel-167.md`, "
    "`plans/FS75-K-kernel-167.md`; register `plans/FS75-derivation.md` FS75-W, C, T, H). **[kernel; standard three axioms, no "
    "native purchase]** The winding is FS73-T42's forward lift read on words: steps in `{1, 2}`, path-independent by the square "
    "argument, `≡ 0 (mod 3)`, bounded below by the box — no averaging, compactness, duality, torsion-freeness or generation "
    "hypothesis, so the kernel never meets `θ` or the real point. The checker is V2's format with integer multipliers, sound by "
    "mutual structural recursion on the nested tree; its sign guard and the hypothesis `s j ≠ 0` are necessary (FS75-N1, N2). "
    "The consumer takes any `d`, `D` and any real `F ∋ √d`; `Sqrt167.cert_check` runs in 12.2 CPU s at 5.5 GiB. The "
    "conjecture's widest gap now has its lower end in the kernel (four proven, at least six predicted; G59). **Not claimed:** "
    "the criterion's ⟸ or its `θ` form; the 60-vector trees; ℚ(√47)'s `θ`-space tree (another checker); the family theorem "
    "(row 82). **Prior art:** the bound is row 79's (FS-73), the lift T42's; the winding form not found stated (FS-75's close, "
    "fourteen zbMATH queries) — its ingredients are Minty's integer tensions, `[Chandgotia2017]`'s heights and "
    "`[CGHO2025coh]`'s cocycles; the kernel forms ours. | `ThreeColour.lean`, `ThetaCert.lean`, `ThetaPlane.lean`, "
    "`Instances/SqrtOneSixSeven.lean` (+ `/Cert.lean`); `tools/j52_intcert.py`, `tools/j52k_plant.py` | FS-75 (crunch "
    "2026-09-26) |"
)

LEDGER = [
    ("§ A — row 119 after row 118 (FS-100's last)",
     "`plans/FS100-three-field-lemma.md` §PA.3 | FS-100 (crunch 2026-09-26) |\n",
     "`plans/FS100-three-field-lemma.md` §PA.3 | FS-100 (crunch 2026-09-26) |\n" + ROW119 + "\n"),
    ("row 79 — Not claimed: the kernel form is row 119",
     "the kernel form (stub `plans/STUB-three-colour-criterion-kernel.md`)",
     "the kernel form, which is row 119 (FS-75)"),
    ("§ B — FS73-T22's kernel column",
     "`plans/FS73-derivation.md` T22 | **stub** (`plans/STUB-three-colour-criterion-kernel.md`) |",
     "`plans/FS73-derivation.md` T22 | kernel for ⟹ in winding form (`ThreeColour.nonempty_winding_of_colorable`, row 119); "
     "⟸ and the `θ` form stub (`plans/STUB-three-colour-criterion-kernel.md`) |"),
    ("§ B — FS73-T39's kernel column",
     "`plans/FS73-derivation.md` T39 | **stub** (box-LP checker + T22's ⟹; `plans/STUB-three-colour-criterion-kernel.md`) |",
     "`plans/FS73-derivation.md` T39 | kernel for the field bound, through T41's sub-lattice "
     "(`four_le_chromaticNumber_planeOver_sqrt167`, row 119); the 60-vector trees not |"),
    ("§ B — FS73-T41's kernel column",
     "`plans/FS73-derivation.md` T41 | with T39's stub (its smallest instance) |",
     "`plans/FS73-derivation.md` T41 | kernel: its 1,050-leaf certificate (`Sqrt167.cert_check`, row 119); the four-case hand "
     "proof not |"),
    ("§ B — FS73-T42's kernel column",
     "`plans/FS73-derivation.md` T42 | with T39's stub |",
     "`plans/FS73-derivation.md` T42 | kernel, steps 1–3 without the averaging (`ThreeColour.nonempty_winding`, row 119) |"),
    ("the claim list — Ours (the owner's call; stage 5's decision 5b)",
     "on its solenoid (row 118);",
     "on its solenoid (row 118); the winding form of the three-colour criterion's ⟹ as a `Θ₃` certificate's semantics, and "
     "the certificate's kernel checker (row 119);"),
]

STUBS = [
    ("FS-75's row — the question cell (landed; next)",
     "| **Re-aimed at FS-91's close:** S1 over every real number field",
     "| **Minimal instance landed 2026-09-26 (row 119; `plans/FS75-kernel-167.md` §R-close):** `χ(ℚ(√167)²) ≥ 4` in the kernel, "
     "no finite graph, by T22's ⟹ in winding form and a checker for V2's certificates; **next the family theorem (row 82)**, "
     "the winding its first input, then FS81-T2's inverse limit and C1(5)'s cells; ℚ(√47)'s `θ`-space tree needs a second "
     "checker. **Re-aimed at FS-91's close:** S1 over every real number field"),
    ("FS-75's row — the cost cell",
     "| T22's ⟹ unpriced (price from its first two leaves); C1(5) a finite computation; the rest short |",
     "| T22's ⟹ in the kernel (winding form; 45 minutes against 4.5 h planned); FS81-T2's inverse limit next; C1(5) a finite "
     "computation; the rest short |"),
    ("FS-75's row — the status cell",
     "| minted at FS-73's close; re-aimed at FS-81's close ; re-aimed at FS-91's close |",
     "| minted at FS-73's close; re-aimed at FS-81's close ; re-aimed at FS-91's close; minimal instance closed and re-aimed "
     "2026-09-26 |"),
    ("FS-60's row — the question cell",
     "the upper halves need the number-field residue step (FS-37/FS-47) |",
     "the upper halves need the number-field residue step (FS-37/FS-47). **Since FS-75's minimal instance (row 119)** every "
     "V2-format `Θ₃` certificate is one line through `ThetaPlane.four_le_chromaticNumber_of_cert`, once "
     "`tools/j52_intcert.py` takes `(d, D)` (`Ld65c8ee8` over `d = 11` first) |"),
    ("FS-60's row — the status cell",
     "| minted 2026-09-17; input set grown by FS-61 |",
     "| minted 2026-09-17; input set grown by FS-61; re-aimed at FS-75's close |"),
]


def apply(text, drafts, label, report=True):
    ok, net = True, 0
    for name, old, new in drafts:
        n = text.count(old)
        delta = len(new.encode()) - len(old.encode())
        if report:
            print(f"  {'ok  ' if n == 1 else 'FAIL'} {delta:+5d} B  {name}  (anchor found {n}x)")
        if n != 1:
            ok = False
            continue
        text = text.replace(old, new, 1)
        net += delta
    return text, ok, net


def check(plant=False):
    ok_all = True
    for fname, fs100_drafts, mine, budget in (("CLAUDE.md", fs100.CLAUDE, CLAUDE, 1500),
                                              ("LEDGER.md", fs100.LEDGER, LEDGER, None),
                                              ("plans/FRONTIER-STUBS.md", [], STUBS, None)):
        raw = (ROOT / fname).read_text(encoding="utf-8")
        before = {name: raw.count(old) for name, old, _ in mine}
        base, ok100, _ = apply(raw, fs100_drafts, "FS-100", report=False)
        if not ok100:
            print(f"FAIL: FS-100's drafts no longer apply to {fname}; re-run J53's check")
            ok_all = False
        drafts = list(mine) + ([("PLANT (an anchor that does not exist)", "no such anchor text, J54 plant", "x")]
                               if plant and fname == "CLAUDE.md" else [])
        print(f"{fname} (after FS-100's drafts):")
        _, ok, net = apply(base, drafts, "FS-75")
        print(f"{fname}: FS-75's net {net:+d} bytes" + (f" (budget {budget})" if budget else ""))
        print("  present before FS-100's drafts too: "
              + ", ".join(f"{name.split(' — ')[0] if ' — ' in name else name}={before[name]}" for name, _, _ in mine))
        if budget is not None and net > budget:
            print(f"FAIL: over budget by {net - budget} bytes")
            ok = False
        ok_all = ok_all and ok
    print("RESULT:", "PASS" if ok_all else "FAIL")
    return 0 if ok_all else 1


def markdown():
    for title, drafts in (("CLAUDE.md", CLAUDE), ("LEDGER.md", LEDGER), ("plans/FRONTIER-STUBS.md", STUBS)):
        print(f"##### {title}\n")
        for name, old, new in drafts:
            if name.startswith("§ A"):
                print(f"- **{name}** — insert after FS-100's row 118:\n\n  {ROW119}\n")
            else:
                print(f"- **{name}** — replace `{old}` with:\n\n  {new}\n")


if __name__ == "__main__":
    if "--markdown" in sys.argv:
        markdown()
        sys.exit(0)
    sys.exit(check(plant="--plant" in sys.argv))
