"""TC1: the drafted corrections, as (file, old, new) triples — the one source of the drafts in
plans/WORKFLOW3-TC1-theory-corrections.md § Stage 2.

  python3 data/workflow3/tc1/tc1_apply.py            write scratch copies to data/workflow3/tc1/copies/ (never the real files)
  python3 data/workflow3/tc1/tc1_apply.py --md       print the drafts as the record's markdown
  TC1_FAULT=1 ...                                    plant a dangling pointer (row 199) in the CLAUDE.md copy

Exits 1, writing nothing, unless every old text occurs exactly once in its file."""
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))
OUT = os.path.join(ROOT, "data/workflow3/tc1/copies")
G = ".claude/skills/grokkings/SKILL.md"
REC = "`plans/WORKFLOW3-TC1-theory-corrections.md`"

R = [
    # --- the four texts of the brief ---
    ("T1", G, "G35's second clause",
     "one above 2 exists iff −1 is not a square in some\n  completion above 2 (norm 2 or 4).",
     "one above 2 exists iff −1 is not a square in some\n  completion above 2 — of norm 2 or 4 when F is multiquadratic, any power of 2 in general. One ramified in F(i)/F gives\n"
     "  χ(F²) ≤ 2, and one inert there, over a place of norm Q, gives the target U_Q, four-colourable exactly when Q ≤ 32 (G56, row 123);\n"
     "  so a standing wall four-colours F² over a multiquadratic field and below degree 12, and not in general: K·E₇, E₇ the septic\n"
     "  subfield of ℚ(ζ₂₉), keeps its wall at two places inert of norm 128, and given MR its plane needs five (" + REC + "\n"
     "  TC1-STANDING-FOUR, TC1-STANDING-FIVE). *Demotion record: this clause read \"(norm 2 or 4)\" for every real number field;\n"
     "  ℚ(ζ₇)⁺'s prime above 2 has norm 8 (TC1).*"),
    ("T2", G, "G56's Do line",
     "*Do: for any field, list\n  its usable q first — six is possible only if one lies in {23, 27, 31, 43, 47}, or a prime above 2 is inert of norm 64, and\n"
     "  the wall is broken; otherwise L is 2, 3, 4, 5 or ≥ 7 before any solver, and over any F ⊇ K it is 5 or ≥ 7.",
     "*Do: for any field, list\n  its usable q and its places above 2 first — six is possible only if a usable q lies in {23, 27, 31, 43, 47} or a place above 2\n"
     "  is inert in F(i) of norm 64, and no place above 2 is ramified in F(i) or inert there of norm ≤ 32 (row 123; over a multiquadratic\n"
     "  field or below degree 12, that is the broken wall); otherwise L is 2, 3, 4, 5 or ≥ 7 before any solver. Over any F ⊇ K no place\n"
     "  above 2 ramifies in F(i) or has norm 64 (TC1-SQRT3-DYADIC), so L is 4, 5 or ≥ 7, and 4 when a place above 2 is inert of norm ≤ 32."),
    ("T3", "CLAUDE.md", "§ Where the problem stands, item 1",
     "1. **The 4/5 wall is 2-adic.** A unit-distance graph forces a fifth colour only if its coordinates break the\n   2-adic wall (G1, G35).",
     "1. **The 4/5 wall is 2-adic.** Over a multiquadratic field, or one of degree at most 11, a unit-distance graph forces a fifth colour\n"
     "   only if its coordinates break the 2-adic wall (G1, G35); over any real number field, only if each place above 2 splits in F(i)\n"
     "   or is inert there of norm 64 or more (row 123), which a field whose wall stands can meet (G35)."),
    ("T4", "LEDGER.md", "row 139, its second sentence",
     "Seven, `χ_m⁰(ℝ²) ≥ 7`, is the map NO made uniform in the complexity bound:",
     "Seven, `χ_m⁰(ℝ²) ≥ 7`, is the NO's hole bound made uniform in the complexity bound:"),
    # --- the sweep ---
    ("S1", G, "G35's Do line",
     "for any F, is 1/2 ∈ ℤ[U], i.e. does every prime above 2 split in F(i) — and\n  expect no odd-degree field to break it.",
     "for any F, is 1/2 ∈ ℤ[U], i.e. does every prime above 2 split in F(i) — and\n  expect no odd-degree field to break it; where it stands, call the null free only once a place above 2 is ramified in F(i) or inert\n"
     "  of norm ≤ 32, which is automatic over a multiquadratic field or below degree 12."),
    ("S2", G, "G1's fourth sentence",
     "A 5-forcer's\n  coordinates must break the 2-adic wall — contain an odd square class ≡ 7 (mod 8), such as √5, √7 or √247\n  (G35).",
     "A 5-forcer's\n  coordinates must break the 2-adic wall when their field is multiquadratic or of degree at most 11 — for a multiquadratic\n"
     "  field, contain an odd square class ≡ 7 (mod 8), such as √5, √7 or √247 (G35); in general they need only avoid a place above 2\n"
     "  ramified in F(i) or inert of norm ≤ 32, and given MR a field whose wall stands can hold one (G35's K·E₇)."),
    ("S3", G, "G1's Do line",
     "*Do: before any solver on a candidate,\n  read its field's square classes for an odd one ≡ 7 (mod 8) (G35's congruence); none means Theorem B four-colours the\n"
     "  object and the null is free — never run it. Nothing kills it; it kills every five-colour design in a wall-standing field.*",
     "*Do: before any solver on a candidate\n  over a multiquadratic field, read its square classes for an odd one ≡ 7 (mod 8) (G35's congruence); none means a residue\n"
     "  colouring at a prime above 2 (Theorem B's, over K) four-colours the object and the null is free — never run it; over any other\n"
     "  field, read its places above 2 (G35's Do). Nothing kills it; it kills every five-colour design in a wall-standing field that is\n"
     "  multiquadratic or of degree at most 11.*"),
    ("S4", G, "G43's fourth sentence",
     "For F ⊇ K,\n  6-open ⟺ wall broken ∧ 11 inert:",
     "For multiquadratic F ⊇ K,\n  6-open ⟺ wall broken ∧ 11 inert (not for every F ⊇ K: K·E₇ is 6-open with its wall standing, G35):"),
    ("S5", G, "G56's exclusion",
     "so such a field's usable primes are 11 and then nothing below 83, its local bound is 5 or ≥ 7,\n"
     "  and **six is arithmetically excluded for all of them**.",
     "so such a field's usable primes are 11 and then nothing below 83; its places above 2 never ramify in F(i) and, when\n"
     "  not split, have norm 2, 8, 32, 128, …, never 64 (" + REC + " TC1-SQRT3-DYADIC); its local bound is 4\n"
     "  (a place above 2 inert of norm ≤ 32), 5 or ≥ 7, and **six is arithmetically excluded for all of them**."),
    ("S6", G, "G56's enumeration clause",
     "the second condition being what makes a local bound\n  of 6 worth anything, since a wall-standing field is four-colourable by the residue at 2.",
     "the second condition being what makes a local bound\n  of 6 worth anything, since a wall-standing field below degree 12 — every field these enumerations reach — is four-colourable\n"
     "  by the residue at 2 (TC1-STANDING-FOUR; from degree 12 a place above 2 inert of norm ≥ 64 keeps the wall without four colours)."),
    ("S7", "CLAUDE.md", "§ Notation, 6-open",
     "(the wall is broken and every usable plane needs ≥ 6; over K, row 53's criterion)",
     "(every usable plane and every target at a prime above 2 needs ≥ 6; over a multiquadratic field, the wall is broken and every usable\n"
     "  plane needs ≥ 6; over K, row 53's criterion)"),
    ("S8", "CLAUDE.md", "§ Where the problem stands, item 2",
     "2. **The field sieve.** For F ⊇ K: 6-open ⟺",
     "2. **The field sieve.** For multiquadratic F ⊇ K: 6-open ⟺"),
    ("S9", "LEDGER.md", "row 53",
     "over K, 6-open ⟺ wall broken ∧ 11 inert —",
     "over multiquadratic F ⊇ K, 6-open ⟺ wall broken ∧ 11 inert (not over every F ⊇ K: G35's K·E₇) —"),
    ("S10", "LEDGER.md", "row 57",
     "— the same algebra whose ramification set is the 2-adic wall (G35) —",
     "— the same algebra, `(−1,−1)`, whose ramification at a place above 2 keeps the 2-adic wall standing there without being the wall (G35) —"),
    ("S11", "LEDGER.md", "§ B, M58-T2",
     "| M58-T2 | M58 | for `F ⊇ K = ℚ(√3,√11)`:",
     "| M58-T2 | M58 | for multiquadratic `F ⊇ K = ℚ(√3,√11)`:"),
    ("S12", "LEDGER.md", "§ B, ASTRA-2026-09-14-T7",
     "— wall-broken sufficient, not only necessary, over `K` |",
     "— wall-broken sufficient over `K`, not only necessary (necessary over multiquadratic `F ⊇ K`; not over every `F ⊇ K` given MR: G35's K·E₇) |"),
]


def main():
    texts = {f: open(os.path.join(ROOT, f), encoding="utf-8").read() for f in {r[1] for r in R}}
    bad = [(k, f, texts[f].count(old)) for k, f, _, old, _ in R if texts[f].count(old) != 1]
    if bad:
        print("REFUSED: old text not found exactly once:", bad)
        sys.exit(1)
    if "--md" in sys.argv:
        for k, f, slot, old, new in R:
            print(f"**{k} — `{f}`, {slot}.** Replace\n\n```text\n{old}\n```\n\nwith\n\n```text\n{new}\n```\n")
        return
    for k, f, _, old, new in R:
        texts[f] = texts[f].replace(old, new)
    if os.environ.get("TC1_FAULT") == "1":
        texts["CLAUDE.md"] = texts["CLAUDE.md"].replace("norm 64 or more (row 123), which", "norm 64 or more (row 199), which")
    os.makedirs(OUT, exist_ok=True)
    for f, t in texts.items():
        open(os.path.join(OUT, os.path.basename(f)), "w", encoding="utf-8").write(t)
    print(f"applied {len(R)} replacements to scratch copies of {len(texts)} files in {os.path.relpath(OUT, ROOT)}")


main()
