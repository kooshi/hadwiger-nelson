# FS-85 Part 1 — the blind verifier's record

*The verifier (Opus 5.5), 2026-09-24. Brief: `BRIEF.md` beside this file. Everything here stays in scratch until the owner moves it.*

## C0. Predictions (written before any written derivation)

Written after reading the brief's named inputs (the plan's §0, §IQ 1–2, §M, §R-review; row 78; FS73-T4–T7; MASCOT-T6–T11;
`[Parts2020hv]` §§1–4; `[Polymath16wikiR2]` in full) and one mental pass at V1 while reading — so V1's number below is not blind
to that pass, and is marked so.

| statement | predicted verdict | probability | note |
|---|---|---|---|
| V1 | proved | 0.90 proved / 0.08 gap / 0.02 refuted | not blind: a mental pass while reading suggested the pointwise-disjointness constraint alone forces it |
| V2 | proved (given (S), V1, and that U generates Λ) | 0.85 / 0.14 / 0.01 | the only risk I see is the coset graph's connectivity, an exact check |
| V4 | proved | 0.70 / 0.28 / 0.02 | expect a "three residues among the neighbours in the known set" spreading argument plus exact coset checks |
| V5 | proved | 0.45 / 0.50 / 0.05 | the hard step; the risk is the bridge between orientations, and whether the wiki's Prop. 7 (its unwritten "similarly" cases) runs on Λ |
| V  | proved given (S) + wiki | 0.45 / 0.50 / 0.05 | rests on V5 |

The owner's V3 (finite index, lcm 1680) I expect to re-check exactly at no cost.

## Would-have-searched-here log

(one line each time my default next move would have been a search, and what I did instead)

- (C1, V1) I would have checked V1 by colouring two adjacent cosets with a solver; instead I enumerated stripe DATA on a 16-point window (`v1_enum.py`).
- (C1, V5) I would have searched for a four-colouring of the Moser lattice with every T0-coset residue-type and a non-residue eta^2 T0-coset; instead I derived the line-data rule (Lemma X) and enumerated only the 9 normalized line types it allows (`lemmaX_lines.py`).
- (C1, V5) I would have tested the wiki's Prop. 7 by searching colourings near its configuration; instead I hand-built one partial object from the values the proof forces and checked its edges (`adversary.py`).
- (C1, V4) no search was tempting: the closure on Lambda/M is exact arithmetic (`v4.py`).

## C1. Objects, stated exactly (before any proof)

- `zeta = e^{i pi/3}`, `T0 = Z[zeta]`, `E = Q(sqrt-3, sqrt-11)`, `O_E = Z<1, zeta, w, zeta w>`, `w = (1+sqrt-11)/2`, `Lambda = (1/9) O_E`.
  `eta = (sqrt33 + i sqrt3)/6`, `eta^2 = (5 + i sqrt11)/6`.  `F4 = T0/2T0 = {0, 1, zeta, zeta^2}` with `zeta^2 = zeta + 1`.
