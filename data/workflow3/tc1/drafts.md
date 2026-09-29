**T1 — `.claude/skills/grokkings/SKILL.md`, G35's second clause.** Replace

```text
one above 2 exists iff −1 is not a square in some
  completion above 2 (norm 2 or 4).
```

with

```text
one above 2 exists iff −1 is not a square in some
  completion above 2 — of norm 2 or 4 when F is multiquadratic, any power of 2 in general. One ramified in F(i)/F gives
  χ(F²) ≤ 2, and one inert there, over a place of norm Q, gives the target U_Q, four-colourable exactly when Q ≤ 32 (G56, row 123);
  so a standing wall four-colours F² over a multiquadratic field and below degree 12, and not in general: K·E₇, E₇ the septic
  subfield of ℚ(ζ₂₉), keeps its wall at two places inert of norm 128, and given MR its plane needs five (`plans/WORKFLOW3-TC1-theory-corrections.md`
  TC1-STANDING-FOUR, TC1-STANDING-FIVE). *Demotion record: this clause read "(norm 2 or 4)" for every real number field;
  ℚ(ζ₇)⁺'s prime above 2 has norm 8 (TC1).*
```

**T2 — `.claude/skills/grokkings/SKILL.md`, G56's Do line.** Replace

```text
*Do: for any field, list
  its usable q first — six is possible only if one lies in {23, 27, 31, 43, 47}, or a prime above 2 is inert of norm 64, and
  the wall is broken; otherwise L is 2, 3, 4, 5 or ≥ 7 before any solver, and over any F ⊇ K it is 5 or ≥ 7.
```

with

```text
*Do: for any field, list
  its usable q and its places above 2 first — six is possible only if a usable q lies in {23, 27, 31, 43, 47} or a place above 2
  is inert in F(i) of norm 64, and no place above 2 is ramified in F(i) or inert there of norm ≤ 32 (row 123; over a multiquadratic
  field or below degree 12, that is the broken wall); otherwise L is 2, 3, 4, 5 or ≥ 7 before any solver. Over any F ⊇ K no place
  above 2 ramifies in F(i) or has norm 64 (TC1-SQRT3-DYADIC), so L is 4, 5 or ≥ 7, and 4 when a place above 2 is inert of norm ≤ 32.
```

**T3 — `CLAUDE.md`, § Where the problem stands, item 1.** Replace

```text
1. **The 4/5 wall is 2-adic.** A unit-distance graph forces a fifth colour only if its coordinates break the
   2-adic wall (G1, G35).
```

with

```text
1. **The 4/5 wall is 2-adic.** Over a multiquadratic field, or one of degree at most 11, a unit-distance graph forces a fifth colour
   only if its coordinates break the 2-adic wall (G1, G35); over any real number field, only if each place above 2 splits in F(i)
   or is inert there of norm 64 or more (row 123), which a field whose wall stands can meet (G35).
```

**T4 — `LEDGER.md`, row 139, its second sentence.** Replace

```text
Seven, `χ_m⁰(ℝ²) ≥ 7`, is the map NO made uniform in the complexity bound:
```

with

```text
Seven, `χ_m⁰(ℝ²) ≥ 7`, is the NO's hole bound made uniform in the complexity bound:
```

**S1 — `.claude/skills/grokkings/SKILL.md`, G35's Do line.** Replace

```text
for any F, is 1/2 ∈ ℤ[U], i.e. does every prime above 2 split in F(i) — and
  expect no odd-degree field to break it.
```

with

```text
for any F, is 1/2 ∈ ℤ[U], i.e. does every prime above 2 split in F(i) — and
  expect no odd-degree field to break it; where it stands, call the null free only once a place above 2 is ramified in F(i) or inert
  of norm ≤ 32, which is automatic over a multiquadratic field or below degree 12.
```

**S2 — `.claude/skills/grokkings/SKILL.md`, G1's fourth sentence.** Replace

```text
A 5-forcer's
  coordinates must break the 2-adic wall — contain an odd square class ≡ 7 (mod 8), such as √5, √7 or √247
  (G35).
```

with

```text
A 5-forcer's
  coordinates must break the 2-adic wall when their field is multiquadratic or of degree at most 11 — for a multiquadratic
  field, contain an odd square class ≡ 7 (mod 8), such as √5, √7 or √247 (G35); in general they need only avoid a place above 2
  ramified in F(i) or inert of norm ≤ 32, and given MR a field whose wall stands can hold one (G35's K·E₇).
```

