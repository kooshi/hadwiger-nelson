*Poros record, crunch job **J36**, 2026-09-25. Advisor session on one finding: T-C and T-C(A) of the milestone "row 88's
question" (`plans/FS86-row88-rigidity.md` §S.1). Brief: `data/crunch-2026-09-25/briefs/J36-poros-infinitely-many-primes.md`, with
`data/crunch-2026-09-25/briefs/STANDING-RULES.md` as part of it. Opus 5.5. No subagents; no finite-witness search (ban to
2026-10-01); this record is the only file I edit.*

**Inputs added after the brief was written** (from the owner, verbatim in substance, logged here so a successor has them):
1. FS-84 S1's blind check has finished (`plans/FS84-S1V-verification.md`): a second derivation, not using the Ambrus et al.
   certificate, confirms the periodic independence ratio of ℚ(√47) is at most 0.2499972548 < 1/4, binding at 31; which prime attains
   the supremum (11 or 31) is undecided; the amenability hypothesis is load-bearing; one GAP — whether Θ₄ = ∅ on a finitely generated
   unit-distance lattice says anything about four-colourability. **S1 is two derivations at those scopes.**
2. Three later Poros sessions (J37–J39) will assemble "wanted posters" for counterexamples (four colours over ℚ(√47), four-colour
   rigidity over ℚ(√59), five colours over ℚ(√167)). They read this record. I answer my question and do not do theirs.
3. Kooshi's observation, relayed by the coordinator as one more question: *"walls often show up as 'the (impossible?) counter-example
   invariant' and we have had a successful breakthrough when looking for the 'example invariant'."* Asked: what example invariant
   this finding is the shadow of; whether T-A's or T-C's structural form already names it; whether looking for it is a better next
   question than the remainder T-C′. (Answered in its own stage.)

## Stage 1 — SAVED: the expectation, written before reading the two derivations

*Written from `CLAUDE.md` (loaded: Frontier items 10–25, G43, G48, G54, G55, G59, G60, G64, G74–G76) and the brief only. Neither
derivation, nor the verification, nor S1, nor the PA-close has been opened yet. Everything below is a hunch with basis* prior *or*
analogy *until the later stages score it.*

**E1. What "reads infinitely many primes" should mean.** The unit-vector ring `R = ℤ[U_F]` is a ring of S-integers of `F(i)` with
`S` infinite (every rational prime all of whose places split in `F(i)/F` is inverted; `[Fischer1990b]`, G55). Its Pontryagin dual `R̂`
is an adelic solenoid, `(ℂ × Π'_{v split} F(i)_v × Π_{v non-split} O_v) / R`, a restricted product. A character is a product of local
characters; `A` is the image of the archimedean factor, `Fin_S` the image of `Π_{v∈S} F(i)_v` for finite `S`. So `T + A + Fin_S` is a
Haar-null, σ-compact, dense subgroup: the characters that extend continuously to a *locally compact* group `ℂ × Π_{v∈S}`. A spectral
measure "carried by `T + A + Fin_S`" means the colouring's autocorrelation `ρ(r) = E⟨g(c(x)), g(c(x+r))⟩` extends continuously to
that locally compact group (plus a periodic part). "Reads infinitely many primes" = the autocorrelation is continuous for no finite
set of places. **Scope to check:** "for some finite `S`" is stronger than "carried by the union over `S`" — a measure can live on
`∪_S Fin_S` with no single `S` carrying it. I expect T-C(A) to be the single-`S` form, so "reads infinitely many primes" in the brief's
headline may overstate it: a four-colouring could read finitely many primes *per frequency* and infinitely many in total.

