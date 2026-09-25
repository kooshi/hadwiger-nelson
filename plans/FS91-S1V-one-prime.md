# FS-91 crunch J13 — blind verifier of J12 (one prime): X1 = ONE-a, X2 = ONE-b, X3 = ONE-c

*Record of crunch job J13 (de Bruijn, Opus 5.5), brief `data/crunch-2026-09-25/briefs/J13-M1-one-prime-blind-verifier.md`
with `STANDING-RULES.md`. Data `data/fs91/j13/`; tools `tools/crunch_j13_*.py`. Fence as the brief's, plus
`plans/CRUNCH-2026-09-25-INDEX.md` (owner's message).*

## Stage 1 — SAVED (quotation check and C0)

### Quotation check (standing rule 5)

| quoted in the brief | source | result |
|---|---|---|
| X1 "For every prime `p ≡ 1 (mod 4)`, `Θ₄(R_{{p}}) ⊄ T + A`." | `plans/FS91-character-local-global.md` l. 474 (inside the block "J12 — one prime", l. 473–477) | verbatim |
| X2 "Is every `U₅`-minimal closed subset of `Θ₄(R₅)` contained in `T + A`?" | same file l. 475 | verbatim (the source carries no quotation marks; the brief's added "a verdict 'yes' or 'no' … or GAP" is outside its quotes) |
| X3 "Are the orders of band torsion characters of `R_{{p}}` unbounded at one prime — by a derived infinite family, each member checked by an exact finite computation; never a list extended in search of a pattern." | same file l. 476–477 | verbatim |
| "the brief says §S" | the section heading above l. 473 was not opened (fence) | not checked |
| Kooshi: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` § Where the problem stands, item 23 | verbatim (the brief adds a final period) |
| "at `p = 5` a heteroclinic character exists (`LEDGER.md` row 97)" | `LEDGER.md` row 97; `plans/FS89-S0B-band-set.md` §3 (S0B-T3) | agrees |
| owner's message: J01-7 (`|S| ≥ 2`, every `k`, `A(R_F) = Hom_ℚ(F(i), ℝ)` mod 1) and CLG verified | other crunch records, fenced | **not checkable** from inside the fence; used only as the owner's statement, and nothing below rests on it |
| verified inputs: S0B §1–§4, FS89-derivation §2, §4, §6, S1V § V-A3, § V-A4, `[Berend1984min]` Lemma 3.3, the torsion list | read in full from disk | the statements I use are quoted where used |

**Fence slip (mine, logged for the owner).** Locating the quoted block by `grep -n` in the fenced plan printed four lines outside
it: l. 423 (a staffing row), l. 503–505 (the planner J03's priors: "P-U3 | ONE-a proved at every `p` | 0.75", "P-MS5 | ONE-b answered
'no' (a non-`T + A` minimal set exists at one prime) | 0.60", "P-U5 | ONE-c answered 'unbounded' by a derived infinite family | 0.35")
and l. 560–561 ("**ONE-a** is a construction (S0B-T3's heteroclinic at a general `p`; the lens `√2/6 < 1/4` is `p`-free, the step rule is
not). **ONE-b** reduces to one construction"). These are the planner's, not J12's; no J12 route was seen. Nothing else of the file was
read. The C0 below is therefore **not** blind to the planner's priors, and was written after about thirty minutes of thinking (not a
clean prior): both facts disclosed.

### C0 — probability per claim (written before any tool ran)

| claim | my verdict will be | probability |
|---|---|---|
| X1 | TRUE at every `p ≡ 1 (mod 4)` (the order-3 and parity leaves exist at every such `p`, and their layer-0 discs meet by the `p`-free lens) | 0.93; TRUE only at named primes 0.03; GAP 0.04 |
| X2 | "no" (a `U₅`-minimal set outside `T + A` exists), with proof | 0.35 |
|    | "yes" (every minimal set is in `T + A`), with proof | 0.15 |
|    | GAP (neither proved in this budget) | 0.50 |
| X3 | TRUE: unbounded, by a derived infinite family of periodic band orbits (a periodic orbit of the orbit model is a torsion character, and periods are unbounded) | 0.80; FALSE (bounded, with proof) 0.03; GAP 0.17 |

## Stage 2 — SAVED (phase 1, blind: verdicts on X1–X3)

**Verdicts.** **X1 TRUE at every prime `p ≡ 1 (mod 4)`, no exceptions.** **X2: "no"** — a `U₅`-minimal closed subset of `Θ₄(R₅)`
disjoint from `T + A` exists. **X3 TRUE** — unbounded, by a derived infinite family (at `p = 5`, and by the same proof at every
`p ≡ 1 (mod 4)`). Exact checks: `tools/crunch_j13_check.py` → `data/fs91/j13/check.txt` ("OVERALL: PASS", six plants firing for their
reasons, one faithful partner passing). Notation: FS-89's (§0.1 as quoted in `plans/FS89-derivation.md`); `l` a prime `≡ 1 (mod 4)`,
`π = π_l`, `w = π/π̄`, `P = (1+i)/2`, `q = (1+i)/3`, `v₀ = q − P = −(1+i)/6`, `R = |v₀| = √2/6`, `Q₀ = [−1/4, 1/4]²`.

### 2.1 The frame used throughout (J13-T1)

Let `ζ ∈ {±1, ±i}` with `w ≡ ζ (mod 3R_l)` (it exists: `w` has norm one, and the norm-one subgroup of `𝔽₉^×` is `{±1, ±i}`), and
`β̄ := ζw̄`. **J13-T1.** Writing S0B-T1's layer values as `e_t = P + ζ̄^t u_t`,
`Θ₄(R_l) ≅ {(u_t)_{t∈ℤ} : u_t ∈ Q₀, u_{t+1} − β̄u_t ∈ π⁻¹ℤ[i]}` — a time-homogeneous model. *Proof.* `e_{t+1} − w̄e_t =
(1 − w̄)P + ζ̄^{t+1}(u_{t+1} − β̄u_t)`; `(1 − w̄)P ∈ π⁻¹ℤ[i]` because the parity character's layer values are `P` at every `t` (its
orbit obeys the rule); `ζ̄^{t+1}` is a unit; `Q − P = Q₀` is `i`-invariant, so the band is `u_t ∈ Q₀`. ∎ In this frame the **parity leaf**
is `u_t = β̄^t d` (`|d| ≤ 1/4`, digit `a = 0`), the **order-3 leaf** is `u_t = v₀ + β̄^t d` (`|d| ≤ 1/12`, digit `b = (1 − β̄)v₀`), and
`f_b(u) = β̄(u − o)` with `o := (1 − β)v₀`. At `l = 5`: `ζ = −i`, `β̄ = (−4−3i)/5`, `b = −i/π`, `o = −(2+i)/5`, `|o| = 1/√5`.
Checked exactly at `l ∈ {5, 13, 17, 29, 37, 41, 53, 61}` (Part B: `ζ`, both digits in `π⁻¹ℤ[i]`, the order-3 leaf is the constant `v₀`,
the parity leaf the constant 0, computed from the characters themselves).

### 2.2 X1 — TRUE at every `l ≡ 1 (mod 4)` (J13-T2)

`S₊ := ℤ[i][1/π̄]` (holds `w^m`, `m ≥ 0`), `S₋ := ℤ[i][1/π]`; `S₊ ∩ S₋ = ℤ[i]`, `S₊ + S₋ = R_l`. The order-3 character `χ` (parameter
`q`) is a band character of `R_l` with margin `1/12` at every `l` (`U_l mod 3 ⊆ {±1, ±i}`, where `χ` takes `1/3, 2/3`); the parity
character `θ₂` takes `1/2` on every unit vector. For `e` in the lens `|e − q| ≤ 1/12`, `|e − P| ≤ 1/4` (nonempty: `e = q`, `|q − P| =
√2/6 < 1/4`), define `θ* := χ + λ_{e−q}` on `S₊` and `θ₂ + λ_{e−P}` on `S₋`. Both are `λ_e` on `ℤ[i]`, so they glue to a character of
`R_l`; `|λ_d(u)| ≤ |d|` puts every `i^k w^m` in the band (forward half for `m ≥ 0`, backward for `m ≤ 0`). **Not in `T + A`:** S0B-T4's
proof, verbatim at `l` (`⋂_K π^Kℤ[i] = 0`; torsion characters of `R_l` have order prime to `l` and are determined on `ℤ[i]`), since
`χ ≠ θ₂`. The step rule is never used, so no `p`-dependence enters. ∎ *Exact check (Part A):* at the 8 primes, `e ∈ {q, q + (1+i)/30,
q + (1−i)/20}`, band on `i^k w^m`, `|m| ≤ 30`, from the characters' own values; gluing on `ℤ[i]`. Plants: `e = (14 + 14i)/51` (inside the
order-3 disc, outside the parity disc) fails backward only; a mismatched backward archimedean part fails the gluing.

### 2.3 Two lemmas used for X2 and X3

**J13-T3 (digit criterion).** For `θ ∈ Θ₄(R_l)` with digits `h_t := u_{t+1} − β̄u_t`: `θ ∈ T + A` iff `(h_t)` is periodic.
*Proof.* ⟹: `θ = τ + λ_d` with `|d| ≤ r_τ` (S0B-T2); the margin puts `c_τ(t) + w̄^t d` inside `Q`, so it is the lift, and
`u_t = ζ^t(c_τ(t) − P) + β̄^t d`; `d` cancels in `h_t`, which is periodic with `c_τ`. ⟸: if `h` has period `L`, take `4L`; then
`Δ_t := u_{t+4L} − u_t` obeys `Δ_{t+1} = β̄Δ_t`, which is the orbit of `λ_{Δ₀}`, so `(w^{4L} − 1)θ ∈ A`; `(w^{4L} − 1)` maps `A` onto `A`
with finite kernel on the solenoid, so `θ ∈ T + A`. ∎

**J13-T4 (no bubbles).** Two band orbits that agree at times `s < t` agree on `[s, t]` (the difference is a character vanishing on the
layers `A_s` and `A_t`, hence on `A_s + A_t ⊇ A_m`, `s ≤ m ≤ t` — S0B §1.3's interval family — and lifts in `Q` are unique). Hence two
distinct periodic band orbits never meet, and two isometries `F_W`, `F_{W′}` of admissible words with a common fixed point on an admissible
circle force `W^{|W′|} = W′^{|W|}`. (Used to rule out the "common centre" constructions; recorded because it fixes the shape any
construction must have.)

### 2.4 X3 — TRUE: the family `b a^p` (J13-T5)

For `p ≥ 0` let `c_p := v₀β̄^p(1 − β̄)/(1 − β̄^{p+1})`, the fixed point of `F_p := f_a^p ∘ f_b` (rotation by `(p+1)·arg β̄`).
**J13-T5.** If `|c_p| ≤ 1/4` the orbit `c_p → f_b(c_p) → β̄f_b(c_p) → ⋯ → β̄^p f_b(c_p) = c_p` is a periodic band orbit (every point has
modulus `|c_p|`, since `|f_b(c_p)| = |c_p − o|` and `β̄^p f_b(c_p) = c_p`), hence (a periodic orbit is killed by `w^n − 1`, which has finite
cokernel) a **band torsion character `τ_p` with layer-0 parameter `P + c_p`**. `|c_p| = R|sin(ψ/2)|/|sin((p+1)ψ/2)|`, `ψ = arg β̄`, so
**membership ⟺ `|sin((p+1)ψ/2)| ≥ 4R|sin(ψ/2)|`** (`4R = 2√2/3 < 1`; at `l = 5` ⟺ `sin² ≥ 4/5` ⟺ `N(D_p) ≥ 16·5^p`, an integer test, with
`D_p = π^{p+1} − (−i)^{p+1}π̄^{p+1}` and `c_p = (−i)^{p+1}π̄^p/D_p`). **Infinite:** `β̄` is not a root of unity (not an algebraic integer),
so `(p+1)ψ/2π` is equidistributed and the members have density `1 − (2/π)arcsin(4R|sin(ψ/2)|) > 0` (0.295 at 5). **Orders unbounded:**
the digit word `b a^p` is primitive, so the digit period is `p+1` and `τ_p`'s `w`-period is `≥ (p+1)/4`; at `l = 5` directly,
`ord τ_p ≥ |D_p|/2 ≥ 2·5^{p/2}`. ∎ *Exact checks (Part C; complete enumeration of `p ≤ 40` at 5 and `p ≤ 20` at 13, 17 — a finite range
the derivation fixed, logged):* every member's orbit (step rule, `Q₀`, closure) and, **independently of the orbit model**, the band on all
of `U_l mod N` for the torsion character of parameter `P + c_p`. At 5 the members are `p = 0, 3, 5, 8, 10, 13, 15, 18, 23, 28, 33, 38`
(12 of 41) with orders `3, 48, 234, 1917, 9111, 152886, 708288, 6087369, 484035552, 19215780483, 1523482216314, 60305781079431` — `3` and
`48` are in S0B-L4's list, the rest lie above its `N = 130`. Plant: the non-member `p = 1` (order 6) fails the independent band check at
its first value `1/6`; a wrong step lattice `π̄⁻¹ℤ[i]` fails the step check.

### 2.5 X2 — "no": a minimal set outside `T + A` exists at `l = 5` (J13-T6, J13-T7)

*Blocks.* A block of length `n ≥ 1` from a pre-`b` point `L` is `b a^{n−1}`: `L → β̄(L − o) → ⋯ → L′ := β̄^n(L − o)`; its points after `L`
have modulus `|L − o|`, so it is admissible when `|L| ≤ 1/4` and `|L − o| ≤ 1/4`.
**J13-T6 (branching at 5).** Let `ρ₁ = 43/200` and `Ω := {L : |L| ≤ 1/4, ρ₁ ≤ |L − o| ≤ 1/4}`. For every `L ∈ Ω` at least two `n ∈ [1, 200]`
give `L′ ∈ Ω`. *Proof.* `ρ := |L − o| ∈ [ρ₁, 1/4]` and `|L′| = ρ`; `L′ ∈ Ω` iff its angle `δ` from `o` has `cos δ ∈ [C_hi(ρ), C_lo(ρ)]`,
`C_hi = (ρ² + 1/5 − 1/16)√5/(2ρ)`, `C_lo = (ρ² + 1/5 − ρ₁²)√5/(2ρ)`; both are decreasing in `ρ` on `[ρ₁, 1/4]`, so on a piece `[ρ_a, ρ_b]` the
arc `[δ_lo(ρ_b), δ_hi(ρ_a)]` is always allowed. The angles `δ(n)` are a translate of `{n·arg β̄}`, `n ≤ 200`, whose largest circular gap is
`4.148°` (`= ‖78α‖`, `α = arg β̄/2π = 0.3975836…`; three-gap theorem), so an arc of length `≥ 8.296°` holds two of them. On 400 pieces of
`[ρ₁, 1/4]` the arc exceeds this by at least `3.54°` (60-digit arithmetic, Part D). ∎ Exact sanity: 200 exact rational states in `Ω`
(four on its boundary) each have `≥ 11` such `n`. Plants: `ρ₁ = 0.1975` (the lens tip) and `N₀ = 60` each break the inequality.

**J13-L1 (entropy compression with state-dependent lists).** States `Ω`, alphabet `[1, 200]`, at each state the two smallest admissible
letters. For `K = 9` and every length, every `L₀ ∈ Ω` starts an admissible block word with no factor `V^K`. *Proof.* The Grytczuk–Kozik–Micek
algorithm (append by a random bit; on a `K`-power suffix `V^K` delete `(K−1)|V|` letters) is invertible from its log and final word because
the lists are a function of the prefix; logs number `≤ 2^{N(H(1/8)+1/8)} = 2^{0.669N}`, final words `≤ 200^L`, so for `N > 24L` some bit string
reaches length `L`. ∎ (Method cited from memory: `[GrytczukKozikMicek2013]`, "New approach to nonrepetitive sequences" — **not checked
against the paper here**, a prior-art debt; the argument above is self-contained.)

**J13-T7 (X2 = no).** By J13-L1 and compactness (diagonal limit of centred words of length `2L`; `Ω` closed, alphabet finite) there is a
bi-infinite admissible block sequence with states in `Ω` and no factor `V^9`; its `u`-orbit lies in `Q₀`, so it is a band character `θ` (J13-T1)
whose `{a, b}`-digit sequence `s` has `a`-runs `≤ 199` and no factor `V^{10}` with `V ∋ b` (such a factor contains a 9th power of blocks).
So the orbit closure of `s` has no periodic point, and by J13-T3 the orbit closure `Y` of `θ` meets `T + A` nowhere (digits are continuous and
equivariant); nor does `Y′ := ⋃_{k<4} i^k Y` (`i` acts by `u ↦ −iu`, digits `h ↦ −ih`). **Every `U₅`-minimal closed subset of `Y′` is a
`U₅`-minimal closed subset of `Θ₄(R₅)` disjoint from `T + A`** (the same for the semigroup `⟨i, w⟩`). ∎ Its digit subshift is an infinite
minimal subshift. *What J13-T6 is:* an inequality at `l = 5` only; the same route at another `l` needs its own `Ω` (the lens
`D(0,1/4) ∩ D(o_l,1/4)` is nonempty at every `l`, since `|o_l| ≤ 2R < 1/2`) — **not claimed** beyond 5.

### Would-have-searched-here log

1. X2: would have iterated the piecewise-rotation system numerically to find a recurrent aperiodic orbit (a float finder) — derived the
   branching lemma and the entropy-compression existence instead; no orbit was exhibited.
2. X2: would have run the entropy-compression algorithm to print a long admissible 9-power-free word — not run; existence is by counting.
3. X3: would have extended S0B-L4's torsion list past `N = 130` — derived the family `b a^p` and checked only its members.
4. Part C's range `p ≤ 40` (5), `p ≤ 20` (13, 17) is a complete enumeration of a range fixed by the derivation (members by an integer test).
5. Part D's 200 random exact states test a derived claim at sampled points; they are a sanity check, not a witness search.

### C0 scored (phase 1)

X1 TRUE at every `p` (0.93) — met. X3 TRUE by a derived family (0.80) — met. X2 "no" with proof (0.35) — met against my own GAP-favouring
prior (0.50); the planner's leaked prior (P-MS5 "no", 0.60) was nearer.

## Theorems this phase proved

- J13-T1 — the time-homogeneous `u`-model of `Θ₄(R_l)` at every `l ≡ 1 (mod 4)` [hand + tools exact at 8 primes; this record §2.1]
- J13-T2 — X1: the heteroclinic `θ* ∉ T + A` in `Θ₄(R_l)` at every `l ≡ 1 (mod 4)` [hand + tools exact at 8 primes; §2.2]
- J13-T3 — `θ ∈ Θ₄ ∩ (T + A)` ⟺ periodic digits [hand; §2.3]
- J13-T4 — no bubbles; distinct periodic band orbits never meet [hand; §2.3]
- J13-T5 — X3: the family `b a^p`, infinite at every `l`, orders `≥ 2·5^{p/2}` at 5 [hand + tools exact (members `p ≤ 40` at 5, `≤ 20` at 13, 17); §2.4]
- J13-T6 — branching at 5 (`Ω`, two choices in `[1, 200]`) [hand + tools (60-digit inequality on 400 pieces; exact samples); §2.5]
- J13-L1 — entropy compression with prefix-determined lists of size 2, `K = 9` [hand; method prior art, cited from memory; §2.5]
- J13-T7 — X2: `MS₄({5})` is false: a `U₅`-minimal closed subset of `Θ₄(R₅)` disjoint from `T + A` exists [hand, from T1, T3, T6, L1; §2.5]

## Stage 3 — SAVED (phase 2: J12's lemma statements, `data/fs91/j12/lemma-statements.md`)

*Opened after J12's stage 5 (`3453b552`) and after my phase-1 verdicts were committed (`07836b24`). Statements only; J12's record still
unopened. Exact checks: `tools/crunch_j13_phase2.py` → `data/fs91/j13/phase2.txt` ("OVERALL: PASS").*

**A frame note (mine, no verdict changes).** My tools take `π = 1 + 2i` (the first `a² + b² = 5` found), an associate of J12's and S0B's
`π̄ = 2 − i`; so the tools' `β̄ = (−4+3i)/5` is the conjugate of the hand value `(−4−3i)/5` in §2.1, and the tools' `o = −(1+2i)/5`.
The two frames are exchanged by complex conjugation followed by `z ↦ −iz` (which fixes `Q₀`, the parity centre and the set of order-3
centres, and commutes with the rotations), so memberships, orders and the branching inequality are frame-independent; E2 below matches
J12's list exactly across the two frames, which is the cross-check.

| J12 id | verdict | how (one line) |
|---|---|---|
| A1 | TRUE | UFD: `ℤ[i][1/π̄] ∩ ℤ[i][1/π] = ℤ[i]`; `1 = απ^k + βπ̄^k` gives `S₊ + S₋ = R`; `w^m = π^mπ̄^{−m}` (§2.2) |
| A2 | TRUE | pushout `R = (S₊ ⊕ S₋)/ℤ[i]` (§2.2) |
| A3 | TRUE | units are `1, i` mod `(1+i)²`; `U mod 3 ⊆ {±1, ±i}` (§2.2) |
| ONEa | TRUE | = J13-T2 with `e = C` (my `q`) |
| HL | TRUE | band on each half from the given `τ_j + λ_{d_j} ∈ Θ₄`; not `T + A` by S0B-T4 at `p` |
| B1 | TRUE | = J13-T1 at 5 (`z_m = u_m`: `lift(ī^m e_m) − P = ī^m(e_m − P)` since `ī^mP ≡ P`); centres ↔ digits by `c = h/(1 − ω)`, `1 − ω = 3(1+i)/π`, so the centre lattice is `((1−i)/6)ℤ[i]`, and **E1** finds exactly `C₉` admissible in the only range that can meet `Q₀` (`|1 − ω||z − c| ≤ √2/2`); `θ∘(iw) = (θ∘i)∘w ↦ −i·(i u_{m+1}) `, the pure shift |
| B2 | TRUE | = J13-T3 (centres and digits determine each other) |
| B3 | TRUE | same centres by linearity; sup-norm displacement `≤ |δ| ≤ r` |
| B4 | TRUE | the orbit closure of `τ + λ_d` is `⋃_σ {σ + λ_{d′} : |d′| = |d|}` over the finite orbit of `τ` (on each coset of the period lattice `w̄^m d` is dense on the circle), and it is minimal |
| B5 | TRUE | points of a minimal set are uniformly recurrent (compact space; Gottschalk); a uniformly recurrent point's orbit closure is minimal; then B2 |
| B6 | TRUE | `F_A, F_B` isometries mapping compact `K` into itself are onto; `F_A^{|B|}F_B^{−|A|}` is a translation fixing `K`, so `0`; then J13-T4 gives `A^{|B|} = B^{|A|}` as words; Lyndon–Schützenberger. Second half = J13-T4 (periodic orbits through one point at one time coincide) |
| CL | TRUE | B3 twice (from `Q″` along `W^a`, from `R^a(Q″)` along `W′^b`); the fixed-point formula recomputed |
| CL′ | TRUE | for non-real `z` in the open lens, `(x, y) = (z̄/z, (z − D)/(z̄ − D)) ∈ T²` is the unique pair with `Q″ = z`, and it gives `|xz − D| = |z − D| < r′` for free; the inverse is continuous and `{(ω^{a|W|}, ω^{b|W′|}) : a, b ≥ 2}` is dense in `T²` (`arg ω/2π` irrational, the two exponents independent). Necessity: `D ≤ |R^a(Q″) − Q| + |R^a(Q″) − Q′| ≤ r + r′`, and equality forces `x = 1` |
| H | TRUE | induction by CL′: `Q_{n+1} = Q″ ∈ B(Q_n, r_n)` strictly and `r_{n+1} > 0`, so the next open lens `B(Q_{n+1}, r_{n+1}) ∩ B(Q_n, r_n)` contains `Q_{n+1}`; base: `|c₀ − 0| = √2/6 < 1/4 + 1/12` |
| W | TRUE | lengths: `a_n ≥ 2`; `W_nW_n` a factor since `a_n ≥ 2`; primitive: `W_n`, `W_{n−1}` primitive of different lengths do not commute, and `X^aY^b = V^k` with `a, b, k ≥ 2` forces `X, Y` to commute (Lyndon–Schützenberger) |
| Ω | TRUE | every `W_m`, `m ≥ n`, is a concatenation of `W_n`, `W_{n−1}` blocks, each containing `W_{n−1}`: every factor recurs with bounded gaps in every point (minimal); a period `q < |W_n|` of the factor `W_nW_n` would make `W_n` non-primitive (Fine–Wilf) |
| MS | TRUE, by J12's route too | the `τ_n` have a limit point in the closed `Θ₄(R₅)`; its centre sequence (continuous in `θ`) has every window inside some `W_nW_n ⊆ W_{n+1}`, so lies in `Ω`; its orbit closure's centre sequences lie in `Ω`, which has no periodic point, so it misses `T + A` (B2), and its minimal subsets answer "no". Same verdict as J13-T7 by a different construction (hierarchy of periodic orbits against branching + entropy compression). The added sentence "switching … with bounded runs in both directions": runs are bounded in `Ω` (`0`-runs have length `b₁`, `c₀`-runs are bounded likewise) — TRUE as a property of `Ω` |
| MSp | TRUE | the chain H, W, Ω, MS uses only the two centres `0`, `v₀` (J13-T1 at every `l`: both digits lie in `π⁻¹ℤ[i]`, margins `1/4`, `1/12`, `|v₀| < 1/3`) and `arg β̄_l/2π ∉ ℚ`; nothing else is `p`-dependent. (My own route, J13-T6, is proved at 5 only; J12's route is the better one here) |
| C1 | TRUE | `τ_e∘w^m` has parameter `conj(w̃)^m e = (tπ̄²)^m e` since `w ≡ π²t (mod N)`; negative `m` by periodicity |
| C2 | TRUE | `|c* − z₀| = |z_L − z₀|/|1 − ω^L| ≤ r`, then B3 (Euclidean distance to `∂Q₀` equals the sup-norm margin inside a square) |
| C3 | TRUE | CL, then torsion (periodic); the `a + b` shifts `τ∘(iw)^j` are distinct characters of order `N` (primitive word), so `N² > a + b`; infinitely many pairs by CL′. **E2** recomputes the 14 instance pairs and all 14 orders exactly, and checks each character's band on `U₅ mod N` independently |
| C4 | TRUE | `Q″ = π^L t/D_L` with `π^L t ∈ ℤ[i]`, so `Nm(D_L)Q″ ∈ ℤ[i]`; with `P`, `N | 2Nm(D_L)`; E2 checks the 14 instances |
| C3p | TRUE | = J13-T5 at every `l` (and J12's C3 route via CL′ is also `p`-free) |
| Instances | TRUE | E2: the pairs and orders equal J12's list exactly; the plant (radius `1/13`) drops `(10, 5)` |

**Assembly.** ONE-a: A1–A3 ⟹ ONEa — sound. ONE-b: B1, B2, H, W, Ω ⟹ MS, with B4–B6 as supporting facts (B6 explains why a two-word
"common centre" construction cannot work, so the hierarchy is forced) — sound; CL′'s density is the step everything rests on, and it holds.
ONE-c: CL (with `W = (c₀)`, `W′ = (0)`) and CL′ ⟹ C3 — sound. Compared with phase 1: **the verdicts agree on all three claims**; J12's
X3 family (`c₀^a 0^b` under two disc conditions) and mine (`b a^p` under one, `|c_p| ≤ 1/4`) overlap at `a = 1`: J12's `(1, 5)`, `(1, 10)`
are my `p = 5, 10` (orders 234, 9111), while my `p = 3` (order 48, S0B's list) fails J12's first condition and is still a band character —
J12's condition is sufficient, mine is weaker, both are correct. For ONE-b the routes differ (§ Stage 4).

**Plants (phase 2).** E1′: the rotation `(3+4i)/5` (53°) in place of `ω` admits 29 centres, not `C₉`. The first plant tried there — `w̄` in
place of `ω` — returned `C₉` too and **could not fire**; it was replaced and is recorded (G21). E2′: radius `1/13` drops `(10, 5)` only.

### Theorems this phase proved (phase 2)

- J13-T8 — J12-CL′'s density, with the explicit inverse `(x, y) = (z̄/z, (z − D)/(z̄ − D))` [hand; this record, Stage 3]
- J13-T9 — J12-MSp at every `l ≡ 1 (mod 4)`, by J12's hierarchy on the frame J13-T1 [hand; Stage 3]
- J13-C9 — the admissible centres at `p = 5` are exactly `C₉` [tools exact, E1]
