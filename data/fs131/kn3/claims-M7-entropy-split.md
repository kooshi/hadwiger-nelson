# Draft claim list M7-entropy-split — PE-2: Lemma Γ and the passage from `Γ` to `U`; re-cut by FS131-KN6 from the deriver's answer (FS131-EN2)

*Drafted by FS131-KN3, rewritten by FS131-KN6 (2026-10-14), statement 1 restated by FS131-KN7 (2026-10-14, Amendment 2; by hand, so `tools/fs131_kn6_recut.py --check` reports this file as differing from its template, as it should) for Keryx to fix; a draft, not a fixed claim list. Written by `tools/fs131_kn6_recut.py` from `data/fs131/kn6/recut-M7.tmpl`: every quoted line is copied by script. The first draft is in git (`758af9d28`). Kind: planner and implementer.*

## The leaves it carries (quoted by script)

> NF2-LEAF-20: PE-2 (D:191): Lemma F (X02D:100); PE-1′, the pieces meet the printed hypotheses (X02D:146); Lemma W (X02D:156); Lemma Γ (X02D § 3.1, :181) over leaves 16, 17 (T2, T4); from `Γ` to `U` (X02D § 3.2, :196) over T1, T3.
> — source: data/fs131/claims-NF2.md § The chain's leaves

> NF2-LEAF-17: T1, ergodic decomposition for a countable group acting on a compact metrizable space; T2, `h_ρ(γ) = lim_k h_ρ(γ | 𝒜_k)` along increasing invariant σ-algebras; T3, Jacobs's formula; T4, Fourier uniqueness (leaf 3). X02D § Stage 3: "T1–T4 textbook; exact theorem numbers not checked here" — **a prior-art debt: no page is cited for T1–T3**, so none can be read back yet. Mathlib: no ergodic decomposition (searched). My call: unknown until leaf 13 is typed; T2 and T3 are candidates to formalize, T1 to import.
> — source: data/fs131/claims-NF2.md § The chain's leaves

**NF2-LEAF-17 is answered in part** (FS131-EN2, inventory item 707; FS131-KN3 § 4.2): of T1 only existence in canonical form is read, and only for `Γ ≅ ℤ²`; T3 is read only as the mixture lemma; T2 and T4 are read inside Lemma Γ, unchanged.

## Statements

1. `Rigidity.entropySplit [NumberField F] : EntropySplit F` — typed, `sorry`. **Since FS131-KN7 (Amendment 2 of its brief)
   `EntropySplit F` asks for entropy zero at one rotation by a non-torsion unit vector**, which is all its one consumer
   (`mrPlus_of_split_of_carried`) reads; the variant below proves it for every rotation of one admissible `Γ`, and a
   generator of `Γ` is non-torsion. PE-2 at every rotation is `Rigidity.EntropySplitEvery F`, which implies it
   (`entropySplit_of_every`, proved).
1′. **Off the headline's path since FS131-KN7, kept stated** (as FS100-EXC's scope leaf was): the layer that extends the
   variant from one admissible `Γ` to every `u ∈ U` — **Lemma W** for every non-torsion `u` ("every non-torsion `u ∈ U` lies in an
   admissible `Γ = ⟨u, w⟩`", X02D l. 156, over Chebotarev, NF2-LEAF-19) and **the torsion case** ("torsion `u` has `h_μ(u) = 0`",
   X02D l. 166, which reads `h(uᵏ) = k·h(u)`, not in the library). Needed only for `EntropySplitEvery F`. What stays on the path
   is **one admissible `Γ`** (its existence at a general field is X02D's Lemma W construction for one `u`; at `ℚ(√47)`, by
   NF2-LEAF-19, Dirichlet suffices).
2. to type — **Lemma Γ** (X02D § 3.1): for admissible `Γ` and a `Γ`-invariant, `Γ`-ergodic probability `ρ` on `Dual F`: `IsHaarFourier ρ`, or `ksEntropy ρ (rot γ) = 0` for every `γ ∈ Γ`.
3. **The route that is built — the largest Haar multiple** (the deriver offers two; this one is chosen because the typed `EntropySplit` is exactly the sentence it proves, and it reads neither the Lebesgue decomposition nor the ergodicity of Haar measure):

> EN2-PE2-MAX: For every real number field `F` and every `U`-invariant finite positive measure `τ` on `R̂`, the set of reals `c ≥ 0` with `c·m ≤ τ` has a largest element `a`, and `τ − a·m` is a positive `U`-invariant measure with `h_{τ − a·m}(u) = 0` for every `u ∈ U`.
> — source: plans/FS131-EN2-derivation.md, the entry at l. 904

4. **The second route, kept and not built** — it gives more (`τ′ ⟂ m`; the ergodic form) and costs the two inputs the first avoids; it is the one to build if a later statement reads the ergodic form:

> EN2-PE2-SING: For every real number field `F` and every `U`-invariant finite positive measure `τ` on `R̂`, the singular part `τ_s` of `τ` with respect to Haar measure `m` is `U`-invariant with `h_{τ_s}(u) = 0` for every `u ∈ U`, and `τ − τ_s = a·m` with `a = max{c ≥ 0 : c·m ≤ τ}`.
> — source: plans/FS131-EN2-derivation.md, the entry at l. 755