**E2. Deep or artefact?** I expect **mostly an artefact of the class chosen**, in this precise sense: the class `T + A + Fin_S` is
exactly the class on which local certificates can be applied, and I expect the proof to be **a product rule over finitely many
places** — strong approximation for the norm-one torus makes the diagonal image of `U` dense in the product of the local unit
circles, so the unit-distance graph on `ℂ × Π_{v∈S}` is a *categorical product* of local planes, and then `[Zhang2012]`'s theorems
(independence ratio of a product of vertex-transitive graphs = the max of the factors'; maximum independent sets pulled back from the
strict-max factor) do the rest. That gives: T-C(A) = "every local ratio is < 1/4" (S1 at the compact places, 31 binding, which G54
records as the Hoffman bound `1/4 − 2.745·10⁻⁶`; the archimedean factor by `[AmbrusEtAl2023]`'s `m₁(ℝ²) ≤ 0.247`; the split places
to be seen); T-C = Zhang's MIS-normal half at the tight dyadic place (row 88's route). If so, the finding is the complement of a
finite-product theorem, and "infinitely many primes" names where the product rule stops, not a new phenomenon of colourings.

**E3. Where it should point.** Two places. **(a)** The question it leaves is a **local–global principle for the invariant
independence ratio** (equivalently the fractional chromatic number) of a field plane: is the Følner independence ratio of
`Cay(R, U)` equal to the supremum of its local ratios? If yes, T-C(A)'s remainder closes and `χ(ℚ(√47)²) ≥ 5` follows from S1 and
Ambrus et al. alone — which I rate unlikely to be *that* easy, so I expect the remainder to be hard, and the brief's "does it reach
five at ℚ(√167)" to be **no by a count I can make now**: the archimedean place permits five fractionally (`m₁(ℝ²) ≥ 0.229 > 1/5`;
`χ_f(ℝ²) ≤ 4.36`, G60), so no ratio/product argument can refuse a five-colouring whose statistics are archimedean. **Four is the only
colour count where the archimedean factor refuses fractionally** (`0.229 ≤ m₁ ≤ 0.247 < 1/4`), so I expect the phenomenon to be
**specific to four colours** and silent on six and seven. **(b)** Averaged over rotations (the semidirect product `R ⋊ U` is
amenable), the spectral measure becomes a `U`-invariant measure on the solenoid, and `U` is a free abelian group of infinite rank
acting by automorphisms — Berend's setting, which rows 95–97 used for *closed sets*. The measure version is Rudolph–Johnson /
Einsiedler–Lindenstrauss for positive entropy and **Furstenberg's ×2×3 conjecture for zero entropy**. So I expect the remainder
T-C′ to split: a positive-entropy part that measure rigidity handles (and that is uncorrelated, hence "dead weight" for the
unit-distance constraint) and a zero-entropy part that is ×2×3 in disguise and open.

