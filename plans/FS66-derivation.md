# FS-66 — the derivation file: every theorem this milestone proved outside the kernel

*Written 2026-09-23 by the FS-71 batch-6e implementer (WORKFLOW 2.0 step 9's theorem-tracking rule, backfilled by the theorem
audit). Milestone: FS-66, the residue tower (`plans/FS66-residue-tower-drop.md`, `plans/FS66-phase2-certificate.md`,
`plans/FS66-tower-conjecture.md`; `LEDGER.md` row 75; grokking G66). Ids follow the plans' own names where they already had
one (`FS66-W`, `FS66-E`, `FS66-T`, `FS66-L1`…`FS66-L6`, matching `data/fs66/b1/SOUNDNESS.md`'s own §1–§6 labels) and
`FS66-Tn` for the theorems the sources state and prove but never named. Enumeration: `plans/FS66-tower-conjecture.md` read in
full; `plans/FS66-phase2-certificate.md` §F, §C, §S (§S.1–S.7 in full — the soundness page, `data/fs66/b1/SOUNDNESS.md`, is
the polished restatement of the same six links and is the primary source quoted below), §ST, §PA, §R read in full, the rest
(§H phase briefs, §T, §W, §E) skimmed for anything graded beyond what §R already reports; `plans/FS66-residue-tower-drop.md`
§S1–S6 (the hand derivations) and §Q, §R read in full, the phase checklists (§H onward) skimmed; `data/fs66/b1/SOUNDNESS.md`
and `data/fs66/README.md` read in full; `data/fs66/owner/note-2026-09-20-fibre-density.md` read in full (§1–§8); `data/fs66/owner/rulings-2026-09-20.md`,
`data/fs66/owner/po-plants-phase2a.md`, `data/fs66/owner/po-recheck-phase2c-19.md`, `data/fs66/owner/po-recheck-phase2d-23.md`
grepped for `theorem|lemma|proved`, nothing beyond §R's own account found; `plans/STUB-residue-tower-drop.md`,
`plans/STUB-tower-never-rises.md`, `plans/SESSION-HANDOFF-2026-09-21-fs66.md` read in full. Full enumeration, including files
skipped and why, is in the batch report `data/fs71/batch-6e.md`. Grades are `CLAUDE.md` § Notation's.*

## The theorems

**FS66-L1 — The spectrum above level one is small. [hand; the FS-66 phase-2 planner, lifted verbatim into
`data/fs66/b1/SOUNDNESS.md` §1 by the phase 2A implementer]** Fix `p ≡ 3 (mod 4)` and `k ≥ 2`. Let `G_k = Cay((ℤ/p^k)², S_k)`,
`S_k = {(a,b) : a²+b² ≡ 1 (mod p^k)}`. Every eigenvalue of `G_k`'s adjacency operator, restricted to the orthogonal complement
of the functions constant on the fibres of the reduction map `G_k → G_1`, has absolute value at most `2p^{k-1}` (against
degree `p^{k-1}(p+1)`). *Proof:* Hensel's count gives `|S_k| = p^{k-1}(p+1)` (the gradient of `a²+b²-1` is nonzero mod `p` on
the circle) and exhibits `S_k` as a union of cosets of the subgroup `N = {1 + p^{k-1}·i·a : a ∈ 𝔽_p}`. For a character `χ_u`
of exact level `k` (`u ≢ 0 mod p`), summing over one coset gives `χ_u(s)·Σ_a e(a⟨ū,i·s̄⟩/p)`, which vanishes unless `s̄` lies on
the line through `ū` — at most two points of `S₁`, hence `2p^{k-2}` cosets, hence `|λ_u(G_k)| ≤ 2p^{k-1}`; a character of exact
level `j`, `2 ≤ j < k`, factors through level `j` and inherits the same bound by Hensel's count again. Surjectivity of
`S_k → S_{k-1}` is not used. `data/fs66/b1/SOUNDNESS.md` §1; `plans/FS66-phase2-certificate.md` §S.1. Checked by FFT at
`(3; 2–4)`, `(7; 2–3)`, `(11; 2)` (`depth-spectrum.out`). *Proof verdict:* closes. *Rests on it:* FS66-L2 (the fibre-density
inequality); row 75's certificates, whose exactness this bound licenses at every level of the tower. *Prior art:* partly — the
*sharper*, prime-specific bound (a character sum computed exactly, giving `c(p) = -λ_min(depth 2)/p < 2`, e.g. 1.999326 at 11)
is `[MMST1998]` Thms 2.1, 2.3, 2.9 (already held and cited at row 75, `data/fs66/owner/note-2026-09-20-fibre-density.md` §1),
which the project's own review (G50, `plans/FS38-derivation.md` FS38-L2's neighbour) found gives no colouring value directly;
**this link's contribution is the crude, uniform `2p^{k-1}` bound with an elementary, MMST-free proof** (verified independently
at 11, 19, 23 in `data/fs66/owner/note-2026-09-20-fibre-density.md` §7, which reaches the same bound with `c = 2` from Hensel's
count alone, "without citing anyone"). zbMATH: `ab:"independence number" & ab:"tower" & ab:"prime power"` (0 hits),
`ti:"finite Euclidean graphs over rings"` (1 hit — `[MMST1998]`, the positive control confirming the query mechanics).
*Kernel:* declined — the project's own choice (row 75, `data/fs66/b1/SOUNDNESS.md` §7's trust table) was a standalone
standard-library checker in place of a kernel formalisation for this milestone; not priced.

**FS66-L2 — The fibre-density inequality. [hand; the FS-66 phase-2 planner]** Let `I` be an independent set of `G_k`,
`k ≥ 2`, and `φ(x) ∈ [0,1]` the share of the fibre over `x ∈ V(G₁)` that `I` occupies. Then `φ` satisfies
`⟨φ, A₁φ⟩ ≤ 2·Σ_x φ(x)(1-φ(x))`, and `|I| = p^{2(k-1)}·Σφ`. *Proof:* split `1_I = Pφ + g` (fibre-constant part and its
orthogonal complement, both preserved by the adjacency operator `A_k`); `⟨Pφ, A_k Pφ⟩ = p^{3(k-1)}⟨φ, A₁φ⟩`,
`‖g‖² = p^{2(k-1)}Σφ(1-φ)`, and `⟨g, A_k g⟩ ≥ -2p^{k-1}‖g‖²` by FS66-L1; independence is `⟨1_I, A_k 1_I⟩ = 0`; add and divide
by `p^{3(k-1)}`. At `k = 1`, `φ = 1_I` and both sides are `0`. `data/fs66/b1/SOUNDNESS.md` §2; `plans/FS66-phase2-certificate.md`
§S.2. *Proof verdict:* closes. *Rests on it:* FS66-L1; FS66-L6 (the count bound); every `B₁(p)` certificate of row 75; the
biclique structure (FS66-T5) as a corroborating computation, and `tools/fs66_b1_links_test.py`'s falsifier (803 explicit
independent sets at `(3;2)`, `(3;3)`, `(7;2)`, no violation, pull-backs tight). *Prior art:* ours — the `2Σφ(1-φ)` shape (a
"fuzzy independent set" density inequality for the reduction of a Cayley graph tower) is not the standard fractional
relaxation of independence and was not found in print. zbMATH: `ab:"independence ratio" & ("random lift*" | "covering
graph*" | "voltage graph*" | "regular cover*")` (8 hits total across two queries — only Amit–Linial–Matoušek 2002 on random
lifts, already held, nothing on algebraic covers — `plans/FS66-tower-conjecture.md` §2's own gate, reused here rather than
re-run), `ab:"fibre density" & ab:"independent set"` (0 hits). *Kernel:* declined — same trust decision as FS66-L1.

