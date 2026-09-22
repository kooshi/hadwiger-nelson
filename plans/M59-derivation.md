# M59 — the derivation file: the finite-plane lift (ledger row 54)

*Filed 2026-09-22 by FS-71 batch 3c. Read: `plans/M59-finite-plane-lift.md` §S1–S3 (the derivations), §R0–R8 (the
results). This is the densest file of the batch: the whole rigidity-matrix/Hensel-lift apparatus (D2, §S1) is a hand
derivation with only its "only if" direction (a stress refutes a lift) reaching the kernel; the "if" direction (the
rigid dichotomy) and the counting/geometry lemmas around it (§S2, §S3) never did.*

## The theorems

**M59-T1 — The level-p² lift theorem. [hand; the M59 opening session]** Setting: `𝔭` a degree-one prime of a real
number field `F` above `p ≡ 3 (mod 4)`; a **lift** of `H ⊆ UD(𝔽_p, 2)` along reference positions `x₀ : V → ℤ²`
(reducing to `H`) is `y : V → ℤ_p²` with `x₀ + p·y` unit-distant along every edge. Writing, per edge `e = uv`,
`D_e = x₀(u) − x₀(v)`, `w_e = y_u − y_v`, `m_e := (|D_e|² − 1)/p ∈ ℤ`: **`H` lifts modulo `p² ⟺` the system
`R(H)·ȳ = b` is solvable over `𝔽_p`, where `R(H)` is `H`'s rigidity matrix (row `uv` carrying `D̄_e` at the `u`-block,
`−D̄_e` at the `v`-block) and `b_e = −m_e/2`, ⟺ `⟨λ, b⟩ = 0` for every self-stress `λ ∈ ker R(H)ᵀ`** (the Fredholm
alternative over `𝔽_p`). *Proof:* `plans/M59-finite-plane-lift.md` §S1, "Level p² (the linear obstruction)" (the
expansion `|x_u−x_v|² − 1 = (|D_e|²−1) + 2p⟨D_e,w_e⟩ + p²|w_e|²`, the "Level-p² theorem" blockquote). *Proof verdict:*
closes. *Rests on it:* M59-T2 (the higher-level dichotomy, built on the same expansion); M59-T3 (the stress-count
bound); every kernel instance below. *Prior art:* the rigidity-matrix/self-stress apparatus itself is classical
(Laman/Maxwell rigidity theory, unattributed to a specific held source here); **the *p*-adic Hensel-lift application —
treating the first digit's obstruction as a rigidity-matrix Fredholm alternative over `𝔽_p`, then Newton-iterating —
is not found in the held bibliography or by search**. zbMATH: `ab:"framework" & ab:"Hensel lift" & ab:"rigidity"`
(0 hits), `ab:"self-stress" & ab:"p-adic"` (0 hits). *Kernel:* **kernel, necessity direction only**
(`Lift.lean`'s `stressPairing_eq_zero_of_lift`: a lift implies every stress pairs to zero with the defect, over any
commutative ring with a square-zero element `π`, i.e. the contrapositive `not_exists_lift_of_stressPairing_ne_zero` is
what every kernel instance below actually uses); the sufficiency direction (`b ∈ im R(H) ⟹` a lift exists) is not
formalized — declined, no consumer needs it (every instance either finds a nonzero stress pairing, refuting a lift, or
Newton-iterates directly in the rigid case, which is M59-T2's separate mechanism).

**M59-T2 — The rigid/flexible dichotomy for a residue framework's lift. [hand; the M59 opening session]** For `H` with
`rank R(H) = 2|V| − 3` at its residue positions ("infinitesimally rigid"): choosing a Laman basis `E′ ⊆ E`
(`2|V| − 3` edges) and gauge-fixing three isometries makes the `E′`-system square with invertible Jacobian mod `p`, so
**Hensel's lemma lifts the residue positions to a unique `ℤ_p`-solution of `E′`, up to `p`-adic isometry**; the
remaining edges `E ∖ E′` either fail at some finite level (no lift of `H`) or are all unit (a lift exists,
**algebraic**: its coordinates generate a number field `F_H ⊂ ℚ_p` with a degree-one unramified prime above `p`, real
iff `F_H` has a real place). For `rank R(H) < 2|V| − 3` ("flexible", dimension `f` of infinitesimal flex beyond the
three isometries): the `E′`-solutions form a `(3+f)`-manifold and the Hensel tree branches `p^f`-ways per level.
*Proof:* `plans/M59-finite-plane-lift.md` §S1, "Higher levels, and the dichotomy" (the full blockquotes for both
cases). *Proof verdict:* closes. *Rests on it:* M59-T5 (adding-a-vertex); the "design in the finite plane, lift to the
field" route's closure (§R7: "the route... is closed as a way to FIND a 6-forcer; what survives is its converse"); the
measured instances (§R3: the 1581's injective sub-reduction at 131 passes Newton to precision `131²⁰` and agrees with
the tower coordinates on 20,000 sampled quadrances). *Prior art:* Hensel's lemma and the rigid-framework
realization-variety machinery are classical; the specific composition (residue rigidity ⟹ unique `p`-adic isometry
class ⟹ algebraic number field with a degree-one unramified prime, with a real-place criterion for realizability in
`ℝ²`) was not found. zbMATH: as M59-T1's (0 hits both). *Kernel:* declined (§R6: "the kernel form of the rigid
dichotomy" is listed among what the milestone did not do) — needs Hensel's lemma over `ℤ_p` for a system with
invertible Jacobian, and the recognition of an isolated `ℚ_p`-point as generating a number field; neither is in
Mathlib in the needed form.

**M59-T3 — The stress-count bound for a 6-critical residue subgraph. [hand; elementary counting, the M59 opening
session]** `ker R(H)` always contains the three infinitesimal isometries (two translations, the rotation `v ↦ Jv`,
since `⟨D̄, JD̄⟩ = 0`), so `rank R(H) ≤ 2|V| − 3` and `dim(\text{stresses}) ≥ |E| − 2|V| + 3`. A 6-critical `H` has
minimum degree `≥ 5` (else a lower-degree vertex could be deleted with `χ` unchanged — the deletion-minimality that
"critical" names), so `|E| ≥ 5|V|/2` and **the level-p² test (M59-T1) imposes at least `|V|/2 + 3` independent linear
conditions on the defect `b`**; for a "random" `H` each condition fails with probability `1 − 1/p`, so a 6-critical `H`
on 100 vertices passes by chance with probability `~ p^{−53}`. *Proof:* `plans/M59-finite-plane-lift.md` §S1, "The
count" paragraph. *Proof verdict:* closes. *Rests on it:* the reading "a 6-critical `H` found by search is obstructed
at level `p²` unless it is a shadow" (§S1(b), a consequence of this count plus M59-T1, not separately claimed as a
theorem — see "readings" below); M59-T1's own motivation (the stub's "overdetermined by 5/4" claim, which this entry
makes exact: "the overdetermination is the stress space, and the obstruction is its pairing with the defect"). *Prior art:* the `2|V| − 3` isometry-kernel count is Laman/Maxwell rigidity-theory folklore; the specific application to a
6-critical unit-distance-graph-style minimum degree bound (`≥ 5` from criticality) combined with the count is this
project's. Not separately searched (a one-line corollary of standard rigidity counting plus a standard criticality
fact). *Kernel:* declined, folded into M59-T1's scope (no separate consumer).

