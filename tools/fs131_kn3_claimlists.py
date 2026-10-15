#!/usr/bin/env python3
"""FS131-KN3 stage 6: write the draft claim lists of the later modules under data/fs131/kn3/.

Every leaf line a list quotes is copied by this script from data/fs131/claims-NF2.md by its id (standing rule 3: quoted,
never retyped); the Lean signatures are the ones in Proofs/HadwigerNelson/Rigidity/ (typed by this job) or are marked
"to type". `--check` regenerates in memory and fails if a file on disk differs (a retyped quotation would show here).
"""
import re, sys, pathlib
ROOT = pathlib.Path(__file__).resolve().parent.parent
OUT = ROOT / "data/fs131/kn3"
claims = {}
for line in (ROOT / "data/fs131/claims-NF2.md").read_text().splitlines():
    m = re.match(r"^(NF2-[A-Z0-9-]+): (.*)$", line)
    if m: claims[m.group(1)] = m.group(2)

def leaf(n):
    k = f"NF2-LEAF-{n:02d}"
    return f"> {k}: {claims[k]}\n> — source: data/fs131/claims-NF2.md § The chain's leaves\n"

D = "`plans/FS100-derivation.md`"; J45 = "`plans/FS84-SI-D-derivation.md`"; X01 = "`plans/FS100-X01D-derivation.md`"
X02 = "`plans/FS100-X02D-derivation.md`"; R88 = "`plans/R88-derivation.md`"; F105 = "`plans/FS105-derivation.md`"
EN1 = "`plans/FS131-EN1-derivation.md`"

M = {}
M["C0-smaller-set"] = dict(title="the smaller set: `T + A` measurable and rotation-stable; a non-torsion unit vector; Lemma F",
 leaves=[1], kind="an implementer's job, no planner: the routes are in the module's docstrings",
 statements=["`Rigidity.measurableSet_TA [NumberField F] : MeasurableSet (TA F)` — typed, `sorry`. Route: `TA F = ⋃_N {χ | χ^N ∈ archChars}`; `archChars = Φ⁻¹(S)` for the evaluation map `Φ : Dual F → (unitRing F → ℂ)` and `S` a countable union of continuous images of closed balls of `unitRing F →+ ℝ`, which is finite-dimensional because `unitRing F ⊆ F(i)` has finite rank.",
  "`Rigidity.rot_preimage_TA (u : unitVectors F) : rot u ⁻¹' TA F = TA F` — typed, `sorry`.",
  "`Rigidity.exists_nonTorsion_unitVector : ∃ u : unitVectors F, ∀ n : ℕ, n ≠ 0 → (u : ℂ) ^ n ≠ 1` — typed, `sorry`. Route: `(3 + 4i)² ≡ 3 + 4i (mod 5)`, so `(3 + 4i)ⁿ ≠ 5ⁿ` for `n ≥ 1`.",
  "to type — **Lemma F**: a torsion-free abelian group `A` of rank `n` has `|A/mA| ≤ mⁿ` (the leaf's quotation of X02D:100). Stated here once, upstream of M6 and M10, which both read it."],
 addr=f"EN1 § 8.1 row 1: J45 § 2.1 Lemma N1 (ll. 105–109) at `S = ∅` ({J45}); {EN1} § 4.1 step 3; {X02} l. 100",
 imports="none beyond `Rigidity/ChainAtTA`'s", exports="`chainInterface` with no `sorry` under it; `mrPlus_of_split_of_carried` on the standard three axioms; Lemma F",
 parallel="edits `Rigidity/ChainAtTA.lean` (the three proofs only) and one new file for Lemma F; shares no file with any other module if M6–M9 wait for it or work in files of their own",
 read="typed by me; proofs not attempted")
