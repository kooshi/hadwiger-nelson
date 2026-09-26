#!/usr/bin/env python3
"""FS-100 close (J53b, stage 5): the front-page drafts for CLAUDE.md and LEDGER.md, machine-checked.

Each draft is an (anchor, replacement) pair. The check reads the files the front-page job will edit, asserts every anchor
occurs EXACTLY ONCE, applies every pair in memory, and reports the net byte change per file. CLAUDE.md's net must be at most
3,000 bytes (the J53 brief). Nothing is written to CLAUDE.md or LEDGER.md: this script only reads them.

    python3 data/fs100/j53/front_page_drafts.py            # the check; exit 0 iff every anchor is unique and the budget holds
    python3 data/fs100/j53/front_page_drafts.py --plant    # plants an anchor that does not exist; must exit 1
    python3 data/fs100/j53/front_page_drafts.py --markdown # prints the drafts as the plan's §R-close shows them

The plan's §R-close stage 5 reproduces this file's text via --markdown, so the two cannot drift.
"""
import sys

CLAUDE = [
    ("item 10 — T-C(A)'s class among real quadratic fields (row 117)",
     "carried by no `T + A + Fin_S`, `S` finite (row 113). With every",
     "carried by no `T + A + Fin_S`, `S` finite (row 113). Among real quadratic fields that count's class is exactly `L ≥ 5`, "
     "`d ≡ 47, 143, 167 (mod 168)` (row 117), so MR would give five at ℚ(√143), ℚ(√311), ℚ(√335) as at ℚ(√47) (FS-100). With every"),
    ("item 27 — Kronecker windows at four colours (row 116)",
     "over ℚ(√167) lives at nine places; nothing touches `χ_µ(ℝ²)`.",
     "over ℚ(√167) lives at nine places; nothing touches `χ_µ(ℝ²)`. **Kronecker windows at four colours** (row 116; FS-100): "
     "selecting one onto its `T + A` characters is false — at a split place a unit vector is integral at one of the two conjugate "
     "primes, so the pair sees only a cross, and over a bipartite plane parity times the cross four-colours with no such factor; "
     "at ℚ(√47) the selection onto `E = T + A + Fin_S` is the five-clause's pure-point layer itself, open at one density step."),
    ("G76 — the split-place cross (body)",
     "torsion orders all fail (rows 97, 102).",
     "torsion orders all fail (rows 97, 102). **For vectors of characters** a split place pairs its conjugate primes into a cross "
     "(`ψ_w(u) = 0` or `ψ_w̄(u) = 0` on every unit vector): no naive vector band rigidity, Kronecker selection onto `T + A` false "
     "(row 116), and a closed invariant set may be a union of subgroup translates (`[LindenstraussWang2012]`), which a saturation "
     "statement must allow."),
    ("G76 — the split-place cross (Do)",
     "(one is not enough); when an invariant measure's",
     "(one is not enough); test a statement about several characters against a split place's pair `(ψ_w, ψ_w̄)` first; when an "
     "invariant measure's"),
    ("G21 — FS-100's instances",
     "(every circle is a similarity image of the unit circle).",
     "(every circle is a similarity image of the unit circle). **FS-100's two:** a rank-two control added under the rule that a "
     "control proves only its generator's shapes, whose window still read one coordinate, so neither control could fail (row 116); "
     "and two plants that could not fire."),
    ("G50 — FS-100's instance and the Do (owner ruling 3)",
     "went unsearched. *Do: scan, at the opening",
     "went unsearched. **FS-100's:** EL2021 and `[Wang2012]`, in `BIBLIOGRAPHY.md` since the day before under a journal-year key, "
     "were written \"none held\" in the milestone's stub, carried so into the advisor's card, re-fetched, and one read by its "
     "summary. *Do: grep `BIBLIOGRAPHY.md` for a paper's arXiv id and Zbl number before fetching it or calling it unheld; scan, "
     "at the opening"),
    ("G72 — the count's total",
     "**The count so far — eleven of eleven**",
     "**The count so far — twelve of twelve**"),
    ("G72 — the twelfth close",
     "the three-colour selection not found.",
     "the three-colour selection not found. Twelfth, FS-100 — §IQ's named invariant, the orbit closure of `Θ(U)`, refuted both "
     "uniform selection claims and reduced the corrected one to one density step; the class identification by extending a known "
     "tool; layer 2's invariant not found."),
    ("G79 — its first record",
     "which set counterexample invariants side by side.*",
     "which set counterexample invariants side by side; FS-100's result came from an example's (the cross of an actual "
     "four-colouring of ℚ², row 116).*"),
    ("Paths forward — FS-100's row (rank 3; no rank moves)",
     "stages 1 (blind check, J48) and 2 (KT-1, J49) done — the stub's status block; FS-97 absorbed; next the reframe, MR's "
     "reading room, Kronecker selection",
     "its in-ban round ran (the stub's status block): Kronecker selection refuted as stated, its `E`-form open at one density "
     "step, which leads the next slot, stage 6 the fallback (row 116); the class is `L ≥ 5` (row 117); MR = its zero-entropy "
     "half plus PE-lim (row 118); FS-97 absorbed; P1 leads post-ban"),
    ("Paths forward — FS-64's row",
     "(rows 92, 96, 101, 110, 112–113; FS-96, FS-98)",
     "(rows 92, 96, 101, 110, 112–113; FS-96, FS-98); four-colour Kronecker windows: the `E`-form open over T-C(A)'s class "
     "(rows 116–117)"),
    ("Last updated — FS-100's in-ban round",
     "FS-100's stages 1–2 ran and FS-97 was absorbed into it (the stub).",
     "FS-100's stages 1–2 ran and FS-97 was absorbed into it (the stub); then FS-100's in-ban round (rows 116–118) — "
     "**Paid (theorem); MR not landed** (`plans/FS100-three-field-lemma.md` §R-close)."),
]