> EN2-LEB-INV: Let a group `U` act on a measurable space `X` by bijections measurable in both directions, and let `m`, `ν` be finite measures on `X` with `u_*m = m` and `u_*ν = ν` for every `u ∈ U`. Then the absolutely continuous part and the singular part of `ν` with respect to `m` are each invariant under every `u ∈ U`.
> — source: plans/FS131-EN2-derivation.md, the entry at l. 704

> EN2-AC-ERG: Let `T` be a bijection of a measurable space `X`, measurable in both directions, preserving a probability `m` for which `T` is ergodic, and let `λ` be a finite measure on `X` with `λ ≪ m` and `T_*λ = λ`. Then `λ = λ(X)·m`.
> — source: plans/FS131-EN2-derivation.md, the entry at l. 722

> EN2-SING-COMP: Let `X` be a standard Borel space, `𝓘` a sub-σ-algebra of its Borel σ-algebra, `m` and `λ` probabilities on `X` with `λ ⟂ m`, and `κ` the conditional-expectation kernel of `λ` on `𝓘`. Then for `λ`-almost every `x` there is a Borel set of `κ(x)`-measure 1 and `m`-measure 0; in particular `κ(x) ≠ m`.
> — source: plans/FS131-EN2-derivation.md, the entry at l. 740

## The classical statements this module now reads (on the chosen route), and where each comes from

| statement | from | status |
|---|---|---|
| T1, existence in canonical form, for a countable group on a standard Borel space: the conditional-expectation kernel on the invariant σ-algebra integrates to the measure and is almost surely invariant and ergodic | the release, `action_ergodic_decomposition` (`PrimePackets/ErgodicDecomposition.lean` ll. 127–134), at `H = Γ` — **by port** | declared cone 28 files, 22,632 lines; **used cone not measured** (a trial like FS131-KN6's on the files it names, or the release's compiled constants): the first step of lane M0-erg |
| a mixture of invariant measures of entropy zero has entropy zero | the release, `measureEntropy_kernel_zero` — by port (elaborates at this pin after three renames, measured) | typed here as `Rigidity.ksEntropy_bind_eq_zero`, a leaf of M1 |
| T2, the entropy along increasing σ-algebras (inside Lemma Γ) | the release, `measureEntropy_eq_iSup_generating` — by port (declared cone 11 files, 1,843 lines, all entropy; not trialled) | typed here as `Rigidity.ksEntropy_eq_iSup_ksEntropyOn`, a leaf of M1 |
| T4, a finite measure on the dual is determined by its Fourier coefficients (step 2 of the route; inside Lemma Γ) | Herglotz–Bochner's uniqueness, module M2 (to be formalized, ruling 4) | — |
| the defining property of conditional expectation on one invariant set; the kernel `condExpKernel` | Mathlib | — |
| Haar measure on the dual exists (`IsHaarFourier m`) and every rotation preserves it | module M4 (existence); invariance from T4 (`∫ χ(ur) dm = 0` for `r ≠ 0`) | — |
| the difference of two finite measures, one below the other | Mathlib: the `Sub` instance on `Measure` (`Measure.sub` is not a name at the pin, checked; its lemmas are M7's planner's to `#check`) | — |
| a point mass has entropy zero (the deriver's point of typing: `ρ` when `τ′ = 0`) | `Rigidity.ksEntropy_dirac` | typed, a leaf of M1 |

## What leaves the chain's list of classical inputs here

The uniqueness of the ergodic decomposition (cited three times by the older derivation; idle, replaced by one line, or on a route not taken); the ergodic decomposition for the whole group `U`; the measurability of `{m}` in a space of measures; Jacobs's formula as a formula. On the chosen route also: the Lebesgue decomposition with its uniqueness, and the ergodicity of Haar measure under one non-torsion unit vector (the second route's heaviest leaf).

## Derivation addresses

`plans/FS131-EN2-derivation.md` § 5.2 (EN2-PE2-MAX), §§ 4.1–4.3 (the Lebesgue route), § 4.4 (the permutation of components: true, idle); EN1 § 8.1 row 11: FS100-PE2 (`plans/FS100-derivation.md` l. 191); `plans/FS100-X02D-derivation.md` § 3.1 (l. 181, Lemma Γ), ll. 156–163 (Lemma W)

## Imports

M1, M4, M5, M6, M0 (lanes M0-mix, M0-gen, M0-erg), M2 for T4

## Exports

`entropySplit`

## Can run beside

Lives in a new file that the chain module's successor imports; after M5 and M6. Its statement of step 3 can be typed as soon as M4 has typed Haar measure on `Dual F`

## Not claimed

Any size or price. That the statements marked "to type" elaborate as written. The deriver's entries are [hand], one mind, "given Lemma Γ and Lemma W by statement"; the kernel is their second check. Lemma Γ and Lemma W themselves. What I read: EN2 §§ 4.0–4.3 and 5.2 in full; § 4.5 (the deriver's attack on its own argument) not read; X02D not read by me beyond the lines quoted there.