M["M0-entropy-port"] = dict(title="the entropy base, ported from `[OAIMath2026]` family 015 (a port job with its own brief)",
 leaves=[13, 17], kind="a port, by the method of `LEAN.md` § Assumptions (\"An outside Lean proof may be ported\"): cone from the source's compiled constants, a generator that refuses a patch to a statement, the licence beside the modules, a read-back across pins",
 statements=["`measureEntropy`, `observationEntropyRate`, `orbitEntropy_subadditive`, `tendsto_observationEntropyRate` — `PrimePackets/ShannonEntropy.lean` (453 lines, `import Mathlib` only).",
  "`observationEntropyRate_finite_mixture`, `measureEntropy_kernel_zero` — `PrimePackets/EntropyMixtures.lean` (540 lines over the file above).",
  "`measureEntropy_inverse` — `DukePrimeDegree/Entropy/EntropyInverse.lean` (92 lines over `ShannonEntropy`).",
  "`measureEntropy_eq_iSup_generating` — `PrimePackets/EntropyGeneratingSupremum.lean` with `GeneratingObservationEntropy`, `ConditionalProbabilityExpectation`, `ObservationSigmaAlgebra`, `ObservationConditionalProbability`.",
  "cone to compute before a call: `action_ergodic_decomposition` (`PrimePackets/ErgodicDecomposition.lean`, which imports `KernelEntropy` → `AtomMass`), `observationEntropyRate_blocks` (`DukePrimeDegree/Entropy/FiniteBlockEntropy.lean`, which imports `RootSubgroups`)."],
 addr="`plans/FS131-KN3-chain-plan.md` § Stage 4 (the survey); nothing of ours is derived here",
 imports="Mathlib", exports="the release's entropy of a map and its theorems, kernel-checked at this pin, under `Outside.`",
 parallel="new files under `Proofs/HadwigerNelson/Outside/` only; shares none",
 read="statement heads read; no proof read; nothing built. Size unknown; the release names its own friction (1,502 Mathlib commits between the pins)")
M["M1-entropy"] = dict(title="Kolmogorov–Sinai entropy: this library's definition pinned to the textbook's number",
 leaves=[13, 17], kind="planner and implementer",
 statements=["`Rigidity.blockEntropy_one`, `Rigidity.ksEntropy_id`, `Rigidity.ksEntropy_map` — typed, `sorry`.",
  "to type — the bridge: for `MeasurePreserving T μ μ` and a probability `μ`, `ksEntropy μ T =` the ported `measureEntropy μ T`.",
  "to type — **T2** for `ksEntropyOn`: for increasing `T`-invariant sub-σ-algebras `𝒜_k` with `⨆ k, 𝒜_k = m`, each countably generated, `ksEntropy μ T = ⨆ k, ksEntropyOn (𝒜_k) μ T` (X02D l. 173; from `measureEntropy_eq_iSup_generating`).",
  "to type — the consequence of **T3** the chain reads: a mixture over a Markov kernel of `T`-invariant probability measures with `ksEntropy = 0` has `ksEntropy = 0` (X02D ll. 207, 217; from `measureEntropy_kernel_zero`).",
  "to type — `ksEntropy μ (T^[q]) = 0 ↔ ksEntropy μ T = 0` for `q ≥ 1`, and `ksEntropy μ T⁻¹ = ksEntropy μ T` (FS105-DED's inputs).",
  "to type — **the model at positive entropy**: the shift on `ℕ → Bool` with the fair product measure has `ksEntropy = log 2`. The check that the definition under the axiom is not too small or too large."],
 addr=f"{X02} ll. 170–175 (T1–T4, \"textbook; exact theorem numbers not checked here\" — **the page for T2 is this module's planner's to name**); {F105} l. 24 (FS105-DED's classical inputs)",
 imports="`Rigidity/Entropy`, M0", exports="every entropy fact M5, M7 and M8 read",
 parallel="edits `Rigidity/Entropy.lean`; no other module does",
 read="definitions typed and elaborated by me; no lemma proved beyond `ksEntropy_zero_measure`, `ksEntropyOn_mono`, `measurableSet_nameCell`")
M["M2-herglotz-bochner"] = dict(title="Herglotz–Bochner on a countable discrete abelian group, with uniqueness; Bochner for an induced topology",
 leaves=[3, 11], kind="planner and implementer (ruling 4: formalized, a module of its own)",
 statements=["`SpectralChain.BochnerHerglotz G` for every countable `AddCommGroup G` — the `Prop` is through the gate; this module proves it.",
  "`SpectralInputs.BochnerOn t` for a topology `t` induced by a homomorphism with dense range into a locally compact abelian group — through the gate as a `Prop`; proved here in the form M10 reads."],
 addr="`[Rudin1962]` 1.4.3, 1.3.6 — **the page is not read** (`ARCHITECTURE.md` § Trust; the map's § X5). No derivation of ours",
 imports="`SpectralChain` (for the `Prop`), Mathlib's `RieszMarkovKakutani`", exports="discharges 13 takers of `BochnerHerglotz`",
 parallel="new files only", read="not read by me beyond the `Prop`s; size unknown")
