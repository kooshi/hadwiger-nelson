# FS-86 stage B2–B3: the dyadic profile of `Λ₅₁₀` and exact certificates for "rich"

*de Bruijn (Opus 5.5), briefed by the product owner 2026-09-25 (`data/fs86/briefs/B2-profile-brief.md`, commit d3a523c1). Plan:
`plans/FS86-dyadic-rigidity.md` §S.1, §B, §P, §G.3, §R-review. Tools and outputs: `data/fs86/b2/`. Every number is exact unless
labelled float. The finite-witness-free week applies: no colouring search of any kind.*

## §state (the resume point)

- C0 written (below), committed before any result (fb0039df).
- Positive control PASSED and both planted faults went red (§1, 6dd2fc87).
- §2–§6 done: embedding and `m* = 5`; `Q_m` at every level 1–14 plus a slack certificate at 24; the pull-back derivation for levels
  ≤ 14; the lattice L3 analogue. Next: B3 (§7). Resume: every script in `data/fs86/b2/` reruns in seconds (`qhigh.py 13 14` and `lattice.py`
  under `scripts/slot.py --mem 14`); nothing long-running.

## C0. My predictions, written before any computation

Registered against the plan's §P rows. Reasons are mine, from reading the plan and row 67 only; nothing computed yet.

| id | the plan's prediction | plan p | my p | my reason |
|---|---|---|---|---|
| P-sat | `m* ≥ 5` (`U ↠ S_5`, 48 residues) | 0.55 | **0.65** | 324 unit vectors against 48 residues, and `U` is closed under `z ↦ −z, iz, z̄` and the flip `√59 ↦ −√59` (the local `√3 ↦ −√3`), so it covers in orbits; 48 residues are about 3–6 orbits under that group against about 20 orbits of `U`. Against it: `U` is a few layers of structured rotations (`U₅`, `U₁₇`, the type-M `v₁₅`), not random, and a structured set can miss a whole coset. I expect `m* ∈ {5, 6}` most likely, `m* ≤ 7` certainly (`|S_8| = 384 > 324`) |
| P-slack | some `Q_m` slack at four colours by the injective level | 0.80 | **0.85** | past saturation the level map `T_{m+1} → T_m` loses its constant fibres, so FS38-L1's propagation and FS38-L2's pairing both break; at the injective level `Q_m ≅ Cay(O/𝔓^m, U)` and the 45 pulled-back minimisers read `Σ_s f(s)χ(s)` with `f` the fibre sizes of `U → S_4`, which is `−d/3` only if `f` is orthogonal to every minimiser — no reason for that. I expect the first slack level at `m* + 1` or `m* + 2` |
| P-undec | at least one slack level stays "slack, undecided" this week | 0.70 | **0.75** | deciding whether a finite slack `Q_m`'s four-colourings all pull back from a tight quotient needs either a search (banned) or a structural argument; row 87's L16 was decided only because the infinite lattice was already solved (row 85). A derivation could still close it if `T_m` keeps both lifts of enough generators to force fibre-constancy (the `K_{2,2}` structure of FS-38 §0), so not near 1 |

Also registered, mine (not in the plan): **P-B2-inj** — `U mod 𝔓^m` is injective by `m ≤ 12` (p = 0.6); **P-B2-L3** — the lattice
analogue of FS38-L3 is weaker than the full tower's: `𝔓⁴ ⊄ M_Λ ⊗ ℤ₂` (p = 0.5; I have no strong reason either way); **P-B3** — every
listed prime's (R4) certificate is exact and refuses four colours, except that 29 (Hoffman float 0.2533, open) rests on `χ(UD(𝔽₂₉,2)) ≥ 5`,
whose grade I have not yet checked and which may be a measurement, not a theorem (p = 0.5 that 29 is certified by theorem).

## §1. The positive control: row 67's table, reproduced on the full `S_m` (B2, first)

