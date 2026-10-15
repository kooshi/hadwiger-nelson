
## Stage 5 — SAVED: the lanes, the price, and the drafts

### 5.1 The lanes (none shares a file with another)

| lane | writes | reads (statements only) | who |
|---|---|---|---|
| **T-L** — `Rigidity/TateLocal`, 6 leaves | that file | Mathlib | an implementer; folds the three route copies first (`data/fs131/kt1/scratch/FormG.lean`), then `exists_nat_mul_integral_of_trace_int`, `exists_trace_not_int_away`, `compactSpace_adicCompletionIntegers` |
| **T-A** — `Rigidity/TateArch`, 3 leaves | that file | Mathlib | an implementer (small); may share a session with T-L, not a file |
| **T-C** — `Rigidity/TateCharacter`, 15 leaves | that file | T-L, T-A, the interface | an implementer; beside T-L and T-A |
| **T-K** — `Rigidity/TateKernel`, 9 leaves | that file | T-C, T-L, T-A; `exists_mul_stableIntegers_le` (lane M9-R), `eq_top_of_isClosed_of_dualCoannihilator_eq_bot` (lane PD) | an implementer; beside T-C |
| **T-I** — `Rigidity/TateModel`'s 4 derived leaves | that file | the fields | an implementer (small); first, since M8b-2..4 read `isOpenMap` and `π_eq_π_iff` |
| (assembly) | `Rigidity/TateExists` | — | none: `exists_tateModel` is proved, one field per fact |

`exists_tateModel` prints `sorryAx` until T-L, T-A, T-C, T-K are proved **and** lanes M9-R (`exists_mul_stableIntegers_le`)
and PD (D2's case) land. M8b-2..4 are planned and proved over `(D : TateModel F)` beside all of this.

### 5.2 The price (from stage 3's leaves and stage 4's table)

Measured: form G's first two leaves, 72 lines, closed in three elaboration rounds of a few minutes each. Planned: 30 leaves,
about 1,050 lines (§ 4.3), of which three leaves (72 lines) are written. The table prices each leaf against the measured ones;
four leaves are marked hard (the residue field of `O_v`, the Gram-matrix step, the split step, the compact set in the restricted
product), and I price those at two to three times the measured rate. **Price: about two agent-days of implementer work in
all** — about half a day for each of T-L and T-C, a little more for T-K, an hour or two each for T-A and T-I — **and about one
day of wall time with three lanes running at once.** That is under a week; no fallback is planned and no axiom is drafted.
`LEAN.md`'s rule applies: re-price from the first two leaves each implementer closes. FS131-KN9's price, made from Mathlib's
state and not from a leaf ("several days, two to four thousand lines"), was high: the inverse different, the local traces and
strong approximation all leave the route.

### 5.3 Drafts for files I do not write

- **`data/fs131/claims-NF2.md` § Dated lines** (each follows the last line there):
  - "2026-10-14 — **The model of the dual is typed as an interface, `Rigidity.TateModel F` (FS131-KT1).** `W = L_∞ × ∏′_{w
    split} L_w` (`Rigidity.SAdeleRing`, the archimedean factor Mathlib's mixed space) and a continuous `π : W → R̂`, equivariant
    for the unit vectors, onto, with kernel on the diagonal, `O′ ⊆ Λ ⊆ d⁻¹O′`, `W = K + O′` with `K` compact, and `π(L_∞) ⊆ A`;
    `π(L + L_∞) ⊆ T + A`, `Λ`'s `R`-stability and the openness of `π` are theorems over it. M8b-2..4 are proved over
    `(D : TateModel F)`; its existence is `Rigidity.exists_tateModel` (lane T). A typed interface, not a theorem."
  - "2026-10-14 — **Tate's self-duality in the form the model reads, on a global character (FS131-KT1; a plan, the kernel its
    test).** The standard character of `W` is `ψ(a) = e(Tr_∞(a_∞) − Tr(t))` for any `t ∈ O′` congruent to `a` modulo `O_w` at
    every split prime; it needs no local trace. Two inputs carry it, both over every number field and both elaborated in
    scratch: approximation away from one prime, by the Chinese remainder theorem, and the integrality of the trace of an
    element integral at every prime. The product formula on `O′` is then the definition read at one point. `O′^⊥ ⊆ L` follows
    from the archimedean trace duality, the denominators of the trace dual of `𝓞`, and one element integral off a split prime
    with a non-integral trace. The inverse different, the local traces `L_w → ℚ_p`, strong approximation and Lusin–Souslin
    leave lane T's inputs. Priced at about two agent-days."
- **`LEAN.md` § Searching — Lean**, new lines:
  - "Mathlib at the pin has the uniform continuity of `K → L` for the adic valuations of a prime and one above it
    (`IsDedekindDomain.HeightOneSpectrum.uniformContinuous_algebraMap_liesOver`, `valuation_liesOver`,
    `Mathlib/NumberTheory/RamificationInertia/Valuation.lean`), so the map `K_v → L_w` is `UniformSpace.Completion.mapRingHom`
    of it through `adicCompletion.equiv`. But it constructs no `Algebra (v.adicCompletion K) (w.adicCompletion L)`: its
    `Module.Finite Kv Lw` takes one as a `variable`. It has no trace on an `adicCompletion`, no decomposition
    `L ⊗_K K_v ≅ ∏_{w | v} L_w`, no additive character of `ℚ_[p]`, and no finiteness of the residue field of
    `adicCompletionIntegers` (FS131-KT1, `data/fs131/kt1/scratch/FormL.lean`)."
  - "Approximation away from one prime of a Dedekind domain (`s ∈ K` congruent at `v`, modulo the integers, to an element
    integral at every other prime) is 45 lines over `IsDedekindDomain.exists_forall_sub_mem_ideal` (write `s = n/c`, solve
    `y ≡ n` mod `v^{v(c)}` and `y ≡ 0` at the other primes dividing `c`, take `y/c`); its form in `K_v` adds
    `HeightOneSpectrum.denseRange_algebraMap` and `DenseRange.exists_mem_open` (FS131-KT1, `scratch/FormG.lean`)."
  - "The restricted product of topological rings is a topological ring only given `Fact (∀ i, IsOpen (A i))`, which Mathlib
    supplies by a local `haveI` for `FiniteAdeleRing`; a restricted product over another index set needs its own instance
    (`Rigidity.splitAdeleRing_isOpen_integers`, FS131-KT1)."
  - "`IsDedekindDomain.HeightOneSpectrum.uniformContinuous_algebraMap_liesOver` takes `K L v w` explicitly in that order (the
    file's `variable (K)` comes after `(L)`), and `adicCompletion.continuous_toCompletion K v` takes both explicitly
    (FS131-KT1)."
- **`BIBLIOGRAPHY.md`**: no new row. `[Tate1950]` (§ 4.1, the additive self-duality) and `[ChothiEverestWard1997]` (the
  `S`-integer duality) are cited in `Rigidity/TateExists`' docstring, and `[Weil1967]` (IV.2) beside them; **none was read by
  this job** (the rows' status stands: not held, not read). The route of lane T is this job's own and needs none of them.
- **`ARCHITECTURE.md`**: written by this job (six rows: `Rigidity/TateModel`, `TateExists`, `TateLocal`, `TateArch`,
  `TateCharacter`, `TateKernel`); § Trust: nothing new (no axiom).
- **The draft claim list** `data/fs131/kn3/claims-M8-zero-entropy-carried.md`: a section "Since FS131-KT1" added in place (its
  old text kept above it and in git).