ROW116 = (
    "| 116 | **Kronecker selection is false as stated, and at ℚ(√47) its corrected form is the question. For a real number field "
    "`F`, `R = ℤ[U_F]`, `Θ : R → Tⁿ` and a measurable `W` proper on `Cay(cl Θ(R), cl Θ(U))`, a proper `W′` on the factor "
    "`K/K₀` spanned by the `T + A` combinations need not exist: over ℚ, `Θ = (τ + ψ_w, τ + ψ_w̄)` (`τ` the dyadic parity, `w, w̄` "
    "above 5) with `W = 2⌊2t₁⌋ + ⌊2t₂⌋` is proper while `K̂′ = 0`; the same over every real field with `χ(F²) = 2`, and at "
    "`k²` colours over every real field. The reduction holds in an arithmetic-free form (`C + H = C` in a compact abelian group "
    "⟹ selection to `K/H`); saturation onto `T + A` fails over every real field; and wherever T-C(A) holds, the selection, its "
    "form onto `E = T + A + Fin_S` (KS-1_E) and \"no Kronecker four-colouring\" are one statement, proved for `Θ ∈ Eⁿ` and "
    "`n = 1`, open for `n ≥ 2` off `E`** (FS-100; `plans/FS100-derivation.md` FS100-X1, X2B, KS2, KS3, CP, L0, EQ, C45, R). "
    "**[hand + tools exact; the counterexample two derivations — J51V blind, J51D's construction committed before any "
    "disclosure, its write-up possibly informed — and the owner's check; KS-2, KS-3 and the equivalence two derivations blind to "
    "each other; the `k²` form, the `E`-form and the reduction R one mind]** Mechanism: at a split place a unit vector is "
    "integral at one of the two conjugate primes (`ι_w̄(u) = ι_w(u)⁻¹`), so `(ψ_w, ψ_w̄)` maps `U` into the cross `(T × 0) ∪ "
    "(0 × T)` and `Cay(R, U)` into a co-normal product, `χ(G)²`-colourable [reading, J51V]; at four colours that needs a "
    "bipartite plane, so it cannot reach ℚ(√47). The corrected saturation KS-sat_E is equivalent to the density of `Φ(N)` for "
    "off-`E` families on neighbourhoods of 1 in `U`, stopped at one named step (uncontrolled poles against the discreteness of "
    "`U_{Σ′}`: cut-and-project sums). The plan's controls KS-4, KS-5 could not fail (their window reads one coordinate). "
    "**Not claimed:** KS-1_E or KS-sat_E; anything at ℚ(√47) beyond the equivalence; the co-normal reading as the only cheap "
    "mechanism. **Prior art (`plans/FS100-three-field-lemma.md` §R-close stage 2):** the counterexample not found; its "
    "ingredients textbook — the split norm-one torus `y ↦ (y, y⁻¹)` (FS86-Cx-C1; `[BardestaniMallahiKarai2017]` §3.2) and the "
    "co-normal product's `χ(G)χ(H)` bound; the reduction not found, likely folklore; the cross is a union of subgroups, which "
    "`[LindenstraussWang2012]`'s topological rigidity allows. | `plans/FS100-derivation.md` §1; `plans/FS100-J51D-derivation.md` "
    "§2–§3; `plans/FS100-J51V-verification.md` §2.3–§2.6, §3.2; `tools/j51d_or_check.py`, `tools/j51v_cross.py` | FS-100 "
    "(crunch 2026-09-26) |"
)
ROW117 = (
    "| 117 | **T-C(A)'s class among real quadratic fields is the conjecture's `L ≥ 5` family, and SP-Cor holds over it. For "
    "`ℚ(√d)` real quadratic: every stable place of `ℚ(√d, i)` has all-levels four-colour ratio `< 1/4` ⟺ `d ≡ 47, 143, 167 "
    "(mod 168)` ⟺ `L(ℚ(√d)) ≥ 5`; and over every real number field where T-C(A) holds at `S = ∅`, J45's A⁺ and SP-Cor hold "
    "with J45's proofs — so MR(F) ⟹ `χ(F²) ≥ 5` at ℚ(√143), ℚ(√311), ℚ(√335) as at ℚ(√47)** (FS-100; FS100-T1, K0). "
    "**[hand + tools exact, one mind (J51), re-derived by J51V (not blind) and J53 (Legendre symbols); K0 hand, one mind "
    "(J51V) + a one-step check (J53); both on R88-TCA's class form, one mind outside ℚ(√47)]** The inputs: the dyadic place "
    "split iff `d ≡ 7 (mod 8)`; 3 and 7 not stable; FS-66 at 11 and 19; Lemma P at a ramified place; the Hoffman table (31's "
    "`1/4 − 2.745·10⁻⁶` the largest) and Weil above. A⁺ at a finite `S ≠ ∅` needs T-C(A) at that `S`, which the class form "
    "supplies. ℚ(√167) is in the class; ℚ(√59) and ℚ(√11) are not. **Not claimed:** MR anywhere; the class among fields of "
    "higher degree. **Prior art:** the congruence family is G61's (`[Fischer1990]` Thm 10); its identification with T-C(A)'s "
    "class not found (J53's gate). | `plans/FS100-derivation.md` §2; `plans/FS100-three-field-lemma.md` §1.4, §R-close 1.1; "
    "`plans/FS100-J51V-verification.md` §2.7; `tools/j51_tca_class.py`, `tools/j51v_class.py` | FS-100 (crunch 2026-09-26) |"
)
ROW118 = (
    "| 118 | **Rank one of Kronecker selection, and why Einsiedler–Lindenstrauss's classification does not apply. Over every "
    "real number field one character carries the selection (given row 98, a proper window forces a band character, hence "
    "`θ ∈ T + A`), and `θ ∈ E ∖ (T + A)` has `cl θ(U) = T`; at `F = ℚ` every `θ ∉ T + A` has `cl θ(U) = T`. No finitely "
    "generated `Γ ⊂ U_F` acts irreducibly on the solenoid `R̂` (`R = O′` inverts infinitely many primes, `ℤ[Γ]` finitely "
    "many), so EL2021 Thm 1.2 never applies** (FS-100; FS100-N1, T4, T5, T2). **[hand; one mind each — J51V, J51D, J51D, "
    "J51]** For general `F` off `E` the rank-one density is a GAP at the field form of FS89's PA-B2 and JC over `R_{F,S}` "
    "(row 98's gluing does not transfer). The card's answer [reading, one mind]: EL2021 Thm 1.3 is the in-print "
    "positive-entropy statement that can apply, and MR is its zero-entropy half plus an owed lemma PE-lim (from finitely "
    "generated `Γ` to `U`); nothing known forces positive entropy from the four-colouring constraint. **Not claimed:** PE-lim; "
    "MR; the rank-one density off `E` in general. **Prior art:** the nearest is the topological-rigidity line "
    "(`[Furstenberg1967]`, `[Berend1983]`, `[Wang2012]`, `[LindenstraussWang2012]`), whose hypotheses fail here (FS100-T2); "
    "T4 and T5 compose held lemmas. | `plans/FS100-derivation.md` FS100-N1, T4, T5, T2; `plans/FS100-three-field-lemma.md` "
    "§PA.3 | FS-100 (crunch 2026-09-26) |"
)