M["M3-markov-kakutani"] = dict(title="Markov–Kakutani, twice: an invariant probability measure on a closed invariant set of colourings",
 leaves=[4], kind="planner and implementer (ruling 4)",
 statements=["`SpectralChain.InvariantMeasureOnClosed F` for every `F` with `unitRing F` countable — the `Prop` is through the gate; this module proves it."],
 addr="`[Kakutani1938]` — **not held, not read** (the map's § X5). No derivation of ours",
 imports="`SpectralChain`, Mathlib's `Measure/Prokhorov`", exports="discharges 7 takers", parallel="new files only", read="not read by me; size unknown")
M["M4-dual-with-topology"] = dict(title="the dual of a countable discrete group as a compact group: Haar measure in the page's form and in Fourier form",
 leaves=[15], kind="planner and implementer",
 statements=["to type — for a countable `AddCommGroup M`: a compact Hausdorff additive topological group structure on a type `DualGroup M` with a measurable bijection to `AddChar M Circle` (cylinder σ-algebra) that is a group isomorphism; `BorelSpace (DualGroup M)`.",
  "to type — under that bijection, `μ.IsAddHaarMeasure` for a probability `μ` on `DualGroup M` ⟺ `SpectralInputs.IsHaarFourier` of its image.",
  "to type — the dual of `DualGroup M` is `M` (Pontryagin duality for a discrete countable group, the half that says the characters of `DualGroup M` are the evaluations), so `IsSolenoid (DualGroup M)` when `M` is torsion-free of finite rank.",
  "to type — restriction `AddChar R Circle → AddChar M Circle` for `M ≤ R` is measurable, onto, and carries Haar to Haar."],
 addr=f"the leaf; {X02} § 3.1 steps 1, 3, 4 (what Lemma Γ reads of the maps `π_k`)",
 imports="`Rigidity/Solenoid`, `Arith/SpectralInputs`, Mathlib's `PontryaginDual`", exports="the object the pieces are, and the passage between the axiom's `X` and `Dual F`",
 parallel="new files only; can start now", read="not typed; whether Mathlib's `PontryaginDual` at the pin has the duality half needed is unchecked")
M["M5-totally-irreducible"] = dict(title="Theorem 1.2 from Theorem 1.3 (FS105-DED)",
 leaves=[16], kind="planner and implementer",
 statements=["`Rigidity.haar_or_zero_entropy` — typed, `sorry`: for a solenoid `X`, a totally irreducible, not virtually cyclic `ZdAction d X` and an invariant ergodic probability `μ`: `μ.IsAddHaarMeasure ∨ ∀ n, ksEntropy μ (α n) = 0`.",
  "to type — FS105-NVC: an irreducible, not virtually cyclic action has `2 ≤ d` and `NoVirtuallyCyclicFactors`; for a totally irreducible one, so does every restriction to a finite-index subgroup.",
  "to type — the finite-fibred step: for a finite `α_Λ`-invariant subgroup `G`, `ksEntropy` of `α n` on `X ⧸ G` for the image measure is `0` iff it is `0` on `X` (Abramov–Rokhlin over a finite-to-one factor)."],
 addr=f"{F105} l. 24 (FS105-DED), l. 35 (FS105-VC), FS105-NVC; its classical inputs C1–C6 in D § 2.2 there",
 imports="`Rigidity/PositiveEntropy`, M1", exports="`haar_or_zero_entropy` on the axiom",
 parallel="edits `Rigidity/PositiveEntropy.lean` (one proof) or proves it in a new file; shares none", read="statement typed by me; the deduction read only at its entry")
M["M6-pieces"] = dict(title="the pieces: an admissible `Γ`, the modules `M`, and PE-1′ — the pieces meet the printed hypotheses",
 leaves=[14, 19], kind="planner and implementer",
 statements=["to type — admissible `Γ = ⟨u, w⟩ ⊂ U_F` exists (Lemma W, X02D l. 156): over a general field by Chebotarev (to declare, the map's § X5), at a biquadratic `F(i)` by Dirichlet (`Nat.infinite_setOf_prime_and_eq_mod`).",
  "to type — for a finitely generated `ℤ[Γ]`-submodule `M ⊆ unitRing F` with `ℚM = F(i)`: `DualGroup M` (M4) is a solenoid, the action of `Γ ≅ ℤ²` on it is a `ZdAction 2`, **totally irreducible and not virtually cyclic** (PE-1′, X02D l. 146).",
  "to type — the `M_k` exhaust `unitRing F` and each is stable under `Γ`."],
 addr=f"EN1 § 8.1 row 11: {X02} l. 100 (Lemma F, in C0), l. 146 (PE-1′), l. 156 (Lemma W)",
 imports="`Rigidity/Solenoid`, M4, C0 (Lemma F)", exports="the non-degenerate model of `positive_entropy_rigidity`'s hypotheses (its item 3); the objects of M7",
 parallel="new files only; after M4", read="not read by me beyond the leaf lines; size unknown")
