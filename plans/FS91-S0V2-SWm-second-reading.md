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

## Theorems this phase proved

*(filled at stage 3)*

## Would-have-searched-here log

- Stage 1: none.
- Stage 2: none. (No move was tempted toward search: the sweep is a formula, and the tool enumerates only the ball's image at fixed `m`, which the derivation names.)
