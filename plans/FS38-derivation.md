# FS-38 phase D — the derivation day (2026-09-13; de Bruijn; advisor Poros, `a528bc45003173bad`)

*One section per question of `plans/FS38-residue-tower.md` §S5, in its order, each closing with exactly one of
"**Derived:** …" or "**Not derived, stalls at:** …". Units are §S1's (depth = v_𝔓; 𝔓² = (2); a difference of
depth ≥ m is the zero of level m). Every computation named below is a control on a derivation or the way a
statement was found, never a substitute for one; each is marked. Scratch: `build/fs38-d/` (gitignored), file
names in § Inventory. Kernel-checked facts are cited by module; measured ones by record; hand steps are marked
"elementary, proved here".*

**Status line (2026-09-13, closed).** D-1 derived at level 2 and censused at 3–4; **D-2 derived for every level
m ≥ 5** (the whole tower is 𝔓⁴-periodic, its colouring space is finite); D-3 derived in its correct form (Hoffman
tightness, not gap-freedom, is what propagates — both ways); D-4 answered no on two solver engines with three
controls, its maximum-count refinement stalled. **Stated in the shape the advisor's card 2 asks for: the tower
stabilises at level 4** — `P₄` is pairwise free (**kernel**, `Instances/TwoAdicFour.lean`, the table cover), the
top fibre of `P₅` is forced, exactly the kernel of the level map (**kernel**, `Instances/TwoAdicFive.lean`, a
125-vertex core of the LRAT replayed by the kernel; §R2.3 of the plan), and **every level above 5 is pulled back
from `P₄` by Theorem D2-B (derived, this file)**, with the records at levels 6–9 as consistency checks rather than
as a per-level law. The kernel's level-5 statement is Theorem D2-B's instance at m = 5, so the derivation's own
first case is kernel-checked and its work begins at m = 6. The theorem of the day:

> **Every 4-colouring of P_m, m ≥ 5, is constant on 𝔓⁴-cosets, because every colour class is a maximum
> independent set attaining Hoffman's ratio bound, and the least-eigenvalue characters of P_m are, from level 5
> on, exactly the 45 characters of level 4 pulled back — a consequence of one arithmetic fact, that the
> differences of norm-one units ≡ 1 (mod 𝔓) span a lattice containing 𝔓⁴ and not 𝔓³.** (A character that sees
> the newest layer sums to at most `2^{m−1}` in absolute value — **a third of the degree `d = 3·2^{m−1}`**, which
> is exactly the value `λ_min = −d/3` — and reaches it only by being trivial on that lattice.)
## The theorems (FS-71 index)

*Added 2026-09-23 by the FS-71 batch-5b implementer, per the theorem-tracking rule (Kooshi, 2026-09-22): FS-38's
narrative below already names and proves its own theorems (D-1–D-4, Theorems D2-A/D2-B, Lemmas 1–3), so this file is
**completed in place**, not rewritten — the narrative is untouched and every entry's `*Proof:*` field points into the
section below it. Ids are the narrative's own names, prefixed. Row 66 (`CLAUDE.md`/`LEDGER.md`) is kernel throughout
and files nothing here; the one hand step it names — the field-level step of M58/M60 that a number field's
conjugation-fixed prime supplies a valuation subring with residue field of size `N(𝔭)` — is row 57's gap, already
filed as a conjecture under `plans/R57-derivation.md`, pointing at stub FS-47; not re-filed here. D-4's uniform-gap
question is open and is filed below as a conjecture, never as a theorem.*

**FS38-D1 — the period-set structure at levels 2–4. [hand + tools; de Bruijn, FS-38 phase D]**

At level 2 (`P₂ = K₄ □ K₄`, the isomorphism `x + εy ↦ (y, y − x)`), every proper 4-colouring is periodic under a
nonzero element `δ = δx + εδy` with `δy ≠ 0`: order 4 for the 144 of 576 colourings whose row set is `V₄` (`δ` the
graph of an additive automorphism of `𝔽₄`), order 2 for the 432 whose row set is a cyclic group of order 4 (`δ` a
single nonzero element) — proved from the classification of sharply transitive sets of `S₄` containing the identity
(`V₄` or one of three cyclic groups of order 4). [tools, complete finite enumeration] At levels 3 and 4 the period
structure is a complete census (4,896 colourings at level 3, period-group orders `4·3456 + 8·1152 + 16·288`; 1,179,936
at level 4, orders `8·1154304 + 16·23616 + 32·1728 + 64·288`): every colouring has a period in each fixed `μ₃`-triple
`2x·{1,ω,ω²}` (`x` ranging over five triples at level 4), no single element and no two of a triple are unavoidable,
and the norm-one classes of `x` obey the `μ₃`-triple law while the others (`x ≡ 1 + πω, 1 + πω²` mod `𝔓²`) have
counterexamples (2 of 5 triples at level 4, 8 of 21 at level 5).

*Proof:* `plans/FS38-derivation.md` §D-1 ("Level 2 by hand"; the census via `periods.py`, `enum4.py`, `lawL.py`). *Proof verdict:* closes.

*Rests on it:* explanatory background for §D-2(d)'s account of the 45-minimiser stabilisation at level 4; not
consumed by any later theorem in this file or elsewhere.

*Prior art:* ours — searched (the level-2 Latin-square / sharply-transitive argument, and the period-census of a
small Cayley tower) — nearest held: none specific; zbMATH: `ab:"Latin square" & ab:"sharply transitive" & ab:"regular
subgroup"` (0 hits), `ab:"period" & ab:"colouring" & ab:"finite abelian group" & ab:"census"` (0 hits).

*Kernel:* declined — a complete finite census not consumed by any kernel theorem (Theorem D2-B supersedes it as the
operative fact from level 5 up); not pursued.

**FS38-D2-A — Hoffman-tight Cayley graphs force balanced, gap-free, `H_min`-periodic colourings. [hand; de Bruijn, FS-38 phase D]**

Let `Γ = Cay(G,S)` be a `d`-regular Cayley graph on a finite abelian group `G` (`S = −S`, `0 ∉ S`) with least
eigenvalue `λ_min`. Call `Γ` **k-tight** if `λ_min = −d/(k−1)` (Hoffman's ratio bound `α ≤ n(−λ_min)/(d−λ_min)` holds
with equality). If `Γ` is k-tight, every proper `k`-colouring `C` satisfies: (i) every colour class has exactly `n/k`
elements, attaining the ratio bound; (ii) every colour class's indicator lies in `span(1, E_min)` (`E_min` the least
eigenspace); (iii) with `H_min := ⋂{ker χ : λ_χ = λ_min}` over the characters of `G`, `C` is `H_min`-periodic —
`Forces (addCayley S) k 0 h` for every `h ∈ H_min`; (iv) `C` has no fan gap.