M["M7-entropy-split"] = dict(title="PE-2: Lemma Γ and the passage from `Γ` to `U`",
 leaves=[20, 17], kind="planner and implementer",
 statements=["`Rigidity.entropySplit [NumberField F] : EntropySplit F` — typed, `sorry`.",
  "to type — **Lemma Γ** (X02D § 3.1): for admissible `Γ` and a `Γ`-invariant, `Γ`-ergodic probability `ρ` on `Dual F`: `IsHaarFourier ρ`, or `ksEntropy ρ (rot γ) = 0` for every `γ ∈ Γ`.",
  "to type — from `Γ` to `U` (X02D § 3.2), over the ergodic decomposition for the countable group `U_F` (T1; existence from M0's port; **uniqueness is cited at ll. 205, 209, 225 and is not in the release by name**)."],
 addr=f"EN1 § 8.1 row 11: FS100-PE2 ({D} l. 191); {X02} § 3.1 (l. 181), § 3.2 (l. 196)",
 imports="M1, M4, M5, M6, M0", exports="`entropySplit`",
 parallel="edits `Rigidity/ChainAtTA.lean` at one proof, or lives in a new file that `ChainAtTA`'s successor imports; after M5 and M6",
 read="§ 3.1 read in full by me; § 3.2 at its first lines; size unknown")
M["M8-zero-entropy-carried"] = dict(title="EF_F⁺: zero entropy is carried by `T + A` (the pigeonhole carried to the field)",
 leaves=[21, 18], kind="its own planner; likely three or four modules (the model; Lemma PF and heights; Lemma 3.1′; the pigeonhole and the wandering step)",
 statements=["`Rigidity.zeroEntropyCarried [NumberField F] (h : NoRamifiedStableDyadic F) : ZeroEntropyCarried F` — typed, `sorry`.",
  "to type — the model of `Dual F` as `𝔸_𝒮/D` and, in it, `TA F` = the classes with a lift whose finite part is on the diagonal (FS105-B-M1; X01D § 2.0). **This is where the pigeonhole's reader gets its description of the one set `TA F`.** Needs `R = O′` (M9).",
  "to type — Lemma 3.1′ (X01D l. 226): zero entropy gives few names. **Open classical input**: Shannon–McMillan–Breiman in its almost-everywhere, non-ergodic form — absent from Mathlib and from the release by name — unless Steps 4–5 run on convergence in mean along chosen scales (a question for the derive lane)."],
 addr=f"EN1 § 8.1 row 12: FS100-EFP ({D} l. 162); {X01} § 2.0 (l. 118), l. 208 (Lemma PF), §§ 3.2–3.8; `plans/FS100-X12B-derivation.md` §§ 2.1–2.2; {F105} ll. 76, 86, 106, 110; FS100-EFG (b) ({D} l. 216)",
 imports="M1, M9, Mathlib's adeles and `NumberField.prod_abs_eq_one`", exports="`zeroEntropyCarried`",
 parallel="new files; after M9 and M1's definitions (which are typed)", read="not read by me; the largest block of the chain that is entropy; size unknown")