**FS66-L3 — Symmetrised moments of a feasible fibre-share vector obey the box and localiser inequalities. [hand; the
FS-66 phase-2 planner]** Let `Γ` be the group generated by the translations of `V = 𝔽_p²` and by every bijection `h` with
`h(x+s) - h(x) ∈ S` for all `x, s ∈ S` (a property closed under composition and inverse, so `Γ`'s closure need never be
verified — only that each generator has it). For a feasible `φ ∈ [0,1]^V` with `q(φ) ≥ 0` (`q(φ) := 2Σφ(1-φ) - ⟨φ,A₁φ⟩`,
FS66-L2's inequality), define the symmetrised moment `ȳ(m) = |Γ|⁻¹ Σ_{γ∈Γ} Π_{x∈m} φ(γx)` for a monomial `m` (a multiset of
points of `V`, degree ≤ 4). Then: `ȳ([]) = 1`; `n·ȳ([0]) = Σφ`; `ȳ(γm) = ȳ(m)`; `ȳ(m) ≥ 0` and `ȳ(m∖x) - ȳ(m) ≥ 0`; for
positive semidefinite `𝒵` indexed by monomials, `Σ 𝒵_{ij}ȳ(m_i m_j) ≥ 0`; and with `Q(m)` the linear form "the moment of
`q` times `m`" written from `q`'s definition, `Σ 𝒵_{ij}Q(m_i m_j)(ȳ) = q(φ)·Σ 𝒵_{ij}ȳ(m_i m_j) ≥ 0`. *Proof:* each property
is an average of a pointwise fact (a product of numbers in `[0,1]`, a quadratic form, `q(φ∘γ) = q(φ)` because `s ↦ γ(x+s)-γ(x)`
permutes `S`). `data/fs66/b1/SOUNDNESS.md` §3 (properties M1–M7); `plans/FS66-phase2-certificate.md` §S.3. *Proof verdict:*
closes. *Rests on it:* FS66-L4 (the identity, evaluated at `y = ȳ`); the checker's canonicalisation step (`tools/fs66_b1_cert_check.py`),
whose step-3 property test is exactly "each verified map has this closure property". *Prior art:* ours — a bespoke averaging
construction over the symmetry group of one specific Cayley graph, not a general theorem of a discipline; the enclosing
technique (moment relaxations of a polynomial optimisation problem, symmetrised by an automorphism group) is classical
(Lasserre; Parrilo; Gatermann–Parrilo on symmetry reduction), recalled and not re-read for this milestone
(`plans/FS66-phase2-certificate.md` §PA — the method's citations, marked so per G50). zbMATH: `ab:"symmetrised moment" &
ab:"semidefinite" & ab:"Cayley graph"` (0 hits), `ab:"sum of squares" & ab:"invariant" & ab:"group action" & ab:"independence
number"` (0 hits — not run fresh; the method-level search is `plans/FS66-phase2-certificate.md` §PA's, reused). *Kernel:*
declined — same trust decision as FS66-L1.

**FS66-L4 — The certificate's identity (★), evaluated at the symmetrised moments, gives the bound. [hand; the FS-66
phase-2 planner]** If a certificate's identity `(★): U_num·y([]) - L·n·y([0]) = Σ_blocks T_block(y) + Σ_rows lam·box(A,B)(y)`
holds as an identity of integer linear forms, every block's matrix `R` is positive definite, every row multiplier `lam ≥ 0`,
and `L > 0`, then every `φ ∈ [0,1]^V` with `q(φ) ≥ 0` satisfies `Σφ ≤ U := U_num/L`. *Proof:* evaluate (★) at `y = ȳ`
(FS66-L3). The left side is `U_num - L·Σφ` (by `ȳ([])=1`, `n·ȳ([0])=Σφ`). On the right, each block's contribution
`T_block(ȳ) = Σ_ŵ ⟨E_ŵ R E_ŵᵀ, M⟩` (`M` the moment matrix of `ȳ`, or of `q·ȳ` for a `"q"`-typed block) is a positive
semidefinite pairing when `R` is positive definite (FS66-L5), hence `≥ 0` by FS66-L3's M6/M7; each row's `box(A,B)(ȳ)` is a
symmetrised moment of a product of numbers in `[0,1]` and `1-φ_x`'s, hence `≥ 0` by M4/M5, and `lam ≥ 0`. So
`U_num - L·Σφ ≥ 0`, and dividing by `L > 0` gives `Σφ ≤ U`. `data/fs66/b1/SOUNDNESS.md` §4; `plans/FS66-phase2-certificate.md`
§C.2–C.4, §S.4. **Two things are deliberately not on the trust surface**: the weight vectors (any integers in `ŵ` give a
positive-semidefinite `E R Eᵀ` for positive definite `R`, so a wrong weight only weakens `U`, never invalidates the
inequality) and the choice of representative monomials (any list of degree-≤2 monomials indexes a principal submatrix of the
moment matrix, so an incomplete canonicaliser is safe and a wrongly-merging one is impossible by construction — every merge
is witnessed by a verified group element). *Proof verdict:* closes. *Rests on it:* FS66-L3; FS66-L5; FS66-L6 (which
combines this bound with FS66-L2's `|I| = p^{2(k-1)}Σφ`); every `CERTIFIED` verdict at 7, 11, 19, 23 (row 75). *Prior art:*
ours for the specific identity and its two "not on the trust surface" observations; the shape (a rational certificate whose
soundness needs no trust in the numbers that produced it, only in the identity and the signs) is `[FS50-T…]`'s
(`plans/FS50-certificate-soundness.md` §7, this project's own earlier milestone, explicitly reused: "the 'rational weights are
off the trust surface' and 'U is an output' ideas are taken whole," `plans/FS66-phase2-certificate.md` §PA). zbMATH:
`ab:"positivstellensatz" & ab:"rational certificate" & ab:"rounding"` (searched at FS-50's own opening, not re-run here — see
`plans/FS50-certificate-soundness.md`). *Kernel:* declined — same trust decision as FS66-L1; the identity is a finite exact
arithmetic check the standard-library checker already performs on every certificate file.

**FS66-L5 — Positive definiteness by fraction-free elimination (Sylvester + Bareiss). [hand; the FS-66 phase-2 planner]**
A symmetric integer matrix `R` all of whose leading principal minors are positive is positive definite, and walking
fraction-free (Bareiss) elimination without pivoting — where the `k`-th pivot *is* the `k`-th leading principal minor and
every division is exact — is exactly that test, performed in integers with no rounding. *Proof:* Sylvester's criterion
(classical) plus Bareiss's identity (classical, `data/fs66/b1/SOUNDNESS.md` §5 restates the two theorems by name and cites the
elementary two-line consequence `xᵀRx = (Lᵀx)ᵀD(Lᵀx) > 0` for the `--ldl` alternative route, which trusts neither theorem and
instead re-multiplies `L·D·Lᵀ` and compares entry-by-entry with `R`). `plans/FS66-phase2-certificate.md` §S.5. *Proof verdict:* closes (both classical facts; the checker runs both routes on every block of every certificate and the self-test
demands agreement). *Rests on it:* FS66-L4 (which needs `R` positive definite). *Prior art:* Sylvester's criterion and
Bareiss's fraction-free-elimination identity are both textbook linear algebra (uncited in the source, needing none); the
application — treating exact fraction-free elimination as a from-scratch-checkable Sylvester witness inside an untrusted
program — is this project's engineering choice, shared with `[FS50-T…]`'s certificate (recalled, not re-searched). zbMATH:
`ab:"Bareiss algorithm" & ab:"positive definite" & ab:"certificate"` (0 hits). *Kernel:* declined — same trust decision as
FS66-L1; both theorems are in Mathlib in some form but were not looked up, since the checker route was chosen deliberately.

**FS66-L6 — From the bound to the colours. [hand; the FS-66 phase-2 planner]** If `Σφ ≤ U` for every `φ ∈ [0,1]^V` with
`q(φ) ≥ 0` (FS66-L4), then `α(G_k) ≤ U·p^{2(k-1)}` for every `k ≥ 1` (FS66-L2); and if `m·U < p²`, no `G_k` is `m`-colourable
at any level `k`, and `χ_f(G_k) ≥ p²/U` (vertex-transitivity). *Proof:* an `m`-colouring of `G_k` covers its `p^{2k}` points
with `m` independent sets, so `p^{2k} ≤ m·U·p^{2(k-1)}`, i.e. `p² ≤ m·U`. `data/fs66/b1/SOUNDNESS.md` §6;
`plans/FS66-phase2-certificate.md` §S.6. The checker performs the final comparison in exact integers, `m·U_num < p²·L`, and
prints `CERTIFIED` only then; `m·U ≥ p²` prints `BOUND ONLY` (a valid bound that refuses nothing — "not evidence that that
many colours suffice," `data/fs66/b1/SOUNDNESS.md` §6). *Proof verdict:* closes. *Rests on it:* every clause of row 75's
"no level at 11 or 19 is four-colourable, none at 7 three-colourable, none at 23 five-colourable"; `χ_Bor` bounds (FS66-T7);
the `α(UD(ℤ/49,2)) = 686` exact value (`data/fs66/b1/SOUNDNESS.md` §6's own corollary, using an explicit level-one
independent set of 14 points as the matching lower bound). *Prior art:* ours — the count argument is a one-line pigeonhole,
not itself attributed to anyone; the surrounding fact that a vertex-transitive graph's fractional chromatic number is
`n/α` is standard graph theory, uncited in the source. zbMATH: `ab:"vertex-transitive" & ab:"fractional chromatic number" &
ab:"tower"` (0 hits). *Kernel:* declined — same trust decision as FS66-L1.

**FS66-W — Lemma W: the weighted form of the tower-never-rises conjecture is false at every prime. [hand, the FS-66 prover
(Fable 5.1 planner-mathematician); checked by the owner]** Let `p ≡ 3 (mod 4)`, and let `I = {(a,b) ∈ ℤ/p² : b ≡ 0 (mod p),
a` even as an integer in `[0, p²-3]}`. Then `I` is independent in `G₂ = UD(ℤ/p², 2)`, its fibre shares `φ_I` are supported on
the level-one line `ℓ = \{(j,0)\}` (an induced `p`-cycle of `G₁`), and `Σ_ℓ φ_I = (p²-1)/(2p) > (p-1)/2 = α(G₁[ℓ])`.
Consequently `φ_I ∉ STAB(G₁)` (the stable-set polytope) and `max_I w·φ_I > α_w(G₁)` for `w = 1_ℓ`: **the fibre shares of a
level-two independent set need not lie in level one's stable-set polytope, so no pointwise or local transfer argument can
prove the unweighted conjecture (C-α) — any proof must be global.** *Proof:* a unit vector `(s,t)` of `ℤ/p²` with `t ≡ 0
(mod p)` has `s² ≡ 1 (mod p²)`, so `s = ±1`; two points of `I` differ by `(Δa, Δb)`, `Δb ≡ 0 (mod p)`, adjacent only if
`Δa ≡ ±1 (mod p²)`, and since every `a` is an even integer in `[0,p²-3]` the only possible wrap (`p²-1 ↔ 0`) is excluded, so
`I` is independent; `|I| = p(p²-1)/2`, so the share over `ℓ` (`p` points) is `(p²-1)/(2p)`. `plans/FS66-tower-conjecture.md`
§3.1 (Lemma W and its proof, in full); `data/fs66/conjecture/line.out` (the falsifier). *Falsifier run and passed*:
`tools/fs66_conj_line.py` at `p = 3, 7, 11, 19` (exact integers, every unit vector checked; owner's independent
re-derivation and re-check from the definition at 3, 7, 11, `plans/FS66-tower-conjecture.md`'s "Owner's review"). *Proof verdict:* closes. *Rests on it:* the milestone's own verdict ("NOT PROVED — the run at 23 should be left to finish," §0);
`FS66-T3` (the section bound, which Lemma W's mechanism — line gains not affordable locally — explains); stub FS-68 (the
tower-never-rises question), whose §2 cites Lemma W as the reason no local proof exists. *Prior art:* ours — a specific
independent-set construction on one arithmetic Cayley graph tower and the observation that regular covers of vertex-transitive
graphs can genuinely raise the independence ratio (unlike this tower, conjecturally); not found searched under the covers/
lifts/voltage-graph literature (`plans/FS66-tower-conjecture.md` §2's gate: `ab:"independence ratio" & (cover* | lift* |
voltage)` and `ab:"independence number" & ("random lift*" | "covering graph*" | "voltage graph*" | "regular cover*")`, 3+5
hits, only Amit–Linial–Matoušek 2002 on point, held, review only). zbMATH: `ab:"stable set polytope" & ab:"lifted graph"` (0
hits, fresh). *Kernel:* **priced** — the milestone's own stub names this: "(W) is a finite family of `decide`s plus a
general lemma. Hours, and they are statements nobody had" (`plans/STUB-tower-never-rises.md` §3.5); not attempted.

**FS66-E — Theorem E: equal-characteristic towers are impotent. [hand, the FS-66 prover (Fable 5.1 planner-mathematician);
checked by the owner]** Let `A` be a local ring with maximal ideal `𝔪` and residue field `𝔽_q` (any `q`), containing a
subring mapping isomorphically onto `𝔽_q` (e.g. `𝔽_q[[t]]/t^k`). Then for every `k`, `UD(A/𝔪^k, 2)` and `UD(𝔽_q, 2)` are
homomorphically equivalent, so `χ`, `χ_f` and the independence ratio are constant up the tower — (C-α), (C-χ), (C-m) all hold.
**Corollary:** if `O` is the ring of integers of a finite extension of `ℚ_p` with ramification index `e ≥ 2` and residue
field `𝔽_q`, then `O/π^k ≅ 𝔽_q[ε]/ε^k` for `k ≤ e`, so the first `e` levels of the tower at a ramified place are impotent.
*Proof:* the inclusion `𝔽_q ⊂ A/𝔪^k` is a ring map, hence carries `a²+b²=1` to itself and gives a graph homomorphism
`UD(𝔽_q) → UD(A/𝔪^k)`; reduction gives the homomorphism back; homomorphically equivalent graphs share `χ`, `χ_f` (both
vertex-transitive, so the ratio is `1/χ_f`); for the corollary, `O/π^k` has characteristic `p` for `k ≤ e`, and a complete
local `𝔽_p`-algebra with residue field `𝔽_q` contains a coefficient field (Teichmüller, since `𝔽_q` is finite).
`plans/FS66-tower-conjecture.md` §3.2 (in full). *Falsifier run and passed:* the zero-twist row of
`data/fs66/conjecture/twist-p*.out` (the built graph is `p(p+1)`-regular with level-one spectrum `p·λ₁`, matching the
theorem's prediction that the zero twist is genuinely `UD(𝔽_p[ε]/ε²,2)`). *Proof verdict:* closes. *Rests on it:* FS66-T
(twist-blindness, which shows the *carry* twist — i.e. `G_k` itself — is the one member of this family the theorem does
*not* directly settle); the reading "no twist of `G₁` ever raises `α`" (§3.2 (3)); consistency check against row 67's
2-adic tower (`e = 2`, forces only from level 5 — noted by the owner as consistent with `unitQuadrance.map` and this
theorem). *Prior art:* ours — the subring/coefficient-field argument for a tower's chromatic constancy is elementary
commutative algebra applied to a construction (the residue tower of a unit-distance graph) not found in print. zbMATH:
`ab:"equicharacteristic" & ab:"residue field" & ab:"chromatic number"` (0 hits), `ab:"coefficient field" & ab:"graph
homomorphism" & ab:"local ring"` (0 hits). *Kernel:* **priced** — the milestone's own stub: "(E) is a two-line
`unitQuadrance.map` argument" (`plans/STUB-tower-never-rises.md` §3.5); not attempted.

**FS66-T — Lemma T: twist-blindness. [hand, the FS-66 prover (Fable 5.1 planner-mathematician); checked by the owner, one
erratum found and repaired in the checking]** For `γ : \{oriented edges of G₁\} → 𝔽_p` with `γ(x+s̄,-s̄) = γ(x,s̄)` (the
owner's correction — the prover's original sign, `-γ(x,s̄)`, breaks the symmetry the relation needs), let `G₂^γ` have
vertices `(x,u) ∈ 𝔽_p² × 𝔽_p²` and `(x,u) ~ (x+s̄,v)` iff `⟨v-u,s̄⟩ = γ(x,s̄)`. **For every `γ`, the adjacency operator of
`G₂^γ` preserves the fibre-constant functions (acting there as `p·A₁`) and their orthogonal complement, and on the
complement its spectrum lies in `[-2p, 2p]`.** Consequently FS66-L2's inequality, the bound `α(G₂^γ) ≤ p²·B₁(p)`, and every
`B₁` certificate hold for every twisted cover of `G₁`, not only for the carry twist `G₂` (`γ = γ₀`, the carry of integer
addition) or the zero twist (`γ = 0`, `UD(𝔽_p[ε]/ε²,2)`). *Proof:* decompose a function on `G₂^γ` along the fibre
characters `u ↦ ψ(⟨u^*,u⟩)`; for `u^* ≠ 0` the adjacency operator's action on the `u^*`-isotypic part is `0` unless
`u^* = r·s̄` for some direction `s̄` (which it determines up to sign), in which case it is `p` times a magnetic adjacency
operator on the disjoint `p`-cycles `x + 𝔽_p s̄` with unimodular phases, whose eigenvalues are `2cos(·) ∈ [-2,2]`, giving the
factor `p` bound. `plans/FS66-tower-conjecture.md` §3.2 (Lemma T and its proof); the erratum and its resolution in the
"Owner's review" section (`tools/fs66_conj_twist.py` is unaffected — it symmetrises the adjacency directly and the carry
twist reproduces `UD(ℤ/p²,2)` entry for entry). *Falsifier run and passed:* the carry twist, the zero twist, and 5+3
random twists at `p = 3, 7`, all off-level-one spectra inside `[-2p,2p]`; the carry twist at 7 reads `-13.9712` against the
predicted `-c(7)·7 = -13.9712`. *Proof verdict:* closes (with the sign corrected; the checked conclusion — "every `B₁`
certificate bounds every twisted cover" — is unaffected). *Rests on it:* the free strengthening of `data/fs66/b1/SOUNDNESS.md`
§8 to every twisted cover (a sentence, no new proof obligation); the reading "no twist of `G₁` ever raises `α`," whose
killing test is a verified independent set of 3,389 points in a twisted cover at 11 (not run — a night of CPU against a
plateau, `plans/STUB-tower-never-rises.md` §3 item 4). *Prior art:* ours — a spectral decomposition of a family of twisted
covers of a specific arithmetic Cayley graph, related in spirit to magnetic/gain-graph spectral theory (recalled by name in
the proof, not cited to a specific source) but not matched to any held or searched paper. zbMATH: `ab:"magnetic" &
ab:"adjacency" & ab:"cover" & ab:"chromatic"` (0 hits), `ab:"gain graph" & ab:"twisted cover" & ab:"independence number"`
(0 hits). *Kernel:* declined — no consumer beyond the reading it licenses (FS-68's killing test), not priced.

**FS66-T1 — The chain of equivalents of (C-α). [hand; the FS-66 prover (Fable 5.1 planner-mathematician)]** With
`α_k = α(G_k)`, `n_k = p^{2k}`, `m₁(ℤ_p²) := sup\{`Haar measure of a measurable independent set of `ℤ_p²\}`, and
`χ_f^{fin}(𝔊) := sup\{χ_f(K) : K` a finite subgraph of `𝔊 = UD(ℤ_p,2)\}`: the sequence `α_k/n_k` is non-decreasing with
limit `m₁(ℤ_p²)`, and `χ_f(G_k) = n_k/α_k` (vertex-transitivity). Hence **(C-α)** (`α_k = p^{2(k-1)}α₁` for all `k`)
**⟺ `χ_f(G_k) = χ_f(G₁)` for all `k` ⟺ `m₁(ℤ_p²) = α₁/p²`**, and **`χ_f^{fin}(𝔊) = χ_f(G₁) ⟹` (C-α)** (the liftable-subgraph
form is only a one-way implication; its converse is not proved and not in print, `plans/FS66-tower-conjecture.md` §2.1).
*Proof:* pulling an independent set of `G_k` back to `G_{k+1}` multiplies it by `p²`, giving monotonicity; the limit
identification is Lebesgue density (pull back and take limits both ways); for finite `K ⊂ 𝔊`, a weighted averaging argument
over translates (`∫ Σ_x w_x 1_I(x+t) dt = w(K)μ(I)`, and for a.e. `t` the surviving set is independent in `K`) gives
`μ(I) ≤ α_w(K)/w(K)`, optimised over `w`. `plans/FS66-tower-conjecture.md` §1.2, in full (labelled `[proved; each step is two
lines]` there). *Proof verdict:* closes. *Rests on it:* row 75's table (§1.4) of "where each form stands today"; FS66-T4
(one of the three routes to (C-α)); §1.4's observation that (C-χ) and (C-m) hold at every prime below 23 by three unrelated
mechanisms. *Prior art:* the general machinery — a vertex-transitive graph's fractional chromatic number is `n/α`; the
measurable independence density of a profinite group as the limit of a tower of finite quotients — is standard in the
measurable/descriptive-combinatorics literature the milestone's gate surveyed (`[ConleyKechris2013]`, `[Bernshteyn2022]`,
recalled by name and not re-read here either, per that gate); the specific equivalence chain for this tower is ours. zbMATH:
`ab:"measurable chromatic number" | "measurable independence" | "independence density"` (24 hits, surveyed at the
milestone's own opening — reused, not re-run; none on a totally disconnected/profinite group), `ab:"fractional chromatic
number" & ab:"profinite"` (0 hits, fresh). *Kernel:* declined — a measure-theoretic limit statement with no finite
kernel-checkable consumer named.

**FS66-T2 — The implications among (C-α), (C-χ), (C-m). [hand; the FS-66 prover (Fable 5.1 planner-mathematician)]**
**(C-α) ⟹ (C-m)**: an `m`-colouring of `G_k` has a class of size `≥ n_k/m > p^{2(k-1)}α₁ = α_k` whenever `m·α₁ < p²` —
contradiction. **(C-χ) ⟹ (C-m)**: `χ(G_k) = χ(G₁) ≥ ⌈p²/α₁⌉ > m`. **(C-α) ∧ [`χ(G₁) = ⌈p²/α₁⌉`] ⟹ (C-χ)**. Without the
bracketed hypothesis neither of (C-α), (C-χ) implies the other. *Proof:* each is a two-line pigeonhole or substitution.
`plans/FS66-tower-conjecture.md` §1.3 (`[proved]`). *Proof verdict:* closes. *Rests on it:* row 75's §1.4 table (every prime
below 23 gets (C-χ) and (C-m) as theorems by one of three mechanisms, even where (C-α) itself is open, e.g. at 11 and 19);
the milestone's own headline observation ("(iii)... the run needs (C-m) at `(23,5)`, which follows from **either** (C-α) or
(C-χ) at 23"). *Prior art:* ours — elementary pigeonhole substitutions specific to this tower's three named forms, not a
general theorem. zbMATH: not separately queried (the same search as FS66-T1 covers the discipline; no distinct claim to
search). *Kernel:* declined — no finite kernel-checkable consumer named.

**FS66-T3 — The section bound survives route (a), and shows what any local proof of (C-α) would have to price. [hand;
the FS-66 prover (Fable 5.1 planner-mathematician)]** Write a section `f(x) = x̃ + p·g(x)`, `g : 𝔽_p² → 𝔽_p²` arbitrary. The
edge `(x,x+s̄)` is *kept* by `f` iff `⟨g(x+s̄)-g(x), s̄⟩ = -γ₀(x,s̄)` (`γ₀` the carry of `x ↦ x̃`), one affine condition per
edge; let `K_g` be the spanning subgraph of kept edges. **Then `α₂ ≤ p²·min_g α(K_g)`, and every `K_g` omits at least one
edge of every single-direction cycle.** *Proof:* for `u ∈ 𝔽_p²`, `\{x : f(x)+pu ∈ I\}` is independent in `K_g` (a lifted edge of
`K_g` that both endpoints used would put an edge of `I` inside `I`); averaging over `u` gives `Σφ_I ≤ α(K_g)`. The linear
part of the kept-edge conditions is `G₁`'s rigidity matrix over `𝔽_p`, so a generic `K_g` keeps about `2p²-3` of `p²(p+1)/2`
edges. `plans/FS66-tower-conjecture.md` §3.1 ("The section bound that does survive [proved]"). **Measured** (exact MILP,
`tools/fs66_conj_edgecrit.py`): at 7, `α(G₁-e) = 14` for every single edge deletion (no edge is `α`-critical), yet six
random one-edge-per-line deletions gave `α(K_g) ∈ \{15,16,16,16,16,16\}` — the bound needs a *carefully chosen* `K_g`, not a
generic one, and whether any choice keeps `α(K_g) = 14` at 7 was asked (`tools/fs66_conj_transversal.py`, exact no-good
cuts) and **left undecided** after a 15-minute wall (§4's table). *Proof verdict:* closes (the bound itself; the search for a
tight `K_g` is an open computation, recorded separately as not a theorem). *Rests on it:* Lemma W (FS66-W), whose mechanism —
single-direction lines are the only place a genuine gain lives — is what this bound tries and fails to price generically;
stub FS-68 §3 item 1 (the exact-face certificate at 7), which would need a tight `K_g` if this route were pursued instead.
*Prior art:* ours — a rigidity-matrix argument for bounding a level-two independent set by a family of level-one subgraphs,
specific to this construction. zbMATH: `ab:"rigidity matrix" & ab:"independent set" & ab:"finite field"` (0 hits),
`ab:"section" & ab:"cover" & ab:"independent set" & ab:"tower"` (0 hits). *Kernel:* declined — the route it belongs to
(route (a)) is explicitly reported dead ("DIES HERE"); no consumer.

**FS66-T4 — `G₁` itself can never be the witness for the liftable-subgraph route, at 7 and 11. [hand; the FS-66 prover
(Fable 5.1 planner-mathematician); the core-graph citation flagged by the milestone's own reviewer as recalled, not
re-read — check owed]** A homomorphism `G₁ → 𝔊` composed with reduction `𝔊 → G₁` is an endomorphism of `G₁`. Citing that
the core of a vertex-transitive graph is vertex-transitive with order dividing the graph's order, and that order `p` would
need `p | α₁` (false at 11) or, at 7, a triangle-free 7-vertex graph with `α = 2` (impossible, `R(3,3) = 6`): `G₁(7)` and
`G₁(11)` are their own cores, so the endomorphism above is an automorphism, and any homomorphism `G₁ → 𝔊` would be a
section up to symmetry — which the single-direction cycles forbid (Lemma W's mechanism). *Proof:*
`plans/FS66-tower-conjecture.md` §3.4 ("`G₁` itself can never be the witness [proved at 7 and 11]"). *Proof verdict:*
closes, **conditionally on the cited core-order fact**: the milestone's own "Owner's review" explicitly lists this as
"not checked by me, and therefore not to be repeated as established until they are: that `G₁(7)` and `G₁(11)` are cores
(the author flags the Hahn–Tardif fact as recalled from memory)" — this audit did not independently verify it either (a
graph-homomorphism-core textbook fact, plausible and standard, but unread here). *Rests on it:* §1.4's closing of route (c)
at 7 and 11 as candidates for "`G₁` as its own witness"; the redirection of route (c) toward other fields (`ℚ(√11) ⊂ ℚ₇`) at
§3.4. *Prior art:* the core-order fact is attributed to `[HahnTardif1997]` (the no-homomorphism lemma / core theory
survey), held per row 75's neighbourhood citations but **check owed** — recalled, not re-read, by the milestone's own
account; the specific self-witness argument for this tower is ours. zbMATH: `ab:"core" & ab:"vertex-transitive graph" &
ab:"homomorphism"` (searched at the milestone's own opening under a broader query, reused, not re-run — see
`plans/FS66-tower-conjecture.md` §2's table; no dedicated re-check). *Kernel:* declined — a negative result (rules out one
witness candidate), no consumer.

**FS66-T5 — Level two is a union of complete bipartite blocks between adjacent fibres. [hand + tools; the product owner;
checked exhaustively at 7 and 11, 0 failures]** For `p ≡ 3 (mod 4)`, write `R = ℤ/p²`. Between the fibres of the reduction
map `UD(ℤ/p²,2) → UD(𝔽_p,2)` over two adjacent level-one points `x` and `y = x+s̄`, the graph is **`p` disjoint copies of
`K_{p,p}`**: the second digits of a fibre fall into `p` lines of direction `s̄·i` (indexed by the `s̄`-component of the
point), and line `t` over `x` is completely joined to exactly one line `t' = t + γ(x,s̄)` over `y`, and to nothing else.
*Proof:* the kernel of `S₂ → S₁` is `\{1+p·i·c : c ∈ 𝔽_p\}`, a line, so the lifts of each `s̄ ∈ S₁` form a line of direction
`i·s̄` in the fibre; writing coordinates `(ν_j,τ_j)` on the quotient `Λ_σ = R[i]/L_σ ≅ ℤ/p² × ℤ/p` for each direction class
`σ`, `u ~ v` iff their images in some `Λ_σ` differ by `±s_σ`. `plans/FS66-residue-tower-drop.md` §S1; the underlying
mechanism is also stated independently in `data/fs66/owner/note-2026-09-20-fibre-density.md` §5. **Checked exhaustively**
(`fs66_owner_biclique.py`): 32 level-one edges at 7 and 48 at 11, 0 failures. **Consequence, exploited**: at 11 the
966,306 edges are `726 × 11 = 7,986` bicliques `K_{11,11}`, giving a SAT encoding with one *line variable* per (fibre,
direction, line, colour) and one conflict clause per biclique-and-colour instead of `p²`: at `(11,4)`, 90,508 variables and
397,972 clauses against the plain encoding's 3.9 million (a tenfold reduction; `data/fs66/owner/note-2026-09-20-fibre-density.md`
§5). *Proof verdict:* closes. *Rests on it:* row 75's independent replication of the level-two `(11,4)` refusal (0.97 s
pinned, 56 s unpinned, agreeing with the planner's plain-encoding 1.7 s); FS66-T6 (the resolution-refutation projection,
which uses this encoding's clause structure); `data/fs66/README.md`'s account of the kernel-checked 883-point witness, which
uses the plain (not biclique) encoding — the biclique encoder is a *corroboration and speed instrument*, not the kernel
route. *Prior art:* ours — a Cayley-graph-specific complete-bipartite decomposition tied to the arithmetic of the reduction
map `S_k → S_{k-1}`; not found under the finite-geometry or SAT-encoding literatures. zbMATH: `ab:"complete bipartite" &
ab:"decomposition" & ab:"Cayley graph" & ab:"finite field"` (0 hits), `ab:"SAT encoding" & ab:"biclique" & ab:"symmetry
reduction"` (0 hits). *Kernel:* declined — an encoding-speed instrument with no separate kernel consumer (row 75's kernel
theorem uses the plain encoding).

**FS66-T6 — A resolution refutation of level two projects onto level one, so level `k+1`'s shortest refutation is at least as long as level `k`'s. [hand; the product owner]** Substituting `c[v,a] ↦ c[x(v),a]` (the level-one colour variable
of `v`'s image) and every line variable `z[x,·,·,a] ↦ c[x,a]` sends every clause of level two's biclique CNF (FS66-T5) to
either a clause of level one's CNF or a tautology — at-least-one clauses to at-least-one clauses, edge/biclique clauses to
level-one edge clauses, implications to tautologies. **Consequently a resolution refutation of level two, read through this
substitution, gives a resolution refutation of level one of no greater length — so if level one has no short refutation,
level two does not either.** *Proof:* `plans/FS66-residue-tower-drop.md` §S6 (second bullet); the same statement, in the
same words, is independently recorded in `data/fs66/owner/note-2026-09-20-fibre-density.md` §5's closing paragraph.
**Consequence stated in row 75**: since CDCL never decided `(23,5)` at level one (G56: undecided at four hours of wall
time), `UD(ℤ/529,2)` at five colours "cannot be refused by CDCL unless level one is first" — the all-levels inequality
(FS66-L2/L6) is the only refusal-side instrument in sight there, which is exactly why row 75's ceiling at 23 comes from the
certificate and not from a direct SAT ask. Measured consistency at 11: 1,535 conflicts at level two, 12,311 at level three —
growing, not shrinking, as the projection predicts it must not shrink below level one's own (unmeasured at level one
directly in this data, but the qualitative direction matches). *Proof verdict:* closes. *Rests on it:* the milestone's own
explanation for why FS-53/FS-56's level-3 semidefinite certificate — not CDCL — is what refuses five colours at 23
(row 71); the decision (`plans/FS66-residue-tower-drop.md` §Q) to make Phase 2's `B₁` certificate, not a larger SAT ask, the
route to `(23,5)`. *Prior art:* ours — a resolution-proof-complexity observation specific to the tower's homomorphism
structure (a substitution lemma for a graph-colouring CNF under a graph homomorphism); the general fact that a formula's
refutation complexity can only grow under a homomorphic image (proof complexity's usual direction is the reverse — pulling a
*hard* instance's structure *up*) was not matched to any held or found paper. zbMATH: `ab:"resolution refutation" &
ab:"covering graph"` (0 hits), `ab:"proof complexity" & ab:"graph homomorphism" & ab:"lift"` (0 hits). *Kernel:* declined
— an explanatory/aiming observation, not itself consumed by a kernel theorem (row 75's kernel result is the level-two
witness itself, found independently of this projection argument).

**FS66-T7 — The Borel lower bound, answering Bardestani–Mallahi-Karai's Question 1 no. [hand; the product owner, read
first-hand against the held paper]** For every prime `p ≡ 3 (mod 4)`: `χ_Bor(QG_{ℚ_p}) ≥ 1 + (p+1)/(2√p) > √p/2`. Since
this is unbounded in `p`, **no universal constant `B` bounds the Borel chromatic number of the anisotropic `p`-adic plane
over every `p ≡ 3 (mod 4)`** — `[BardestaniMallahiKarai2017]`'s Question 1 (arXiv:1507.05300 v4, p. 2, quoted verbatim in
the source) is answered **no**. *Proof:* let `S = \{a²+b²=1\} ⊂ ℤ_p²` (compact, symmetric, Borel, `0 ∉ S̄` since `p ≡ 3 mod 4`
is anisotropic) and `μ` the Haar probability measure of the compact group `S`; `[BardestaniMallahiKarai2017]`'s Theorem
2.5 (credited there to Bachoc–DeCorte–de Oliveira Filho–Vallentin, quoted p. 5) gives `1 - sup μ̂/inf μ̂ ≤ χ_Bor(Cay(ℚ_p²,S))`.
Reduction `S → S_k` is onto (Hensel), so Haar pushes forward to uniform and for `u` of exact level `k`,
`μ̂(u) = λ_{p^k u}(G_k)/|S_k|`; `sup μ̂ = μ̂(0) = 1`; at level one `|λ_min(G₁)| ≤ 2√p` (Weil, Kloosterman sums, already held,
G44), and at level `k ≥ 2` the same elementary fibre argument as FS66-L1 gives `|μ̂(u)| ≤ 2/(p+1)` — so
`inf μ̂ ≥ -max(2√p,2)/(p+1)`, and the bound follows. `data/fs66/owner/note-2026-09-20-fibre-density.md` §7 (in full, "read
first-hand" from the held PDF, `~/source/library/pdf/arXiv-1507.05300-…`); the same statement is also recorded in
`plans/FS66-residue-tower-drop.md` §S3, there flagged "for the owner to check; NOT claimed" and closed by this proof.
**Note:** this argument does not need `[MMST1998]`, unlike an earlier version of the same conclusion drafted in
`plans/FS66-residue-tower-drop.md` §S3, which did cite it — the elementary Hensel-count bound (FS66-L1's proof, `c = 2`) is
enough. *Proof verdict:* closes. *Rests on it:* row 75's "Consequences" clause: `χ_Bor(ℚ_p²) = 4, 5, 5` at 7, 11, 19 (the
matching upper bound `χ_Bor ≤ χ(UD(𝔽_p,2))` via a pulled-back clopen colouring, FS66-T8); `CLOSED-QUESTIONS.md` §1.8; the
Weil bound at level one, already held (G44, `[MMST1996]`). *Prior art:* `[BardestaniMallahiKarai2017]` poses the question and
proves only `O(p²)` from above (their own paper, not this lower bound); Theorem 2.5 is theirs, credited by them to
Bachoc–DeCorte–de Oliveira Filho–Vallentin; the anisotropy check, the fibre-argument bound on `μ̂` at level `≥ 2`, and the
conclusion (Question 1 answered no) are ours. **Re-checked against the literature** (`data/fs66/owner/note-2026-09-20-fibre-density.md`
§8, zbMATH, 2026-09-21): complete author listings of Mallahi-Karai (31 entries) and Bardestani (14) after 2017 never return
to the anisotropic `p`-adic plane; `ab:"Borel chromatic number"` (31, descriptive set theory throughout); `ab:"chromatic
number" & ab:"p-adic"` (3: their two known papers plus Kang–Maharaj 2010, a different object by title, distance graphs on
the integers under a `p`-adic norm — listing only, owed a bibliography row); `ti:"Hadwiger-Nelson" & py:2015-2026` (8,
nothing `p`-adic beyond Madore and BMK). **No exact value or lower bound for the Borel or plain chromatic number of an
anisotropic `p`-adic plane was found anywhere.** *Kernel:* declined — a measure-theoretic argument over a compact group, no
kernel consumer named; `CLOSED-QUESTIONS.md`'s entry is the intended publication form, not a Lean theorem.

**FS66-T8 — The tower's limit is the clopen chromatic number of `ℤ_p²`, and the supremum of a measurable independent set's Haar measure is the tower's independence-ratio limit. [hand + partly prior art; the product owner]**
`χ(F²) ≤ χ(ℚ_p²) = χ(ℤ_p²) ≤ χ_Bor(ℤ_p²) ≤ χ_clopen(ℤ_p²) = lim_k χ(G_k) ≤ χ(G₁)` for `F ⊂ ℚ_p`, `p ≡ 3 (mod 4)`; and
`sup\{`Haar measure of a measurable independent set of `ℤ_p²\} = lim_k α(G_k)/p^{2k}`. *Proof:* a finite clopen colouring of
the compact group `ℤ_p²` is constant mod `p^k` for some `k`, and every edge of `G_k` lifts to an edge of the `p`-adic graph
(Hensel), so a clopen colouring is exactly a proper colouring of some `G_k` — giving `χ_clopen = lim_k χ(G_k)`, and
monotonicity gives the inequality chain (the equality `χ(ℚ_p²) = χ(ℤ_p²)` is unit vectors being integral, so components are
cosets of `ℤ_p²`). For the measure statement: if `I ⊆ ℤ_p²` is measurable and independent, the cosets of `p^kℤ_p²` that `I`
more than half fills form an independent set of `G_k` (two adjacent such cosets would give, by Fubini over the lifts of the
connecting unit vector, an edge inside `I`), and by Lebesgue density their share tends to `I`'s measure; conversely
independent sets of `G_k` pull back to measurable independent subsets of `ℤ_p²`. `plans/FS66-residue-tower-drop.md` §S2, in
full. *Proof verdict:* closes. *Rests on it:* row 75's "clopen chromatic number of `ℤ₁₁²` is 5" and Haar-measure-bracket
clauses (`data/fs66/b1/SOUNDNESS.md` §8); FS66-T7 (the Borel bound uses the clopen-pulled-back upper half of this chain);
FS66-T1's `m₁(ℤ_p²)` notation, which is exactly this supremum. *Prior art:* **partly** — the chain's first equality and the
general shape are `[Madore2015]` (his Prop. 3.2 is cited in `plans/FS66-residue-tower-drop.md` §S2 for "unit vectors are
integral, so components are cosets of `ℤ_p²`"; row 75 cites his Prop. 3.8 for the chain as a whole — **a discrepancy between
the two sources not resolved by this audit**, flagged rather than silently picked); the measure-density (Lebesgue) half of
the argument is ours, elementary, not separately attributed by either source. zbMATH: `ab:"Haar measure" & ab:"independent
set" & ab:"local field"` (0 hits, fresh); the clopen/measurable-density literature more broadly is `[ConleyKechris2013]`,
`[Bernshteyn2022]` (recalled, not re-read, per the milestone's own gate). *Kernel:* declined — the plain link
(`χ(F²) ≤ χ(ℚ_p²)`) can be strict for the reason G45 gives (a finite subgraph extends to `ℤ_p` only if it is a shadow), so
this chain is not itself the kernel-worthy statement; no consumer named beyond the reading clauses above.

**FS66-T9 — The bare `B₁`-exceeds-`α` lemma: a maximum independent set that does not 2-dominate its complement is beaten by a fractional point. [hand; the FS-66 prover (Fable 5.1 planner-mathematician)]** Let `G` be a graph, `q(φ) = 2Σφ(1-φ) -
⟨φ,Aφ⟩` (the bare form, constant `c = 2`), `J` a maximum independent set (size `α`) with an outside vertex `v` having
exactly one neighbour in `J`. Then `φ = t·1_{J∪\{v\}}`, `t = (α+1)/(α+2)`, satisfies `q(φ) ≥ 0` and `Σφ = α + 1/(α+2) > α`.
**Consequently, `B₁(G) = α(G)` (the bare form) requires every maximum independent set of `G` to 2-dominate its complement**
(every outside vertex has `≥ 2` neighbours in it). *Proof:* `⟨φ,Aφ⟩ = 2t²` (the single edge `(v, J`'s neighbour of `v`)`)`,
`Σφ(1-φ) = t(1-t)(α+1)`; `q(φ) ≥ 0` reduces to `2t² ≤ 2t(1-t)(α+1)`, i.e. `t ≤ (α+1)/(α+2)`, saturated at the stated `t`.
`plans/FS66-tower-conjecture.md` §3.3 (in full, `[proved]`). *Proof verdict:* closes. *Proof and application:* at 7 the
production certificate proves the required 2-domination (`14.0152 < 14 + 1/16`); at 11 it does not decide it
(`28.2043 > 28 + 1/30`, the only evidence for a 2-dominating maximum set there being a local search reading 28.0000
— "a plane with three far-apart triangles beside a 24-set would have bare `B₁ > α`," noted as the mechanism of the near-tie
found at 11, `data/fs66/owner/note-2026-09-20-fibre-density.md` §6). *Rests on it:* the milestone's explanation of why the
registered quantity is `B₁` *with* the edge and triangle cuts, never the bare form, and why 11's bare optimum being a tie is
"a coincidence" rather than a theorem (§3.3, second bullet); row 75's certificates, all of which use the cut form. *Prior art:* ours — an elementary two-line graph fact (a fractional point beating a maximum independent set exactly when some
outside vertex has exactly one neighbour in it, under this specific `q`), not a named theorem of extremal graph theory
searched or found in this form. zbMATH: `ab:"maximum independent set" & ab:"2-dominating" & ab:"fractional"` (0 hits),
`ab:"stability number" & ab:"quadratic program" & ab:"local maximum"` (0 hits). *Kernel:* declined — an explanatory lemma
for why the bare relaxation is not the registered one; no separate consumer.

## Readings and measurements that were called theorems

- **"The tower never rises": `α(G_k) = p^{2(k-1)}α(G₁)` for every `p` and `k`.** Explicitly **not** claimed as a theorem
  anywhere in the sources (`plans/FS66-tower-conjecture.md` §0: "NOT PROVED — and the run at 23 should be left to finish");
  it is the reading FS-68 (`plans/STUB-tower-never-rises.md`) exists to test. Not filed to § B, per the brief's explicit
  instruction and the milestone's own verdict.
- **The bracket-with-cuts `B₁(p) = α(G₁)` (per prime, numerically).** `plans/FS66-residue-tower-drop.md` §S5: "if `B₁(p) =
  α(G₁)` were a theorem, the independence ratio... would be constant up the whole tower. **It is not a theorem about graphs
  in general**." Explicitly a numerical/local-search finding (`fuzzy-*.out`), not a proof, scored separately in row 75 and
  §1.4's table as "level two only" at 7, "open" at 11, 19, 23. Not filed.
- **`c(p) = -λ_min(depth 2)/p < 2` at each prime** (`data/fs66/owner/note-2026-09-20-fibre-density.md` §1). A sharper,
  per-prime constant than FS66-L1's uniform `2`, checked by FFT rather than proved as a uniform bound across primes; used
  only as a tighter *numerical* instrument (the registered `B₁` certificates use the sharper `c` where measured and the
  uniform `2` where the certificate format needed a round number, per the note's own account) — not filed as a separate
  general theorem, since the general statement it would need ("the sharper bound holds at every prime") rests on
  `[MMST1998]`'s spectrum results, already attributed at row 75 and not independently re-verified beyond the FFT checks
  named in FS66-L1.
- **Route (d), the exact face at 7 (§3.5).** A by-hand proof attempt through the seven columns of the circular-clique
  homomorphism was tried and explicitly reported as failing ("dies because the cyclic sum of the column inequalities has
  slack `3N` at the extremal configuration — the constraints... must be combined non-linearly, and I did not find how").
  Not a theorem; recorded here so it is not silently re-attempted as one. The homomorphism `(x,y) ↦ 2x+3y` onto `K_{7/2}`
  itself is verified by hand (checked, not filed separately — a five-line computation with no further consequence beyond
  aiming route (d), which failed).
- **Route (c)'s three failing examples** (`ℤ[ζ_{p+1}]`, `ℤ[√D]` with `D` a non-residue, `ℤ[(1+√5)/2]`) — each shown, by a
  short computation, to be undercut by another place. A worked catalogue of negative instances, not a general theorem (the
  milestone explicitly frames the positive content as "a witness must live in an order all of whose other stable places have
  `χ_f ≥ p²/α₁(p)`" — a necessary condition stated in prose, not filed as FS66-Tn since it is definitional, restating what a
  witness would need rather than proving anything about whether one exists).

## Conjectures surfaced, not claimed

- **(C-α), (C-χ), (C-m) — "the tower never rises."** The milestone's central object. Not proved at 23 or beyond; proved as
  theorems (not conjectures) at every prime `p ≡ 3 (mod 4)` below 23 by three separate mechanisms (Hoffman tightness at 3;
  the finite 7-adic witness at 7; the `B₁` certificates at 7, 11, 19 — row 75's own table, §1.4). The open case is exactly
  stub FS-68.
- **The twist-blind reading**, `α(G₂^γ) = p²α₁` for every twist `γ` and every `p`. `[reading]`, FS66-T's consequence, killing
  test: a verified independent set of 3,389 points in a twisted cover at 11 (not run).
- **`χ_f(ℚ(√11)²) = 7/2`.** `[reading]`, the milestone's own cheapest proposed killing test of route (c) at 7 — a weighted
  independence-ratio bound on FS-61's saturated `ℚ(√11)` lattice pieces (not run; stub FS-68 §3 item 2).

## Prior art re-attributed

None beyond what is noted per-entry above (FS66-L1's crude bound versus `[MMST1998]`'s sharper one, already correctly
distinguished in the sources; FS66-T7's Question 1 credit, already correctly attributed to `[BardestaniMallahiKarai2017]` in
the sources). No edit to `BIBLIOGRAPHY.md` is proposed for a re-attribution; one new listing-only entry is proposed for
Kang–Maharaj (`data/fs71/batch-6e.md`).

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| FS66-L1 – FS66-L6 | declined — the milestone's own choice: a standalone standard-library checker (`tools/fs66_b1_cert_check.py`) replaces the kernel here; not priced |
| FS66-W | **priced** — "a finite family of `decide`s plus a general lemma. Hours" (`plans/STUB-tower-never-rises.md` §3.5) |
| FS66-E | **priced** — "a two-line `unitQuadrance.map` argument" (same stub) |
| FS66-T | declined — no consumer beyond FS-68's killing test |
| FS66-T1, FS66-T2 | declined — measure-theoretic / pigeonhole facts, no finite kernel consumer |
| FS66-T3 | declined — belongs to a route explicitly reported dead |
| FS66-T4 | declined — a negative result; its citation is check-owed |
| FS66-T5, FS66-T6 | declined — encoding/aiming instruments, not consumed by the kernel result (which uses the plain encoding) |
| FS66-T7 | declined — a `CLOSED-QUESTIONS.md`-shaped consequence, not a Lean theorem |
| FS66-T8 | declined — the plain link can be strict (G45); no kernel-shaped consumer |
| FS66-T9 | declined — an explanatory lemma for the choice of registered quantity |