**S3 — `.claude/skills/grokkings/SKILL.md`, G1's Do line.** Replace

```text
*Do: before any solver on a candidate,
  read its field's square classes for an odd one ≡ 7 (mod 8) (G35's congruence); none means Theorem B four-colours the
  object and the null is free — never run it. Nothing kills it; it kills every five-colour design in a wall-standing field.*
```

with

```text
*Do: before any solver on a candidate
  over a multiquadratic field, read its square classes for an odd one ≡ 7 (mod 8) (G35's congruence); none means a residue
  colouring at a prime above 2 (Theorem B's, over K) four-colours the object and the null is free — never run it; over any other
  field, read its places above 2 (G35's Do). Nothing kills it; it kills every five-colour design in a wall-standing field that is
  multiquadratic or of degree at most 11.*
```

**S4 — `.claude/skills/grokkings/SKILL.md`, G43's fourth sentence.** Replace

```text
For F ⊇ K,
  6-open ⟺ wall broken ∧ 11 inert:
```

with

```text
For multiquadratic F ⊇ K,
  6-open ⟺ wall broken ∧ 11 inert (not for every F ⊇ K: K·E₇ is 6-open with its wall standing, G35):
```

**S5 — `.claude/skills/grokkings/SKILL.md`, G56's exclusion.** Replace

```text
so such a field's usable primes are 11 and then nothing below 83, its local bound is 5 or ≥ 7,
  and **six is arithmetically excluded for all of them**.
```

with

```text
so such a field's usable primes are 11 and then nothing below 83; its places above 2 never ramify in F(i) and, when
  not split, have norm 2, 8, 32, 128, …, never 64 (`plans/WORKFLOW3-TC1-theory-corrections.md` TC1-SQRT3-DYADIC); its local bound is 4
  (a place above 2 inert of norm ≤ 32), 5 or ≥ 7, and **six is arithmetically excluded for all of them**.
```

**S6 — `.claude/skills/grokkings/SKILL.md`, G56's enumeration clause.** Replace

```text
the second condition being what makes a local bound
  of 6 worth anything, since a wall-standing field is four-colourable by the residue at 2.
```

with

```text
the second condition being what makes a local bound
  of 6 worth anything, since a wall-standing field below degree 12 — every field these enumerations reach — is four-colourable
  by the residue at 2 (TC1-STANDING-FOUR; from degree 12 a place above 2 inert of norm ≥ 64 keeps the wall without four colours).
```

**S7 — `CLAUDE.md`, § Notation, 6-open.** Replace

```text
(the wall is broken and every usable plane needs ≥ 6; over K, row 53's criterion)
```

with

```text
(every usable plane and every target at a prime above 2 needs ≥ 6; over a multiquadratic field, the wall is broken and every usable
  plane needs ≥ 6; over K, row 53's criterion)
```

**S8 — `CLAUDE.md`, § Where the problem stands, item 2.** Replace

```text
2. **The field sieve.** For F ⊇ K: 6-open ⟺
```

with

```text
2. **The field sieve.** For multiquadratic F ⊇ K: 6-open ⟺
```

**S9 — `LEDGER.md`, row 53.** Replace

```text
over K, 6-open ⟺ wall broken ∧ 11 inert —
```

with

```text
over multiquadratic F ⊇ K, 6-open ⟺ wall broken ∧ 11 inert (not over every F ⊇ K: G35's K·E₇) —
```

**S10 — `LEDGER.md`, row 57.** Replace

```text
— the same algebra whose ramification set is the 2-adic wall (G35) —
```

with

```text
— the same algebra, `(−1,−1)`, whose ramification at a place above 2 keeps the 2-adic wall standing there without being the wall (G35) —
```

**S11 — `LEDGER.md`, § B, M58-T2.** Replace

```text
| M58-T2 | M58 | for `F ⊇ K = ℚ(√3,√11)`:
```

with

```text
| M58-T2 | M58 | for multiquadratic `F ⊇ K = ℚ(√3,√11)`:
```

**S12 — `LEDGER.md`, § B, ASTRA-2026-09-14-T7.** Replace

```text
— wall-broken sufficient, not only necessary, over `K` |
```

with

```text
— wall-broken sufficient over `K`, not only necessary (necessary over multiquadratic `F ⊇ K`; not over every `F ⊇ K` given MR: G35's K·E₇) |
```