**Instrument** (`data/fs86/b2/tower.py`, built for this stage from the ring axioms, not from FS-38's code): `O = ℤ₂[ω][√3]` in the basis
`(1, ω, √3, ω√3)`, conjugation `ω ↦ ω²` with `√3` fixed, `𝔓 = (1 + √3)`, canonical residues mod `𝔓^m`; `S_m = {z : z z̄ ≡ 1}` built by lifting
level by level; characters `u ∈ (ℤ/N)⁴`, `N = 2^⌈m/2⌉` (for odd `m`, `u₀ + u₂` and `u₁ + u₃` even). **Every eigenvalue is held exactly** as an
integer vector in `ℤ[ζ_N]` (basis `ζ⁰ … ζ^{N/2−1}`); "`λ = −d/3`" is decided exactly; "nothing below `−d/3`" by float with margin `10⁻⁶` on the
characters not exactly equal (float error ≤ `d·10⁻¹⁵`), and a character within the margin but not exactly equal is flagged (none occurred).

**Result** (`control.py` → `control.out`, 1.6 s): `|S_m| = 3·2^{m−1}`, norm one, `S = −S`, `S_m ↠ S_{m−1}` at levels 1–8; and the table, every
entry **exact** and equal to `plans/FS38-derivation.md` §D-2(b):

| m | n | d | λ_min | tight (exact) | # minimisers | \|H_min\| | H_min = 𝔓⁴/𝔓^m | second-least |
|---|---|---|---|---|---|---|---|---|
| 1 | 4 | 3 | −1 | yes | 3 | 1 | — | 3 |
| 2 | 16 | 6 | −2 | yes | 9 | 1 | — | 2 |
| 3 | 64 | 12 | −4 | yes | 21 | 1 | — | 0 |
| 4 | 256 | 24 | −8 | yes | 45 | 1 | yes | 0 |
| 5 | 1024 | 48 | −16 | yes | 45 | 4 | yes | −8 |
| 6 | 4096 | 96 | −32 | yes | 45 | 16 | yes | −16 |
| 7 | 16384 | 192 | −64 | yes | 45 | 64 | yes | −32 |
| 8 | 65536 | 384 | −128 | yes | 45 | 256 | yes | −64 |

**Planted faults, both red** (same script): (1) *a wrong generator* — at each level ≥ 2 the pair `±s₀` replaced by `±(s₀ + π^{m−1}ω)`: the
table mismatches at levels 2, 4, 5, 6, 8 (at 2 and 4 `λ_min` drops below `−d/3`; at 5, 6, 8 the second-least eigenvalue moves). **Honest limit:**
this plant is invisible at levels 3 and 7 (the table there is unchanged), so one level's match would not have caught it; the eight-level table
does. (2) *a wrong conjugation* (`√3 ↦ −√3`, `ω` fixed — another torus): mismatches at every level (`d` itself changes). The control's failure
mode is reachable and was reached.

## §2. `U₅₁₀` in the dyadic ring, and the saturation depth (B2)

**Embedding** (`embed.py` → `embed.out`, `U510_O.npy`): `3·59 = 177 ≡ 1 (mod 8)`, so `√59 ↦ s√3` with `s² = 59/3` in `ℤ₂`, and
`i ↦ (2ω + 1)√3/3`. Checked mod `2²²`: `i² = −1`, `(√59)² = 59`, `ī = −i`, `√59` fixed by conjugation. All 324 unit vectors (stage A's
enumerator, reused) land in `O` with `z z̄ ≡ 1 (mod 𝔓⁴⁴)` [exact]. **(R3) re-derived:** `U mod 2` has rank 4 over `𝔽₂`, so by Nakayama the
`ℤ₂`-span of `U` is `O` [exact] — agrees with the planner.

**Residues against `S_m`, by membership** (each residue tested for `z z̄ ≡ 1` and looked up in `S_m`, which `tower.circle` builds from the ring):

| m | \|S_m\| | \|T_m\| = \|U mod 𝔓^m\| | every residue in S_m | T_m = S_m | fibre sizes of U → T_m |
|---|---|---|---|---|---|
| 1 | 3 | 3 | yes | yes | 108 each |
| 2 | 6 | 6 | yes | yes | 54 each |
| 3 | 12 | 12 | yes | yes | 27 each |
| 4 | 24 | 24 | yes | yes | 12–15 |
| 5 | 48 | 48 | yes | **yes** | 3–12 |
| 6 | 96 | 92 | yes | no (4 missing, all in one class mod 𝔓) | 1–10 |
| 7 | 192 | 160 | yes | no | 1–5 |
| 8 | 384 | 200 | yes | no | 1–3 |
| 9 | 768 | 260 | yes | no | 1–2 |
| 10 | 1536 | 308 | yes | no | 1–2 |
| 11 | 3072 | **324** | yes | no | 1 (injective) |

**`m* = 5` exactly** [exact], and `U mod 𝔓^m` is injective from `m = 11` on. P-sat (`m* ≥ 5`) **met**.

## §3. The quotients `Q_m`, levels 1–14 (B2)

`Q_m = Cay(O/𝔓^m, T_m)`; for `m ≤ 5` it is `P_m` (§1's table applies verbatim). Two independent code paths: **(O)** the 2-adic embedding
(`qprofile.py`, levels 1–11, every character by FFT, the extreme ones exactly in `ℤ[ζ_N]`; `qhigh.py`, levels 11–14); **(Λ)** a `ℤ`-basis of
`Λ₅₁₀` with no embedding at all, using `Λ ∩ 𝔓^{2k} = 2^kΛ` (a consequence of (R3)), so `Q_{2k} = Cay(Λ/2^kΛ, U)` (`lattice.py`, even
levels 2–14). **They agree at every even level** on `d`, `λ_min`, the number of minimisers and the number of characters below `−d/3`.

| m | d | −d/3 | λ_min | characters below −d/3 | minimisers (conductor) | sign |
|---|---|---|---|---|---|---|
| 1–5 | 3·2^{m−1} | | −2^{m−1} | 0 | 3, 9, 21, 45, 45 | **tight** (= `P_m`) |
| 6 | 92 | −30.667 | **−36** | 21 | 1 (conductor 1) | **slack** |
| 7 | 160 | −53.333 | **−58** | 24 | 8 (conductor 4) | **slack** |
| 8 | 200 | −66.667 | **−78** | 21 | 8 (conductor 4) | **slack** |
| 9 | 260 | −86.667 | **−92** | 21 | 1 (conductor 1) | **slack** |
| 10 | 308 | −102.667 | **−108** | 21 | 1 (conductor 1) | **slack** |
| 11 | 324 | −108 | **−108** | 0 | 45 (conductors 1–4) | **tight** |
| 12 | 324 | −108 | −108 | 0 | 45 | **tight** |
| 13 | 324 | −108 | −108 | 0 | 45 | **tight** |
| 14 | 324 | −108 | −108 | 0 | 45 | **tight** |

Grades. The slack minima at 6–10 are **integers held exactly** in `ℤ[ζ_N]` (a single character each; exact). At 11–14 the 45 minimisers
equal `−108` **exactly**; "nothing else at or below `−108`" is **float with margin**: the next eigenvalue is `−97.94` at 11–12 and `−105.39` at
13–14 (gaps 10.06 and 2.61), against an FFT error bound below `10⁻⁹`, on both code paths. At 6, 9 and 10 the slackness is a **level-one
imbalance**: `T_m`'s residues over `𝔽₄^×` are `28/32/32`, `84/88/88`, `100/104/104`, and the character of `𝔽₄` that is `+1` on the thin class reads
`28 − 64 = −36`, `84 − 176 = −92`, `100 − 208 = −108`. At 7 and 8 the minimisers have conductor 4.

**The 45 minimisers at 11–14 are exactly the pull-backs of `P₄`'s 45** (`descent.py`: the 45 characters of `Λ/4Λ` with `λ = −8` on the set
`T₄ = S₄` are the same 45 with `Σ_{u∈U} χ(u) = −108` on the multiset `U`, whose fibres over `S₄` are uneven, 12–15), and their common kernel
in `Λ/4Λ` is trivial [exact]. So **`H_min(Q_m) = 𝔓⁴/𝔓^m` at `m = 11, 12, 13, 14`.**

## §4. The slack levels 6–10 are decided: every four-colouring of `Q_m`, `m ≤ 14`, is pulled back from `P₄` (B2; derivation)

**FS86-B2-T1.** For `5 ≤ m ≤ 14`, every proper four-colouring of `Q_m` is `𝔓⁴/𝔓^m`-periodic and is the pull-back of a proper four-colouring of
`P₄`; the colouring space of every `Q_m`, `4 ≤ m ≤ 14`, is `P₄`'s (1,179,936 colourings). In lattice terms: **every four-colouring of `Λ₅₁₀`
periodic under `Λ ∩ 𝔓¹⁴ = 128Λ` is `4Λ`-periodic, a pull-back from `P₄`** [hand, one mind, on §3's spectra: the minimisers
exact, the tightness of `Q₁₄` float with margin 2.61; the owner should check it].

*Proof.* `Q₁₄` is four-tight with `H_min = 𝔓⁴/𝔓¹⁴` (§3), so by FS38-D2-A(iii) every four-colouring of `Q₁₄` is `𝔓⁴`-periodic. For `m ≤ 14`
the reduction `ρ : O/𝔓¹⁴ → O/𝔓^m` maps `T₁₄` onto `T_m` (both are `U`'s residues), so it is a graph homomorphism `Q₁₄ → Q_m`; a
four-colouring `c` of `Q_m` pulls back to `c ∘ ρ`, a four-colouring of `Q₁₄`, hence `𝔓⁴`-periodic, and `ρ(𝔓⁴/𝔓¹⁴) = 𝔓⁴/𝔓^m`, so `c` is
`𝔓⁴`-periodic. It therefore factors through `O/𝔓⁴`, and the factor is proper on `P₄` because `T_m ↠ T₄ = S₄` (for `m ≥ 4`), so each edge of `P₄`
lifts to an edge of `Q_m`. Conversely every colouring of `P₄` pulls back along `Q_m → P₄`. ∎

**Reading.** The slack levels 6–10 are G54's middle case again (row 87's L16): slack, yet every four-colouring gap-free and pulled back from
the tight `P₄`. **The mechanism is new:** L16 was decided by the infinite lattice's theorem (row 85); here it is decided by a **tight cover
above** the slack levels — `Q₁₄` tight with `H_min = 𝔓⁴`, mapping onto every `Q_m` below it. So the brief's stop rule ("where a level turns
slack, stop") was resolved by exact algebra of the kind it permits, not by a search. P-undec is **not met at levels 6–10**; see §5 for the levels
where it is.

## §5. The infinite lattice is not tight; `Q_m` is slack again from some level in [15, 24] (B2)

**FS86-B2-T2.** The symbol `σ(θ) = Σ_{u∈U} cos 2πθ·c(u)` of the infinite `Cay(Λ₅₁₀, U)` on the 4-torus has, at 36 of the 45 minimisers
`θ₀ = n₀/4`, a **nonzero gradient** `2π g`, `g = −Σ_u sin(2πθ₀·c(u)) c(u)` an exact integer vector (e.g. `g = (−1986, −2036, 4022, −50)` at
`n₀ = (1, 1, 0, 1)`). So `σ < −108` just off `θ₀`: **the infinite lattice is not Hoffman-tight at four colours** [exact gradient; hand]. The
2-power torsion points are dense, so some character of some `Q_m` has eigenvalue `< −108`, and since `U mod 𝔓^m` is injective from 11 on, that
eigenvalue persists at every higher level with the same `d = 324`: **from that level on every `Q_m` is slack**.

**Certificates** (`descent.py` → `descent.out`): the character `n = (1025, 1023, 1024, 1)` of `Λ/2¹²Λ` has eigenvalue `−110.761944` on `Q₂₄`, and
`n = (2048, 2048, 8191, 2048)` of `Λ/2¹³Λ` has `−109.392617` on `Q₂₆` [exact residue counts; the value by float, margins 2.76 and 1.39 against an
error bound of `3.3·10⁻¹³`]. The neighbourhood check `n₀·2^{k−2} + δ`, `|δᵢ| ≤ 2`, finds nothing at levels 16, 18, 20, 22. **So the first slack
level above 14 lies in [15, 24]; levels 15–23 are not computed in full** (a full spectrum at 16 is a `256⁴` transform, past this stage's budget).
The same reading as row 87's dB5 for de Grey's lattice, here exact: a finite dyadic quotient can be tight while the lattice is not; here the
tight window is 11–14, between two slack ranges.

**What it leaves** (the registered "slack, undecided" outcome, **reached**): at every level `m ≥` the first slack level (≤ 24), whether every
four-colouring of `Q_m` pulls back from `P₄` is **undecided**; no tight cover exists above those levels (slackness persists), so §4's argument
does not reach them. P-undec **met** at levels ≥ 24.

## §6. The lattice analogue of FS38-L3 (B2)

`M_Λ = ℤ-span{t − 1 : t ∈ U, t ≡ 1 (mod 𝔓)}` (108 unit vectors). `l3.py` → `l3.out`, two code paths:
- **(Λ)** Smith normal form over `ℤ` in `Λ₅₁₀`'s basis: invariant factors **1, 2, 4, 4** [exact] — no odd part, so `[Λ : M_Λ] = 32`.
- **(O)** in `O` mod `2¹²`, Hermite form and exact membership of `π^j·(1, ω, √3, ω√3)`: **`𝔓⁴ ⊆ M_Λ ⊗ ℤ₂`, `𝔓³ ⊄`**, and `𝔓²`, `𝔓³` fail
  on the `ω` and `ω√3` directions and hold on `1` and `√3` [exact].

**FS86-B2-T3.** `M_Λ ⊗ ℤ₂` equals the full tower's `M` of FS38-L3: the same elementary divisors, the same sharp `j = 4`, the same failing directions
[exact]. So the lattice's unit vectors already generate the full tower's `M` at 2, and the depth 4 of row 67 is seen by `Λ₅₁₀`'s 108 unit
vectors `≡ 1 (mod 𝔓)`. My P-B2-L3 (weaker) is **not met**.

## "Would have searched here" log

(one line per move I would have made by search, and what I did instead)

1. **Would have asked a solver whether the slack `Q₆` (or `Q₇`–`Q₁₀`) has a four-colouring not pulled back from `P₄`.** Instead derived that it
   has none, from the tight cover `Q₁₄` (§4).
2. **Would have minimised the torus symbol numerically over the whole 4-torus**, to find the exact first slack level above 14. Instead computed
   the exact integer gradient at the 45 known minimisers and evaluated the spectrum at characters that the gradient names (§5). Borderline,
   logged: the neighbourhood check `n₀·2^{k−2} + δ`, `|δᵢ| ≤ 2`, evaluates eigenvalues of a fixed Cayley graph at 625 × 45 chosen characters
   per level — a spectrum, not a colouring, and its shape was fixed by the gradient.
3. **Would have asked a solver for a four-colouring of `Q₂₄` that is not pulled back from `P₄`.** Instead left level 24 and above as
   "slack, undecided" (§5).

## Theorems this phase proved

- **FS86-B2-T0.** `m* = 5` for `Λ₅₁₀`: `U mod 𝔓^m = S_m` exactly for `m ≤ 5` and not at 6 (92 of 96); injective from 11; `ℤ₂`-span of `U` = `O`.
  [exact; §2, `embed.py`]
- **FS86-B2-T1.** For `5 ≤ m ≤ 14` every four-colouring of `Q_m` is pulled back from `P₄`; on `Λ₅₁₀`, every `128Λ`-periodic four-colouring is
  `4Λ`-periodic. [hand, one mind, on §3's spectra (tightness of `Q₁₄` float with margin 2.61); §4]
- **FS86-B2-T2.** `Cay(Λ₅₁₀, U)` is not Hoffman-tight at four colours (nonzero symbol gradient at 36 of the 45 minimisers), and `Q_m` is slack
  for every `m ≥ 24`; the first slack level above 14 lies in [15, 24]. [exact gradients; slack certificate float with margin 2.76; §5,
  `descent.py`]
- **FS86-B2-T3.** `M_Λ ⊗ ℤ₂ = M` (FS38-L3's): elementary divisors 1, 2, 4, 4; `𝔓⁴ ⊆`, `𝔓³ ⊄`. [exact, two code paths; §6, `l3.py`]
- The spectral table of §3 (levels 1–14): tight at 1–5 and 11–14, slack at 6–10. [exact minima; tightness at 11–14 float with margin; two code
  paths]