- **U** (checked exactly, `basics.py`): the unit vectors of Lambda are exactly `{zeta^a eta^b : |b| <= 4}`, 54 of them
  (all `y in O_E` with `y ybar = 81` enumerated in a box from the trace form's inverse Gram diagonal); `eta^{+-5}, eta^{+-6}` are not in
  Lambda; U generates Lambda (HNF of U in Lambda-coordinates = identity). Identities (8), (9) hold with `omega = zeta` and (8) fails
  with `omega = e^{2 pi i/3}` (FS85-A2 confirmed).
- **Orientation k** (`|k| <= 2`): the sublattice `eta^k T0` of Lambda; its cosets are the "cosets of orientation k".  For every such
  k, each of the 48 unit vectors outside `eta^k T0` lies ALONE in its coset of `eta^k T0` (`checks1.py`), so two distinct cosets of one
  orientation are joined by no edge or by exactly one translation matching `x <-> x + u`.
- **Stripe pattern** on a coset `Z = z + eta^k T0` in direction `eta^k eps`, `eps in {1, zeta, zeta^2}`: writing
  `x = z + eta^k eps (m + n zeta)`, `c(x) = P_{n mod 2}[(m + phi_n) mod 2]`, `{P0, P1}` a partition of the colours into two ordered
  pairs, `phi : Z -> {0,1}`.  Lines = fixed n.  Always `c(x + 2 eta^k eps) = c(x)`.
- **Residue-type** coset: `c|Z` is `2 eta^k T0`-periodic.  Then `c(z + eta^k t) = Psi(t mod 2)` with `Psi : F4 -> colours` a bijection
  (the quotient `T0/2T0` of the triangular lattice is K4). For a stripe pattern: residue-type iff `phi_{n+2} = phi_n` for all n.
  A residue-type coset is striped in all three directions; a non-residue striped coset has exactly one direction (two directions
  force residue-type: the two pair-partitions then differ, so each colour is fixed by the two line parities).
- **Reductions** `red_q : Lambda -> F4` at the two primes above 2: `O_E/2 = F4[w]/(w^2+w+1)`, `red_p : w -> zeta`, `red_p' : w -> zeta^2`,
  and `red(x) = red(9x)` (9 = 1). Computed (`checks2.py`): `red_p(eta^2) = zeta`, `red_p'(eta^2) = zeta^2`; `red_q(eta) = 1 + red_q(eta^2)`;
  `(red_p, red_p') : Lambda/2Lambda -> F4^2` is an isomorphism, and U hits all 9 pairs of nonzero residues. On T0 both reductions are
  `t -> t mod 2`.  A **residue colouring** is `Phi o red_q`, Phi a bijection F4 -> colours; it is proper since `red_q(u) != 0` for u in U.
- **Renormalised colouring** (the wiki's device): for a base point b, `rho_b(t) = c(b + t) + (t mod 2)`, colours identified with F4 by
  a fixed bijection.  The coset `b + T0` is residue-type iff `rho_b` is `2T0`-periodic; "constant rho" means `c(b+t) = kappa + t mod 2`.
- **The Moser lattice** `M = T0 + eta^2 T0` (index 729 in Lambda). Exactly: `eta = sqrt-3 - sqrt-3 eta^2` (identity (8)), so
  `eta T0 ⊂ M`, and `U ∩ M = {zeta^a eta^b : b = 0, 1, 2}` (18 vectors). Points of `z + M` are written `z + u eta^2 + t`, `u, t in T0`;
  the three edge types are `t -> t + zeta^j` (orientation 0), `u -> u + zeta^j` (orientation 2), and
  `(u, t) -> (u - sqrt-3 zeta^j, t + sqrt-3 zeta^j)` (orientation 1, the eta-edges).  The rotated copies `eta^m M`, m = -2, -1, 0, lie
  in Lambda with unit vectors `eta^m (U ∩ M) ⊂ U` (`checks2.py`: `eta^m N+ ⊂ Lambda` for `m in [-4, 1]`, `N+ = T0 + T0 eta^2/sqrt-3 ⊃ M`).

## C1. Verdicts

### V1 — PROVED (hand; the case list checked by an exact enumeration of stripe data, a planted fault seen to fire)

**Lemma V1 (sharper than stated).** Let f, g be stripe patterns on T0 (proper, in the pinned form) with `f(t) != g(t)` for every t,
striped in directions `eps1 != eps2`. Then f or g is residue-type; if their pair-partitions coincide, both are.
*Only pointwise disjointness is used*, and adjacent cosets `Z, Z+u` of one orientation satisfy it through the matching
`z + eta^k t <-> z + u + eta^k t`; so V1 follows, and it holds even if more edges joined the cosets (there are none: `checks1.py`).

*Proof.* Rotation by zeta permutes the three directions cyclically and preserves disjointness, so take `eps1 = 1, eps2 = zeta`.
In coordinates `t = M + N zeta`: f's lines are the rows (fixed N), pairs `P_{N mod 2}`; g's lines are the columns (fixed M), pairs `Q_{M mod 2}`
(the pinned form in direction zeta re-indexes to this with a re-labelled phase sequence).
- *Partitions differ.* Then `P_i ∩ Q_j = {s(i,j)}` is a single colour, and `s(i,0) != s(i,1)`, `s(0,j) != s(1,j)`. Along a row f alternates
  in `P_{N mod 2}` and `M -> s(N mod 2, M mod 2)` alternates in the same pair in lockstep, so on each row f agrees with s everywhere or
  nowhere; likewise g on each column. With A the rows of agreement and B the columns of agreement, every point of A x B is a collision
  `f = g = s`. So A or B is empty; if A is empty, `f(M,N) = s(N mod 2, M mod 2 + 1)` depends only on `t mod 2`: f is residue-type.
- *Partitions coincide*, `P_i = Q_{sigma(i)}`. On the points with `sigma(N mod 2) = M mod 2` both lie in one pair, so `g = other(f)` there.
  For fixed N those points form a parity class of M on which f is constant, hence g is constant there, which forces `psi_M` constant on
  that parity class of M; as N runs over both parities the class runs over both, so g is residue-type, and then the same relation,
  read along columns, makes f residue-type. ∎

**Exact check** (`v1_enum.py`): for each ordered pair of directions, the window W is the 16 points on lines `0..3` of both directions; all
24 ordered pair-data x 16 phase words for each pattern (147,456 pattern pairs per direction pair). Distinct directions: 12,672
disjoint pairs each, **0** with both non-residue on W, **0** with equal partitions and not both residue. *Positive control* (same
direction, where V1 claims nothing): 32,256 disjoint pairs, 19,584 with both non-residue — the hypothesis "directions differ" is
load-bearing. *Planted fault* (one window point dropped from the disjointness test): **2,304** violations reported. The window statement
is the lemma's: the proof above is local to four consecutive lines of each direction.

### V2 — PROVED given (S) and V1

If no coset of orientation k is residue-type, then by V1 any two adjacent cosets (joined by one matching) have the same direction.
The coset graph on `Lambda / eta^k T0` with steps `U \ eta^k T0` is connected because U generates Lambda (HNF = identity). So one direction
`eta^k eps_k` serves every coset, and every coset satisfies `c(x + 2 eta^k eps_k) = c(x)`; since `2 eta^k eps_k` lies in `eta^k T0`, c is
`2 eta^k eps_k`-periodic on Lambda. ∎  *(S) is used for every coset of orientation k.*

### V3 — CONFIRMED (tools exact, `v3.py`)

All 243 choices give rank 4 (finite index); Smith invariants' last entries are {6, 12, 30, 42, 48}; lcm **1680**; the product of the
invariants equals the HNF index in every case; a rank-deficient control (`<2, 2 zeta, 2 zeta^2>`) returns two invariants only.

### V4 — PROVED (hand one-liner + exact closure, `v4.py`)

*Argument.* Suppose c = Phi o red_q on a union S of cosets of M. For x with neighbours `x - u` in S, `c(x) != Phi(red x - red u)`. If the
residues `red_q(u)` of those u cover all three nonzero elements of F4, then `c(x) = Phi(red x)`. *Computation.* On `Lambda/M` (729
cosets, all reached from 0 by unit steps), close S = M under "a coset Y joins once `{red_q(u) : u in U, Y - u in S}` has 3 elements":
at both primes the closure is all 729 cosets after 6 rounds. *Control:* started from the thinner `T0 + 2 eta^2 T0` (index 2,916) the same
closure stops at 3 cosets, so the check can report failure. By translation the statement holds for any coset `z + M`. ∎

### V5 — PROVED given (S) (hand + tools exact). The wiki's Prop. 7 is NOT used as a black box: its written proof has a gap (below), and (S) closes it.

The route has five lemmas, each stated on a coset of M (or a rotated copy), where all it uses are the 18 edges of M and (S).

**Lemma A (a coset beside a constant coset).** If `rho_b` is constant `kappa` and the coset at `b + e` (e a unit vector, matched `t <-> t`)
is striped, then `rho_{b+e}` avoids kappa and is either constant or two-valued and `omega^j`-periodic for the direction of its two values'
difference; if it is non-residue in direction eps then its values are `{kappa + eps zeta, kappa + eps zeta^2}` and it is eps-periodic.
*Proof.* The non-residue case is V1's analysis with f residue: coinciding partitions with the same assignment make g residue, differing
partitions make g's phases copy f's, so g's pair on each line is f's pair on the next line, which gives the two values and the
periodicity. The residue case: `rho = D(t mod 2)` with `x -> x + D(x)` a bijection of F4, so `sum D = 0` over F4; D avoids kappa, and a sum
of four values from the other three that vanishes uses at most two distinct values; two values `c, c + omega^j` give `omega^j`-periodicity
by the wiki's Lemma 4 (re-derived: a jump of `omega^j` across an edge `omega^j` is an edge conflict). ∎
**Cor 5, general form (re-derived).** If `rho_b` and `rho_{b+e}` (e any unit vector, matched) are both two-valued, periodic in directions
`omega^k`, `omega^l`, their images are equal or disjoint: otherwise the two level sets of a shared value, invariant under `Z omega^k` and
`Z omega^l` (k != l mod 3, which span T0), meet, and there `rho_b = rho_{b+e}`, an edge conflict. (The wiki states it for `e = omega^j`
and applies it with `e = zeta^i eta^2`; the proof is the same.)

**Lemma P (propagation; the wiki's Prop. 7 + Cor. 8, re-derived on M with (S)).** If `z + T0` is residue-type and every T0-coset and
every `eta^2 T0`-coset of `z + M` is striped, then every T0-coset of `z + M` is residue-type.
*Proof.* By induction (Cor. 8's) it suffices to pass from the coset at `u = 0` to the one at `u = zeta^j`; by rotation `j = 0`. Recolour
so `rho_0 = 0`; write `rho_u` for the coset at `z + u eta^2`. Suppose `rho_1` non-residue, direction eps (Lemma A: values
`{eps zeta, eps zeta^2}`, eps-periodic).
*Case eps = 1* (the wiki's part 1). The chain below uses only the adjacencies checked exactly in `prop7_points.py` (30 steps: base
points in N+, differences in U — only `eta` and `eta^2` rotations are needed here — and the colour offsets the wiki writes):
1. `rho_zeta`, `rho_{zeta^-1}` each in `{1, rho_1 + 1}` (Lemma A + Cor 5 against `rho_1`'s `{zeta, zeta^2}`); both `rho_1 + 1` is impossible
   (the eta-edge between them makes `rho_1` `sqrt-3`-periodic, and `<1, sqrt-3> ⊇ 2T0`).
2. If `rho_zeta = 1`: `rho_{1+zeta} = 0` (avoids 1 and `zeta^2`, Cor 5, avoids `zeta`); **`rho_2 = 1`** (avoids 0 by the edge from `(1+zeta)`,
   avoids `zeta^2` by the eta-edge to `u = zeta`, Cor 5, avoids `zeta`) — *the wiki writes `rho_{2 eta^2} = 0`, contradicting its own
   previous sentence*; then `rho_{zeta^-1} = 1` (avoids 0 and, by the eta-edge to `u = 2`, `rho_2 + zeta^2 = zeta`; Cor 5; avoids `zeta^2`);
   and the mirror chain gives `rho_{2-zeta} = 0`. The mirror chain from `rho_{zeta^-1} = 1` gives the same five values.
3. **Closing step (mine; the wiki's does not close).** Consider the `eta^2 T0`-coset through `z + t` (the "column"): its colours at `u` are
   `k_t(u) = rho_u(t) + (t mod 2)`: `k_t(0) = k_t(1+zeta) = k_t(2-zeta) = t mod 2` and `k_t(2) = k_t(zeta) = k_t(zeta^-1) = t mod 2 + 1`.
   The pairs `(0, 2)`, `(zeta^-1, 1+zeta)`, `(zeta, 2-zeta)` differ by `2`, `2 zeta`, `-2 zeta^2` and carry different colours, so the column is
   `2 eta^2 delta`-periodic for no delta: it is not striped, contradicting (S) on orientation 2.
*Case eps in {zeta, zeta^2}* (the wiki's part 3). For eps = zeta (`rho_1` in `{1, zeta^2}`, zeta-periodic): Cor 5 leaves `rho_zeta` constant or
`rho_1 + zeta`; the latter is zeta-periodic and non-residue, which case 1 rotated by zeta (shift `zeta eta^2`, direction zeta) forbids; so
`rho_zeta = zeta`. Then `rho_{zeta^-1}` avoids 0 and (eta-edge to `u = zeta`) `zeta^2`, Cor 5 makes it constant, it avoids 1: `rho_{zeta^-1} = zeta`.
Now case 1 rotated by zeta at the base `u = zeta^-1` (recoloured to 0) with shift `zeta eta^2` lands on `u = zeta^-1 + zeta = 1`, where `rho_1`
is zeta-periodic: contradiction. eps = zeta^2 is the mirror (base `u = zeta`, shift `zeta^-1 eta^2`). ∎

**The wiki's final step, and why it is not used.** With the offsets it writes (all verified), the three inequalities for
`X = rho_{(2/3)(1+omega) eta^2}` exclude `{rho_{eta^2}(a) + 1, omega^2, rho_{2 eta^2} + omega}`. With `rho_{2eta^2} = 1` (the correct value)
this leaves X free (e.g. X = 0); with the page's `0` it leaves `{0, 1}`, which contradicts the claimed `X = rho_{eta^2}` outright. The
adversarial object below realises X = X' = 0 with every edge proper: **the wiki's written proof of Prop. 7 part 1 does not reach its
contradiction.** On Lambda, (S) supplies one (step 3). Whether Prop. 7 holds in the plane without stripes is not decided here.

**Lemma X (a residue base forces residue columns).** On `z + M`, if every T0-coset is residue-type and every `eta^2 T0`-coset is striped,
then every `eta^2 T0`-coset is residue-type.
*Proof.* Write `c(z + u eta^2 + t) = F_tau(u)`, `tau = t mod 2`. Then (M1) each `F_tau` is a striped proper colouring (the column);
(M2) `tau -> F_tau(u)` is a bijection; (M3) the eta-edges give `F_tau(u) != F_{tau + vbar}(u + v)` for all six `sqrt3`-vectors v, `vbar = v mod 2`.
By V1's lemma the non-residue `F_tau` share one direction, and residue ones are striped in every direction: take it to be 1 (rotation).
Line data `L_n(tau, mu) = F_tau(mu + 2k + n zeta)`: (a) each row a pair, each column a bijection; (b) `L_{n+1}(tau, .)` = complement of
`L_n(tau, .)`; (c) `L_{n+1}(s, mu) != L_n(s + zeta, mu)` (`v = sqrt-3 zeta = zeta - 2`); (c') `L_{n+1}(s, mu+1) != L_n(s + zeta^2, mu)`
(`v = -sqrt-3 zeta^2 = 1 + zeta`); (d) `L_{n+2}(tau+1, mu+1) != L_n(tau, mu)` (`v = sqrt-3`). The relation R = {(a),(b),(c),(c')} between
consecutive lines is **symmetric** (`s + zeta` and `s + zeta^2` are involutions). Normalising colours by column 0 of `L_n`, column 1 is a
derangement pi: three translations (`pi(s) = s + y`) and six 4-cycles. By hand, each has **at most one** R-successor (translation y = 1:
`X_s = s + zeta^2`, forced; y = zeta: `X_s = s + zeta^2`; y = zeta^2: `X_s = s + 1`; the six 4-cycles: four have one successor, two have none —
e.g. `0->1->zeta->zeta^2->0` forces `X = (zeta^2, 0, 1, zeta)`). Since `L_n` is itself an R-successor of `L_{n+1}`, uniqueness gives
**`L_{n+2} = L_n`**: every `F_tau` is `2 zeta`-periodic as well as 2-periodic, i.e. residue-type. ∎ (Enumeration, `lemmaX_lines.py`: the 9
line types have 1, 1, 1 translation successors and 4 successors among the six 4-cycles; the only triples satisfying (a)-(d) are the
translation types y = zeta, zeta^2 with `L_{n+2} = L_n`; condition (d) additionally kills y = 1 and all four surviving 4-cycles.
*Planted fault:* dropping (d) makes 5 non-claimed triples appear.)

**Transversal lemma (hand).** If every T0-coset and every `eta^2 T0`-coset of `z + M` is residue-type, then
`c(z + u eta^2 + t) = A(t mod 2, u mod 2)` with A a Latin square on F4 x F4 and `A(tau, x) != A(tau + y, x + y)` for `y != 0` (M3). Each colour
class is `{(tau, x(tau))}` with `x` and `x - id` bijections of F4 (an orthomorphism of `(Z/2)^2`); translating `x(0) = 0`, x permutes
`{1, zeta, zeta^2}` without fixed points, so it is multiplication by `zeta` or `zeta^2`; classes with different multipliers meet; so
`A(tau, x) = Phi(x + lambda tau)`, `lambda in {zeta, zeta^2}`, i.e. `c = Phi'(t mod 2 + lambda^-1 (u mod 2))`. As
`{red_p(eta^2), red_p'(eta^2)} = {zeta, zeta^2}`, this is `Phi'' o red_q` on `z + M` for the q with `red_q(eta^2) = lambda^-1`. ∎

**V5, assembled.** Let some coset of orientation `k0` be residue-type.
- `k0 = 0`: Lemma P on `z + M` (orientations 0, 2), Lemma X, the transversal lemma: `c = Phi o red_q` on `z + M`; V4: on Lambda.
- `k0 = -2`: the same three lemmas on the rotated copy `eta^-2 M` (base orientation -2, columns orientation 0, twist edges `eta^-1`;
  `eta^-2 M ⊂ Lambda`, edges in U) make every T0-coset of `z + eta^-2 M` residue-type: case `k0 = 0`.
- `k0 = -1`: the lemmas on `eta^-1 M` (base -1, columns +1, twist edges `zeta^j`, i.e. the Eisenstein edges, whose residues are diagonal
  `(zeta^j, zeta^j)`): the colouring of `z + eta^-1 M` is `Phi(a mod 2 + lambda b mod 2)` in coordinates `z + eta^-1 a + eta b`, so each T0-coset
  (`a = sqrt-3 t, b = -sqrt-3 t`) has colour `Phi((1 + lambda) t mod 2)`: residue-type. Case `k0 = 0`.
- `k0 = 2, 1`: complex conjugation (a symmetry of Cay(Lambda, U), fixing each prime above 2) maps them to `-2, -1`. ∎
*(S) is used on all five orientations: 0 and 2 (on M), -1 and 1 (on `eta^-1 M`), -2 and 0 (on `eta^-2 M`).*

### V — PROVED given (S) (the wiki is used for its method and its chain of cosets, not as a black box)

Either some coset of some orientation `|k| <= 2` is residue-type — then (V5) `c = Phi o red_q`, which is periodic under `ker red_q ⊇ 2 Lambda` —
or none is — then (V2) c is `2 eta^k eps_k`-periodic for each k, hence periodic under L of V3, of exponent dividing 1680. In both cases c
is `1680 Lambda`-periodic. So `F ⊇ 1680 Lambda`, and since every colouring is periodic, the periodic colourings are all colourings and
`P = F` (colourings exist: the residue colourings). ∎  Nothing here gives `F ⊇ 8 Lambda` without the certificate; that needs more.

## C1 item 4. The adversarial attempt

*Aim:* a colouring striped on every coset, not periodic, by planting one residue coset (rho_0 = 0) beside a non-residue one with the
"all-wall" phases `rho_1(m + n zeta) = zeta` for `n mod 4 in {0,1}`, `zeta^2` otherwise (1-periodic, not 2T0-periodic), and filling the cosets
the proof visits with the values it forces (`rho = 1` at `zeta, zeta^-1, 2`; `0` at `1+zeta, 2-zeta`; `rho_1` shifted at `2zeta, -2zeta^2`), plus the
wiki's two `(2/3)`-cosets set to `rho = 0`. `adversary.py` builds 2,475 points (11 T0-cosets, 15x15 windows): **all 26,324 unit-distance
pairs among them are properly coloured**, every T0-coset is striped, and **every one of the 25 columns tested violates all three stripe
directions**. It fails for the reason my proof names (step 3, (S) on orientation 2) — and it survives every inequality the wiki's written
proof of Prop. 7 part 1 lists, including its last step. That is a finding about the published input (above), not about V5.

Two cheaper attempts fail at the named steps: a direction change between two adjacent cosets of one orientation, all non-residue, dies
by V1 (the enumeration's zero); a phase flip on one line of one coset in the no-residue case dies by V2 for another orientation, whose
period `2 eta^k' eps_k'` carries that line onto an unflipped one of the same coset.

## C2. Comparison with the competitor (de Bruijn's FS85-dB9, dB10, dB11; read only after every C1 verdict above was written)

*The 2,475-point object* (asked by the owner): built **by formula** — the coset values the proof forces, written down directly in
`adversary.py`; no search, solver or colouring enumeration. It is used only as the adversarial attempt and to show the wiki's last
step cannot fire; **nothing in V1–V5 or V rests on it.**

| # | item | competitor | verifier | status |
|---|---|---|---|---|
| D1 | V1, pair-partitions coincide | "Z is residue-type" | both are residue-type | compatible (mine sharper); resolved |
| D2 | V4's bookkeeping | a single class of U mod M_i with all three residues; sublattice chain 729→81→9→3→1 | per-coset closure on Λ/M (neighbours from any known coset), 6 rounds | two exact routes, same conclusion; keep both |
| D3 | **V5 step 1 (dB11.1): every T0-coset of M residue-type** | the wiki's Prop. 7 / Cor. 8, "transferred step by step" (Task 0 T0.3: points and 17 adjacencies checked) | the written proof of Prop. 7 part 1 does not close: `rho_{2eta^2}` is 1, not 0, and the final `(2/3)(1+omega)eta^2` step forces nothing (the adversarial object satisfies all its inequalities); closed by Lemma P step 3, (S) on the η²T0-cosets | **ESCALATED: a gap in dB11 as written, inherited from the published input; my step repairs his chain** (details below) |
| D4 | the wiki's "similarly" steps | the partial conjugation `α + βη² ↦ ᾱ + β̄η²` | explicit mirror steps, each checked exactly | both valid; his map is the Galois automorphism fixing √−11 (it sends ζ to ζ̄ and fixes η²), an automorphism of Cay(Λ, U) — cleaner than mine; resolved |
| D5 | V5 step 3 (Lemma X): the η²T0 families are residue-type | D/C case split on one row's derangement; C killed by the three E2 offsets, including (−1, 2); D with t = 1 killed by (−1, 2) | the successor relation R between consecutive lines is symmetric and has at most one successor for each of the 9 normalised line types, so `L_{n+2} = L_n`; (d) = offset (−1, 2) is not needed for residue-type, and it then kills y = 1 and every 4-cycle | two routes, same conclusion, and my enumeration agrees with each of his sub-claims (4-cycles: two have no successor, four die at (d); y = 1 dies at (d)); keep both |
| D6 | the Latin square on F4² | complete mappings of (Z/2)²: `y + μβ`, μ = red_q(η²) = ζ̄₃^{±1} | orthomorphisms: multiplication by ζ or ζ², matched to red_q(η²) ∈ {ζ, ζ²} | the same; the prime labels differ only by which prime is called 𝔭; resolved |
| D7 | the other orientations | rotated copies `M_k`, k = −1, −2, which contain T0; conjugation for +1, +2 | the same | agree; the gap in D3 recurs in each rotated copy and my step closes each (it needs (S) on orientation k+2 ∈ {1, 0}, which both routes already use) |
| D8 | V3 | Smith types (162, 54, 12, 6, 6, 3 choices) | exponents {6, 12, 30, 42, 48}, lcm 1680 | agree |
| D9 | V | periodic, F ⊇ 1680Λ, P = F; F ⊇ 8Λ not derived | the same | agree on every statement's verdict |

**D3 in detail — does dB11 step 1 depend on the wiki's written Prop. 7? Yes.** Task 0 (T0.3) checked that every point is in Λ and
every adjacency is in U, and repaired three typos (Cor. 5's scope, its citation of (4), Lemma 3's `ρ_a(z)`). It did not re-derive the
logic, and it records "P-wiki is won". The logic has two defects, found blind in C1:
1. "ρ_{2η²} = 0" contradicts the sentence before it ("it has to avoid 0 entirely"). The forced value is 1.
2. The last step ("and hence ρ_{(2/3)(1+ω)η²}(a) = ρ_{η²}(a)") does not follow. With the offsets as written (all verified exactly), the
   three inequalities exclude `{ρ_{η²}(a) + 1, ω², ρ_{2η²} + ω}`. With the value 1 this leaves the coset free. With the page's 0 it
   leaves `{0, 1}`, which contradicts the claimed equality outright.

So part 1 of Prop. 7, and with it parts 3, Cor. 8 and dB11.1, is **unproved as written**.
- **My route repairs his chain rather than replacing it.** Everything in the wiki's chain up to the values at u ∈ {0, ζ, ζ⁻¹, 1+ζ, 2−ζ, 2} is
  sound once ρ_{2η²} = 1. Replace its final step by Lemma P step 3: the η²T0-coset through any point has colours `t̄` at u = 0, 1+ζ, 2−ζ
  and `t̄+1` at u = 2, ζ, ζ⁻¹. That kills 2η²δ-periodicity for every δ, so the coset is not striped, contradicting (S).
- This uses only (S) on orientation 2, which dB11 steps 2–3 already use. It stays inside M: only the η and η² edges are needed, and not
  the η³ edges or the (2/3)-cosets.
- Part 3 then follows from part 1 as the wiki argues, with (S) supplying part 2 (Lemma A).
- With this one substitution, dB11 steps 1–5 stand and agree with my V5.
- My verdict on the competitor's dB11: **gap (inherited from `[Polymath16wikiR2]`), closed by the verifier's Lemma P step 3.** On
  the statements themselves, the verdicts agree. This is not a contradiction under stall criterion 2. It is escalated because the
  competitor's record and Task 0 currently say that the wiki transfers "step by step" as a proof.

**Outside the comparison** (the brief scoped C2 to dB9–dB11): dB5–dB8 (level-3 tightness, locality at one prime given `8Λ`-periodicity,
the chirality congruence, Lemma S) were read, not checked.

## C3. Prior art and scope

**Has anyone proved in print, by hand, that every four-colouring of Λ, of R₂, or of any lattice between them is periodic? Not found.**
I searched the held Polymath16 threads 1–18 (Python regex over the text for "human-provable", "periodicity of 8", "8-periodic",
"stripes", "9120", "Coloring R_2"), the wiki page "Coloring R_2" in full, and `[Parts2020hv]` §§1–4. I did not run a zbMATH or
citation search this session.
- **The question was posed.** The sixth thread's opening post (Mixon, June 2018) asks: *"Is Tamas's result that every 4-coloring of
  ℤ[ω₁,ω₃] is 8-periodic human-provable?"* That result is `[Hubai2018]`, by computer search. Gibbs (30 May 2018) writes that getting
  from the absence of monochromatic triangles to periodicity 8 by human proof "has not been done yet". Hubai (sixth thread) notes that
  stripes on R₁ alone give no periodicity in other directions, and that "we'll need to use that our colouring extends to R₂ in some
  stronger way". That is exactly the coupling V1–V5 supply. This belongs in `CLOSED-QUESTIONS.md` as a candidate, at its exact scope.
- **The nearest claims.**
  - Gibbs (3 June 2018): *"I think I know how to get from the lack of the monochromatic triangle to a periodicity of 16 using mostly
    algebraic methods."* It is on R₂, it was never written in the threads, and he said he would put it on the wiki if it worked. We do not
    hold the wiki's "Algebraic formulation" page; that page is a debt to read before any novelty claim.
  - Gibbs (31 May 2018) studies exactly the `T0 + η^a T0`-type sublattices ("R₁ × R₁") that Lemma X uses.
  - Tao's wiki page proves only the spreading step (Cor. 9) on R₁ + η²R₁, and its written proof has the gap found here.
  - `[Parts2020hv]` proves stripes on one hexagonal lattice, given non-monochromatic √3-triples, and goes straight to χ ≥ 5 by a √5
    rotation. He does not treat periodicity.
- **Scope, with forcing monotone upward.**
  - V is about the smaller graph Cay(Λ, U).
  - Every colouring of R₂ = ℤ[ζ, η²] ⊃ Λ restricts, on each coset of Λ, to a colouring of Cay(Λ, U). So V implies that every
    four-colouring of R₂ is invariant under translation by 1680Λ. Λ has infinite index in R₂ (R₂ is not finitely generated), so this is
    **weaker than Hubai's 8R₂-periodicity** on the ring, and V says nothing about 8Λ on Λ.
  - What V answers: Mixon's question with 8 replaced by a finite-index period lattice, on Λ. It is hand-provable given (S). (S) itself
    rests on Parts's computer-found, human-checkable trees (C3b).

**Where (S) fails on the loose controls, so V does not prove too much.**
- **ℤ[ζ₆] alone:** the proper colouring `m + nζ ↦ (m + 2n) mod 3` uses three colours on every line, so it is not striped. And even
  with stripes, one orientation gives `L = ⟨2ε⟩` of infinite index, and there is no η-twist for Lemmas P and X.
- **FS-73's loose lattices that contain Eisenstein hexagons** (`data/fs73/table/TABLE.md`): each is loose by an exhibited *gapped*
  periodic colouring. Examples: `K|Q(√11,√−3)` (rank 2, 6 units, gap at N = 3), `K|Q(√3,i)` (gap 3), `K|Q(√3,√−11)` (gap 5),
  `Q35|Q(√15,√−3)` (gap 5), `Q35|Q(√3,√−5)` (gap 5), `Q3_23|Q(√69,√−3)` (gap 5).
  - A striped Eisenstein coset shows all four colours in every closed hexagon: the axis neighbours carry the other colour of the pair,
    and the two neighbours on each adjacent line carry both colours of the other pair.
  - So a gapped colouring is not striped on the Eisenstein coset through its gapped vertex, and (S) fails on each such lattice. This is
    a one-line argument from the table's recorded gaps; I did not recompute the colourings.
- **Lattices without √−3** (`K|Q(√11,i)`, `Q35|Q(√15,i)`, …) have no Eisenstein cosets, so the hypothesis does not apply.
- **The load-bearing place** is Parts's lemma, whose base graph must lie in the lattice (C3b).

## C3b. The shared input (S), read a second time

1. **Re-transcription.** I rendered page 15 of `[Parts2020hv]` (`pdftoppm -r 110`, `p15-15.png`) and read Table 3 (29 orbit
   representatives, degrees and orders) **by eye**, not through pdftotext. My reading agrees entry for entry with the pdftotext text.
   The orders sum to 1 + 4·6 + 10·12 + 14·24 = 481. The mod-4 constraint `a − b + c + d ≡ 0` holds on every representative.
2. **Rebuild** (`g481.py`, exact). Each representative is closed under the order-24 group: 60° rotations, complex conjugation, and
   Parts's "conjugation symmetry" (b, c) ↦ (−b, −c), which is the Galois automorphism fixing √−11 (the competitor's partial
   conjugation).
   - Every orbit has exactly the order the table states, and the orbits are disjoint: **481 points, 2,814 unit edges**, every edge
     difference in U.
   - **Every orbit's rebuilt degree equals Table 3's "vertex degree" column** (29 of 29). This is an independent check of the
     transcription: a one-digit plant, `(4,0,2,2)` read as `(4,0,2,6)`, changes 11 orbits' degrees and is caught.
   - **η^k·G481 ⊂ Λ for |k| ≤ 2** (0 points outside). **η^{±3}·G481 has 150 points outside Λ, and η^{±4}·G481 has 342**, matching the
     advisor's figures.
3. **The trees.** Table 4 (pages 16–22) states every tree in full: each node's coordinates (a, b, c, d), its colour (the cell's
   background), and for each colour port the earlier nodes of that colour adjacent to it. So it is complete enough to walk as a fixed
   certificate.
   - It is **raster images only** (214 ppi; pdftotext returns just the labels S, L1–L8), 787 non-root nodes in total.
   - I walked **tree S** (11 nodes, read by eye from `t4-002.png`; `treeS.py`). Every node is a vertex of the rebuilt G481; every listed
     port neighbour is earlier, has that colour and is at unit distance; the three stems have exactly three blocked colours, and the end
     node has all four. **S walks.** A planted coordinate is refused (three port failures).
   - **Not walked: L1–L8 (776 non-root nodes).** That needs a by-eye or OCR transcription of 776 raster cells, or Parts's data files
     (Polymath16 "Code and data/dropbox/JP/Pink", `[Parts2020hv]` ref. [3], not held). Also unchecked here: the completeness of the root
     case split (Table 1: 36 extended root colourings of the 2-Golomb graph, mapped onto S and L1–L8, including the 19 excluded through
     Fig. 11's mono-pair). That is a hand claim in the paper.

## Theorems this phase proved

All in scratch; the proofs are in this record. The grades are this project's.
- **V-T1 (V1, sharpened).** Two pointwise-disjoint stripe patterns on T0 with different directions: one is residue-type; both are, if
  their pair-partitions coincide. [hand; window enumeration with a control and a plant]
- **V-T2 (V2).** Given (S): if an orientation has no residue-type coset, then one direction serves all its cosets, and c is
  2η^kε_k-periodic on Λ. [hand]
- **V-T3 (V3 re-check).** All 243 choices of L have finite index; the lcm of the exponents is 1680. [tools exact]
- **V-T4 (V4).** A residue colouring on a coset of M = T0 + η²T0 is the global residue colouring. [hand + tools exact closure, 6 rounds]
- **V-T5 (Lemma A).** A striped coset beside a constant-ρ coset is constant, or two-valued and periodic; in the non-residue case its
  values are {κ + εζ, κ + εζ²}. [hand]
- **V-T6 (Lemma P, = the wiki's Prop. 7 + Cor. 8 on M, repaired).** Given (S) on the T0- and η²T0-cosets of z + M: one residue-type
  T0-coset makes all of them residue-type. [hand; the wiki's chain with ρ_{2η²} corrected to 1; the closing step is the column argument]
- **V-T7 (a defect in the published input).** The written proof of `[Polymath16wikiR2]` Prop. 7 part 1 does not reach its
  contradiction. The adversarial object (2,475 points, built by formula) satisfies every inequality it lists and has no monochromatic
  edge. [hand + tools exact]
- **V-T8 (Lemma X).** On z + M, residue-type T0-cosets and striped η²T0-cosets force residue-type η²T0-cosets. The proof: the
  successor relation between consecutive lines is symmetric, with at most one successor, so `L_{n+2} = L_n`. [hand; 9-type enumeration
  with a plant]
- **V-T9 (transversal lemma).** A Latin square on F4² that is rainbow on the diagonals is `Φ(x + λτ)`, λ ∈ {ζ, ζ²}; on z + M this is
  Φ∘red_𝔮. [hand; red_𝔮(η²) computed exactly]
- **V-T10 (V5).** Given (S): one residue-type coset of any orientation |k| ≤ 2 forces c = Φ∘red_𝔮 on Λ. [hand + tools exact]
- **V-T11 (V).** Given (S): every four-colouring of Cay(Λ, U) is 1680Λ-periodic; F ⊇ 1680Λ; P = F. [hand + tools exact]
- **V-T12 (C3b).** G481, rebuilt from a by-eye transcription, has 481 points and 2,814 edges, with degrees matching Table 3. It lies in
  Λ exactly in orientations |k| ≤ 2 (150 and 342 points outside at |k| = 3, 4). Tree S walks. [tools exact]

## C4. Derivation-file entries (format of `plans/FS79-derivation.md`)

**FS85-V1 — Adjacent striped cosets share a direction unless one is residue-type; both are, if their partitions coincide. [hand; tools
exact check]**
- *Proof:* RECORD.md § V1; `v1_enum.py` (0 violations; same-direction control 19,584; plant 2,304).
- *Proof verdict:* closes.
- *Rests on it:* V2, Lemma A, Lemma X's common direction.
- *Prior art:* the stripe form is `[Parts2020hv]`'s; the disjointness lemma was found neither in the threads nor on the wiki
  (a held-sources search only); its content is also the competitor's dB9(1), derived independently.
- *Kernel:* **stub**. A small finite statement about stripe data, the natural first leaf of any kernel form of V.

**FS85-V2 — One direction per orientation, and global 2η^kε_k-periodicity. [hand]**
- *Proof:* § V2.
- *Proof verdict:* closes given (S).
- *Rests on it:* V.
- *Prior art:* the competitor's dB9(2), independently.
- *Kernel:* with FS85-V1's stub.

**FS85-V3 — The 243 lattices L have finite index; the lcm of the exponents is 1680. [tools exact]**
- *Proof:* `v3.py`.
- *Proof verdict:* closes.
- *Rests on it:* V.
- *Prior art:* the owner's and dB9(3)'s computations agree.
- *Kernel:* declined. A Smith form; decide it in the kernel only if V is ever formalised.

**FS85-V4 — Residue on a coset of M spreads to Λ. [hand + tools exact]**
- *Proof:* § V4; `v4.py` (6 rounds, both primes; a thin-start control stops at 3 of 2,916).
- *Proof verdict:* closes.
- *Rests on it:* V5.
- *Prior art:* dB10 by a different chain (729→81→9→3→1).
- *Kernel:* stub, with V5.

**FS85-V5 — One residue-type coset forces the global residue colouring. [hand + tools exact]**
- *Proof:* Lemmas A, P, X and the transversal lemma, assembled in § V5.
- *Proof verdict:* closes given (S). It does **not** close given only the wiki's written Prop. 7 (V-T7).
- *Rests on it:* V.
- *Prior art:* the renormalisation and the chain of cosets are `[Polymath16wikiR2]`'s (Tao, 2018). The closing step and Lemma X are
  ours (the competitor's dB11 reached Lemma X's content independently).
- *Kernel:* **stub.** Everything is finite and local on M; the one published input used is (S).

**FS85-V6 — The written proof of `[Polymath16wikiR2]` Prop. 7 part 1 has a gap; on Λ, (S) closes it. [hand + tools exact]**
- *Proof:* § V5 ("the wiki's final step"); `prop7_points.py` (30 steps, including the mirrored ones); `adversary.py`.
- *Proof verdict:* closes (as a finding about the published proof).
- *Rests on it:* the correction owed to Task 0's "P-wiki is won" and to dB11 step 1.
- *Prior art:* the page itself.
- *Kernel:* declined (a finding about a document).

**FS85-V7 — Every four-colouring of de Grey's lattice is 1680Λ-periodic; F ⊇ 1680Λ, P = F. [hand + tools exact, given (S)]**
- *Proof:* § V.
- *Proof verdict:* closes given (S), which rests on Parts's trees; only S among them was walked here.
- *Rests on it:* the inheritance question on Λ without the 2,044-point certificate (row 78). F ⊇ 8Λ still needs the certificate.
- *Prior art:* Mixon's sixth-thread question ("is 8-periodicity human-provable?") is answered with a finite-index period lattice in
  place of 8. Gibbs claimed a route to periodicity 16 on R₂, never written (3 June 2018). No hand proof was found in held sources;
  zbMATH was not run.
- *Kernel:* stub, conditional on (S) as a named hypothesis.

**FS85-V8 — G481 rebuilt; its orientations in Λ; tree S walked. [tools exact]**
- *Proof:* § C3b; `g481.py`, `treeS.py`.
- *Proof verdict:* closes for what it states; L1–L8 are not walked.
- *Rests on it:* (S)'s transfer to Λ.
- *Prior art:* the graph and trees are `[Parts2020hv]`'s.
- *Kernel:* declined until L1–L8 are transcribed.
