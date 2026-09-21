# FS-66 close — the owner's drafts, written while the solve at 23 converges (2026-09-21)

*Paste-ready text for `CLAUDE.md`, to be completed with the 23 numbers (every `‹23: …›`) and then deleted from here in the closing
commit. Written in the file's post-compression conventions: § Notation's macros (`K`, `Γ_q`), one home per fact — numbers,
certificates, Lean names and addresses in the row; mechanism, reading and killing tests in the grokking; orientation items point.
After pasting: `python3 tools/claude_md_fact_audit.py --base <pre-close rev>` and `--dupes`.*

## § Notation — one new line (after the `Γ_q` line)

- **The tower at p** (p ≡ 3 (mod 4)): `G_k = UD(ℤ/p^k, 2)`, k ≥ 1, with `G₁ = Γ_p`; a Cayley graph on the norm-one group `S_k`,
  `|S_k| = p^{k−1}(p+1)`. Reduction `G_{k+1} → G_k` is a homomorphism, so χ(G_k) is non-increasing and α(G_k)/p^{2k} non-decreasing
  in k (row 75, G66). `L(F)` reads level one; FS-66 asks whether higher levels read lower.

## Ledger row 75

| 75 | **The residue ceiling does not drop up the tower at 7, 11, 19 ‹23: , 23› — one level-one inequality governs every level** (FS-66). **[kernel]** `chromaticNumber_unitQuadrance_zmod121 : (unitQuadrance (ZMod 121)).chromaticNumber = 5` on the standard three axioms — level two at 11 needs five, like level one — from an 883-point 1-minimal witness (4.4 CPU-min, 6.14 GB); the generic layer `unitQuadrance_colorable_of_ringHom`, `chromaticNumber_unitQuadrance_zmod_le_of_dvd`, `unitPairNat`, `unitPairNat_eq_true_iff`, `unpackPt`. **[hand]** *The fibre-share inequality:* a character of `G_k` of exact level ≥ 2 has `|λ| ≤ 2p^{k−1}` (the sum over a fibre `{s(1 + p^{k−1}·i·a)}` of `S_k → S_{k−1}` vanishes off at most two residues), so an independent set of `G_k` with fibre shares `φ ∈ [0,1]^{𝔽_p²}` over level one obeys `⟨φ, A₁φ⟩ ≤ 2Σφ(1−φ)`; with `B₁(p) = max Σφ` under it, `α(G_k) ≤ B₁·p^{2(k−1)}` and **`m·B₁ < p²` refuses m colours at every level at once**. **[cert]** Exact integer sum-of-squares certificates (format `fs66-b1-cert-v2`) of the second-level moment relaxation of `B₁`, its symmetry divided out by translation-Fourier blocks, each `CERTIFIED` by a frozen standard-library checker written from the specification (exit 0 CERTIFIED / 3 BOUND ONLY / 2 ERROR; sha256 `735b9267…`), re-run by the owner with identity-preserving plants refused, and joined to the statement by six hand links L1–L6: **`U = 14.015224` (7), `28.204320` (11), `77.511742` (19)** against 49/3, 121/4, 361/4 ‹23: ; `U = …` (23) against 529/5› — **no level at 11 or 19 is four-colourable, none at 7 three-colourable ‹23: , none at 23 five-colourable›**; `α(UD(ℤ/49,2)) = 686` exactly, `3,388 ≤ α(UD(ℤ/121,2)) ≤ 3,412`, `27,436 ≤ α(UD(ℤ/361,2)) ≤ 27,981`, and **`α(Γ₁₉) ∈ {76, 77}`** (was [76, 80]) ‹23: ; `α(Γ₂₃) ≤ …`›. **Consequences:** `χ_Bor(ℚ_p²) = 4, 5, 5` at 7, 11, 19 and `[BardestaniMallahiKarai2017]` Question 1 answered **no** (`χ_Bor(ℚ_p²) ≥ 1 + (p+1)/(2√p)`; `CLOSED-QUESTIONS.md` §1.8); the bracket at ℚ(√47) cannot be closed from above by residues at any depth (§1.7) ‹23: ; the prediction at ℚ(√167) holds at every level of its first usable tower›. **[hand, the prover's; checked by the owner]** the weighted form of *the tower never rises* is false at every p — a level-two set on one single-direction line carries `(p²−1)/(2p)` against the line's `(p−1)/2` (Lemma W); towers over a ring containing its residue field are impotent (Theorem E: the first `e` levels at a ramified place); every spectral fact and every `B₁` certificate holds for **every** twisted cover of `Γ_p` (Lemma T). **[tools]** the biclique structure of one step (between adjacent fibres, p disjoint `K_{p,p}` matching lines to lines; SAT encoding 397,972 clauses against 3.9 M) and the projection of a level-two resolution refutation onto level one. **Not claimed:** the plain `χ(ℚ_p²)`; `α(G_k) = p^{2(k−1)}α(G₁)` — **not proved** (`plans/FS66-tower-conjecture.md`); anything at 43, ℚ(√167)'s other plane below the spectral refusals. **Prior art:** the chain `χ(F²) ≤ χ(ℚ_p²) = χ(ℤ_p²) ≤ lim_k χ(G_k) ≤ χ(G₁)` is `[Madore2015]` Prop. 3.8; the `p`-adic problem is posed by his ¶1.5 and by `[BardestaniMallahiKarai2017]`; the completely-positive exactness of measurable independence density is `[DeCorteOliveiraVallentin2022]` (statements read, proofs unread). Ours: the inequality, the certificates and their checker, every value above, the answer. | `ResidueTower.lean`, `Instances/ZMod121Four.lean`, `Instances/ZMod121Four/`, `tools/fs66_b1_cert_check.py`, `tools/fs66_b1_cert_make.py`, `tools/fs66_owner_verify.py`, `data/fs66/b1/` (`cert-p*.json`, `records.jsonl`, `level-one-sets.json`, `SOUNDNESS.md`, `README.md`), `data/fs66/witness-p11-l2-k4/`, `data/fs66/owner/`, `plans/FS66-residue-tower-drop.md`, `plans/FS66-phase2-certificate.md`, `plans/FS66-tower-conjecture.md` | FS-66 |

## Grokking G66

* **G66 — Up a residue tower nothing drops where we can see, because a higher level is a *fuzzy* copy of level one and fuzziness is
  taxed; what is left of the question is the carry. [kernel + cert + hand; one reading]** The tower's limits are analytic objects:
  `lim_k χ(G_k)` is the clopen chromatic number of `ℤ_p²` and `lim_k α(G_k)/p^{2k}` its measurable independence density, with
  `χ(F²) ≤ χ(ℚ_p²) ≤ χ_Bor ≤ χ_clopen ≤ χ(Γ_p)` — so every ceiling this project owns, and `L(F)`, reads the *weakest* term of a chain
  whose other terms nobody had computed at an odd prime. **Why they do not drop** (row 75): every character of `G_k` that is new at
  level k is small (`|λ| ≤ 2p^{k−1}` against degree `p^{k−1}(p+1)`), so an independent set of any level is, to level one, a fractional
  set φ paying `2Σφ(1−φ)` for its fractional part — one inequality, the same at every level, and the certificates show it leaves no
  room for a fourth class at 11 or 19 ‹23: or a fifth at 23›. The 2- and 3-adic towers of row 67 are constant for a different reason
  (level one is Hoffman-tight); at `p ≥ 7` nothing is tight and the tax is what holds. **The gain is real locally and unaffordable
  globally**: on one single-direction line the p-cycle unrolls into a `p²`-cycle and a level-two set does beat the pull-back
  (Lemma W), so fibre shares leave the stable-set polytope and no pointwise transfer argument can exist; the plane forbids the gain
  only through its bracing as a whole (G45's over-determination, seen from the other side). **The whole content is the carry**:
  with the carry of integer addition set to zero the tower is over a ring containing `𝔽_p` and is impotent in two lines (Theorem E);
  and every instrument we own — the spectrum, the inequality, every `B₁` certificate — is blind to the carry, holding verbatim for
  every twisted cover (Lemma T). So the certificates prove more than was asked, and the method can prove *the tower never rises*
  at a prime only if no twist of `Γ_p` rises there. *Reading — the tower never rises: `α(G_k) = p^{2(k−1)}α(Γ_p)` for every p and k
  (true at level two of 7, `α = 686`; `B₁ = α(Γ_p)` numerically at 7, 11, 19), and the same for every twist.* **Killing tests:** a
  verified independent set of 687 in `UD(ℤ/49, 2)` (which would refute a hand link or the checker, not only the reading); of 3,389
  in any twisted cover of `Γ₁₁`. **What it does to the conjecture:** `L(F)` with every level allowed is the same number at 7, 11, 19
  ‹23: and 23›, so the prediction at ℚ(√167) ‹23: survives its first tower; 43 is unpriced› and ℚ(√47)'s bracket cannot close from
  above by residues (`CLOSED-QUESTIONS.md` §1.7). **Instrument lessons** [method]: ask the whole graph directly, clique pinned,
  before building any finder — the pilot fell in 1.7 s; a level-two resolution refutation projects onto level one, so CDCL refuses
  nothing up a tower that it cannot refuse at the bottom; the second-level moment relaxation with the symmetry divided out beats
  the three-point bound and the level-3 relaxation on these planes (77.5 against 80.59 at 19) and bounds `α(Γ_p)` itself — *"it must
  beat the last instrument's reading" was never an argument that it cannot* (the owner ruled 23 out of reach on exactly that and
  was overturned by the 19 reading); a rounded bound travels with its shift (positive definiteness survives iff
  `shift ≥ 10^(3−D)`; at 11 one knob moves `U` from 28.2021 to 30.5445) and tracks the **dual** residual; in the kernel the clause
  table is the graph's bill (super-linear) and the segments are the proof's.

## Touches elsewhere (each a sentence; numbers stay in row 75)

* **Item 12 / item 14 / G59's last paragraph** (ℚ(√167)): after "five is refused at 23 by certificate" add ‹23: "— at every level of
  the tower at 23 (row 75)"›.
* **G48** (the conjecture): after the proved range add "With every residue level allowed, `L` is unchanged at 7, 11, 19 ‹23: , 23›
  (row 75, G66) — the level-one form is not known to be the wrong form anywhere."
* **G54** (towers): after the inert-tower sentence add "Slack towers at 7, 11, 19 do not drop either, by certificate and not by the
  spectrum (row 75)."
* **G56 / item 11** ‹23 only, if `U < 89`: floors become 7, 6, 5, 6, 6; "χ(Γ₂₃) ∈ {7, 8}"; the window loses 23 at level one; FS-17's
  digit›. The seven-colour search at 23 (2026-09-21; three 10-minute arms, 14 threads; best 30 clashing edges of 6,348) found
  nothing: ceiling stays 8.
* **The prior-art position:** "Ours: … the fibre-share inequality and the all-levels certificates (row 75), the answer to the
  `p`-adic Hadwiger–Nelson question." "Not ours: the tower chain (`[Madore2015]` Prop. 3.8)."
* **"Last updated"**, **"Open milestones"**, **Paths forward** (FS-66 out; FS-59 alone at rank 1; FS-57, FS-65, FS-17 re-aimed at
  the second-level relaxation; new stubs listed).
* **§ Toolchain**, semidefinite row: "the second-level moment relaxation, symmetry by hand in Python: `tools/fs66_b1_cert_make.py`;
  no Julia needed to `n = 529`."