LEDGER = [
    ("§ A — rows 116–118 after row 115 (last number 118)",
     "`tools/crunch_j27v_fq9.py` | FS-67 (crunch 2026-09-25) |\n",
     "`tools/crunch_j27v_fq9.py` | FS-67 (crunch 2026-09-25) |\n" + ROW116 + "\n" + ROW117 + "\n" + ROW118 + "\n"),
    ("row 98 — Not claimed (J51V-X2 (c))",
     "one prime (rows 97, 102); anything kernel-checked.",
     "one prime (rows 97, 102); anything kernel-checked; any vector form — `0 ∉ cl Θ(U)` forces no non-zero `m·Θ` into "
     "`T + A` (false, row 116)."),
    ("the claim list — Ours",
     "Theorem C over the real S2 fields and its ℚ(√47) form (rows 111–113);",
     "Theorem C over the real S2 fields and its ℚ(√47) form (rows 111–113); Kronecker selection refuted as stated, its "
     "reduction and its corrected form's reduction to one density step (row 116); T-C(A)'s class among real quadratic fields "
     "and SP-Cor over it (row 117); rank one of the selection and the non-irreducibility of the unit-vector group on its "
     "solenoid (row 118);"),
]


def check(path, drafts, budget=None):
    text = open(path, encoding="utf-8").read()
    ok, net = True, 0
    for name, old, new in drafts:
        n = text.count(old)
        delta = len(new.encode()) - len(old.encode())
        print(f"  {'ok  ' if n == 1 else 'FAIL'} {delta:+5d} B  {name}  (anchor found {n}x)")
        if n != 1:
            ok = False
            continue
        text = text.replace(old, new, 1)
        net += delta
    print(f"{path}: net {net:+d} bytes" + (f" (budget {budget})" if budget else ""))
    if budget is not None and net > budget:
        print(f"FAIL: over budget by {net - budget} bytes")
        ok = False
    return ok


def markdown():
    for title, drafts in (("CLAUDE.md", CLAUDE), ("LEDGER.md", LEDGER)):
        print(f"##### {title}\n")
        for name, old, new in drafts:
            if name.startswith("§ A"):
                print(f"- **{name}** — append after row 115's line:\n")
                for row in (ROW116, ROW117, ROW118):
                    print(f"  {row}\n")
                continue
            print(f"- **{name}** — replace\n  > {old.strip()}\n\n  with\n  > {new.strip()}\n")


if __name__ == "__main__":
    if "--markdown" in sys.argv:
        markdown()
        sys.exit(0)
    claude = list(CLAUDE)
    if "--plant" in sys.argv:
        claude.append(("PLANT — an anchor that does not exist", "this anchor is not in CLAUDE.md ⟂", "x"))
    a = check("CLAUDE.md", claude, budget=3000)
    b = check("LEDGER.md", LEDGER)
    print("RESULT:", "PASS" if a and b else "FAIL")
    sys.exit(0 if a and b else 1)