**M59-T4 — The finite plane's own geometry, three criteria derived. [hand; elementary algebra over `𝔽_p(i)`, the M59
opening session]** For `p ≡ 3 (mod 4)`, `p > 3`, working in `𝔽_p² ≅ 𝔽_p(i)` with quadrance = norm and `C` the norm-one
circle (order `p+1`): **(i)** a unit triangle exists (`ω(UD(𝔽_p,2)) = 3`) iff `6 | p+1`, i.e. **`p ≡ 11 (mod 12)`**
(else `ω = 2`); **(ii)** the Moser spindle embeds iff `p ≡ 11 (mod 12)` and `11` is a residue or zero mod `p` —
**exactly the usable primes of `K = ℚ(√3,√11)`** (the spindle's rotation has trace `5/3`, and its characteristic
polynomial's discriminant `−11/9` must be a square or zero on the torus); **(iii)** two spheres of quadrances `c, c′`
about a common centre carry unit chords iff `4cc′ − (c+c′−1)²` is a nonzero square (two chords each) or zero (a
tangency, one chord); a sphere carries a self-chord iff `4c − 1` is a square — **the spindle-distance condition
`4d² − 1` of G12/G37, read verbatim on the finite side.** *Proof:* `plans/M59-finite-plane-lift.md` §S2, all three
bullets, each checked at every `p ≡ 3 (mod 4)` below 132. *Proof verdict:* closes. *Rests on it:* the confirmation that
M58's measured `ω` (3 at 11, 23, 47, 59; 2 at 19, 31, 43) matches criterion (i) exactly; the observation (§S2) that "the
finite plane knows which real objects it is the shadow of" — the reduction theorem read from the finite side; row 57's
`[Krebs2022]`-attributed `ω` criterion (**this entry's criterion (i) is the same fact as `[Krebs2022]`'s Lemma 5.1,
independently re-derived here** — see prior art). *Prior art:* **criterion (i) is `[Krebs2022]`'s clique-number
criterion** (held, `ω(Γ_q) = 3` iff char 3 or 3 is a square in `𝔽_q`; for `q = p ≡ 3 (mod 4)` "3 a square" is exactly
"`p ≡ 11 (mod 12)`" by quadratic reciprocity, so the two statements coincide) — this entry rediscovers it independently
via the sixth-root-of-unity computation rather than citing Krebs, a duplication the audit records rather than corrects
retroactively (G57's own text, minted later, correctly cites `[Krebs2022]`); criteria (ii) and (iii) are not found
elsewhere. zbMATH: `ab:"Moser spindle" & ab:"valuation"` (0 hits) for (ii); (iii) not separately queried (it restates
G12/G37's spindle-distance condition, already searched at those grokkings' own minting). *Kernel:* declined — no
consumer beyond the instrument (`tools/fplift.py`'s `hubs` subcommand uses (iii) directly, unformalized).

**M59-T5 — The adding-a-vertex corollary. [hand; the M59 opening session, a direct consequence of M59-T1 and M59-T3]**
For a lifted (rigid) `H₀` and a residue point `w` with `d` neighbours in `H₀`, the framework `H₀ + w` has stress
dimension `d − 2` larger than `H₀`'s, so the level-p² test on `H₀ + w` is `d − 2` new linear conditions: **a
degree-2 residue point always lifts** (zero new conditions — the "glue point" of M22's classification, seen from the
finite side); **a degree-3 point lifts mod `p²` with probability `1/p` unless it is a shadow.** *Proof:*
`plans/M59-finite-plane-lift.md` §S1, "(a) The adding-a-vertex form". *Proof verdict:* closes. *Rests on it:* the hub
scan's interpretation (§R7: "the hub scan enumerates, over every field with an unramified degree-one prime above `p` at
once, the points at unit distance from ≥ 3 vertices of an object" — this is exactly the degree-3-point instance,
run in reverse as a *search* for shadows rather than a probability estimate); the identification of the depth-one
partner space (M49–M50) "seen from the finite side, with the field read off the lift rather than adjoined by hand"
(§S1(a)). *Prior art:* ours — a direct corollary of the entry's own M59-T1/T3, not separately searched. *Kernel:*
declined, folded into M59-T1's scope.

**M59-T6 — A field's sealing prime is never its lifting prime. [hand finding, confirmed by the instrument's own
controls; the M59 opening session]** For fields over `K`, the sealing prime is always 11 (M58-T2), but 11 is
**ramified** in every field the descent used (`K = ℚ(√3,√11)` itself: `11` ramifies in `ℚ(√11)`), so a `ℤ_{11}`-lift of
a K-object would force `√11 ∈ ℚ_{11}` — impossible, since 11's ramification means the residue extension has no room for
it. The lift theory (M59-T1/T2) needs an **unramified** degree-one prime, so for fields over K the lift's primes are
exactly `83, 107, 131, …` (M58's usable-prime list minus 11) — **the upper bound (M58, via 11) and the lower bound
(M59, via an unramified prime) of the sieve use different primes of the same field, structurally, not by
coincidence.** *Proof:* `plans/M59-finite-plane-lift.md` §R1, "The controls corrected the derivation's scope" (the
Moser spindle and Heule-510 read OBSTRUCTED at level 2 over `ℤ_{11}`, and rightly so, since their coordinates live in
`ℤ_{11}[√11]` and a `ℤ_{11}`-lift would put `√11` in `ℚ_{11}`); §R3 (the two self-test controls: the Moser spindle and
Heule-510 at 11 both obstructed); §R7, third bullet. *Proof verdict:* closes. *Rests on it:* the sieve's overall
structure (G43, G45); M61-T5 (the tightness mechanism, which explains structurally why the *spindle's own construction*
removes the sealing prime rather than the lifting prime coinciding with it). *Prior art:* ours; a direct consequence of
elementary ramification theory (11 ramifies in `ℚ(√11)`) combined with this entry's own lift theory; not separately
searched. *Kernel:* declined — the ramification fact itself is standard algebraic number theory (not formalized here);
the consequence (obstruction at level 2 for the Moser spindle and Heule-510 at 11) is exhibited directly in the kernel
as a spec example (`Lift.lean`'s self-test controls), not stated as a general theorem about ramified primes.

## Readings and measurements that were called theorems

- **"Every 6-critical `H` found by search is obstructed at level 2 unless it is a shadow"** (§S1(b), P2) — the
  *reading* that follows from M59-T3's count plus M59-T1's characterization; **not itself tested at the milestone's
  scale** (§R4: "NOT TESTED at 131; stands by derivation… its analogue one level down MEASURED — the 5-critical core of
  `UD(𝔽₁₁,2)` fails with 98 of 123 [conditions]"). The one-level-down measurement (63-vertex, 1-minimal, rigid, 98 of
  123 stress conditions fail) and the 19-plane's analogue (138 vertices, 330 of 346 fail) are genuine `[tools]`
  results but are *instances* of M59-T1/T3, not additional theorems (the kernel already certifies them directly:
  `Instances/LiftObstruction11.lean`, `Instances/LiftObstruction19.lean`).
- **The hub-scan census** (1,171 of 12,339 candidates at Heule-510/131; 3,739 of 15,596 at the 1581/131) — a `[tools]`
  complete census on a named finite domain, each hub independently verified in exact `sympy` arithmetic on a sample
  (100 of 100 both times); this is measurement in the sense of M.1 ("a [tools] theorem's statement quantifies over
  exactly the finite set that was checked") but is not filed as a separate theorem entry here because its content is
  fully subsumed by M59-T5's mechanism (it is exactly "search for degree-≥3 shadows" run as a completed enumeration)
  and the numbers themselves carry no further mathematical claim beyond "these residue classes are shadows, these are
  not" — a census, not a law.
- **"The strict hub test was wrong on every dense reduction"** (§R5) and the other incidents in §R5 — instrument bugs
  and their fixes, not mathematics.

## Conjectures surfaced, not claimed

- **The field-level statement (M58's D5) recurs here**: "that the merged image has no lift in `ℤ₁₃₁²` or in other
  number fields" beyond the specific kernel-checked instances is explicitly not claimed (§R2: "What the kernel does
  NOT say"). Same gap as M58-derivation.md's, not re-filed.
- **P1 and P6 of the registered predictions were never tested** (§R4: "no 6-critical core at 131 was reached"; "sphere-
  minimal ≥ 6 object at 131 has 20–60 spheres — NOT TESTED") — not conjectures in the mathematical sense, just unrun
  work, noted for completeness of the census.

## Prior art re-attributed

- **M59-T4's criterion (i)** is independently derived here but is the same fact as `[Krebs2022]`'s Lemma 5.1 (already
  a held bibliography entry, correctly cited at G57's later minting). No `BIBLIOGRAPHY.md` edit needed — the held row
  already carries the right attribution and reading status; this entry records only that M59 rediscovered a special
  case of it without noticing.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M59-T1 | kernel, necessity direction only (`stressPairing_eq_zero_of_lift`, `not_exists_lift_of_stressPairing_ne_zero`); sufficiency declined |
| M59-T2 | declined — needs Hensel's lemma over `ℤ_p` and number-field recognition, neither in Mathlib in the needed form |
| M59-T3 | declined — folded into M59-T1 |
| M59-T4 | declined — instrument-only; criterion (i) already covered by the kernel decision on `[Krebs2022]`'s fact if ever formalized |
| M59-T5 | declined — folded into M59-T1 |
| M59-T6 | declined — the ramification fact is standard, exhibited only as spec examples |