*Proof:* `plans/FS38-derivation.md` §D-2(a), the six-line argument from the ratio bound's equality case (write `1_A =
(a/n)·1 + z`, expand `xᵀMx = 0` against `λ_min‖z‖²`) plus Fourier inversion on a finite abelian group.
*Proof verdict:* closes.

*Rests on it:* `LEDGER.md` row 67's "Derived" clause; FS38-D2-B (the 2-adic instance); FS38-D3 (the general
classifier and its propagation); stubs FS-41 (`forces_of_tight`) and FS-42 (5-tight quotients), both minted from this
theorem at the FS-38 close.

*Prior art:* **partly — the split the brief asks for**: (i) and (iv), the balance and gap-freedom of an extremal
Hoffman colouring, are Blokhuis–Brouwer–Haemers 2007 Prop. 2.3, cited through `[AbiadEtAl2025]` Prop. 2.1 ("the color
classes have equal size and every vertex is adjacent to exactly `−λ_min(G)` vertices of every colour other than its
own"), which also names the object — a graph meeting the ratio bound is **Hoffman colorable**, its optimal colourings
**Hoffman colorings**; the ratio bound itself is unpublished by Hoffman (`[Haemers2021]` §3: `[Hoffman1970]` is "the
wrong reference" for it, traced instead to a c. 1974 conversation with Seidel about `[Delsarte1973]`'s
strongly-regular clique bound; `[Lovasz1979]` Thm 9 implies it). **(ii)–(iii), the Fourier periodicity of a Hoffman
colouring under `H_min` on an abelian Cayley graph, are ours** — searched at the FS-38 close
(`plans/FS38-residue-tower.md` §PA: "ratio bound equality Cayley graph cosets characters", "Hoffman coloring Cayley
graph abelian characters kernel", "chromatic number Cayley graph local ring Hoffman tight" — nothing found beyond the
uniquely-colourable-graph line, `[KlotzSander2017]`, `[Basic2026]`) and re-searched here — nearest held
`[AbiadEtAl2025]`; zbMATH: `ab:"Hoffman colorable" & ab:"periodic"` (0 hits), `ab:"least eigenspace" & ab:"coloring" &
ab:"abelian group"` (2 hits, both irrelevant — link-diagram and HNN-extension colourings).

*Kernel:* **stub** (FS-41, `plans/STUB-forces-of-tight.md`: `forces_of_tight`, `not_fanGap_of_tight`,
`colorable_balanced_of_tight`).

**FS38-D2-B — the 2-adic tower's 4-colourings are pulled back from level 4, for every m ≥ 5. [hand; de Bruijn, FS-38 phase D]**

Let `P_m := twoAdicPlane m`, the record's ring-free `addCayley` representation of `Cay(O/𝔓^m, S_m)` (`O = ℤ₂[ω][√3]`,
`𝔓² = (2)`; **that `twoAdicPlane m` IS `Cay(O/𝔓^m, S_m)` is [hand], three independent constructions agreeing** — the
record's own, an independent ring-axiom build (`build/fs38-d/tower.py`, §0), and T's closed-form circle lists,
matching at levels 4 and 5). `P_m` is 4-tight at every level `m ≥ 1` (FS38-L1 + `P₁ = K₄`), with exactly 45 minimising
characters at level 4 whose common kernel is trivial (a finite `decide`: sums of 24 fourth roots of unity). For every
`m ≥ 5`: a character of `O/𝔓^m` is either primitive with `|λ| < 2^{m−1}` (FS38-L2–L3) or a pullback of a level-`(m−1)`
character with eigenvalue `2λ' ≥ −2^{m−1}`, equality iff the level-`(m−1)` character minimises; hence `λ_min(P_m) =
−2^{m−1}` and the minimisers of `P_m` are exactly the pullbacks of the 45 minimisers of `P₄`, so `H_min(P_m) =
𝔓⁴/𝔓^m`. By FS38-D2-A(iii): **every 4-colouring of `P_m` is `𝔓⁴`-periodic**, `Forces (twoAdicPlane m) 4 x y ↔ x − y ∈
𝔓⁴` and `Separated (twoAdicPlane m) 4 x y ↔ y − x ∈ S_m + 𝔓⁴`, for every `m ≥ 5`; the tower's colouring space is
exactly `P₄`'s (1,179,936 colourings); the forcing lives in no natural proper subgroup (18 sub-Cayley graphs of `P₅`
down to index 2 are all free at `(0,4)`, verified colourings) and is an extremal property of the whole Cayley graph,
transferring freeness only to any finite chunk that maps into it — never forcing.

*Proof:* `plans/FS38-derivation.md` §D-2(c) (Theorem D2-B and its induction) and corollaries (1)–(6).
*Proof verdict:* closes.

*Rests on it:* `LEDGER.md` row 67 in full; the m = 4, 5 base cases are already **kernel** independently
(`twoAdicFour_forces_iff`, `twoAdicFive_forces_iff` — `Instances/TwoAdicFour.lean`, `Instances/TwoAdicFive.lean`), so
this theorem's own first two instances were kernel-checked before the hand proof of the general case existed; stub
FS-42 (5-tight quotients) cites row 67 directly; row 66's `not_forces_of_fanGap`-style consumers at other primes are a
different mechanism (slack, not tight) and do not rest on this theorem.

*Prior art:* ours — the tower's spectra alone are prior art in listing/read form (`[MMST1998]`, read in full
2026-09-16: Thms 2.1, 2.3, 2.9 give the degree and the inherited eigenvalues of an inert tower over `ℤ/p^r` for
**odd** primes `p`, nothing for `p = 2` and no colouring value for any level); the propagation to a forced-set
characterisation, the colouring-space finiteness, and the extremality transfer are not found — nearest held
`[MMST1998]`; zbMATH: `ab:"eigenvalue" & ab:"tower" & ab:"chromatic number"` (0 hits), `ti:"period" & ti:"colouring" &
ab:"Cayley graph" & ab:"quotient"` (0 hits); positive control on the search mechanics: `ti:"finite Euclidean graphs
over rings"` returns exactly `[MMST1998]` (1 hit).