M["M9-ring-and-scope"] = dict(title="the ring and the scope: the class lies in the scope; `R = O′`; the density of `R` — with the two results the leaf list did not number",
 leaves=[], kind="planner and implementer; pure number-field arithmetic over Mathlib's API",
 statements=["`Rigidity.noRamifiedStableDyadic_of_tca [NumberField F] (h : TCA F) : NoRamifiedStableDyadic F` — typed, `sorry` (FS100-EXC: at a ramified stable dyadic prime `x·x̄ = 1` reads `x² = 1`, the level-one target is a perfect matching, ratio `1/2`).",
  "to type — `IsRamified P` ⟺ the ramification index of `P` over `F` is 2, for a stable prime (a check on the definition, against Mathlib's `Ideal.ramificationIdx'`).",
  "to type — **`R = O′`** (Lemma C′, FS91-J07-4): under `NoRamifiedStableDyadic F`, `unitRing F` is the subring of `fieldI F` of elements integral at every stable prime. *The deriver's row 14; not a numbered leaf.*",
  "to type — **density**: `unitRing F` is dense in the completion that carries `T + A` (J45 N1 (b) at `S = ∅`; or EN1 § 8.2 route 4, from `1/5 ∈ R`). *The deriver's row 3; not a numbered leaf.* Read by M12's extension step."],
 addr=f"EN1 § 8.1 rows 3, 14: `LEDGER.md` row 100; `plans/FS91-derivation.md` l. 136 (FS91-J07-4); FS100-EXC ({D} l. 297); J45 N1 (b) ({J45} ll. 114–120); `plans/FS86-R88-D-derivation.md` ll. 148–150",
 imports="`SpectralChain`, `Rigidity/ChainAtTA` (for the predicate)", exports="the scope of M8 and the density M12 reads",
 parallel="new files, and one proof in `Rigidity/ChainAtTA.lean`; can start now", read="FS91-J07-4 and FS100-EXC read at their entries; not typed beyond the first statement")
M["M10-continuity-group"] = dict(title="J45-N1 (a) at `S = ∅`: the characters continuous for the profinite-plus-archimedean topology are exactly `T + A`",
 leaves=[11], kind="planner and implementer",
 statements=["to type — the topology `τ′_∅` on `unitRing F`, and `SpectralInputs.contChars τ′_∅ = TA F`, both inclusions (EN1 § 3.3). **This is where the spectral lemmas' reader gets its description of the one set `TA F`.**",
  "then `SpectralInputs.spectral_carried_iff` reads at `TA F`, over `BochnerOn τ′_∅` (M2)."],
 addr=f"EN1 § 8.1 rows 2, 4: J45 § 2.1 (ll. 110–113, 126–135) ({J45}); {EN1} § 3.3; J28V-7 ({R88} l. 182: `NR` of finite index — Lemma F, in C0)",
 imports="`Arith/SpectralInputs`, `Rigidity/ChainAtTA`, C0", exports="N2 at `T + A` for M11", parallel="new files; after C0's Lemma F",
 read="not read by me beyond EN1's table; size unknown")
M["M11-a-plus"] = dict(title="A⁺ at `S = ∅` from R88-TCA (SI-1, SI-3 with SI-4)",
 leaves=[12], kind="planner and implementer",
 statements=["`(Rigidity.chainInterface F).APlusOfR88` — closed; this module proves it: `R88TCA → APlus0` at `T + A`."],
 addr=f"EN1 § 8.1 rows 5–7: J45 § 2.2 (ll. 145–159), § Stage 3 (ll. 240–250) ({J45})",
 imports="M10, M2, `Arith/SpectralInputs`, `Arith/FactorAction`", exports="the headline's `hAP`", parallel="new files; after M10",
 read="not read by me; size unknown")
M["M12-count"] = dict(title="the count: T-C(A) at `S = ∅` gives no colouring measure with spectrum on `T + A`; `m₁(ℝ²) < 1/4` declared",
 leaves=[7, 9, 10], kind="its own planner; several modules (the extension to `G_∅`; regularisation; the factors; the archimedean factor; a complex place)",
 statements=["`(Rigidity.chainInterface F).Count` — closed; this module proves it: `TCA F → R88TCA`.",
  "to type and declare — `m₁`, and `[AmbrusEtAl2023]` Thm 1, `m₁(ℝ²) ≤ 0.246989` (four items owed).",
  "to type — `[S9]`: at a stable prime the image of `U` in `𝓞/P^m` is every norm-one element."],
 addr=f"EN1 § 8.1 row 8: R88-TCA ({R88} l. 161), -TC-ext (l. 114), -TC-reg (l. 130), -TC-count (l. 144), -TC-Yp / -J28V-3 (ll. 135, 140), -TC-tab (l. 152); FS100-TCA ({D} l. 291), FS100-CX ({D} l. 293)",
 imports="M9 (density, `R = O′`), `Arith/StationaryRatio`, row 99's weak approximation", exports="the headline's `hCount`",
 parallel="new files; `m₁` and its import can start now", read="not read by me; the largest block that is ours and not entropy (the map); size unknown")
