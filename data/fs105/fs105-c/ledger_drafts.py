#!/usr/bin/env python3
"""FS105-C's drafted edits to LEDGER.md, plans/FS100-derivation.md and plans/FS103-derivation.md, as exact (old, new) pairs,
plus the new LEDGER.md § B rows, for the front-page job FS105-X.

The close planner edits none of these files. --check applies every draft to copies in --dir (default: this job's scratch
directory), asserts each old text occurs exactly once, and checks with tools/fs71_ledger_b_check.py's own parsers that every
FS105 derivation entry has exactly one § B row and every FS105 § B row has an entry.

    python3 data/fs105/fs105-c/ledger_drafts.py --check [--dir D]
    python3 data/fs105/fs105-c/ledger_drafts.py --self-test     # a planted § B row with no entry must be caught
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / "tools"))
import fs71_ledger_b_check as b  # noqa: E402  (read-only use of its parsers)

L120_GRADE_OLD = ("[hand; PE-2 two derivations blind to each other (X02D, X02V), EL2021 Thm 1.2 by statement (external, in print; its "
                  "proof in EL2021 §§2–9, unread here); EF_F⁺ two derivations blind to each other (X01D, X12B) and a checking reading "
                  "(X01V, after its blind GAP, withdrawn as its own error); MR a composition, three minds]")
L120_GRADE_NEW = ("[hand; PE-2 two derivations blind to each other (X02D, X02V), applying EL2021 Thm 1.2 by statement — announced as "
                  "EL2003 Thm 1.1, whose proof there is an outline (§6), it rests on EL2021 Thm 1.3 (external, published) and a deduction "
                  "EL2021 never writes (FS105-DED, two minds, one blind); its hypotheses read on the pieces at ℚ(√635087) (FS105-R) and "
                  "at de Grey's field (FS105-R; FS105-W, separately); EL2021 read at §§1, 2, 4 and the last step of Thm 4.1's proof in "
                  "full, its cited leafwise-measure machinery unread — a reading gap, not a mathematical one; EF_F⁺ three derivations "
                  "blind to one another (X01D, X12B; FS105-B at ℚ(√635087), with EF_F⁰) and a checking reading (X01V, after its blind "
                  "GAP at the multiplier step, withdrawn for the premise FS105-B met blind); MR a composition, three minds; at degree 16 "
                  "one checking walk (FS105-W)]")

EDITS: dict[str, list[tuple[str, str, str]]] = {
    "LEDGER.md": [
        ("r120-grade", L120_GRADE_OLD, L120_GRADE_NEW),
        ("r120-count", "(`U_ℚ` alone gives `c·M^{1/[F:ℚ]}`)",
         "(`U_ℚ` alone gives `(4/π + o(1))M^{1/[F:ℚ]}` in `H_L`, and any positive exponent suffices — FS105-W-H, W-G)"),
        ("r120-sataev", "(on 𝕋; Sataev 1975 first, `[Sataev1975]`, unread)",
         "(on 𝕋; `[Sataev1975]` first, for the case of a semigroup holding the values of an integer polynomial — its abstract read)"),
        ("r120-el", "the positive-entropy input `[EinsiedlerLindenstrauss2022]` Thm 1.2 (EL2003 Thm 1.1);",
         "the positive-entropy input `[EinsiedlerLindenstrauss2022]` Thm 1.3, from which its Thm 1.2 follows (FS105-DED; announced as "
         "EL2003 Thm 1.1, whose §6 is an outline);"),
        ("r120-read", "EL2021 §2 and §4.1–4.3 read (X24R):", "EL2021 §§1, 2, 4 read in full (X24R; FS105-R):"),
        ("r120-unheld", "Sataev 1975 is the circle theorem, unheld)", "Sataev 1975 is the circle theorem)"),
        ("r120-gate", "MR not found under its discipline's names —",
         "MR not found under its discipline's names (five more zbMATH queries at FS-105; `[BekkaFrancini2022]` needs unipotent "
         "generation) —"),
        ("r120-address", "`tools/x12b_multiplier_count.py` | FS-100 stage 5 (crunch 2026-09-26) |",
         "`tools/x12b_multiplier_count.py`; `plans/FS105-derivation.md` §1–§3, `tools/fs105_r_scope.py`, `tools/fs105_b_heights.py`, "
         "`tools/fs105_w_growth.py` | FS-100 stage 5 (crunch 2026-09-26); hardened at FS-105 |"),
        ("r128-dg", "MR at degree 16 as row 120 states it, its walk unexercised",
         "MR at degree 16 walked at FS-105, one checking reading (FS105-MR16)"),
        ("r128-nc", "**Not claimed:** MR at degree 16 (FS-105); the complex-place widening; anything at six.",
         "**Not claimed:** the complex-place widening; anything at six."),
        ("r128-address", "`tools/fs103_v1_checks.py`, `tools/fs103_v2_places.py` |",
         "`tools/fs103_v1_checks.py`, `tools/fs103_v2_places.py`; `plans/FS105-derivation.md` FS105-MR16 |"),
        ("r129-grade", "B-AMEN and B-CHIF one mind; the whole weight MR's (row 120)]",
         "B-AMEN's reverse half and B-CHIF one mind, both off the killing test's chain and off `α₁(ℝ²) = m₁(ℝ²)`, which use only "
         "B-AMEN's Følner half (two blind: F, B; FS105-W-D1); the whole weight MR's (row 120)]"),
        ("r129-test", "**A finite-graph killing test for MR:** any proof that `α₁(ℝ²) > m₁(ℝ²)` refutes MR at ℚ(√635087).",
         "**A finite-graph killing test for MR:** any proof that `α₁(ℝ²) > m₁(ℝ²)` refutes MR at ℚ(√635087). Such a proof must be "
         "(W) a bound `α(G) ≥ c|G|` over every finite unit-distance graph with `c ∈ (0.24699…, 0.249956…)` — above "
         "`[AmbrusEtAl2023]`'s bound on `m₁`, below `[DuczVarga2026]`'s on `α₁`, a window `0.00297` wide and `0.0176` above the best "
         "proved lower bound on `α₁` — or (W′) `χ_f,0(ℝ²) < χ_f(ℝ²)`, through B-CHIF; its cheap form `α₁ ≥ 1/4` was reachable in "
         "print and is false (FS105-W-D1, W-D2)."),
        ("r129-address", "`tools/fs103_f_places.py`, `tools/fs103_b_places.py` |",
         "`tools/fs103_f_places.py`, `tools/fs103_b_places.py`; `plans/FS105-derivation.md` §4 |"),
        ("b-efp", "| hand, two blind derivations + a checking reading |",
         "| hand, three blind derivations (X01D, X12B; FS105-B at ℚ(√635087)) + a checking reading |"),
        ("b-pe2", "| hand, two blind, on EL2021 Thm 1.2 |",
         "| hand, two blind, on EL2021 Thm 1.2 = Thm 1.3 + FS105-DED; hypotheses read at ℚ(√635087), `F_dG` (FS105-PEH) |"),
        ("b-dg", "| tools exact + hand, two blind; MR@16 unwalked |",
         "| tools exact + hand, two blind; MR@16 walked (FS105-MR16, one reading) |"),
    ],
    "plans/FS100-derivation.md": [
        ("pe2", "[hand; two derivations blind to each other, by different routes, both applying EL2021 Thm 1.2 by statement only on "
                "admissible `Γ` — E1 external, in print, its proof in EL2021 §§2–9, unread here]",
         "[hand; two derivations blind to each other, by different routes, both applying EL2021 Thm 1.2 by statement only on "
         "admissible `Γ` — E1: announced as EL2003 Thm 1.1, whose proof there is an outline, it rests on EL2021 Thm 1.3, external and "
         "published, and the deduction FS105-DED, two minds; its hypotheses read on the pieces at ℚ(√635087) and de Grey's field, "
         "FS105-PEH]"),
        ("efp", "[hand; two derivations blind to each other (X01D; X12B), a checking reading by X01V (stage 4, after its blind stage-2 "
                "GAP at \"UZ\", withdrawn for a named reason), readings by the advisor (not independent: X01D writes out its sketch) and "
                "the close]",
         "[hand; three derivations blind to one another (X01D; X12B; FS105-B, at ℚ(√635087), which met X01V's stall blind by the "
         "premise X01V §4.2 named), a checking reading by X01V (stage 4, after its blind stage-2 GAP at \"UZ\", withdrawn for a named "
         "reason), readings by the advisor (not independent: X01D writes out its sketch), the close and FS-105's advisor; walked at "
         "degree 16, FS105-W-G]"),
        ("efg", "EF-G (b) holds (`#U_N ≥ c·N^{1/[F:ℚ]}` via `U_ℚ ⊆ U_F`)",
         "EF-G (b) holds (`#U_N ≥ c·N^{1/[F:ℚ]}` via `U_ℚ ⊆ U_F`; exactly `(4/π + o(1))N^{1/[F:ℚ]}` from `U_ℚ` in `H_L`, FS105-W-H)"),
    ],
    "plans/FS103-derivation.md": [
        ("dg", "MR at degree 16 rests on row 120's statement as written — its walk (C-MR16) unreached by both]",
         "MR at degree 16 walked at FS-105, FS105-MR16, one checking reading]"),
    ],
}

NEW_B_ROWS = """\
| FS105-DED | row 120 | EL2021 Thm 1.3 ⟹ Thm 1.2 (each `G_j` finite or `X`; Abramov–Rokhlin over a finite-fibred factor); EL2003's proof is an outline | hand, two minds (R; D blind) | `plans/FS105-derivation.md` FS105-DED | declined |
| FS105-VC | row 120 | "no virtually cyclic factors" must mean non-trivial ones, else Thm 1.3 is vacuous | hand, three minds (D blind) | `plans/FS105-derivation.md` FS105-VC | declined |
| FS105-NVC | row 120 | irreducible + not virtually cyclic ⟹ `d ≥ 2`, no non-trivial virtually cyclic factor; every `α_Λ′` under total irreducibility | hand, three minds (D blind) | `plans/FS105-derivation.md` FS105-NVC | declined |
| FS105-L21 | row 120 | "no non-trivial virtually cyclic factor" passes to `α_Λ` and to the adelic lift, any action | hand, one mind (half re-checked) | `plans/FS105-derivation.md` FS105-L21 | declined |
| FS105-PEH | row 120 | PE-2 within Thm 1.3's hypotheses at ℚ(√635087) and `F_dG` ((a1)–(a9)); a reading gap at EL2021's cited machinery | hand + reading; one at `F₁`, two at `F_dG` | `plans/FS105-derivation.md` FS105-PEH | declined |
| FS105-H | row 120 | totally real `F`, non-torsion `γ ∈ U`: `h_{m_{M̂}}(γ) ≥ log 2` | hand, one mind | `plans/FS105-derivation.md` FS105-H | declined |
| FS105-L74 | row 120 | EL2021 Lemma 7.4's two Lyapunov weights hold for the pieces directly | hand, one mind; exact at `F_dG` | `plans/FS105-derivation.md` FS105-L74 | declined |
| FS105-SCOPE | row 120 | ℚ(√635087), `F_dG`: totally real, wall broken, `R = O′`; 421 the least totally split prime at `F_dG` | tools exact, two runs per field | `plans/FS105-derivation.md` FS105-SCOPE | declined |
| FS105-B-M1 | row 120 | `R̂ ≅ 𝔸_𝒮/D`, `ker Φ = D`, `T + A = Φ(L + L_∞)` (any real `F`, `R = O′`) | hand, one mind | `plans/FS105-derivation.md` FS105-B-M1 | declined |
| FS105-B-L5 | row 120 | zero entropy of one `u*` makes the `𝔓₀`-coordinate global, `μ`-a.e. | hand, one mind, blind | `plans/FS105-derivation.md` FS105-B-L5 | declined |
| FS105-B-L6 | row 120 | a `U`-invariant finite measure global at one place lives on `T + A` (contractions, no class number) | hand, one mind, blind | `plans/FS105-derivation.md` FS105-B-L6 | declined |
| FS105-B-EFP | row 120 | EF_F⁺ at ℚ(√635087) | hand, blind; three blind with X01D, X12B | `plans/FS105-derivation.md` FS105-B-EFP | declined |
| FS105-B-EF0 | row 120 | EF_F⁰ at ℚ(√635087), ergodicity unused | hand, one mind, blind | `plans/FS105-derivation.md` FS105-B-EF0 | declined |
| FS105-W-H | row 120 | `H_L(q) = (den q)^{[F:ℚ]}` on `U_ℚ`: `(4/π + o(1))M^{1/[F:ℚ]}` multipliers | tools exact, one mind | `plans/FS105-derivation.md` FS105-W-H | declined |
| FS105-W-G | row 120 | EF_F⁺ needs polynomial growth, any exponent; the degree enters constants only | hand (checking) + tools exact, one mind | `plans/FS105-derivation.md` FS105-W-G | declined |
| FS105-W-LW | row 128 | an explicit admissible `Γ` at `F_dG` (421; all 373 proper subfields excluded) | tools exact + hand, one mind | `plans/FS105-derivation.md` FS105-W-LW | declined |
| FS105-MR16 | row 128 | C-MR16: MR at de Grey's field by row 120's proof, walked at degree 16 | checking reading, one mind | `plans/FS105-derivation.md` FS105-MR16 | declined |
| FS105-W-D1 | row 129 | MR(ℚ(√635087)) ⟹ `α₁(ℝ²) = m₁(ℝ²)`, every link named; the killing test uses only B-AMEN's Følner half | checking reading, one mind | `plans/FS105-derivation.md` FS105-W-D1 | declined |
| FS105-W-D2 | row 129 | a refutation must be (W) `α(G) ≥ c\\|G\\|`, `c ∈ (0.24699…, 0.249956…)`, or (W′) `χ_f,0 < χ_f` | derived, one mind | `plans/FS105-derivation.md` FS105-W-D2 | declined |
"""


def apply_all(outdir: Path, extra_row: str = "") -> list[str]:
    misses: list[str] = []
    for rel, pairs in EDITS.items():
        text = (ROOT / rel).read_text()
        for name, old, new in pairs:
            n = text.count(old)
            if n != 1:
                misses.append(f"{rel} {name}: old text occurs {n} times")
                continue
            text = text.replace(old, new)
        if rel == "LEDGER.md":
            text = text.rstrip("\n") + "\n" + NEW_B_ROWS + extra_row
        dest = outdir / rel.replace("/", "__")
        dest.write_text(text)
        print(f"{rel}: {len((ROOT / rel).read_text().encode())} → {len(text.encode())} bytes; copy {dest}")
    # id agreement for FS105, with fs71's own parsers
    ledger = (outdir / "LEDGER.md").read_text()
    rows, _ = b.parse_ledger_b(ledger)
    entries = b.parse_entries((ROOT / "plans/FS105-derivation.md").read_text(), "FS105")
    fs105_rows = {k for k in rows if k.startswith("FS105-")}
    if set(entries) != fs105_rows:
        misses.append(f"id mismatch: entries-only {sorted(set(entries) - fs105_rows)}, rows-only {sorted(fs105_rows - set(entries))}")
    missing = [k for k, v in entries.items() if not all(v["fields"].values())]
    if missing:
        misses.append(f"entries missing fields: {missing}")
    print(f"FS105 entries {len(entries)}, FS105 § B rows {len(fs105_rows)}")
    return misses


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--check", action="store_true")
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--dir", default="/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs105-c")
    a = ap.parse_args()
    out = Path(a.dir)
    out.mkdir(parents=True, exist_ok=True)
    if a.self_test:
        misses = apply_all(out, "| FS105-PLANT | row 120 | a planted row with no entry | x | x | x |\n")
        ok = any("rows-only ['FS105-PLANT']" in m for m in misses)
        print("SELF-TEST", "PASS: the planted row was caught" if ok else "FAIL", misses)
        return 0 if ok else 1
    misses = apply_all(out)
    for m in misses:
        print("MISS:", m)
    print("FAIL" if misses else "PASS")
    return 1 if misses else 0


if __name__ == "__main__":
    sys.exit(main())