*Kernel:* **stub** (FS-41; the base cases m = 4, 5 are independently kernel already — see "Rests on it" — and the
general induction over FS38-L1–L3 plus FS38-D2-A is the theorem `forces_of_tight`'s consumer, not separately stubbed).

**FS38-L1 — tightness (and slackness) propagate up a level map with onto, constant-size fibres. [hand; de Bruijn, FS-38 phase D]**

If `S_{m+1} → S_m` is onto with fibres of size two, a character `χ` of `O/𝔓^m` pulled back to level `m+1` has
eigenvalue `2λ_χ`, and `d_{m+1} = 2d_m`. So if `P_m` is 4-tight, `λ_min(P_{m+1}) ≤ 2λ_min(P_m) = −d_{m+1}/3`; since
`P_{m+1}` is 4-colourable (pull back any colouring of `P_m`), Hoffman's bound gives `≥`, so `P_{m+1}` is 4-tight. With
`P₁ = K₄` 4-tight (`λ_min = −1 = −3/3`), **every level `m ≥ 1` is 4-tight, balanced, gap-free, with no solver.** The
same one-line computation shows `λ_min/d` is non-increasing under pullback, so **slackness propagates up too**: a
tower whose level one is slack is slack at every level.

*Proof:* `plans/FS38-derivation.md` §D-2(c) Lemma 1. *Proof verdict:* closes.

*Rests on it:* FS38-D2-B's induction; FS38-D3's general-tower restatement of the same argument (the hypothesis
"surjective level maps, constant fibre size" generalised off the 2-adic case); `LEDGER.md` row 67's "tightness and
slackness both propagate up a tower".

*Prior art:* ours — searched at the FS-38 close ("nothing on tightness propagating up a tower of quotients `O/𝔓^m`",
`plans/FS38-residue-tower.md` §PA) and re-searched here — nearest held `[MMST1998]` (the spectra of the tower, not the
propagation argument); zbMATH: `ab:"tight" & ab:"eigenvalue" & ab:"periodic coloring"` (0 hits), `ab:"chromatic
number" & ab:"local ring" & ab:"Cayley graph"` (0 hits).

*Kernel:* with FS38-D2-A's stub (FS-41) — the pulled-back-eigenvalue computation is a short character-sum lemma over
`AddChar`, not separately stubbed.

**FS38-L2 — the primitive-character bound. [hand; de Bruijn, FS-38 phase D]**

For `m ≥ 2` and `χ` a character of `O/𝔓^m` nontrivial on the top fibre `𝔓^{m−1}/𝔓^m ≅ 𝔽₄`: pairing the two lifts `s₀,
s₀(1 + π^{m−1})` of each `s̄ ∈ S_{m−1}` gives `λ_χ = 2·Σ{χ(s₀) : s̄ ≡ a₀ (mod 𝔓)}` for the unique `a₀ ∈ 𝔽₄` with
`ψ(a₀) = 1` (`ψ(t) := χ(π^{m−1}t)`, a nontrivial character of `(𝔽₄,+)`), a sum of `2^{m−2}` roots of unity, so `|λ_χ|
≤ 2^{m−1}`, **with equality only if `χ` is trivial on `a₀·M_m`** (`M_m := ⟨t − 1 : t ∈ S_m^{(1)}⟩`, the norm-one units
of `O/𝔓^m` congruent to 1 mod `𝔓`). If `M_m ⊇ 𝔓^{m−1}/𝔓^m`, equality forces `χ` trivial on `𝔓^{m−1}` — a
contradiction; **so every primitive character has `|λ_χ| < 2^{m−1}`, given that hypothesis on `M_m`** (supplied by
FS38-L3 for `m ≥ 5`).

*Proof:* `plans/FS38-derivation.md` §D-2(c) Lemma 2. *Proof verdict:* closes.

*Rests on it:* FS38-D2-B's induction (the "primitive, hence strictly smaller" branch); consumes FS38-L3's `M_m ⊇
𝔓^{m−1}/𝔓^m` for `m ≥ 5`.

*Prior art:* ours — a character-sum bound tied to the specific unit-vector-generated subgroup `M_m`, sharper than
and different in kind from the uniform Weil/Kloosterman bound (`[MMST1998]`, `[Weil1948]`: every character bounded by
`2√Q` uniformly) — this bound is conditional on `M_m`'s size and is what makes the *exact* stabilisation at level 4
provable rather than merely asymptotically bounded — nearest held `[MMST1998]`; zbMATH: `ab:"primitive character" &
ab:"local ring" & ab:"eigenvalue bound"` (0 hits), `ab:"norm one units" & ab:"additive subgroup"` (0 hits).

*Kernel:* declined — a finite-ring character-sum computation specific to this tower; not separately worth a stub (the
general theorem `forces_of_tight`, FS-41, does not need this instance; only the 2-adic application, FS38-D2-B, does,
and that application is priced together, not separately).

**FS38-L3 — the elementary-divisor certificate: `𝔓⁴ ⊆ M` and `𝔓³ ⊄ M`. [hand + tools; de Bruijn, FS-38 phase D; re-verified on a second code path on the advisor Poros's audit ask]**

Let `U₁` be the norm-one units of `O` congruent to 1 mod `𝔓`, `M := ℤ₂-span{t − 1 : t ∈ U₁}`. The image of `M` in
`O/𝔓^m` is contained in `M_m` (FS38-L2's subgroup) for every `m` (only this direction is used or claimed — no
surjectivity of `U₁ → S_m^{(1)}`). [tools, exact integer arithmetic, independently re-verified on a second code path]
Four explicit elements `u ∈ ℤ[ω,√3]`, each `≡ 1 (mod 𝔓)` of odd rational norm, give vectors `t − 1` (`t = u/ū`) whose
ℤ-span has 2-adic elementary divisors `1, 2, 4, 4`; since `O ≅ ℤ₂⁴` in this basis and the rational norms are 2-adic
units, **`𝔓⁴ = 4O ⊆ M` and `2O = 𝔓² ⊄ M`** — sharp, and located: the second code path (built independently, without
clearing denominators) confirms `2π·O = 𝔓³ ⊄ M`, failing on the `ω` and `√3ω` directions and succeeding on `1` and
`√3`. Consequently `[O/𝔓^m : M_m] = 32` and **`M_m ⊇ 𝔓^{m−1}/𝔓^m` for `m = 5,6,7,8`, not for `m = 3,4`** (computed at
levels 4–8 on both code paths).

*Proof:* `plans/FS38-derivation.md` §D-2(c) Lemma 3 (the certificate) and the following paragraph, "Re-verified by a
second code path". *Proof verdict:* closes.

*Rests on it:* FS38-L2 (supplies the hypothesis FS38-L2 needs, at `m ≥ 5`); FS38-D2-B's induction — this
certificate is the reason the stabilisation happens at level 4 and not earlier, and everything for `m ≥ 9` rests on
this receipt alone (per the narrative's own scepticism note at the file's end) plus the level-4 spectrum.

*Prior art:* ours — an explicit elementary-divisor computation on the norm-one units of `ℤ₂[ω][√3]` congruent to 1
mod `𝔓`; not found. Distinct from `[Fischer1990b]`'s prime-inversion question (whether `1/p` lies in the unit-vector
ring `ℤ[U]` at all, G55) — this is a sharper, exact 2-adic-index question inside a ring already known to contain `1/2`
— nearest held: none specific; zbMATH: `ab:"Smith normal form" & ab:"norm one units"` (0 hits), `ab:"unit group" &
ab:"quotient" & ab:"norm one" & ab:"lattice"` (0 hits).

*Kernel:* priced — the narrative's own closing note: "a 4×4 determinant over `ℤ[ω, √3]`: kernel-able by
`decide`/`norm_num`"; not attempted; folds under FS-41's stub if FS38-D2-B's induction is pursued in full, not
separately stubbed.

**FS38-D3 — the tight/slack classifier propagates up a tower, and no usable prime above 3 is tight at any k ≤ 7. [derived, from FS38-L1 generalised + FS38-D2-A; de Bruijn, FS-38 phase D, with T and Poros on the Weil-cutoff closure]**

For a tower `Cay(G_m, S_m)` whose level maps `S_{m+1} → S_m` are onto with constant fibre size: k-tightness of level
one propagates to every level (FS38-L1's argument in general form), carrying with it gap-freedom and
`H_min`-periodicity of every k-colouring (FS38-D2-A); slackness propagates too. The sign of `λ_min + d/(k−1)` at level
one classifies the tower — zero is tight, negative is slack — and **this is the correct one-line form of `CLAUDE.md`
G54**: a residue plane seals a field's pair compulsions at k colours when it is slack (gap ⇒ free, kernel, row 66) and
forces them when it is tight (FS38-D2-A); "no gap at level one" is not the hypothesis that propagates ("gap-freedom
above level 2 is not inherited from level one by any local mechanism", since the clique number drops to 3 from level 3
on). [tools, exact character sums, `tightsweep.py`] Computed: tight at 2 (k=4, this file) and at 3 (k=3, the rhombus,
row 58); slack at 7 (k=4), 11, 19, 23 (k=5), 83 (k=6).

**No usable prime plane above 3** (`p ∈ {7,11,19,23,31,43,47,59,67,71,79,83,103,107}`, `p ≡ 3 mod 4`, `p ≤ 149`) **is
k-tight for any k ≤ 7** (closed by T and Poros, the same day, via the Weil cutoff): tightness at `k` needs
`(p+1)/(k−1) ≤ 2√p`, which holds only for `p ≤ 13, 31, 61, 97, 139` at `k = 3,4,5,6,7`, and over the committed table
`d/|λ_min|` is integral only at `p = 3` (exactly 2.000000), with `p = 31` the nearest miss at `k = 4` (margin
`+4.4·10⁻⁵`, the last prime the cutoff could have allowed) and `p = 23` next (`+0.0148` at `k=4`); two scope riders —
`k ≤ 7` only, and only the usable primes in the committed table.

[tools, exact, solver-free, two engines as a control only] **The 3-adic instance**: `Cay((ℤ/3^m)², {a²+b²=1})` at
three colours is 3-tight at levels 1–4 (`λ_min = −2,−6,−18` against `d = 4,12,36`, exactly `−d/2`), four minimising
characters throughout, `H_min = 3·(ℤ/3^m)²` from level 2 (confirmed to level 3 on an independent construction), so
**every 3-colouring of `UD(ℤ/9,2)` is 3-periodic** — a prediction met with no solver by FS38-D2-A's mechanism; the ℤ/9
asks were run only as a control on the corollary (all eight nonzero fibre differences refused at three colours on two
engines, CaDiCaL and Glucose, agreeing; the valuation-0 non-edge control free), never as its test.

*Proof:* `plans/FS38-derivation.md` §D-3 (the mis-posed-question correction and items 1–3) and the registered
predictions P-D2 and P-D5 (both closed the same day). *Proof verdict:* closes.

*Rests on it:* `CLAUDE.md` G54 (this is its correct restated form, per the narrative's own words); `LEDGER.md` row
67's "classifier" clause; stub FS-42 (5-tight quotients), whose own §2 cites P-D5 verbatim as the reason a tight
quotient of a 6-open plane is expected to be rare; FS70-T9 (a different milestone's application of the same
tight/slack mechanism to CM lattices over ℚ(√3,√5)) is a sibling instance, not a consumer.

*Prior art:* partly — the Weil/Kloosterman eigenvalue bound is classical (`[Weil1948]`, `[MMST1998]`); this file's
contribution is turning it into an exhaustive tightness sweep with exact margins (ours); the 3-adic tower's tightness
and `H_min` are ours, checked against no prior source; the classifier itself (tight ⇒ forced, slack ⇒ gap-permitted,
both propagate) restates FS38-D2-A/FS38-L1, already scored there — nearest held `[MMST1998]`, `[Weil1948]`; zbMATH:
`ab:"Kloosterman" & ab:"Hoffman bound" & ab:"tight"` (0 hits), `ab:"finite Euclidean graph" & ab:"chromatic"` (0 hits;
positive control on the API's mechanics, `ti:"finite Euclidean graphs over rings"`, returns exactly `[MMST1998]`, 1
hit, confirming the two zero-hit queries are genuine negatives and not a broken query).

*Kernel:* declined — the Weil-cutoff sweep and the 3-adic control are exact finite computations consumed as a reading
(G54), not currently the target of any stub; the general classifier's kernel form is FS-41/FS-42's territory (already
named under FS38-D2-A).

## Conjectures surfaced, not claimed (the FS-71 index)

- **D-4 — why 11 is slack: a uniformly gapped 5-colouring?** `plans/FS38-derivation.md` §D-4: whether the maximum
number of simultaneously gapped vertices in a 5-colouring of `UD(𝔽₁₁,2)` reaches all 121 — the strongest form of
slackness. **Not derived, stalls at:** the cardinality ask (121 selector variables) did not terminate in an hour on
either of two engines; the file's own words: "not needed for any theorem". Not a theorem; not filed to `LEDGER.md` §
B.

## Kernel decisions, summarised (the FS-71 index)

| theorem | decision |
|---|---|
| FS38-D2-A | **stub** (FS-41, `plans/STUB-forces-of-tight.md`) |
| FS38-D2-B | **stub** (FS-41); base cases m = 4, 5 already kernel independently (`Instances/TwoAdicFour.lean`, `Instances/TwoAdicFive.lean`) |
| FS38-L1 | with FS38-D2-A's stub (FS-41), not separately stubbed |
| FS38-L2 | declined — finite-ring character-sum computation, not separately worth a stub |
| FS38-L3 | priced — "kernel-able by `decide`/`norm_num`" (a 4×4 determinant); not attempted |
| FS38-D1 | declined — complete finite census, not consumed by any kernel theorem |
| FS38-D3 | declined — exact finite computations (G54's reading); kernel form is FS-41/FS-42's territory |

## 0. Inputs, verified before use (independent construction; a control, not the record's code)

`build/fs38-d/tower.py` builds `O/𝔓^m` from the ring axioms (pairs of Eisenstein integers, `π² = 2 + 2π`,
conjugation `ω ↦ ω²` with `π` fixed, `S_m = {z : z z̄ = 1}`), with none of §S3's norm form. Against it
(`inputs.py`): `|S_m| = 3·2^{m−1}`, `S_m` closed under multiplication, conjugation = inversion, `S_m = −S_m`
(levels 1–6); **no fibre edge at any level ≥ 2** (elementary, proved here: a difference in 𝔓^{m−1} has norm in
𝔓^{2m−2} ⊆ 𝔓^m for m ≥ 2, never 1); **P₂ = K₄ □ K₄** with exactly eight K₄'s, the four constant cliques
`{a + εv}` and the four shifted cliques `{a + ε(a + c)}`, every edge in exactly one (the isomorphism is
`x + εy ↦ (y, y − x)`: constant cliques are the rows, shifted cliques the columns — elementary, proved here);
**S_m → S_{m−1} onto with fibres of size two** at levels 2–6, the two lifts of `s̄` differing by `π^{m−1}·(s̄
mod 𝔓)`, so the neighbours of `z` in the fibre over `w = ⌊z⌋ + s̄` form a coset of `H(s̄) = 𝔽₂·(s̄ mod 𝔓)` —
the two-`K_{2,2}` structure, depending on the direction only through its residue in 𝔽₄^× (elementary, proved
here: `(1 + π^{m−1}t)(1 + π^{m−1}t̄) ≡ 1 + π^{m−1}Tr(t)` mod 𝔓^m for m ≥ 2, and `Tr : 𝔽₄ → 𝔽₂` has kernel 𝔽₂;
onto because `Tr` is onto); the circle lists coincide with the record's at levels 4 and 5 (`data/fs38/`) — a
third independent construction of the object beside T's closed form and its genuine ring quotient. **New:
the clique number is 4 at level 2 and exactly 3 at every level 3–5** (no K₄ through 0 above level 2), so
gap-freedom above level 2 is not a clique fact and D-3 needed a different mechanism.

## D-1. The structure of the period sets at levels 2–4

**Census (complete enumerations, `periods.py`, `enum4.py`; exact facts about finite objects, tools-side).**

| level | 4-colourings | period-group orders (weighted) | aperiodic | factor through the level below |
|---|---|---|---|---|
| 2 | 576 | 2: 432 · 4: 144 | 0 | 24 (the K₄ colouring's palettes) |
| 3 | 4,896 | 4: 3,456 · 8: 1,152 · 16: 288 | 0 | 576 |
| 4 | **1,179,936** | 8: 1,154,304 · 16: 23,616 · 32: 1,728 · 64: 288 | 0 | (all of level 5's, see D-2) |

No nonzero element is a period of every colouring at any level 2–4 (that is P-A1's free half; the record's
two-table cover at level 4 is its kernel form). What is unavoidable is a **disjunction**: at level 3 every
colouring has a period in `{2, 2ω, 2ω²}`; at level 4 every colouring has a period in each of the μ₃-triples
`2·{1,ω,ω²}`, `2√3·{1,ω,ω²}`, `2π·{1,ω,ω²}` (the last is depth 3, the fibre differences of P₄ → P₃), while no
single element and no two of a triple are unavoidable (verified colourings, `ask.py`). **§S5's conjectured
shape "the coset 𝔓^{m−2}·(units mod 𝔓)" is wrong as a function of m**: the shape is the fixed μ₃-triple
`2x·{1, ω, ω²}`. It is not a law either: for `x ≡ 1 + πω, 1 + πω²` (mod 𝔓²) — the units whose norm is not 1
mod 𝔓² — there are verified colourings with none of `2x, 2xω, 2xω²` as a period, at level 4 (2 of 5 triples)
and level 5 (8 of 21 triples; every depth-3 and depth-4 triple is unavoidable there — `lawL.py`). The
additive-colouring version *is* a two-line theorem for every x (a hom to a group of order 4 kills one of
`2x, 2xω, 2xω²` because their sum is 0 and `2·(ℤ/4) = {0, 2}`), and it is the additive family's
over-forcing that the general colourings do not share. The nine inclusion-minimal period groups at level 4 —
three of order 8 (one μ₃-orbit; profile: four depth-1, two depth-2, one depth-3 period) and six of order 32 —
are in `enum4-periods.json`; every period group contains one of them. D-2 explains all of this at once
(§D-2 (d)): a colour class's period group is the common kernel of the least-eigenvalue characters in its
Fourier support, and the census is the census of Boolean functions in a 46-dimensional space.

**Level 2 by hand (§S5 asked for it).** A 4-colouring of `K₄ □ K₄` is a Latin square `L(r, s)`; its colour
classes are the graphs of four permutations `σ_c` of 𝔽₄ forming a sharply transitive set. After relabelling
columns so that `σ_0 = id`, a sharply transitive set containing the identity on four points is a regular
subgroup of S₄ — `V₄` or one of the three cyclic groups of order 4 (the 24 reduced Latin squares of order 4
give 4 sets, and these are 4 subgroups) — so it contains a double transposition `α` commuting with every
`σ_c`; in the original labelling `L(αr, ρα ρ⁻¹ s) = L(r, s)` with `ρ` the column relabelling, and every double
transposition of 𝔽₄ is a translation by a nonzero element. Hence **every 4-colouring of P₂ has a period
`(δr, δs)` with both coordinates nonzero, i.e. `δ = δx + εδy` with `δy ≠ 0`, `δx ≠ δy`**: the period group has
order 4 for the 144 colourings whose row set is `V₄` (the graph of an additive automorphism of 𝔽₄; the 24
pullbacks of K₄'s colouring are the case `ρ ∈ V₄`) and order 2 for the 432 whose row set is cyclic. The
census above matches (144 + 432 = 576; 108·4 and 36·4 with `C(0) = 0`).

**Derived:** at level 2, every 4-colouring is periodic, under a period of depth 0 (a non-edge) or of depth 1,
the period set being the graph of an additive automorphism of 𝔽₄ (order 4, 144 colourings) or a single element
(order 2, 432 colourings) — elementary, proved here. At levels 3 and 4 the period structure is a complete
census (tools-side, exact), explained but not re-derived by D-2 (d): the unavoidable structure is disjunctive,
the μ₃-triple law holds for the norm-one classes of `x` and fails for the others, and no element is
unavoidable.

## D-2. Propagation: every 4-colouring of P_{m+1} factors through P_m, from m = 4 upward

### (a) The mechanism: Hoffman's ratio bound and its equality case

**External theorem (Hoffman, 1970, unpublished; Delsarte 1973; Lovász 1979; Godsil–Meagher, *Erdős–Ko–Rado
Theorems: Algebraic Approaches*, 2016, §2.4 — not yet in `BIBLIOGRAPHY.md`, to be added at the close; the
proof is six lines and is reproduced here).** Let Γ be a d-regular graph on n vertices with adjacency matrix
M and least eigenvalue λ_min < 0, and A an independent set. Then
`|A| ≤ n·(−λ_min)/(d − λ_min)`, **with equality iff `1_A − (|A|/n)·1` lies in the λ_min-eigenspace.**
*Proof.* Write `x = 1_A = (a/n)·1 + z` with `z ⊥ 1`, `a = |A|`. Independence gives `xᵀMx = 0`; expanding,
`0 = (a²/n)·d + zᵀMz ≥ (a²/n)·d + λ_min·‖z‖² = (a²/n)·d + λ_min·(a − a²/n)`, hence
`a·(d − λ_min) ≤ n·(−λ_min)`; equality forces `zᵀMz = λ_min‖z‖²`, i.e. `z ∈ E_min`. ∎

**Cayley form (elementary).** For `Γ = Cay(G, S)`, G finite abelian, `S = −S`, `0 ∉ S`: every character χ of
G is an eigenvector with eigenvalue `λ_χ = Σ_{s ∈ S} χ(s)` (real, since `S = −S`), and `E_min` is spanned by the
characters with `λ_χ = λ_min`. Let `H_min := ⋂ {ker χ : λ_χ = λ_min}`. A function on G whose Fourier support
lies in a set of characters all trivial on `H` is `H`-periodic (Fourier inversion).

**Theorem D2-A (tightness forces; elementary from the above).** Call `Cay(G, S)` *k-tight* if
`λ_min = −d/(k−1)`. If it is k-tight, then every proper k-colouring C satisfies:
(i) every colour class has exactly n/k elements and attains the ratio bound;
(ii) every colour class's indicator lies in `span(1, E_min)`;
(iii) **C is `H_min`-periodic: `Forces (addCayley S) k 0 h` for every `h ∈ H_min`** (with `Forces` as in
`Forcer.lean:41`, translated by `forces_iff_forces_zero_sub`);
(iv) **C has no fan gap** (`FanGap` of `FanGap.lean`): a colour γ absent from `N[v]` would let `v` join the
γ-class, an independent set of size n/k + 1 > α.
*Proof.* n = Σ|A_c| ≤ k·α ≤ k·n(−λ_min)/(d − λ_min) = n, so every inequality is an equality: (i); the equality
case gives (ii); (ii) and the Fourier remark give (iii); (i) gives (iv). ∎
Note: k-tightness needs `λ_min ≤ −d/(k−1)` to hold with equality; for a k-colourable graph `λ_min ≤ −d/(k−1)`
is *always* true (Hoffman's chromatic bound), so **k-tight ⟺ Hoffman's bound α ≤ n/k is exact**.

### (b) The spectrum of the 2-adic tower (exact computation, levels 1–8; `spectrum.py`; a control on (c))

| m | n | d | λ_min | −d/3 | # minimising χ | H_min | second-least eigenvalue |
|---|---|---|---|---|---|---|---|
| 1 | 4 | 3 | −1 | −1 | 3 | 0 | 3 |
| 2 | 16 | 6 | −2 | −2 | 9 | 0 | 2 (spectrum {−2⁹, 2⁶, 6¹} = K₄ □ K₄'s, a control) |
| 3 | 64 | 12 | −4 | −4 | 21 | 0 | 0 |
| 4 | 256 | 24 | −8 | −8 | **45** | **0** | 0 |
| 5 | 1024 | 48 | −16 | −16 | 45 | **𝔓⁴/𝔓⁵ (4)** | −8 |
| 6 | 4096 | 96 | −32 | −32 | 45 | 𝔓⁴/𝔓⁶ (16) | −16 |
| 7 | 16384 | 192 | −64 | −64 | 45 | 𝔓⁴/𝔓⁷ (64) | −32 |
| 8 | 65536 | 384 | −128 | −128 | 45 | 𝔓⁴/𝔓⁸ (256) | −64 |

(Eigenvalues are integers through level 6 and irrational from level 7, where 16th roots of unity enter;
`H_min` was first computed with a kernel test that checked the two phase components separately — a subset of
the true kernel — and recomputed with the combined phase; the answer did not change.) So P_m is **4-tight at
every level**, the minimisers stabilise at level 4, and `H_min` is exactly the measured forced set: trivial
through level 4, 𝔓⁴ from level 5. **Positive control on the mechanism (G21):** for 1,224/1,224 colourings at
level 3, 2,000/2,000 at level 4 and 6/6 fresh solver models at level 5, every colour class's Fourier support
lies in `{1} ∪ E_min` and the colouring's period group equals the common kernel of its support
(`fourier_ctrl.py`). Balance (i) holds on every enumerated colouring at levels 2–4.

### (c) The derivation for every level m ≥ 5

**Lemma 1 (tightness propagates up; elementary, proved here).** `S_{m+1} → S_m` is onto with fibres of size
two (§0). A character `χ` of `O/𝔓^m` pulled back along the level map has eigenvalue `2·λ_χ` at level m + 1,
and `d_{m+1} = 2·d_m`. So if P_m is 4-tight, `λ_min(P_{m+1}) ≤ 2·λ_min(P_m) = −d_{m+1}/3`, and P_{m+1} is
4-colourable (pull back any colouring), so Hoffman gives `≥`: **P_{m+1} is 4-tight.** P₁ = K₄ is 4-tight
(λ_min = −1 = −3/3). Hence **every level is 4-tight, every 4-colouring of every level is balanced, and no
level has a fan gap** — P-A3 derived, with no solver. The same computation shows **slackness propagates up**
(λ_min/d is non-increasing under pullback), so a tower whose level one is slack is slack at every level.

**Lemma 2 (the primitive-character bound; elementary, proved here).** Let m ≥ 2 and χ a character of
`O/𝔓^m` nontrivial on the top fibre `𝔓^{m−1}/𝔓^m ≅ 𝔽₄`. Pair the two lifts `s₀, s₀(1 + π^{m−1}) = s₀ + π^{m−1}s₀`
of each `s̄ ∈ S_{m−1}`: `λ_χ = Σ_{s̄} χ(s₀)·(1 + ψ(s̄ mod 𝔓))`, where `ψ(t) := χ(π^{m−1}t)` is a nontrivial
character of (𝔽₄, +), equal to 1 on exactly one nonzero residue `a₀` and −1 on the other two. Hence
`λ_χ = 2·Σ{χ(s₀) : s̄ ∈ S_{m−1}, s̄ ≡ a₀ (mod 𝔓)}`, a sum of `|S_{m−1}|/3 = 2^{m−2}` roots of unity, so
`|λ_χ| ≤ 2^{m−1}`, **with equality only if χ is constant on `{s ∈ S_m : s ≡ a₀} = a₀·S_m^{(1)}`**
(`S_m^{(1)}` the norm-one units ≡ 1 mod 𝔓). Then `χ(a₀(t − t')) = 1` for all `t, t' ∈ S_m^{(1)}`, so χ is
trivial on `a₀·M_m`, where `M_m := ⟨t − 1 : t ∈ S_m^{(1)}⟩` (additive subgroup). **If `M_m ⊇ 𝔓^{m−1}/𝔓^m`,
χ is trivial on `a₀𝔓^{m−1} = 𝔓^{m−1}`, a contradiction; so every primitive character has `|λ_χ| < 2^{m−1}`.**

**Lemma 3 (the arithmetic fact; computed per level and certified globally).** Let `U₁` be the norm-one
units of O congruent to 1 mod 𝔓 and `M := ℤ₂-span{t − 1 : t ∈ U₁}`. **Only one direction is used:** the image
of M in `O/𝔓^m` is *contained* in `M_m` (if `t t̄ = 1` in O then its image satisfies `z z̄ = 1`, so it lies in
`S_m`, and `t ≡ 1 mod 𝔓` gives `z ≡ 1`), and Lemma 2 needs `M_m` to be **large**. So no surjectivity of
`U₁ → S_m^{(1)}` is claimed or needed — an earlier draft of this file asserted `M_m` *is* the image of M,
which is stronger than the proof uses and is unverified. Computed
(`spanU1.py`): `[O/𝔓^m : M_m] = 32` at every level 4–8; **`M_m ⊇ 𝔓^{m−1}/𝔓^m` for m = 5, 6, 7, 8 and NOT for
m = 3, 4**; `𝔓⁴ ⊆ M_m` and `𝔓³ ⊄ M_m` at every level ≥ 5. Globally: for `u ≡ 1 (mod 𝔓)`, `t = u/ū = u²/N(u) ∈
U₁` with `N(u) ∈ ℤ₂[√3]` a unit, and `t − 1 = (u² − N(u))·N(u)⁻¹`. **Certificate:** the four elements
`u ∈ ℤ[ω, √3]` with coordinates `(−2,−2,−1,−2), (−2,−2,−1,0), (−2,−1,−1,−1), (−2,−1,−1,1)` in the basis
`(1, ω, √3, ω√3)` (each ≡ 1 mod 𝔓; norms `13+6√3, 7+2√3, 6+3√3, 12+3√3`, each of odd rational norm) give
integer vectors `(t − 1)·N_ℚ(N(u))` — `(−106,−20,2,28), (−40,4,22,20), (−9,0,3,6), (−135,−72,63,18)` — whose
ℤ-span has 2-adic elementary divisors `1, 2, 4, 4` (gcds of the k×k minors `1, 2, 72, 406944`; exact integer
arithmetic). Since `O = ℤ₂[ω] ⊕ √3·ℤ₂[ω] = ℤ₂⁴` in this basis and the rational norms are 2-adic units,
**`𝔓⁴ = 4O ⊆ M` and `2O ⊄ M`**, so `M_m ⊇ 𝔓⁴/𝔓^m ⊇ 𝔓^{m−1}/𝔓^m` for every m ≥ 5 — and the certificate's
index 2⁵ = 32 equals `[O/𝔓^m : M_m]`, so these four elements already generate M 2-adically. (A 4×4 determinant
over ℤ[ω, √3]: kernel-able by `decide`/`norm_num`.)

**Re-verified by a second code path (2026-09-13, on the advisor's audit ask — everything for m ≥ 9 rests on
this receipt and on nothing computed above level 8; `recheck_lemma3.py`).** No minors, no Smith form, no
clearing by `N_ℚ(N(u))`: each `t = u/ū` is built as an exact element of `O/2¹²` by inverting `N(u)` in
`ℤ[√3]/2¹²`, and membership is decided by solving `Σ cⱼ(tⱼ − 1) = target` over ℚ with exact fractions and
testing that every `cⱼ` has an odd denominator (⟺ `cⱼ ∈ ℤ₂`). Results: `4·O ⊆ ℤ₂-span{t − 1}` on all four
basis elements; **`2π·O = 𝔓³ ⊄ span` and `2·O = 𝔓² ⊄ span`, failing on the `ω` and `ω√3` directions and
succeeding on `1` and `√3`** — so `j = 4` is sharp, and sharp for a located reason. The coefficients writing
`4 = Σ cⱼ(tⱼ − 1)` have denominators 33416349183, 33416349183, 11138783061, 4773764169, every one odd.
**This path also checks two things the first one never did:** that each `t` satisfies `t t̄ = 1` exactly
(the first path assumed it from the construction) and that each `t ≡ 1 (mod 𝔓)`. Both hold for all four.

**Theorem D2-B (propagation, all m ≥ 5).** *At level 4:* λ_min(P₄) = −8 = −d/3, attained by 45 characters
whose common kernel is {0} (exact: the level-4 eigenvalues are sums of 24 fourth roots of unity; a finite
`decide`). *Induction, m ≥ 5:* a character of `O/𝔓^m` is either primitive, with `|λ| < 2^{m−1}` by Lemmas 2–3,
or a pullback of a level-(m−1) character with eigenvalue `2λ' ≥ 2λ_min(P_{m−1}) = −2^{m−1}`, equality iff the
level-(m−1) character minimises. Hence `λ_min(P_m) = −2^{m−1}` and **the minimisers of P_m are exactly the
pullbacks of the 45 minimisers of P₄**, so `H_min(P_m) = ρ_{m→4}⁻¹({0}) = 𝔓⁴/𝔓^m`. By Theorem D2-A (iii),
**every 4-colouring of P_m is 𝔓⁴-periodic**, i.e. `Forces (twoAdicPlane m) 4 x y` whenever `x − y ∈ 𝔓⁴`, for
every m ≥ 5 — P-A2's forced half at every level. ∎

**Corollaries (with the level-4 records).** (1) Every 4-colouring of every P_m, m ≥ 4, is pulled back from
P₄: **the tower's colouring space is finite — it is P₄'s, 1,179,936 colourings** (level-4 census; 294,984
with `C(0) = 0`). (2) With the two-table cover of P₄ (`data/fs38/p4-tables.json`; kernel as the five tables
of `Instances/TwoAdicFour.lean`): **`Forces (twoAdicPlane m) 4 x y ↔ x − y ∈ 𝔓⁴`** for all m ≥ 5 (⟸ derived;
⟹ a pair with `x − y ∉ 𝔓⁴` has distinct images in P₄, separated by a table). (3) With P₄'s 231 verified
non-edge models (level-4 record: every non-edge through 0 identified by some colouring): **`Separated
(twoAdicPlane m) 4 x y ↔ x − y ∈ S_m + 𝔓⁴`** for all m ≥ 5 — Poros's virtual-edge law, derived: if
`y − x = s + h` then `C(y) = C(x + s) ≠ C(x)` by 𝔓⁴-periodicity; if `y − x ∉ S_m + 𝔓⁴` its image in P₄ is a
non-edge, identified by a level-4 colouring, pulled back. Both rest on **no refusal at all**: the level-4
tables and models, plus the theorem. (4) P-A6's additive half: an additive 4-colouring is a hom `Λ → G`,
`|G| = 4`, exponent | 4, so it kills `4Λ ⊆ 𝔓⁴` and factors through P₄ (two lines); the forced set of every
P_m, m ≥ 5, equals the additive family's `F_add = 𝔓⁴` — but the mechanism is not additivity, it is
tightness, and the additive colourings are a 20-element (8 up to palette, M56 R1) subset of 1,179,936.
(5) The forcing lives in no natural proper subgroup — 18 sub-Cayley graphs of P₅ down to index 2 are all
free at (0, 4) (`subask.py`, verified colourings) — as (a) predicts: extremality is a property of the
complete graph. (6) §S4's transfer statement stands unchanged: a K-fabric mapping into P_m inherits freeness
only; the tower's forcing is an extremal property of the whole Cayley graph and says nothing about a chunk.

**Derived:** for every m ≥ 5, every 4-colouring of `P_m = Cay(O/𝔓^m, S_m)` is constant on 𝔓⁴-cosets;
the forced pairs are exactly the differences in 𝔓⁴ and the virtual edges exactly `S_m + 𝔓⁴` (the two "exactly"
halves resting on the level-4 tables and models); every level is 4-tight, balanced, and gap-free. Proof:
Hoffman's ratio bound with its equality case (external, reproduced above), Lemmas 1–3 (elementary, proved
here, one 4×4 integer determinant), the level-4 spectrum (exact finite computation, `decide`-able), and
Theorem D2-B's induction.

### (d) What this explains about D-1

A colour class A of a colouring of P₄ has `1_A ∈ span(1, E_min)` with `|E_min| = 45`; its period group is the
common kernel of the characters in its Fourier support, and the colouring's period group is the intersection
over its four classes. The nine minimal period groups, the disjunctive μ₃-triple laws and their failures are
all statements about which subsets of the 45 characters can be the support of a Boolean function — finite,
not pursued today. The three-way counts 3, 9, 21, 45 of minimisers at levels 1–4 and the stabilisation at 45
are the whole D-1 story in one line: `1, 3, 9, 21, 45` grow while the top fibre still carries minimising
characters, and stop when `M_m` swallows the top fibre (Lemma 3, level 5).

## D-3. The dichotomy's other side: does "no gap at level one" propagate?

The question as posed is **mis-posed**, in two ways, and both are settled by D-2 (a) and (c).

1. "No gap at level one ⟹ no gap at any level" is not a theorem for Cayley towers in general and is not what
   holds here: the level-one object K₄ is gap-free for a trivial reason (a clique), P₂ for the same reason,
   and **from level 3 on the clique number is 3** (§0), so gap-freedom above level 2 is not inherited from
   level one by any local mechanism. What propagates is **4-tightness** (Lemma 1), which implies gap-freedom
   (Theorem D2-A (iv)). Gap-freedom is a consequence, not the invariant.
2. The two directions of G54 have different shapes. **Gap ⟹ free** is `FanGap.lean` (kernel). **Tight ⟹
   gap-free and forced by H_min** is Theorem D2-A. The middle case — slack but gap-free — is logically open and
   unobserved. So the correct classifier of (𝔭, k) is the sign of `λ_min + d/(k−1)` of the level-one plane:
   zero is tight (forcing, no gap, every k-colouring balanced), negative is slack (Hoffman's α-bound exceeds
   n/k; gaps are permitted and, at 7, 11, 19, found). Computed (`fpspec.py`, exact character sums):

   | plane | k | λ_min | −d/(k−1) | verdict | the record |
   |---|---|---|---|---|---|
   | UD(𝔽₃,2) = K₃ □ K₃ | 3 | −2 | −2 | **tight** | no gap; the rhombus forces (row 58) |
   | 2-adic K₄ | 4 | −1 | −1 | **tight** | no gap; forced from level 5 (D-2) |
   | UD(𝔽₇,2) | 4 | −4.494 | −2.667 | slack | gapped (brief §1) |
   | UD(𝔽₁₁,2) | 5 | −4.796 | −3 | slack | gapped, kernel (`FanGap11.lean`) |
   | UD(𝔽₁₉,2) | 5 | −7.610 | −5 | slack | gapped, kernel (`FanGap19.lean`) |
   | UD(𝔽₂₃,2) | 5 | −7.961 | −6 | slack | (FS-17, open) |
   | UD(𝔽₈₃,2) | 6 | ≈ −17.7 (`data/fplane/spectral-p83.json`, Hoffman 5.743) | −16.8 | slack | (Poros card 1) |

   Tight exactly where the record found forcing and no gap; slack exactly where it found gaps. And slackness
   propagates up (Lemma 1's second half): **the 11-adic tower at five colours is slack at every level**
   (computed at levels 1–2: λ_min = −4.80, −52.75 against −3, −33), consistent with the kernel's gaps at every
   level there. The advisor reproduced the slack figures from its own construction to six decimals
   (−4.493959 at 7, −4.795755 at 11) — an independent confirmation of this table.

3. **No prime plane above 3 is tight, at any colour count** (computed, `tightsweep.py`: p = 3, 7, 11, 19, 23,
   31, 43, 47, 59, 67, 71, 79, 83, 103, 107; only p = 3 matches `−d/(k−1)` for any k ≤ 8, and for every
   p > 3 no small multiple `q·λ_min`, `q ≤ 8`, is integral). The reason is `[Krebs2022]`/G44's arithmetic read
   the other way: the eigenvalues are Kloosterman values `−K(1, c/4)`, algebraic of degree dividing
   `(p − 1)/2`, and tightness needs `λ_min ∈ ℚ`. **So the forcing half of the dichotomy is empty at every
   usable prime above 3** — the observed gaps at 7, 11, 19 are the generic case, not a coincidence of three
   small primes, and no field whose sealing prime exceeds 3 can have its pair compulsions forced by this
   mechanism. Registered as P-D5, since "degree dividing `(p−1)/2`" bounds the degree and does not by itself
   forbid a rational value.

   **The cheap screen (the advisor's point, and I agree it is the most transferable thing here).** Tightness
   is a character sum: seconds per (field, k) on one core, against the desktop-day FS-17 priced for a single
   colouring ask at one prime. It decides a k-colouring question *negatively* only in the tight case, so it is
   not a substitute for FS-17's ask — but where it fires it is decisive and free, and it says in advance which
   planes *cannot* be screened by the fan-gap mechanism. Its honest scope: tight ⟹ forced, balanced, gap-free;
   slack ⟹ gaps are permitted but not guaranteed (D-4 is the instance where a *uniform* gap is refused).

**Derived:** for a tower `Cay(G_m, S_m)` with surjective level maps carrying `S_{m+1}` onto `S_m` with
constant fibre size, k-tightness at level one propagates to every level, and with it gap-freedom and
H_min-periodicity of every k-colouring (Lemma 1 + Theorem D2-A); slackness propagates too. "No gap at level
one" is not the hypothesis that propagates, and the right one-line statement of G54 is: **the residue plane
seals a field's pair compulsions at k colours when it is slack (gap ⟹ free, kernel) and forces them when it is
tight (Theorem D2-A); at 2 with four colours and at 3 with three the plane is tight, at 7, 11, 19, 23, 83 it is
slack.** Descent (tightness at level m + 1 ⟹ at level m) is not claimed and not needed.

## D-4. Why 11 is slack: a uniformly gapped 5-colouring?

One solver ask (`gap11.py`): a proper 5-colouring of UD(𝔽₁₁, 2) with **every** closed neighbourhood missing a
colour is **UNSAT (solver, untrusted)**. Controls on the same code path: five colours without the demand SAT;
**six colours with every vertex gapped SAT (verified proper, every N[v] misses a colour)** — the encoding's
positive outcome is reachable on this very graph; four colours with every vertex gapped UNSAT (the plane is not
4-colourable, `chromaticNumber_finitePlane11`). So the strongest form of slackness does not hold; slackness at
11 is partial (three gapped vertices in the certified table, a shared gap on an edge in the second table —
`Instances/FanGap11.lean`). In D-3's terms this is expected: Hoffman's α-bound at 11 is 34.55 against n/k =
24.2, so classes of size up to 34 are allowed, but nothing says every vertex can see only three colours.
The refinement — the maximum number of simultaneously gapped vertices — was asked by binary search on a
cardinality constraint and did not finish inside the budget (killed at 71 CPU-minutes).

**Second engine (after the pause):** the same encoding on Glucose 4 returns UNSAT for the uniform-gap ask and
reproduces all three controls (five colours without the demand SAT; four colours all gapped UNSAT; six colours
all gapped SAT, verified). Trust word: refused on two engines, one encoding, untrusted.

**Not derived, stalls at:** the maximum number of simultaneously gapped vertices in a 5-colouring of
UD(𝔽₁₁, 2) — the cardinality asks (seqcounter, 121 selector variables) did not terminate in an hour. The
uniform-gap answer is now two engines' UNSAT with the three controls; a second *encoding* would be the next
trust step. Not needed for any theorem.

## What this changes

| item | before today | now |
|---|---|---|
| P-A1 (free at depth ≤ 3, every level) | measured; kernel at 4 via tables | **derived for every m ≥ 5** from the level-4 tables (a depth-≤3 pair has distinct images in P₄) |
| P-A2 (forced at depth ≥ 4 from level 5) | solver at 5–7, orbits at 8; LRAT at 5 | **derived for every m ≥ 5** (Theorem D2-B); the LRAT is now a control on the theorem |
| P-A3 (no gap at any level) | solver 1–8; corollary of P-A2 at ≤ 5 | **derived for every m** (Lemma 1 + D2-A (iv)), no solver |
| P-A4 (a nonzero period at every level ≥ 2) | measured 2–4 | derived at 2 (hand) and at every m ≥ 5 (𝔓⁴); levels 3–4 a complete census |
| P-A5 (2–3 tables) | met (two) | unchanged |
| P-A6 (forced set = F_add = 𝔓⁴ for m ≥ 5) | derived additive half, measured equality | **equality derived**; the mechanism is tightness, not additivity |
| virtual edges = S_m + 𝔓⁴ (Poros item 1) | measured 5–7 | **derived for every m ≥ 5** from the level-4 models |
| the colouring space of the tower | open | **finite: P₄'s 1,179,936 colourings at every level ≥ 4** |
| G54 | one-directional (gap ⟹ free) | two named directions with a classifier: tight ⟹ forced ∧ gap-free; slack permits gaps; tightness and slackness both propagate up a tower |
| §S4 transfer | freeness only | unchanged, with the reason: the forcing is extremal (whole-graph), which is why no proper subgroup of P₅ carries it |

**What stays measured.** The level-4 census (exact enumeration, tools-side); the census of period groups at
3–4; the (L)-triple verdicts; D-4's UNSAT. **What is derived but not kernel:** Hoffman's ratio bound and its
equality case; Lemmas 1–3; the level-4 spectrum; the certificate determinant.

**Registered predictions (both outcomes reachable):**
- **P-D1 — MET (2026-09-13, after the pause; 134 s, the level-9 spectrum was never computed before the
  registration).** λ_min(P₉) = −256.000000 = −d/3 with **exactly 45** minimising characters, whose common
  kernel has 1,024 elements and **equals 𝔓⁴/𝔓⁹ element for element**; second-least eigenvalue −128 = −2^{m−2},
  as Lemma 2's bound predicts for the primitive characters. Theorem D2-B's first out-of-sample level. Trust
  word: an exact character-sum computation (floats to 10⁻⁶ on integer-valued sums), solver-free.
- **P-D2 (the 3-adic control, same mechanism, other prime) — MET out of sample, and it needed no solver.**
  Registered: `Cay((ℤ/3^m)², {a²+b² = 1})` at three colours is 3-tight at levels 1–4 with exactly 4
  minimising characters at every level and `H_min = 3·(ℤ/3^m)²` from level 2, so **every 3-colouring of
  UD(ℤ/9, 2) is 3-periodic**. Scored the same hour by the advisor from its own independent construction
  (exact character sums, no solver): λ_min = −2, −6, −18 at levels 1, 2, 3 against d = 4, 12, 36 — exactly
  `−d/2` — four minimisers throughout, and `H_min = 3·(ℤ/3^m)²` element for element at m = 2 (9 elements) and
  **m = 3 (81 elements), one level deeper than predicted**. The SAT ask the prediction offered as its test is
  **not to be spent**: by Theorem D2-A the periodicity is a corollary, and the ask would only re-measure it.
  *What the two outcomes were:* a rational `λ_min ≠ −d/2`, or a common kernel smaller than `3·(ℤ/3^m)²`,
  either of which would have put the mechanism's second prime outside it. **The ℤ/9 asks were run anyway on the
  coordinator's instruction, as a control on the corollary and not as its test:** all eight nonzero fibre
  differences `(3a, 3b)` are refused at three colours on two engines (CaDiCaL and Glucose agree — solver word,
  untrusted), and the control pair `(0, (1,1))`, a valuation-0 non-edge, is free (verified colouring). Consistent
  with Theorem D2-A; it could not have contradicted the theorem, only the encoding. **Candidate for phase C, the
  advisor's and not verified by either of us:** this 3-adic instance may be the mechanism behind the record's
  rhombus forcing at three colours over ℚ(√3) (row 58, `exists_forces_of_unit_drawing_three`) — the drawing
  has not been checked against the tower, so it is a candidate, not a claim.
- **P-D3.** No finite unit-distance graph in K² forces a four-colour pair at depth 4 (16/3, 16, 16/9, 48) —
  the tower's depth-4 forcing is an extremal property of the complete Cayley graph and has no finite
  sub-witness that lifts (Poros's card 2, now with a mechanism). Falsifier: one K² graph with a verified
  forced pair at those distances (M53's dial re-asked at three classes).
- **P-D5 — CLOSED for k ≤ 7 over the committed usable primes, by T and Poros (the Weil cutoff), the same
  day.** As registered: no plane `UD(𝔽_p, 2)`, p > 3, is k-tight for any k. The closure: tightness at k needs
  `λ_min = −d/(k−1)` with `d = p + 1` at a usable prime, and Weil's bound on the Kloosterman eigenvalues gives
  `|λ_min| ≤ 2√p`; so `(p + 1)/(k − 1) ≤ 2√p`, which holds only for `p ≤ 13, 33, 61, 97, 141` at
  `k = 3, 4, 5, 6, 7` — **largest primes 13, 31, 61, 97, 139** — and above those cutoffs tightness is
  impossible at that k with no computation. Below them, over `data/fplane/spectral-below-600.json`, the ratio
  `d/|λ_min|` at the eighteen usable primes `≤ 149` (3, 7, 11, 19, 23, 31, 43, 47, 59, 67, 71, 79, 83, 103,
  107, 127, 131, 139) is integral **only at p = 3** (2.000000). The margins to the nearest integer, printed
  rather than rounded because two of them are small: **p = 31 reads 3.000044** (a near miss at k = 4, margin
  +4.4·10⁻⁵ — the plane is not 4-tight, and at k = 4 the cutoff is exactly p ≤ 31, so this is the last prime
  that could have been) and **p = 23 reads 3.014815** (+0.0148); the rest are ≥ 0.02 away (7: 1.780; 11: 2.502;
  19: 2.628; 43: 3.678; 47: 3.736; 59: 4.022; 67: 4.516; 71: 5.080; 79: 4.678; 83: 4.743; 103: 5.192;
  107: 5.669; 127: 5.920; 131: 6.253; 139: 6.640). **Two scope riders:** (i) k ≤ 7 only — for k ≥ 8 the
  cutoff exceeds 149 and the sweep does not reach it; (ii) only the usable primes in the committed table, so
  nothing is said about a prime absent from it. The Galois-degree argument of the registration (Kloosterman
  values are algebraic of degree dividing `(p−1)/2`) is an independent second reason and is not needed for
  the closure. Reproduced here from the committed table, margins as above (`tightsweep.py` agrees at every
  overlapping prime to 10⁻⁷).
- **P-D4.** UD(𝔽₂₃, 2) is slack at 5 colours (computed), so if it is 5-colourable it has a 5-colouring with a
  fan gap (the empirical pattern at 7, 11, 19); if it refuses five, the first plane refusing five is slack at
  five and its 6-colourings, if any, are slack too (λ_min = −7.96 against −24/5 = −4.8). Falsifier for the
  first clause: a 5-colourable UD(𝔽₂₃,2) all of whose 5-colourings are gap-free.

**Kernel skeleton, statement shapes only (record vocabulary: `Forces`, `addCayley`, `twoAdicPlane m` of
`TwoAdicTower.lean`; Mathlib's `AddChar` with `Mathlib/Analysis/Fourier/FiniteAbelian/{Orthogonality,
PontryaginDuality}.lean` for characters and Fourier inversion; the ratio bound is not in Mathlib):**
```
/-- Hoffman's ratio bound, equality case, Cayley form: on `addCayley S` over a finite abelian group with
    `S = -S`, `0 ∉ S`, if every character has `(∑ s ∈ S, χ s).re ≥ -(S.card / (k-1))`, then every `k`-colouring
    is periodic under the common kernel of the characters attaining the bound. -/
theorem forces_of_tight {A : Type*} [AddCommGroup A] [Fintype A] [DecidableEq A] (S : Finset A)
    (hS : ∀ s ∈ S, -s ∈ S) (h0 : 0 ∉ S) (k : ℕ) (hk : 2 ≤ k) (H : AddSubgroup A)
    (htight : ∀ χ : AddChar A ℂ, -((S.card : ℝ) / (k - 1)) ≤ (∑ s ∈ S, χ s).re)
    (hker : ∀ χ : AddChar A ℂ, (∑ s ∈ S, χ s).re = -((S.card : ℝ) / (k - 1)) → ∀ h ∈ H, χ h = 1) :
    ∀ h ∈ H, Forces (addCayley (S : Set A)) k 0 h
theorem not_fanGap_of_tight … : ∀ (C : (addCayley (S : Set A)).Coloring (Fin k)) v γ, ¬ FanGap C v γ
theorem colorable_balanced_of_tight … : ∀ C, ∀ c, (Finset.univ.filter (C · = c)).card * k = Fintype.card A
/-- the tower: tightness at every level (Lemma 1), and the arithmetic fact (Lemma 3) -/
theorem twoAdicPlane_tight (m : ℕ) : ∀ χ : AddChar (TwoAdicLevel m) ℂ, -(2 ^ (m - 1) : ℝ) ≤ (∑ s ∈ circle m, χ s).re
theorem twoAdicPlane_four_minimisers : {χ | (∑ s ∈ circle 4, χ s).re = -8}.ncard = 45 ∧ ⋂ … ker χ = ⊥   -- decide
theorem span_norm_one_sub_one_contains_four : (4 : O) ∈ Submodule.span ℤ₂ {t - 1 | t ∈ U₁} ∧ …  -- the 4×4 determinant
theorem twoAdicPlane_forces_iff (m : ℕ) (hm : 5 ≤ m) (x y : TwoAdicLevel m) :
    Forces (twoAdicPlane m) 4 x y ↔ twoAdicLevelMap … (x - y) = 0     -- image in level 4 is zero
theorem twoAdicPlane_separated_iff (m : ℕ) (hm : 5 ≤ m) (x y) :
    Separated (twoAdicPlane m) 4 x y ↔ twoAdicLevelMap … (y - x) ∈ twoAdicCircle 4
theorem twoAdicPlane_coloring_factors (m : ℕ) (hm : 4 ≤ m) (C : (twoAdicPlane m).Coloring (Fin 4)) :
    ∃ C₄ : (twoAdicPlane 4).Coloring (Fin 4), C = C₄.comp (twoAdicLevelHom …)
```
The certificate `span_norm_one_sub_one_contains_four` is the one genuinely new kernel object: four explicit
elements of `ℤ[ω, √3]` and a Smith-form (or four-minor gcd) computation over ℤ; everything else is either
Fourier analysis on a finite abelian group (Mathlib has the characters and orthogonality; the ratio bound is a
six-line real inequality) or a `decide` at level 4.

## Inventory of the scratch (`build/fs38-d/`, gitignored, regenerable)

`tower.py` (the independent construction), `inputs.py` (§0), `periods.py` + `cols-m{2,3}.json` (D-1 census
2–3), `enum4.py` + `enum4-ckpt.json` + `enum4-periods.json` (the complete level-4 census), `ask.py` (period
and forcing asks), `lawL.py` + `lawL-m{4,5}.json` (the μ₃-triple verdicts), `subask.py` (18 sub-Cayley graphs
at level 5), `spectrum.py` + `spectrum-m{1..8}.json` (the spectra and H_min), `fpspec.py` (the finite planes),
`spanU1.py` (Lemma 3 per level and the certificate), `fourier_ctrl.py` (the positive control),
`gap11.py` (D-4), `recheck_lemma3.py` (the second code path for Lemma 3's receipt), `tightsweep.py` (the
prime planes), `core5.py` + `core5-random-ckpt.json` (a 1-minimal vertex core of P₅ + (0,4), stopped by the
coordinator at 850 of 1,022 deletion trials with 211 vertices kept; resume: `python3 core5.py random` reads
the checkpoint; its shape is moot after D-2 (c) but would be the smallest finite sub-witness inside P₅).

## Bibliography entries the close must add (this file does not edit `BIBLIOGRAPHY.md`)

Per the bibliography rule, each with its role and read status; **titles from memory are marked as such and must
be checked against the copies before entry** (G50). (1) **Hoffman, A. J.** — the ratio bound `α ≤ n(−λ_min)/(d −
λ_min)`, circa 1970, unpublished notes (the standard attribution; the equality case is folklore attached to it).
Role: the whole of D-2 (a). Not read (no copy). (2) **Lovász, L.** — *On the Shannon capacity of a graph*, IEEE
Trans. Inf. Theory 25 (1979) [title from memory] — the ϑ function, which the record already uses at the finite
planes (row 56, "ϑ = Hoffman at eleven primes"); role: the bound's modern home. Not read here. (3) **Godsil, C.
and Meagher, K.** — *Erdős–Ko–Rado Theorems: Algebraic Approaches*, Cambridge Univ. Press 2016 [title from
memory], §2.4 "the ratio bound" with the equality case and its use to classify maximum independent sets — the
exact shape of Theorem D2-A. Role: the reference for (a) and the prior art for "tightness classifies the
extremal colourings". Not read here; the six-line proof is reproduced in (a) so nothing rests on the citation.
(4) **Delsarte, P.** — *An algebraic approach to the association schemes of coding theory*, Philips Res. Rep.
Suppl. 10 (1973) [title from memory] — the linear-programming bound of which the ratio bound is the one-eigenvalue
case; role: ancestry only. Prior-art query for the close, in the discipline's words (G49): *"Hoffman ratio bound
equality maximum independent sets Cayley graph periodic"*, and *"chromatic number Cayley graph local ring Hoffman
tight"* — the 2-adic and 3-adic towers as Cayley graphs of `O/𝔓^m` may already appear in the finite-field-geometry
lineage `[MMST1998]` → `[Vinh2006]` → `[Krebs2022]`, which the plan's §PA lists as spectra without colouring values.

## Retractions inside the planning window (G51: count them; zero means the disagreement has not started)

**Three, all free — nothing was committed under any of them, no solver time was paid, nothing was claimed
outside the room.** (1) *Mine, the load-bearing one:* the propagation route through law (L) — "every
4-colouring has a period in `2x·{1,ω,ω²}`" — was withdrawn within the hour of being sent, on two grounds: it
is **false** as a law (verified counterexamples at level 4 and 5, D-1) and, at the `x` the induction needed,
**equivalent to the forcing it was meant to prove**, so the argument was circular. Its replacement covers
every level m ≥ 5 instead of the levels measured. (2) *Mine, small:* the claim that `M_m` **is** the image of
M (Lemma 3) — stronger than the proof uses and unverified; the file now states the containment it needs.
(3) *The advisor's, recorded at its own request:* it hand-checked my propagation step, correctly found the
step sound, and did not ask whether the hypothesis the step consumed was the conclusion it served — which is
the defect that killed the route. Worth keeping because a valid check of a step says nothing about the
circularity of the whole, and the reviewer who verifies a step is the person least likely to look at its
premise. My own miss has the same shape and is the reason the route survived long enough to be sent.

**Closed (2026-09-13; paused once by the coordinator, resumed twice).** Done after the pause: Lemma 3's receipt
re-verified on a second code path; P-D1 met at level 9; P-D2's ℤ/9 asks run as a control on two engines; D-4 on a
second engine; P-D5 closed by the Weil cutoff (T and Poros) with its riders. Not done, for the close or a
successor: the maximum gapped count at 11 (a second encoding first); the bibliography entries above; the
prior-art query above. **What a sceptic should re-run first:** the level-4 spectrum — 45 minimisers at −8 with
trivial common kernel — since Theorem D2-B's base case rests on it alone (every other input has a second path:
the tightness of levels 1–9 by the propagation lemma and by direct computation, Lemma 3 by two codes, the
colouring-space claim by the kernel at 5 and the records at 6–9).