M["M13-cls"] = dict(title="CLS: `L(F) ≥ 5` gives T-C(A) at `S = ∅`, with the fourth-moment count at the dyadic targets (ruling 3)",
 leaves=[8], kind="planner and implementer",
 statements=["`5 ≤ localBound F → TCA F` — closed already; this module proves it.",
  "to type — EN1-UQ4: for `Q = 2^f ≥ 256` every non-trivial eigenvalue of `U_Q` has `3|λ| < Q + 1` (`Σ_n S_n⁴ ≤ 2Q³ − 2Q² − 3Q − 1`), with the exact spectra at 64 and 128."],
 addr=f"EN1 § 8.1 row 9: FS100-CLS ({D} l. 285), FS100-DLP (l. 287), FS100-G27 (l. 289); {EN1} § 7.1, § 7.3 (EN1-UQ4: one mind, prior art owed)",
 imports="`Arith/RatioBound`, `NormOneTarget`, `FloorPlanes`, `StandingFive`, `Floor128`", exports="the headline's `hCLS`",
 parallel="new files; independent of every entropy module; can start now", read="not read by me; size unknown")
M["M14-row-99"] = dict(title="row 99 at `L ≤ 4`; and the upper half, which is another planner's",
 leaves=[5, 6], kind="leaf 5 is on branch `fs131-wnf` (the brief); leaf 6 by the map's entry for row 99",
 statements=["`localBound F ≤ 4 → localBound F ≤ χ(F²)` — closed already (the headline's `hRow99`)."],
 addr="`LEDGER.md` row 99; `plans/FS91-derivation.md` § 3; the map's entry for row 99", imports="as the map's entry says", exports="the headline's `hRow99`; the equality's upper half",
 parallel="not this job's files", read="not read by me")
M["M15-instances"] = dict(title="the instances: `ℚ(√47)` first",
 leaves=[23], kind="planner and implementer",
 statements=["to type — `NumberField` for `ℚ(√47)`'s `Subfield ℝ`; `5 ≤ localBound` there; **`NoRamifiedStableDyadic` there (no stable prime of `ℚ(√47, i)` contains 2: the model of that hypothesis — `ℚ` itself fails it)**.",
  "then `χ(ℚ(√47)²) = 5` from `min_localBound_five_le_chromaticNumber_closed` and `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five`."],
 addr=f"EN1 § 8.1 row 17: FS100-Q47 ({D} l. 206), FS100-T1 (l. 116), FS100-COR (l. 299), FS100-FAM (l. 275), FS100-Q35 (l. 301), FS100-167's first route (l. 279)",
 imports="`Rigidity/ChainAtTA`, `Instances/SqrtFortySeven`", exports="the row's statement", parallel="new files; the place computations can start now", read="not read by me")

def render(key, m):
    s = f"# Draft claim list {key} — {m['title']}\n\n"
    s += f"*Drafted by FS131-KN3 (the chain's planner) for Keryx to fix; a draft, not a fixed claim list. Kind: {m['kind']}.*\n\n"
    if m["leaves"]:
        s += "## The leaves it carries (quoted by script)\n\n" + "\n".join(leaf(n) for n in m["leaves"]) + "\n"
    s += "## Statements\n\n" + "\n".join(f"{i}. {t}" for i, t in enumerate(m["statements"], 1)) + "\n\n"
    s += f"## Derivation addresses\n\n{m['addr']}\n\n## Imports\n\n{m['imports']}\n\n## Exports\n\n{m['exports']}\n\n"
    s += f"## Can run beside\n\n{m['parallel']}\n\n## Not claimed\n\nAny size or price. That the statements marked \"to type\" elaborate as written. What I read: {m['read']}.\n"
    return s

bad = 0
for key, m in M.items():
    path = OUT / f"claims-{key}.md"; text = render(key, m)
    if "--check" in sys.argv:
        if not path.exists() or path.read_text() != text:
            print("DIFFERS:", path.name); bad += 1
    else:
        path.write_text(text)
covered = sorted({n for m in M.values() for n in m["leaves"]})
first_layer = {2, 22}
missing = [n for n in range(1, 24) if n not in covered and n not in first_layer]
print(f"modules: {len(M)}; leaves carried by a module: {covered}; proved in the first layer: {sorted(first_layer)}; unassigned: {missing}")
sys.exit(1 if (bad or missing) else 0)