**E4. What should kill it cheaply.** (i) The single-`S` versus union scope (E1). (ii) A shared input: both derivations resting on one
product-rule step (Zhang for locally compact, non-discrete factors is not Zhang's theorem, which is for finite graphs) or one
archimedean certificate. (iii) The split places: their unit circle is non-compact (`F_v^×`), so "the local ratio at a split place"
needs its own statement — I expect either a Følner-mean argument or an assumption. (iv) Whether "carried by `T + A + Fin_S`" means the
*spectral measure of the one function `g∘c(0)`* or of the whole process (a 2-point statement versus a factor statement): a 2-point
hypothesis cannot license a use of Ambrus et al.'s certificate unless the correlation extends continuously to ℂ, which is what the
`A`-part gives — I will check that step.

**E5. Kooshi's example invariant (hunch, before reading).** The counterexample invariant is "reads infinitely many primes". Its
example-invariant shadow should be a property every *known* four-colouring carries that forbids that: **finite local support of the
autocorrelation** — every four-colouring we can exhibit (Theorem B's residue colourings, the dyadic pullbacks over type-(B) fields,
Fischer's ℤ/4 colouring) has autocorrelation continuous for one dyadic place. The candidate example invariant is then a
*finite-support law*: "every four-colouring's autocorrelation is continuous for a finite set of places", or, sharper, "every
four-colouring is local at a tight place" — which is G76's locality, so T-C's structural form may already name it.

## Stage 2 — SAVED: quotation check and the evidence inventory (read against Stage 1's expectations)

### 2.1 Quotation check (standing rule 5)

| # | quoted in the brief | source | result |
|---|---|---|---|
| Q1 | T-C, "Over a type-(B) field, every translation-invariant Borel probability measure … is carried by Pull." | `plans/FS86-row88-rigidity.md` §S.1 | **verbatim** (the brief omits the plan's trailing parenthetical on `Fin_S`, which is outside the quoted statement) |
| Q2 | T-C(A), "Over ℚ(√47), no translation-invariant … carried by no `T + A + Fin_S`." | same | **verbatim** |
| Q3 | "The derivation (J28D) states it for the whole class S2." | `plans/FS86-R88-D-derivation.md` l.14, §3.2 "Class (TC-class)" | agrees |
| Q4 | CLG (not in quotation marks in the brief): "a band `k`-character exists iff one exists at a single stable place … never 'every character colouring is local'" | `plans/FS91-S1D-character.md` §3.1, verbatim there: "`Θ_k(R_F) ≠ ∅` if and only if some stable place `𝔓` of `F(i)` and some level `m ≥ 1` have a band `k`-character of `T_{𝔓,m}`" | agrees in substance, existence scope confirmed; **note:** §3.1 and §3.3 of that record carry "Correction owed" banners (`plans/FS91-S1V-character.md` §2.3, §3.1 item 19) which I did not read |
| Q5 | S1: "periodic independence ratio below 1/4 by a margin of about 3·10⁻⁶ at the prime 31" | `plans/FS84-S1-derivation.md` S1a: `h*(31) = 0.2499972548…`, margin `2.745·10⁻⁶` | agrees |
| Q6 | the owner's update on S1V (bound, 11 or 31 undecided, amenability load-bearing, one GAP) | `plans/FS84-S1V-verification.md` S1V-4, V1, S1V-5, V3 (ii) | agrees |

### 2.2 Evidence inventory

- `plans/FS86-row88-rigidity.md` §0, §PA, §IQ, §S, §P, §M, the plan — read against: E1's single-`S` scope, E2's product rule — surprised: no (§M.1 item 5 fixes a single `S` because "a union over all finite `S` has no single completion"; §IQ item 2 already says that at type (A) the measure form **is** the chromatic question)
- `plans/FS86-R88-D-derivation.md` §3 and §5, J28D's proof of T-C and T-C(A) — read against: E2 (strong approximation plus a Zhang-type product count) and E4 (iv) (a 2-point hypothesis cannot license a use of Ambrus et al.) — surprised: yes, on E4 (iv). The hypothesis is 2-point, but C1–C2 turn it into **continuity in probability**, which extends the *whole process* to `G_S`; after that the argument is about genuine Borel colourings, so higher-order facts (`m₁ ≤ 0.2470`) apply legitimately. E2 confirmed: the count is "the stationary Zhang count" (C5), stable places absorbed by Hoffman, split places at ratio 0
- J28D §5.1, T-C′ — read against: E3 (b), an entropy split — surprised: yes, at one sentence: "the spectral measure of a merely translation-invariant `μ` is not `U`-invariant; those theorems see only `U`-averages, which can carry mass onto Pull". **Pull is empty at type (A)**, so this objection does not apply to ℚ(√47) (Stage 3, F4)
- `plans/FS86-R88-V-verification.md` §2.1–§2.2, J28V's blind derivations — read against: an independent route — surprised: partly. Same architecture (extension, regularisation, count), independent regularisation (C3) and tail factor (C4); shared inputs: `[AmbrusEtAl2023]`'s `m₁ ≤ 0.2470`, Coxeter's window lemmas C14.1/C14.3, FS-66 at 11 and 19. Its C0 remark ("any proof of T-C must use more of the colouring than its pair correlations", from FS86-dB-C0's archimedean positive-definite function) is the fact Stage 3's F5 turns into an equivalence. J28V's §Stage 5 (the independence discussion) was sampled only through its headings: **unread in full**
- `plans/FS86-row88-PA-close.md` stages 3–4 and §6.6–6.7, J35's gate — read against: "not found in print" — surprised: no. Useful names: "translation-invariant strict vector 4-colouring" (Karger–Motwani–Sudan), "continuous in probability for the `S`-adic topology", Bardestani–Mallahi-Karai's hyperbola computation (the split places), Bachoc–DeCorte–Oliveira–Vallentin (measurable Hoffman). I do not duplicate it
- `plans/FS84-S1-derivation.md` §2.2–§2.3, S1's invariant-measure section — read against: an invariant-measure form of four-colourability and a price for the single-class route — **surprised: yes.** §2.3 item 3 prices the route "`ι(ℚ(√47)) < 1/4`" as "exactly as hard as" refuting `[MatolcsiEtAl2025]`'s conjecture `α₁(ℝ²) = 1/4`. That conjecture was **already refuted** in the plane by `[DuczVarga2026]` (a 29-vertex unit-distance graph with independence ratio below 1/4; `BIBLIOGRAPHY.md` l.182, "read in full (2026-09-16)"). A `grep` finds no mention of it in S1, S1V, J28D, J28V or J35. Correction owed (Stage 4)
- `plans/FS84-S1V-verification.md`, the theorem table — read against: the owner's summary — surprised: no
- `plans/FS91-S1D-character.md` §3.1, §3.3, CLG and CLG-g — read against: an existence-only statement — surprised: no; CLG-g (g1) gives no exception at `k ≤ 5`. `plans/FS91-PA-close.md` ll.85–125 (M1's gate: Manners's pyjama lemma, Wang 2012, Einsiedler–Lindenstrauss 2022) — read against: nothing held on *measure* rigidity at zero entropy — surprised: no
- `plans/M3-S1D-windows-five.md` §3.2–§3.4 (J21-MX, J21-RED) — read against: a deletion lemma for compact factors — **unread** (used only through the plan's and J28D's quotations; J28D records it did not use J21-MX)
- `plans/STUB-adelic-window-colouring.md` (FS-64) — read against: a window over finitely many places — **unread in full** (used through `CLAUDE.md`'s table row 11)
- the dog that did not bark: no record tests whether "carried by no `T + A + Fin_S`" is *hard to achieve* anywhere colourings exist — read against: a control field — surprised: yes, and it is Stage 3's F2

### 2.3 Would-have-searched-here log

- Would have searched for a `U`-invariant measure on the adelic solenoid with negative mean at 1. Instead derived that one exists iff a non-Haar invariant measure exists (Stage 3, F5).
- Would have searched ℚ(√11) for a four-colouring whose spectrum is off every `T + A + Fin_S`. Instead wrote one down by formula (F2).
- Would have searched a finite `H ⊂ ℚ(√47)²` with `α(H) < |H|/4` (the fractional route). Not run; its price is corrected in Stage 4.
- Would have run a `Θ₄` tree and a colouring finder for a four-colourable unit-distance lattice with `Θ₄ = ∅` (EI-1's falsifier, Stage 4). Not run (ban); posed.
- **One exact check of seconds** (the ban's edge; a derivation fixed the set): the band-`k` characters of `Γ₇` at level one, all 48 non-zero characters (`tools/crunch_j36_band7.py` → `data/crunch-2026-09-25/j36/band7.out`): 0 at `k = 3`, **8 at `k = 4`**, 8 at `k = 5`. The plant (`PLANT=1`, the band replaced by `[0, 1)`) fires: 48 at every `k`, exit 1. Use: `Γ₇` does not falsify EI-1 (Stage 4).
