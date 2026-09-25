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

## Theorems this phase proved

*(filled at stage 3)*

## Would-have-searched-here log

- Stage 1: none.
