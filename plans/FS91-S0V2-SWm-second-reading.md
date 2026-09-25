# FS-91 crunch job J03a — the second, blind reading of Lemma SW-m and its all-`k` consequence

*De Bruijn (Opus 5.5), blind verifier, 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J03a-SWm-blind-reading.md` with
`data/crunch-2026-09-25/briefs/STANDING-RULES.md`. Read before this record: the brief and the rules; `CLAUDE.md`, `WORKFLOW.md`,
`DEBRUIJN.md` (loaded); `plans/FS89-derivation.md` §1–§9a; `plans/FS89-S1VB-verification.md` lines 1–101 (its C0, §B1.0 and §B1.1);
`plans/FS89-S0A-gluing-verification.md` §C1 G1 and G0 (not fenced; read for the definition of `A(R_F)` and the gluing's six steps).
Of `plans/FS91-S0V-band-to-nine.md` only the two quoted statements were extracted, by a script that printed the text between the
statement's quotation marks and the verdict heading with its first bullet, plus a whitespace-normalised existence test of the theorem-table
quotation (nothing around it printed). Nothing else fenced was opened.*

## Stage 1 — SAVED

### 1.1 The quotation check (standing rule 5)

Every quotation in the brief, tested against its source by exact substring match after whitespace normalisation (the brief drops the
source's bold markers; nothing else differs):

| quotation in the brief | source | result |
|---|---|---|
| C1, Lemma SW-m: "Let `S` be a finite set of primes `≡ 1 (mod 4)`, `k ≥ 3`, `v \| p ∈ S`, `x ∈ R̂_S`, `c₀ ∈ K_v`, `s ∈ ℤ`. Then not every `x + c̄` with `c ∈ c₀ + π_v^s O_v` lies in `Θ_k(R_S)`." | `plans/FS91-S0V-band-to-nine.md` lines 242–243 (the statement begins on 242 and ends on 243) | **verbatim** |
| C2: "`RS_k(S)` for every `k ≥ 2` and every finite `S` with `\|S\| ≥ 2`; `RQ_k` for every `k`; and, by S0A-2's band-free gluing, `Θ_k(R_F) ⊆ T + A` for every `F ⊆ ℝ` at every `k`." | same file, line 271ff, "Verdict on the all-`k` candidate: TRUE", first bullet | **verbatim** (bold dropped) |
| C2's restatement: "Equivalently: *for `\|S\| ≥ 2`, every character of `R_S` outside `T + A` takes values arbitrarily close to 0 on `U_S`*." | same bullet | **verbatim** |
| the theorem table: "`RS_k(S)` for every `k` and `\|S\| ≥ 2`, `RQ_k` for every `k`, and `Θ_k(R_F) ⊆ T + A` for every `F ⊆ ℝ` (with S0A-2)" | same file, one occurrence; the string "J01-7" occurs within 300 characters before it | **verbatim**; the J01-7 attribution is consistent (not read further) |
| FS89-S1VB-2 (Lemma SW) | `plans/FS89-derivation.md` line 218 | **verbatim** |
| FS89-S1VB-4 (VB1) | line 225 | **verbatim** |
| FS89-S1VB-6 (VB3) | line 233 | **verbatim** |
| FS89-S1VB-7 (VB4) | line 237 | **verbatim** |
| FS89-S0A-2 (the gluing) | line 45 | **verbatim** |
| PA-B2, "for every finite `S` with `\|S\| ≥ 2`, every `U_S`-minimal closed `M ⊊ R̂_S` lies in `T + A`" | line 343 (FS89-PA-B2's statement; J01's verdict on it is fenced and was not read) | **verbatim** as FS89-PA-B2's statement |
| notation: `RS_k(S)`: `Θ_k(R_S) ⊆ T + A`, `RQ_k`: `Θ_k(Q) ⊆ T + A` | `plans/FS89-derivation.md` "Notation, fixed once" | **verbatim** |

**Two paraphrases in the brief's prose (not quotations), logged:**
1. "FS-89 proved that at four and five colours every band character of `R_S` with `|S| ≥ 2` is a torsion character plus an archimedean
   one." At five colours FS-89 proved it only for `S ∋ 5`: FS89-S1VB-14 reads "`RS₅(S)` and `MS₅(S)` for every `S ∋ 5` with `|S| ≥ 2`"
   (D5-L1 needs `5 ∈ S`). A widening; harmless here only if C2a holds.
2. "Its route has exactly one step that reads the band: Lemma SW." True of verifier I's route **once PA-B2 replaces D1-L4 and D5-L1**
   (the parity line, which reads the band at 1/4 and 1/5, FS89-D1-L4 and D5-L1). In FS-89 as closed, the minimal-set step read the band
   too. The brief's sentence presupposes the accepted PA-B2; I record the presupposition.

**One definitional point found while checking the sources, carried to C2c:** the brief's notation gives `A` as "`λ_e(x) = Re(ē x)`". For
`Q` and `R_S` (inside `ℚ(i)`) that is all of `Hom_ℚ(ℚ(i), ℝ)`. For `R_F` with `[F : ℚ] ≥ 2`, the gluing's own conclusion is about
`A(R_F) := {x ↦ ℓ(x) mod 1 : ℓ ∈ Hom_ℚ(F(i), ℝ)}` (`plans/FS89-S0A-gluing-verification.md` §C1 "Conventions": "`A(X)` for `X ⊆ L` is the
set of `x ↦ ℓ(x) mod 1` with `ℓ ∈ Hom_ℚ(L, ℝ)`"), which is larger than the one-embedding `λ_e`. C2c is judged under each reading.

### 1.2 C0 — probabilities, written before any derivation was written down

Honesty note (verifier I's form): written after reading the sources above and after a mental pass of perhaps fifteen minutes, nothing
written. The pass already contained the sweep's arithmetic (a ball `c₀ + π_v^s O_v` under `ψ_v(u·)` with `v(u) = −(m + s)` fills a coset of
step `p^{−m}`), so C1's number is a posterior of that pass; the C2 numbers are priors on the rest of the chain.

| claim | predicted verdict | probability TRUE |
|---|---|---|
| C1, SW-m at every `k ≥ 3` | TRUE: a deeper expanding power makes the step `p^{−m}` as fine as wanted; I expect it to hold at `k = 2` too | 0.95 |
| C2a, `RS_k(S)`, every `k`, `\|S\| ≥ 2` | TRUE, if VB1's other lines (Lemma E, Lemma JC) are band-free as they look, and resting on the accepted PA-B2 | 0.85 |
| C2b, `RQ_k`, every `k` | TRUE given C2a: VB3 and VB4 look band-free; `N` non-effective | 0.85 |
| C2c, `Θ_k(R_F) ⊆ T + A`, every `F ⊆ ℝ`, every `k` | TRUE with `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`; the uniform `N` must come from VB3; FALSE if `A` is read as one embedding's `λ_e` | 0.75 (wide reading) |

Where I expect the weight: nowhere in the sweep. If anything fails it is a scope question (what `A` means over `R_F`; what `N` is at a
general `k`), or a line of VB1 that reads the band implicitly.

## Stage 2 — SAVED

### 2.1 C1, Lemma SW-m, derived blind from its statement

*Conventions* (verifier I's, `plans/FS89-S1VB-verification.md` §B1.0, quoted there and not changed): a point of
`R̂_S = (ℂ × ∏_{v|S} K_v)/Δ(R_S)` with data `(e; b)` is the character `x ↦ Re(ē x) − Σ_v ψ_v(b_v x)`, `ψ_v` the local component of the
standard additive character (trivial on `O_v`, non-trivial on `π_v^{−1}O_v`); `c̄` is the image of `(0; c at v, 0 elsewhere)`. Every `p ∈ S`
splits in `ℚ(i)`, so `K_v = ℚ_p`, `O_v = ℤ_p`, `π_v^s O_v = p^s ℤ_p`, and `ψ_v` is the `p`-adic fractional part `{·}_p` (up to a sign,
which changes no image below). For `u ∈ U_S`: `(x + c̄)(u) = x(u) − ψ_v(c u)`.

**Lemma SW-m, the statement as quoted in §1.1, proved at every `k ≥ 2`.** [hand + tools exact]

*Proof.*
1. **(The one line that reads `k`.)** Fix `m ≥ 1` with `2p^m > k`. Any `k` works; `k ≥ 3` is not used.
2. `w_p = π_p/π̄_p` has valuation `+1` at one place above `p` and `−1` at the other: `p = π_p π̄_p` with `π_p`, `π̄_p` coprime, so in each
   embedding `ℤ[i] → ℤ_p` exactly one of them has valuation 1 and the other is a unit (tool check S1, at 5, 13, 17, 29, 37). So for every
   integer `n` there is `t` with `v(w_p^t) = n`. Take `u := w_p^t ∈ U_S` (`p ∈ S`) with `v(u) = −(m + s)`.
3. For `c = c₀ + b`, `b ∈ p^s ℤ_p`: `(x + c̄)(u) = a − ψ_v(bu)`, `a := x(u) − ψ_v(c₀u)` fixed. As `b` runs over `p^s ℤ_p`, `bu` runs over
   `u p^s ℤ_p = p^{−m} ℤ_p`, and `{·}_p` maps `p^{−m}ℤ_p` **onto** `p^{−m}ℤ/ℤ` (it is a homomorphism with kernel `ℤ_p`, and
   `p^{−m}ℤ_p/ℤ_p ≅ ℤ/p^m`). So the values `(x + c̄)(u)` over the ball are the full coset `a + p^{−m}ℤ/ℤ` (tool check S2: the image
   enumerated in exact `p`-adic arithmetic, both places, four balls including `s < 0` and `c₀ ∉ ℤ_p`, `m = 1, 2`).
4. Every point of `ℝ/ℤ` lies within `1/(2p^m)` of that coset, so some value lies at distance `≤ 1/(2p^m) < 1/k` from 0, i.e. in the open
   arc `(−1/k, 1/k)`, the complement of `B_k = [1/k, 1 − 1/k]`. That `x + c̄` is not in `Θ_k(R_S)`. ∎ (Tool check S3: at every
   `k = 2..200` and each of the five primes, the least such `m` is `m_k`, and one fewer digit leaves the worst-shifted coset inside the band;
   S4: the enumerated image of step 3, shifted adversarially, meets the arc at the largest `k` with that `m`.)

**What the proof uses, and what it does not.** It uses `p ∈ S` (so that `w_p ∈ U_S`) and `v | p` split. It does **not** use `k ≥ 3`, `|S| ≥ 2`,
the finiteness of `S` beyond the definition of `R̂_S`, `x ∈ Θ_k`, or any property of `c₀` and `s`. Its one `k`-reading line is step 1.

**At `k = 2`.** `B_2 = {1/2}`; the complement is everything but `1/2`; `m = 1` already gives a coset of `p ≥ 5` points, so SW-m holds at
`k = 2` (and so does FS-89's one-digit SW, since `2 < 2p`). The statement's `k ≥ 3` is a convention, not a hypothesis the proof needs.

**Why FS-89's SW stopped at `k < 2p`, and why SW-m does not.** SW took `v(u) = −(1 + s)`, one digit: its coset has step `1/p`, and its worst
shift sits at distance exactly `1/(2p)` from 0, which is `< 1/k` iff `k < 2p` (`k ≤ 9` at `p = 5`). A deeper power of the same `w_p` is
just as available, and the step `p^{−m}` beats any band. Plant P1 checks the edge: at `k = 2p` the one-digit coset at its worst shift lies
in the band (distance `1/(2p) = 1/k`, not `< 1/k`), while `m = 2` meets the arc.

**Verdict C1: TRUE** — at every `k ≥ 2`, not only `k ≥ 3`. [hand + tools exact] The lemma is two lines once the expanding power is allowed
to be deep; the depth `m` depends on `k` and `p`, never on `x`, `c₀` or `s` (`s` enters only through `t`).

### 2.2 The tool

`tools/crunch_j03a_sweep.py` (1.5 s, exact `Fraction` and `p`-adic integer arithmetic at 60 digits) → `data/fs91/j03a/sweep-check.txt`,
`ALL CHECKS PASS`, exit 0. Checks S1–S5 as in its docstring; S5 is Lemma JC's radius, used in stage 3 (`w_{p′}^{p−1} = 1 + p^j·unit` with
`j = 1` at every pair among 5, 13, 17, so the ball VB1 produces has radius `p^{−(v(c)+1)}` when `w_{p′} ∈ U₀`). **Plants, each paired
with a faithful twin that passes, each firing for its stated reason:**
- P1: the one-digit sweep at `k = 2p` stays in the band at its worst shift, distance `1/(2p) = 1/k` (all five primes); twin `m = 2` meets
  the arc.
- P2: sweeping with `u = w₁₃` (a unit at `v | 5`) instead of a power of `w₅`: the ball's image is one point (size 1), not a coset; twin full.
- P3: Lemma JC with `p′ = p = 5`: refused because `w₅` has valuation 1 at `v`, not a unit (so JC needs a second prime); twin `p′ = 13`
  gives `j = 1`.

The extent (five primes, `k ≤ 200`, `m ≤ 2` for the enumeration) was fixed by the derivation before the run; the tool checks a derived
formula and searches for nothing.

## Stage 3 — SAVED

*Everything below was derived before any fenced file was opened. Inputs used as verified: FS89-D1-L2 and D1-L3 (each derived twice in FS-89),
PA-B2 (accepted by the owner; its composition re-derived in §3.2), Lemma E and Lemma JC (re-read line by line below), S0A-2's six steps.*

### 3.1 VB1 at a general band

**Theorem (VB1 at every `k ≥ 2`).** Let `|S| ≥ 2`, `k ≥ 2`, `y ∈ Θ_k(R_S)`, and suppose `Ō(y)` contains `x = τ₀ + λ_d ∈ T + A`. Then
`y ∈ T + A`. [hand + tools exact (S5, P3)]

Verifier I's proof (`plans/FS89-S1VB-verification.md` §B1.1), re-read line by line; every line survives, and one changes:

| line | content | reads `k`? |
|---|---|---|
| (a) | `U₀ := Stab(τ₀)` has finite index (`τ₀` factors through the finite `R_S/NR_S`) | no |
| (b) | `g_n y → x`, `δ_n := g_n y − x`; if some `δ_n ∈ A`, then `y ∈ T + A` (`T + A` is invariant) | no |
| (c) | Lemma E, `x_n = x`: `h_n ∈ U₀`, `v \| p`, `c ∈ K_v^×`, `x′ = τ₀ + λ_{d′}` (`\|d′\| = \|d\|`), `x′ + c̄ ∈ Ō(y)`. Re-derived: the expanding power `w_p^{±a k_n}` keeps the archimedean part and every other place bounded (isometric there, or contracting at the conjugate place), puts the `v`-part in the annulus `[p^{−a}, 1)`, and fixes `τ₀` | no |
| (d) | `Ō(y) ⊆ Θ_k`: `Θ_k` is closed (evaluation is continuous, `B_k` closed) and `U_S`-invariant (`U_S` a group) | no (any closed band) |
| (e) | `p′ ∈ S ∖ {p}` (the one use of `\|S\| ≥ 2`), `w_{p′}^b ∈ U₀`; Lemma JC: the pairs `(w̄_{p′}^{bn}, w_{p′}^{bn}\|_v)` are dense in `S¹ × W₀`, `W₀ ⊇ 1 + p^{j}ℤ_p` (`j = 1` at every pair among 5, 13, 17 when `b = 1`, tool S5); so `x′ + (tc)‾ ∈ Ō(y)` for every `t ∈ W₀` | no |
| (f) | hence `x′ + c̄′ ∈ Θ_k` for every `c′` in the ball `c + p^{v(c)+j}ℤ_p` | no |
| (g) | **was:** "Lemma SW refutes this" (one digit, `k < 2p`); **now:** SW-m with `x = x′`, `c₀ = c`, `s = v(c) + j` refutes it | **yes, and only here**: through SW-m's step 1, `m` with `2p^m > k` |

Plant P3 of the tool is line (e)'s hypothesis made to fail: with `p′ = p` the unit is not a unit at `v`, and JC does not apply — the
one-prime failure S0B-T4 needs. ∎

### 3.2 C2a — `RS_k(S)` at every band

**Theorem.** For every finite `S` (primes `≡ 1 (mod 4)`) with `|S| ≥ 2` and every `k ≥ 2`: `Θ_k(R_S) ⊆ T + A`, and `MS_k(S)`. [hand; given
PA-B2]

*Proof.* `y ∈ Θ_k`; `X := Ō(y) ⊆ Θ_k` (line (d)); `X` contains a minimal closed invariant `M` (Zorn, `X` compact). `M ≠ R̂_S`, because
`0 ∉ Θ_k`: `0(u) = 0 ∉ B_k` **(the second line that reads `k`: it needs `0 ∉ B_k`, true for every `k ≥ 2`)**. PA-B2: `M ⊆ T + A`. So `X`
meets `T + A`, and VB1 (§3.1) gives `y ∈ T + A`. `MS_k(S)` is PA-B2 itself, restricted to minimal subsets of `Θ_k`. ∎

**PA-B2's composition, re-derived** (not its lemmas; the reader's §5 is fenced and was not read): a minimal `M` either has arbitrarily small
differences with non-zero `S`-adic part (case 1) or not (case 2). Case 2: D1-L2 gives a point of `T + A` in `M`; its orbit closure is `M`
(minimality) and is Lemma L's set, inside `T + A`. Case 1: D1-L3 gives `M − M = R̂_S`. Then `J := {(g, x) ∈ R̂_S × M : x + g ∈ M}` is
closed and `U_S`-invariant (`u(x + g) = ux + ug`), projects onto `M` (take `g = 0`) and onto `M − M = R̂_S`: a joining of `(R̂_S, U_S)` with
the minimal flow `M`. `(R̂_S, U_S)` has dense periodic points (the torsion characters) and is totally transitive (every finite-index
subgroup contains a `w_p^a`, ergodic because no non-zero element of `R_S` has a finite `w_p^a`-orbit), so it is disjoint from every minimal
flow (Furstenberg's F-flow disjointness; for this group flow `[Berend1984]` Thm I.2 with Prop. II.6, as PA-B2 cites). So `J` is the
product: `x + g ∈ M` for all `x ∈ M`, `g`, and `M = R̂_S`. Nothing in either case reads a band. **So the whole of C2a rests on four
band-free inputs (D1-L2, D1-L3, the disjointness theorem, Lemmas E and JC) and one line that reads `k` (SW-m).**

**The restatement.** "`RS_k(S)` for every `k`" ⟺ "every character of `R_S` outside `T + A` takes values arbitrarily close to 0 on `U_S`":
if `θ ∉ T + A` had `inf_u dist(θ(u), 0) = ε > 0`, then `θ ∈ Θ_k` for `1/k ≤ ε`, against `RS_k`; conversely a point of `Θ_k` has every
value at distance `≥ 1/k` from 0, so it is in `T + A`. [hand] **TRUE**, as an equivalence and, with the theorem, as a statement.

**At `k = 2`.** `Θ_2(R) ⊆ T_2` for every `R = ℤ[U]`, with no hypothesis on `S` or `F`: `θ(u) = 1/2` on `U` makes `2θ` vanish on `U`, hence on
its additive span `R`. [hand, one line] So C2's "every `k ≥ 2`" is right, and at `k = 2` it is trivial; C1's "`k ≥ 3`" is a convention
(SW-m holds at `k = 2`, §2.1).

**Verdict C2a: TRUE** [hand; given PA-B2, whose composition I re-derived and whose two lemmas are FS-89's, each derived twice].

### 3.3 C2b — `RQ_k` at every band, and the order bound

**VB3 at every band.** [hand] Verifier I's proof, re-read: compactness and closedness of `Θ_k`, `T ∩ A = 0` (`R_S` is `p`-divisible),
Lemma E with `x_n = φ`, and the data description of `T + A` (`(e; q, …, q)`, one `q ∈ ℚ(i)`; the point `z` has `q₀` at the conjugate place
`v̄` above the same `p`, which exists because `p` splits, so `q = q₀` and `c = 0`). **No line reads `k`** except through the hypothesis
`RS_k(S)`. So `RS_k(S) ⟹ Θ_k(R_S) ∩ T` finite, at every `k`, for every nonempty finite `S`. Non-effective.

**The order bound `N_k`, and why it transfers to `Q`.** [hand] Fix `S₀` with `|S₀| ≥ 2` (say `{5, 13}`) and let `N_k` be the lcm of the
orders in the finite set `Θ_k(R_{S₀}) ∩ T`. A torsion `τ ∈ Θ_k(Q)` has order `M` prime to every `p ≡ 1 (4)` (`Q` is `p`-divisible), and
`ℤ[i] → Q/MQ` is onto (a denominator `n` is invertible mod `M`), so `ord(τ) = ord(τ|_{ℤ[i]}) = ord(τ|_{R_{S₀}})`, and `τ|_{R_{S₀}}` is a
torsion band character of `R_{S₀}`. So every torsion character in `Θ_k(Q)` has order dividing `N_k`, and `Θ_k(Q) ∩ T` is finite.

**VB4 at every band.** [hand] For `θ ∈ Θ_k(R_{S′})`, `S′ ⊇ S₀` finite or not, and `u ∈ U_{S′}`: `θ_u := θ(u·)|_{R_{S₀}} ∈ Θ_k(R_{S₀})`
(`uU_{S₀} ⊆ U_{S′}`), so by C2a `θ_u = τ_u + λ_{e_u}`. **Averaging** (the line that makes `τ_u` itself a band character): `Stab(τ_u)` has
finite index and contains some `w_p^a`, whose conjugate rotates `e_u` densely, so `τ_u(u′) + [−|e_u|, |e_u|] ⊆ B_k` and in particular
`τ_u(u′) ∈ B_k`; this uses only that `B_k` is closed, at every `k`. So `N_k τ_u = 0`. Then S0A-2's steps 2–6 with base `R_{S₀}`, `p ∈ S₀`:
`R_{S′} = ℤ[U_{S′}]` is the additive span of `U_{S′}` (G0's Bezout, `1/p = x(w_p + w̄_p) + y`), the lift `L(x) = lim p^m·rep(N_kθ(x/p^m))`
is additive and `≡ N_kθ`, and a ℚ-linear `ℚ(i) → ℝ` is `Re(ē·)`. So `θ ∈ T_{N_k} + A`. No line reads `k` except the averaging (closedness
only) and the hypothesis.

**Verdict C2b: TRUE** [hand]: `Θ_k(Q) ⊆ T_{N_k} + A` for every `k ≥ 2`, with `N_k` finite and not computed (at `k = 4` it is 168,
FS89-S0A-3).

### 3.4 C2c — every real field, every band

**The gluing at band `k`.** S0A's G1 (`plans/FS89-S0A-gluing-verification.md` §C1, steps 1–6), re-read: step 1 uses the hypothesis
`Θ_k(Q) ⊆ T_N + A` and that a layer restriction `θ_b(y) = θ(by)` is in `Θ_k(Q)` (G0: "The same holds at every band"); steps 2–6 read no
band. With `N = N_k` from §3.3: **`Θ_k(R_F) ⊆ T_{N_k}(R_F) + A(R_F)` for every subfield `F ⊆ ℝ` and every `k ≥ 2`.** [hand]

**Does the gluing need `N` fixed in advance?** Yes, and it has one. Step 2 defines `c_x = Σ ε_j ℓ_{u_j}(1)` from `N τ_b = 0` with one `N` for
all layers, and step 3's additivity compares different `x`; with layer orders unbounded, S0A-5's 3-adic character over ℚ(√2) is layer-wise
torsion and not in `T + A` (not band there, so no conflict). At a general `k` the `N` is `N_k`: it comes from VB3's finiteness at one
finite `S₀` with `|S₀| ≥ 2` and the order transfer of §3.3, not from the band directly, and it is non-effective.

**Which `A`.** The brief's notation gives `A` as "`λ_e(x) = Re(ē x)`". Over `ℚ(i)` that is all of `Hom_ℚ(ℚ(i), ℝ)`. Over `R_F` the gluing
proves membership in `A(R_F) := {ℓ mod 1 : ℓ ∈ Hom_ℚ(F(i), ℝ)}` (S0A's "Conventions"), a sum over all archimedean places of `F(i)`, which for
`[F : ℚ] ≥ 2` is strictly larger than the one-embedding `λ_e`. **Under the one-embedding reading the field clause is false**, already at
`k = 4`: [hand]
- `F = ℚ(√3)`. By `[Fischer1990]` Thm 9 (`d ≡ 3 (mod 12)`) there is an additive three-colouring, i.e. a character `τ` of `R_F` with
  `τ(U_F) ⊆ {1/3, 2/3} ⊆ B_4`, margin `1/12`.
- Let `σ₂` be the embedding of `F(i)` with `√3 ↦ −√3`, `i ↦ i`; `|σ₂(u)| = 1` for `u ∈ U_F`. For `0 < |e| ≤ 1/12`,
  `θ := τ + Re(ē σ₂(·)) mod 1` is in `Θ_4(R_F)`.
- If `θ = τ′ + λ_f` with `τ′` torsion, then `Re(ē σ₂(x)) − Re(f̄ x)` is a real ℚ-linear map that is torsion mod 1 on the 5-divisible `R_F ⊇ Q`,
  hence 0 on `R_F`, hence on `F(i)`; at `x = 1, √3, i, i√3` this forces `Re e = Re f = −Re e` and `Im e = Im f = −Im e`, so `e = 0`.
  Contradiction.
So C2c is TRUE with `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1` (the reading the source uses, "by S0A-2's band-free gluing") and FALSE with `A` read as
the notation paragraph's one-embedding `λ_e`. The same holds of FS89-CL2's wording. A correction to the notation is owed, not to any proof.

**Verdict C2c: TRUE** in the gluing's reading of `A` [hand]; **the notation needs the one sentence** "over `R_F`, `A` is
`Hom_ℚ(F(i), ℝ)` mod 1, all archimedean places" (proposed below).

### 3.5 Every line that reads `k`, in one table

| proof | line | what it needs of `k` |
|---|---|---|
| SW-m (§2.1) | step 1: choose `m` with `2p^m > k` | `k` finite; nothing else (`k ≥ 2` for the complement arc to be non-empty) |
| VB1 (§3.1) | line (g): the call to SW-m | as SW-m |
| C2a (§3.2) | `M ≠ R̂_S` because `0 ∉ Θ_k` | `0 ∉ B_k`: every `k ≥ 2` |
| VB3 (§3.3) | none (only through the hypothesis `RS_k`) | — |
| VB4 (§3.3) | the averaging `τ_u ∈ B_k` | `B_k` closed: every `k` |
| order bound (§3.3) | `N_k` is the lcm over `Θ_k(R_{S₀}) ∩ T` | finiteness, from VB3 at `k`; non-effective |
| gluing (§3.4) | step 1's hypothesis at band `k` | as C2b; steps 2–6 none |

**The band enters the whole chain exactly once as arithmetic — the depth `m` of the sweep — and otherwise only as "closed and misses 0".**

### 3.6 Verdicts

| claim | verdict | grade |
|---|---|---|
| **C1**, Lemma SW-m, every `k ≥ 3` | **TRUE**, and at `k = 2` | hand + tools exact |
| **C2a**, `RS_k(S)`, every `k`, `\|S\| ≥ 2` | **TRUE** | hand, given PA-B2 (composition re-derived; D1-L2, D1-L3 FS-89's) |
| **C2b**, `RQ_k`, every `k` | **TRUE**, `Θ_k(Q) ⊆ T_{N_k} + A`, `N_k` non-effective | hand |
| **C2c**, `Θ_k(R_F) ⊆ T + A`, every `F ⊆ ℝ`, every `k` | **TRUE** with `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`; **FALSE** with the one-embedding `λ_e` (ℚ(√3), `k = 4`) | hand |

C0 scored: all four as predicted; C2c's scope point was predicted at stage 1 and is confirmed with a counterexample to the narrow reading.

### 3.7 Proposed edits (the front-page lane decides)

- `plans/FS89-derivation.md` "Notation, fixed once": after "`A`: archimedean characters `λ_e(x) = Re(ē x)`", add "; over `R_F`, `A(R_F)` is
  `{ℓ mod 1 : ℓ ∈ Hom_ℚ(F(i), ℝ)}`, the archimedean characters of every place of `F(i)` (S0A's convention; for `[F : ℚ] ≥ 2` it is larger
  than one embedding's `λ_e`, and FS89-CL2 is false with the smaller `A`: `ℚ(√3)`, J03a §3.4)".
- `LEDGER.md` rows 95–97 and `CLAUDE.md` Frontier item 25 / G76: "torsion plus archimedean" is right in that reading; if row 95 is widened to
  every `k`, say "archimedean at every place of `F(i)`" once.

## Theorems this phase proved

| id | statement | grade | address |
|---|---|---|---|
| J03a-1 | Lemma SW-m at every `k ≥ 2` (not only `k ≥ 3`): a ball of pure local translates `x + c̄`, `c ∈ c₀ + π_v^s O_v`, never lies in `Θ_k(R_S)`; the sweep by `w_p^t`, `v(w_p^t) = −(m + s)`, `2p^m > k`, fills a coset of step `p^{−m}` | hand + tools exact | §2.1; `tools/crunch_j03a_sweep.py` |
| J03a-2 | VB1 at every `k ≥ 2`, `\|S\| ≥ 2`; its only `k`-reading line is the call to SW-m | hand + tools exact (JC's radius) | §3.1 |
| J03a-3 | `RS_k(S)` and `MS_k(S)` for every `k ≥ 2` and finite `\|S\| ≥ 2`; equivalently every character of `R_S` outside `T + A` takes values arbitrarily close to 0 on `U_S` | hand, given PA-B2 | §3.2 |
| J03a-4 | PA-B2's case-1 step by a joining: `J = {(g, x) : x + g ∈ M}` joins the F-flow `R̂_S` with the minimal `M`, so `M − M = R̂_S` forces `M = R̂_S` | hand, given Furstenberg's disjointness (`[Berend1984]` Thm I.2, Prop. II.6) | §3.2 |
| J03a-5 | `Θ_2(R) ⊆ T_2` for every `R = ℤ[U]` | hand, one line | §3.2 |
| J03a-6 | VB3 at every band; the order transfer `ord(τ) = ord(τ\|_{ℤ[i]})` for torsion characters of `Q`, so `Θ_k(Q) ∩ T` is finite with orders dividing `N_k` | hand | §3.3 |
| J03a-7 | `RQ_k` for every `k ≥ 2`: `Θ_k(Q) ⊆ T_{N_k} + A` | hand | §3.3 |
| J03a-8 | `Θ_k(R_F) ⊆ T_{N_k}(R_F) + A(R_F)`, `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`, every `F ⊆ ℝ`, every `k ≥ 2` | hand | §3.4 |
| J03a-9 | With `A` read as one embedding's `λ_e`, the field clause is false: over ℚ(√3), `τ + Re(ē σ₂(·))` (`τ` the additive three-colouring, `0 < \|e\| ≤ 1/12`) is in `Θ_4` and not torsion plus `λ_f` | hand | §3.4 |

## Would-have-searched-here log

- Stage 3: I would have enumerated the torsion band characters of `ℤ[i]/M` at `k = 10..20` to watch `N_k` grow; instead `N_k` is left non-effective, which is all the gluing needs. I would have run a float orbit of a random character of `R_{5,13}` to watch its values approach 0; instead the equivalence and the theorem are derived.

- Stage 1: none.
- Stage 2: none. (No move was tempted toward search: the sweep is a formula, and the tool enumerates only the ball's image at fixed `m`, which the derivation names.)
