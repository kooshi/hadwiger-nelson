# M53 — the theorem audit (FS-71 batch 3a; ledger row 47)

*Filed 2026-09-22 by the batch-3a implementer. Enumeration: `plans/M53-iteration-5.md` (in full — mission
context through §R5, "HALT"); `plans/FIELD-WALL-THEOREM.md` (in full — every numbered proposition, §1–§10.2);
`plans/FIELD-WALL-SESSION-HANDOFF.md` (in full); `plans/B1-field-wall-kernel.md` (in full — the kernelization
event, dated 2026-09-08, read to fix the exact Lean declarations and to decide what M53's hand theorems are
kernel already); `plans/STUB-field-wall.md`, `plans/STUB-field-wall-kernel.md` (in full — both short; the
latter's proof route is superseded by B1's actual shape, recorded as context, not filed); `plans/DESCENT-ALGORITHM.md`
(spot-checked per the brief — grepped for `theorem|lemma|Theorem` and its "The wall — a theorem" section read in
full; the "minimum-halo theorem" (WO-9) already classified out of scope by batch 2b's `plans/M51-derivation.md`,
confirmed here, not re-filed); `LEDGER.md` row 47 and § B; `Proofs/HadwigerNelson/FieldWall4.lean`,
`ResidueColouring.lean`, `PartnerLattice.lean` (declaration lists, to fix kernel names and decide what a
FIELD-WALL-THEOREM.md proposition already has in the kernel — and what it does not).*

## Provenance, read once

`plans/FIELD-WALL-THEOREM.md` (a repository copy of `~/field-wall-conjecture.md`) was not written by the M53
implementer. Kooshi asked a **separate session** — briefed only to "write the field-wall conjecture up" for a
reader with no knowledge of this project — to produce a note, and that session proved the conjecture instead
(`plans/M53-iteration-5.md` §R5: *"another session, asked to write the field-wall conjecture up, proved it"*;
`FieldWall4.lean`'s own docstring: *"the session that was asked to write the conjecture up for a stranger and
proved it instead"*). M53 (the milestone proper) halted on reading that proof, verified it computationally
(§R5's "Checked here, before believing"), and wrote up what it means for the descent. Per the brief's convention
("the field-wall file's theorems are M53's… unless the file says another milestone proved them") and per
`plans/FS71-theorem-audit.md` §M.2 ("the home of a theorem is where it was proved"), every theorem in
`FIELD-WALL-THEOREM.md` is credited below as **hand; Kooshi's parallel session (2026-09-05), consumed and
computationally checked by the M53 implementer** — no other milestone number claims it. §7.2–§7.5's material
(the residue obstruction, the wall-break census, the two witnesses) is the M53 implementer's own extension of
the note, run and recorded in the same file and in `plans/FIELD-WALL-SESSION-HANDOFF.md`.

**Cross-batch note, flagged for whoever reads row 57 (assigned to batch 3b).** Theorem A and Theorem B were
kernelized eight days later by a separate backlog item, B1 (`plans/B1-field-wall-kernel.md`, dated 2026-09-07/08,
`Proofs/HadwigerNelson/FieldWall4.lean` + `ResidueColouring.lean`), indexed at `LEDGER.md` row 57. B1's proof
**does not follow the route this file's §5 describes** — it abandons the valuation-ring/DVR machinery entirely
for a direct parity descent (`plans/B1-field-wall-kernel.md` §1: *"None of it is needed"*) — so the kernel
theorem is the same **statement**, reached by a different **argument**. Below, M53-T1–T3 are filed as M53's hand
theorems (proved first, by the note's own route) with their kernel status recorded as *kernel, by a different
proof, eight days later* — matching the M50→M51 spare-colour-lemma precedent (`plans/M50-derivation.md`,
`plans/M51-derivation.md`), and matching `plans/FS71-theorem-audit.md` §M.2's rule that a theorem re-attributed
entirely to a later kernel proof still gets its own row, honestly marked. **Batch 3b should not re-file
Theorem A/B as row-57 theorems without cross-checking this entry** — the statement is one fact, filed once.

## The theorems

**M53-T1 — Theorem A: the residue-colouring theorem (general number field form). [hand; Kooshi's parallel
session, 2026-09-05]** Let `F ⊂ ℝ` be a number field, `L = F(i)`, and let `𝔭` be a nonzero prime ideal of `O_L`
fixed by complex conjugation (`𝔭̄ = 𝔭`). Then the unit-distance graph on `F²` is properly colourable with
`N(𝔭) = |O_L/𝔭|` colours, hence `χ(G(F²)) ≤ min{N(𝔭) : 𝔭 a prime of L with 𝔭̄ = 𝔭}`. *Proof:*
`plans/FIELD-WALL-THEOREM.md` §5.1 — every unit vector is a `𝔭`-adic unit (conjugation fixes the valuation),
so the residue map colours properly on each coset of the local ring `O_(𝔭)`. *Proof verdict:* closes (the
argument is three lines of valuation theory, checked by hand here and reproduced independently, in a different
shape, in the kernel — see *Kernel* below). *Rests on it:* M53-T2, M53-T3, M54's D1 corollary, every later use
of a conjugation-fixed prime (rows 52, 56, and G43's field sieve). *Prior art:* **partly** — this is
`[Madore2015]` Prop. 3.2 (the valuation-ring form: an anisotropic quadratic form over the residue field gives a
graph homomorphism into the valuation ring, exactly this argument for `d = 2`) with `[Fischer1990]` Thm 1's
additive-colouring framing (the residue map restricted to the unit-vector subgroup is his `v`); Woodall's
2-colouring of `ℚ²` is the `F = ℚ`, `𝔭 = (1+i)` instance (`[Woodall1973]`, held not read — via `[Fischer1990]`
and `[Soifer2024]`). The **number-field-specific** existence claim — that a conjugation-fixed prime of `F(i)`
always supplies a valuation subring with residue field of exactly size `N(𝔭)` — is not separately stated in
either held paper as a number-field theorem (both work with a fixed field or a fixed prime); no fresh zbMATH
query run (the held bibliography's reconciliation of Madore/Fischer/Moorhouse against this exact statement is
already exhaustive — `BIBLIOGRAPHY.md` §A entries for `[Madore2015]`, `[Fischer1990]`, `[Moorhouse2010]`, all
read in full). *Kernel:* the **abstract ring machinery** is kernel — `colorable_of_residue`,
`normOne_subset_valuationSubring`, `colorable_unitDistance_induce_of_valuationSubring`
(`ResidueColouring.lean`, row 57) — but the **number-field step** (a conjugation-fixed prime of `F(i)` always
gives such a valuation subring) is **not proved in the kernel for a general number field**: this is exactly
`LEDGER.md` row 57's flagged gap (*"Not proved: that a number field with a conjugation-fixed prime supplies the
valuation subring with residue field of size N(𝔭)"*), FS-47's territory. So M53-T1, as a general-number-field
theorem, is **stub (FS-47)** — the machinery it would need is kernel, the connecting step is not.

**M53-T2 — Lemma 5.2: the splitting of 2 in K(i) = ℚ(i,√3,√11). [hand; Kooshi's parallel session, 2026-09-05]**
`L = K(i)` is Galois over `ℚ` of degree 8 with group `(ℤ/2)³`; `2·O_L = (𝔭₁𝔭₂)²` with `𝔭₁ ≠ 𝔭₂`, each of residue
field `𝔽₄`, and complex conjugation fixes each `𝔭ⱼ` (its decomposition field is `ℚ(√33)`, the unique quadratic
subfield of `L` in which `2` splits completely, and `√33 ∈ ℝ` is conjugation-fixed). *Proof:* `plans/FIELD-WALL-THEOREM.md`
§5.2, via the local factorization `ℚ₂(i,√3) = ℚ₂(ζ₁₂)` (ramified-times-unramified) and a decomposition-group
argument; a "concrete cross-check" with an explicit Hensel lift `s ≡ 17 (mod 256)` of `√33` is given alongside.
*Proof verdict:* closes. *Rests on it:* M53-T1 applied to `K`; M53-T3. *Prior art:* ours — a specific-field
computation, standard local-field technique, no paper computes this exact field; superseded in practice, see
*Kernel*. *Kernel:* **the conclusion is kernel, by an entirely different argument that makes this lemma's own
machinery (the decomposition group, the local factorization `ℚ₂(i,√3) = ℚ₂(ζ₁₂)`) unnecessary.**
`plans/B1-field-wall-kernel.md` §1 replaces the whole lemma with a four-line parity computation over an explicit
order `O = ℤ[ω,i,T]`: two ring homomorphisms `ψ₁, ψ₂ : O → 𝔽₄` are exhibited directly (`T = (1+√33)/2 ↦ 0` or
`1`), their joint kernel is shown to be `(1+i)O` by halving, and conjugation's fixing of each prime becomes a
four-line Frobenius identity over `ZMod 2` — no ideal, no localization, no decomposition group. So Lemma 5.2's
**statement** is kernel (`FieldWall4.lean`'s `psiZero`, `psiOne`, the descent lemma of §4 in the module layout)
but its own **Galois-theoretic proof** is not what got formalized; declined as a separate kernel target (the
easier route already closed the statement).

**M53-T3 — Theorem B: χ(G(K²)) = 4 for K = ℚ(√3,√11). [hand; Kooshi's parallel session, 2026-09-05]** Every
finite unit-distance graph with both coordinates in `K` is properly 4-colourable (the explicit residue colouring
of M53-T1 at `𝔭₁` of M53-T2), and the Moser spindle — drawable in `K²`, with `K` the smallest field containing
one (M53-T4) — needs four. *Proof:* `plans/FIELD-WALL-THEOREM.md` §5.3, plus the consistency checks of §5.4
(Woodall's theorem as the `F = ℚ` instance; every distance of positive `𝔭`-adic valuation monochromatic,
matching the already-held pigeonhole fact that every proper 4-colouring of the plane has a monochromatic
distance-2 pair; every known 5-chromatic graph's field failing the conjugation-fixedness hypothesis).
*Proof verdict:* closes — and independently checked here (not merely asserted): the residue colouring is exhibited
proper on all 1,004 unit edges of the Exoo–Ismailescu seed and on all 13,796 of the M53 descent object, on both
2-adic branches, zero search (`tools/residue_colouring.py`, `data/m53/residue-{seed,it4}.json`). *Rests on it:*
the whole M53 halt (a K-point descent cannot force five colours — row 47, M53-T11 below); the seam-field closures
(rows 1–25) as instances; `LEDGER.md` row 57's value; `[Fischer1994]`'s independent 1994 proof of the same value
(found 2026-09-19, read 2026-09-22 — see *Prior art*). *Prior art:* **the exact value is `[Fischer1994]`'s**
(K. G. Fischer, *A planar geometric graph of chromatic number four*, Congressus Numerantium 104 (1994) 73–79),
an additive `ℤ/4`-colouring of the plane over his congruence family `p ≡ 3, q ≡ 11 (mod 16)`, `pq ≡ 1 (mod 32)`
— `K = ℚ(√3,√11)` is `p = 3, q = 11` — proving *"the chromatic number of this graph is 4"* in those words,
thirty-two years before this project (`BIBLIOGRAPHY.md` §A `[Fischer1994]`, read in full and verified
2026-09-22, `LEDGER.md` row 57 and `CLAUDE.md` § Publication). What stays ours: the kernel proof (a different
argument and a different, `𝔽₄`-valued colouring — G41); Theorem A's general form, of which Fischer's congruence
family is a proper subfamily; the descent consequences (§7). `[Madore2015]` Prop. 4.6 had bracketed
`4 ≤ χ(ℚ(√3,√11)²) ≤ 5` in 2015 without closing it (footnote 3: he knew `χ(𝔽₁₁²) = 5` and did not use it).
zbMATH: none run beyond the held bibliography's own exhaustive search, which already found `[Fischer1994]` by
the author-listing route (`WORKFLOW.md` 3.2 item 8) — re-querying would only reproduce that result. *Kernel:*
kernel — `chromaticNumber_seamPlane`, `four_colorable_of_seam_field` (`FieldWall4.lean`, row 57, dated
2026-09-08, eight days after this hand proof; see the cross-batch note above). Also kernel, from the same file:
`not_forces_five_seamPlane` / `not_separated_five_seamPlane` (the sentence that halted M53, via `SpareColour`)
and `residueColouring_eq_of_dist_two`.

**M53-T4 — Lemma 4.1: K is the smallest field containing a Moser spindle. [hand; Kooshi's parallel session,
2026-09-05]** If `F ⊆ ℝ` is a field and `F²` contains a unit equilateral triangle, then `√3 ∈ F`; if `F²`
contains a Moser spindle, then `√3, √11 ∈ F`, hence `K ⊆ F`. *Proof:* `plans/FIELD-WALL-THEOREM.md` §4 —
the third vertex of a unit equilateral triangle on `a, b ∈ F²` is `(a+b)/2 ± i(√3/2)(b−a)`, forcing `√3 ∈ F`;
the spindle's two rhombus diagonals `u, u′` (`|u|=|u′|=√3`, `|u−u′|=1`) give `Re(uū′) = 5/2`,
`Im(uū′) = ±√11/2`, forcing `√11 ∈ F`. *Proof verdict:* closes — elementary coordinate algebra, checked by
hand. *Rests on it:* the framing sentence "K is the Moser field" (used throughout §6–§8 and in
`FieldWall4.lean`'s docstring); not load-bearing for Theorem B itself (which only needs the spindle to exist
in `K²`, not minimality). *Prior art:* **prior art** — `[Moorhouse2010]` §1, Prop. 1.4(b) (held, read in
full): "`K` holds a Moser spindle iff `K` holds `1/66, √3, √11`" identifies the same field as the smallest one
containing a Moser spindle, and is the headline `BIBLIOGRAPHY.md` credits to him ("he identifies ℚ(√3,√11) as
the smallest number field whose plane contains a Moser spindle… and writes 'We have not determined the exact
value'"). No fresh zbMATH query needed — the held bibliography's own note already states this is his. *Kernel:*
declined — an elementary coordinate fact about one specific object (`Ladder.sqrt_indep` gives the
ℚ-independence it needs, but no consumer has asked for a minimality theorem; only the spindle's *membership* in
`K²` is kernel, via `FieldWall4.lean` §8's `spindleOrd`).

**M53-T5 — Proposition 6.1 + Corollaries 6.2, 6.3: the criterion at 2, general number field. [hand; Kooshi's
parallel session, 2026-09-05]** For a number field `F` and a prime `𝔮` of `F` above 2: the primes of `F(i)`
above `𝔮` are fixed by conjugation iff `𝔮` does not split in `F(i)/F`, iff `−1 ∉ F_𝔮×²`; then there is exactly
one such prime `𝔭`, with `N(𝔭) = N(𝔮)^f`, `f ∈ {1,2}` the residue degree of `F_𝔮(i)/F_𝔮`. **Corollary (four
colours):** if some prime `𝔮` above 2 has `−1 ∉ F_𝔮×²`, with `N(𝔮) = 2` or (`N(𝔮) = 4` and `F_𝔮(i)/F_𝔮`
ramified), then `χ(G(F²)) ≤ 4`. **Corollary (necessary for five):** if `F²` holds a 5-chromatic graph, `−1` is a
square in every completion of `F` above 2 with residue field `𝔽₂`. *Proof:* `plans/FIELD-WALL-THEOREM.md` §6.1
— conjugation generates `Gal(F(i)/F)` and permutes the primes above `𝔮`; it is trivial on a split prime, so
conjugation swaps the two factors; the corollaries are M53-T1 applied at the two admissible `(N(𝔮), f)`
combinations. *Proof verdict:* closes (elementary local field theory). *Rests on it:* the whole "wall" reading
(G1, G35); the multiquadratic specialization (M53-T6/M53-T7). *Prior art:* the mechanism (conjugation-fixed
prime above 2 iff `−1 ∉ F_𝔮×²`) is the local-field content behind `[Fischer1990]` Thm 8 and `[Moorhouse2010]`
§7.1 (both held, read in full); the general-number-field statement in this exact form is not separately
attested in either — both work case-by-case (quadratic fields for Fischer, odd degree for Moorhouse). No fresh
zbMATH query (both held papers already searched and reconciled at this exact question — `BIBLIOGRAPHY.md`).
*Kernel:* declined — subsumed by the field-specific instances that ARE kernel (K's case via M53-T2/T3; the
multiquadratic two-colour case via `TwoColourResidue.lean`, row 63); the general local-field statement over an
arbitrary number field `F` has no Lean form and no named consumer beyond what the instances already supply.

**Proposition 6.4 (multiquadratic wall criterion), original and corrected — NOT given a fresh id; = row 63 /
FS-36. [hand; the original 2026-09-05 by Kooshi's parallel session, self-corrected 2026-09-06 (§10.1) and by a
further correction 2026-09-11 (§10.2)]** For `F = ℚ(√d : d ∈ S)` real multiquadratic, all 2-adic completions are
`ℚ₂(√e : e ∈ S)`, and `−1` is a square there iff `S` contains an odd element `≡ 7 (mod 8)`. **Original §6.2:**
"if no odd element of `S` is `≡ 7 (mod 8)`, `χ(F²) ≤ 4`; the bound improves to 2 when the completion of `F(i)`
has residue field `𝔽₂`" — **wrong**: the two-colour clause is too narrow (`ℚ(√5)` is bipartite by
`[Fischer1990]` Thm 8, but its completion has residue field `𝔽₄`, so the original clause put it under "four").
**Corrected form (§10.2, 2026-09-11), = `LEDGER.md` row 63 / FS-36's theorem:** with `V ⊆ ℚ₂×/ℚ₂×²` the image
of `S`: (a) `[−1] ∉ V ⟹ χ ≤ 4` (unchanged); (b) `[−1] ∉ V ∧ [3] ∉ V ⟹ χ = 2`; (c) `[−1] ∈ V ∨ [3] ∈ V ⟹ χ ≥ 3`
— together, `χ(F²) = 2` exactly when no odd element of `S`'s square-class group is `≡ 3 (mod 4)`. *Proof:*
`plans/FIELD-WALL-THEOREM.md` §10.2's (b)/(c), turning on whether `L/E` (`E` the 2-adic completion, `L = E(i)`)
is ramified — complex conjugation then lies in the inertia group and acts trivially on the residue field, so
every unit vector's residue is `1`, and a linear functional gives two colours. *Proof verdict:* closes (checked
against all sixteen subgroups of the local square-class group by
`reference/ChatGPT-multiquadratic/independent_check.py`, per the file's own record). *Rests on it:*
`LEDGER.md` row 63's own text, `CLAUDE.md` G38's two-colour clause. *Prior art:* **this correction IS
`LEDGER.md` row 63 / milestone FS-36's theorem** — same statement, same date (2026-09-11), same credit ("the
decomposition is ChatGPT's, with Kooshi, 2026-09-11" per row 63; the same session's handoff is named in this
file's own §10.2 header). **Cross-batch note: FS-36 is assigned to batch 5** (`plans/FS71-theorem-audit.md`
§G.2, row 63), which owns the prior-art check against `[AxenovichEtAl2014]`/`[Johnson2006]` row 63 itself
flags as owed. **Not re-filed here as a separate § B line** to avoid a duplicate row for one fact filed under
two ids; this entry exists only to record that the correction landed inside `FIELD-WALL-THEOREM.md` and to
point at its true home. **Distinct from row 63's other content**: row 63 also credits Fischer/Moorhouse/Madore
for the *mechanism*, which this file's own §10.1 (below, M53-T7) already worked out for the quadratic case one
day before §10.2's multiquadratic generalization. *Kernel:* not filed here — see row 63 (`TwoColourResidue.lean`,
`SquareClass.lean`), batch 5.

**M53-T7 — Corollary 6.5: real quadratic fields under the 2-adic criterion. [hand; the original 2026-09-05,
corrected 2026-09-06 in §10.1 after reading Fischer's 1990 paper]** For `d > 1` squarefree, `F = ℚ(√d)`: the 2-adic
completion of `F(i)` contains `√−1` iff `d ≡ 7 (mod 8)`, and a primitive cube root of unity iff `d ≡ 3, 5
(mod 8)`. **Corrected verdicts** (§10.1, replacing the file's own original which put `d ≡ 5 (mod 8)` under
"≤ 4"): bipartite for `d` even or `d ≡ 1 (mod 8)` — **and, per `[Fischer1990]` Thm 8's exact criterion `N ≢ 3
(mod 4)`, also for `d ≡ 5 (mod 8)`**; at most 4-chromatic for `d ≡ 3 (mod 8)` (Thm 10); 3-chromatic for
`d ≡ 3, 7 (mod 12)` (Thm 9, giving the exact values `χ(ℚ(√3)²) = χ(ℚ(√7)²) = 3`); beyond the residue method
for `d ≡ 7 (mod 8)`, where the note itself exhibits an explicit unit 5-cycle in `ℚ(√7)²`
(`0, −1, −1+ζ, −1+2ζ, −1+2ζ+(w/2)(−1+i)`, `ζ = (3+i√7)/4`, `w = (1+i√7)/2`), giving `χ(G(ℚ(√7)²)) ≥ 3` with
no equilateral triangle. *Proof:* `plans/FIELD-WALL-THEOREM.md` §6.2's original criterion plus §10.1's
self-correction against `[Fischer1990]`, read in full 2026-09-06. *Proof verdict:* closes for the corrected
form; the original form (published in §6.2 before §10.1) is a demoted claim, kept in this entry per
`plans/FS71-theorem-audit.md` §S.1's "including whether a later row or grokking corrected it." *Rests on it:*
G38's real-quadratic summary; the census of row 74 (fourteen certified `d ≡ 11 (mod 12)` fields). *Prior art:*
**the classification is `[Fischer1990]`'s** (Thms 8–10, held, read in full 2026-09-08) — `χ(ℚ(√3)²) =
χ(ℚ(√7)²) = 3` is his in print, and this project's own §10.1 already records the correction and the
attribution in full ("χ(ℚ(√3)²) = χ(ℚ(√7)²) = 3 is Fischer's, not this note's"). **Ours: the explicit unit
5-cycle in `ℚ(√7)²`** — a constructive witness the paper does not exhibit. No fresh zbMATH query (the held
paper's exact theorem numbers already reconciled in the note's own §10.1). *Kernel:* declined — the
5-chromatic-field classification for real quadratic fields is superseded by the certified census of row 74
(FS-58/FS-61, batch 6's territory); the explicit `ℚ(√7)` 5-cycle has no kernel form and no named consumer.

**M53-T8 — Theorem A′ + Corollary 6.6: the linear (additive-subgroup) refinement and the 3-adic wall. [hand;
Kooshi's parallel session, 2026-09-05]** Let `𝔭` be a conjugation-fixed prime of `F(i)` with residue field `k`,
`k₀` the residue field of `𝔮 = 𝔭 ∩ F`. Every unit vector's residue lies in the norm-one group
`C = {c ∈ k× : c c̄ = 1}`; if `H ⊆ k` is an additive subgroup with `H ∩ C = ∅`, then `z ↦ (z mod 𝔭) + H` is a
proper colouring with `[k:H]` colours. **Corollary 6.6 (the 3-adic wall):** if `F` has a prime above an odd
`p ≡ 3 (mod 4)` of residue degree one, `χ(G(F²)) ≤ p` — such a `𝔮` has residue field `𝔽_p` (no square root of
`−1`), so it is inert in `F(i)`, `C` has order `p+1`, exactly `(p+1)/2` of the `p+1` lines of `𝔽_{p²}` over
`𝔽_p` meet `C`, and a line avoiding it gives `p` colours. *Proof:* `plans/FIELD-WALL-THEOREM.md` §6.2′ — a unit
step changes the residue by an element of `C ∌ H`, so the descent to `k/H` is still proper; the line-counting
argument for `Corollary 6.6` (`λc ∈ C` forces `λ² = 1`, so a line meets `C` in `{c,−c}` or not at all).
*Proof verdict:* closes. Consequences drawn in the same section: `χ(ℚ(√3)²) = 3` (3 ramifies with residue
`𝔽₃`) and `χ(ℚ(√7)²) = 3` (3 splits in `ℚ(√7)`, giving a degree-one prime) via the elementary line-counting
argument alone — matching M53-T7's Fischer-attributed values by an independent, self-contained route; `K`
escapes (its primes above 3 have residue field `𝔽₉`, containing `√−1`, so they split in `K(i)` and Theorem A′
has nothing to colour with — consistent with the Moser spindle standing in `K`). The **residue chromatic
number** `χ_res(F)` (the least `[k:H]` over all conjugation-fixed primes and admissible `H`) is defined here,
with `χ_res(ℚ) = 2`, `χ_res(ℚ(√3)) = χ_res(ℚ(√7)) = 3`, `χ_res(K) = 4` (each exact), `χ_res(ℚ(√3,√5,√11)) = 11`
(Heule's field — above the plane's own 7, hence uninformative there). *Rests on it:* **the first instance of
"the linear method"** `CLAUDE.md` G38 asks about (*"the linear method's thresholds (2, 3, 4, then nothing below
7 — proved where? M56)"*) — this file (M53) is the origin; row 50 (M56, "the additive yardstick") is a later,
more general additive-colouring framework and **may subsume, generalize, or independently rediscover this**;
**cross-batch note, flagged for whoever reads row 50 (assigned to batch 3b):** check M56's `Additive.lean`
against Theorem A′/Corollary 6.6 before crediting M56 with originating the linear method — this file predates
it by ten days. *Prior art:* Theorem A′'s subgroup-quotient idea is the additive-colouring machinery of
`[Fischer1990]` (Thm 1: `F² 2`-colourable iff a ring homomorphism `Σ₀ → ℤ/2`), generalized here to any residue
field and any admissible subgroup rather than a fixed target group; `[Moorhouse2010]` §7.1 gives the odd-degree
2-colouring by one specific functional (the trace) — an instance of Theorem A′ with `H` a hyperplane, not
stated at this generality. The exact statement "residue degree one above an odd `p ≡ 3 (mod 4)` gives `χ ≤ p`
by a norm-one-avoiding subgroup" is not found verbatim in either held paper. zbMATH:
`ab:"norm-one group" & ab:"coloring"` (0 hits); `ab:"additive coloring" & ab:"unit distance"` (0 hits, beyond
Fischer's own papers already held) — ours. *Kernel:* declined — no consumer has asked for the general subgroup
machinery in Lean; the `p = 3` instance is subsumed by row 63/FS-36's two-colour theorem for the boundary case,
and the general finite-plane bound of row 52 (M58, non-linear, giving `χ ≤ χ(Γ_q)` rather than `χ ≤ p`, for
any odd residue degree, not just one) supersedes Corollary 6.6's *reach* while not reproducing its *elementary,
solver-free* route at degree one. **Note for the record**: row 52's bound uses `χ(Γ_q)` which can be far below
`q` or `p`; Corollary 6.6's `χ ≤ p` is weaker in general but sharp at `p = 3, 7` (matching M53-T7's exact
values) and needs no finite-plane computation.

**M53-T9 — Lemma 7.5: one gluing step stays multiquadratic. [hand; Kooshi's parallel session, 2026-09-05]**
For `a, b ∈ F²` at distance `d`, `0 < d < 2`, the two points at unit distance from both are
`p± = (a+b)/2 ± v√(4/d²−1)`, `v = i(b−a)/2`, lying in `F(√r)²` with `r = 4/d²−1 ∈ F`, and in `F²` iff `r` is a
square in `F`. Iterating from a `K`-point set therefore produces only multiquadratic extensions of `K` (never
a cubic field, e.g. Haugland's). *Proof:* `plans/FIELD-WALL-THEOREM.md` §7.3 — the perpendicular bisector meets
the two unit circles where the height `h` satisfies `h² = 1 − d²/4`. *Proof verdict:* closes. *Rests on it:*
the whole out-of-field pool census of §7.4 (M53-T14/T15's fields); `STUB-field-wall.md`'s "lattice-closure
lemma" (statement 1), which this lemma answers. *Prior art:* ours — elementary plane geometry, specific to
this project's descent construction; no discipline-neutral restatement attempted (the fact is definitional
once "glue point" is granted). *Kernel:* **the geometric existence half is kernel already, one milestone
earlier, under a different id**: `PartnerLattice.eq_gluePoint_of_dist_pair` /
`PartnerLattice.eq_gluePoint_of_unit_pair` (`Proofs/HadwigerNelson/PartnerLattice.lean`), filed by batch 2b
under `LEDGER.md` row 45 / `plans/M50-derivation.md` — that theorem gives the two candidate points directly
(as `gluePoint x y r₁ r₂` and its reflection) without naming the field-extension fact. **The field-theoretic
corollary stated here** (`p± ∈ F(√r)²`, `r = 4/d²−1`, and `∈ F²` iff `r` is a square) is **not** separately
proved in Lean — `gluePoint`'s definition presumably already involves such a square root internally, but no
lemma states the membership-in-`F(√r)` fact as such. Declined as a fresh target; a stub note is owed if FS-47's
general field machinery is ever extended to cover it.

**M53-T10 — Lemma 7.2: no unit chord across a length-2 fork in K. [hand; the M53 implementer]** If
`q, p, s ∈ K²` with `|p−q| = |s−q| = 2` and `|p−s| = 1`, then `(s−q)/(p−q) = (2d²−1 ± i√(4d²−1))/(2d²)` at
`d = 2` would need `√15 ∈ K`, which is false; so two points of `K²` at distance 2 from a common point of `K²`
are never one unit apart. *Proof:* `plans/FIELD-WALL-THEOREM.md` §7.2, cosine-rule computation, using M53-T9's
form at general `d` specialized to `d = 2`. *Proof verdict:* closes. *Rests on it:* the 2-SAT transversal
system of M53-T12 (a fork's two "arms" are never adjacent, so the residue colouring's clauses are well-formed
in the sense the argument needs). *Prior art:* ours, an instance of the wall criterion (M53-T5/M53-T6) applied
to one specific even distance. *Kernel:* declined — an ad hoc lemma feeding a tool-side 2-SAT construction, no
standalone consumer.

**M53-T11 — Theorem 7.1: the descent cannot terminate in K. [hand; the M53 implementer, from Theorem B]** No
finite unit-distance graph with vertices in `K²` forces two vertices to share a colour, or forces two
non-adjacent vertices to differ, in every proper 5-colouring. *Proof:* Theorem B (M53-T3) with the spare-colour
lemma at `k = 4` (`plans/FIELD-WALL-THEOREM.md` §7.2). *Proof verdict:* closes — a direct corollary, two
citations. *Rests on it:* the whole halt of M53 (row 47's headline: "M53, halted when Theorem B was proved");
`CLAUDE.md` G34's "the field is the selection" reading; G37's necessity half. *Prior art:* ours — the
descent-specific corollary; the spare-colour lemma itself is already kernel (`SpareColour.lean`, row 45,
batch 2b). *Kernel:* kernel, as a direct instance — `not_forces_five_seamPlane` / `not_separated_five_seamPlane`
(`FieldWall4.lean`, row 57's module, cited above under M53-T3's kernel field) are exactly this corollary,
proved at the B1 event. Not filed as a separate stub.

**M53-T12 — Theorem 7.3: the residue obstruction (the 2-SAT criterion). [hand; the M53 implementer]** For a
`K`-point graph `Γ = (V, E₁, C)` with unit edges `E₁`, cheats (distance-2 edges) `C`, and a distinguished pair
`A, B`, let `Σ(C′)` be the 2-SAT instance with a boolean `x_v` per vertex, clauses `x_u ⊕ x_v` per cheat in
`C′`, `¬(x_u ∧ x_v)` per unit edge, and `¬(x_A ∧ x_B)`. If `Σ(C′)` is satisfiable, then for every finite
`H ⊂ K²` the graph on `V ∪ H` with unit edges and cheats `C′` has a proper 5-colouring separating `A` from `B`
— so no set of `K`-points, of any size or depth, ever turns `C′` into a forcing set. *Proof:*
`plans/FIELD-WALL-THEOREM.md` §7.2 — a satisfying assignment `x` gives a set `S`; colour `S` with a fifth
colour, everything else by the residue colouring (M53-T3) translated to `A`'s component; each clause type
checks properness on the corresponding edge kind. *Proof verdict:* closes. *Rests on it:* M53-T13 (the floor
`μ ≥ 3`); the measured "residue obstruction" instrument (`tools/residue_floor.py`) used throughout M53's own
census and cited at row 47. *Prior art:* ours — a project-specific reduction of a geometric admissibility
question to 2-SAT via a general-purpose colouring (M53-T3); the reduction technique (reduce a combinatorial
admissibility question to 2-SAT via bipartiteness of an auxiliary graph) is standard in the 2-SAT literature
generally but no paper poses this specific question. *Kernel:* declined — the statement quantifies over "every
finite `H ⊂ K²`" using the whole-plane colouring of M53-T3, so a Lean form is available in principle
(`not_forces_five_seamPlane` already gives the base case) but the 2-SAT reduction itself is tool-side
bookkeeping with no consumer asking for a kernel form.

**M53-T13 — Corollary 7.4: three is the floor inside K (μ ≥ 3). [hand; the M53 implementer — this is
`CLAUDE.md` G32/G36's cited target, "μ ≥ 3 inside K"]** A standing cheat set reachable by an in-field descent
has at least three cheats; with exactly three, they form either a distance-2 triangle or a configuration where
all four candidate transversals are blocked by unit adjacencies. *Proof:* `plans/FIELD-WALL-THEOREM.md` §7.2 —
a full case analysis on 0, 1, 2 (sharing a vertex or disjoint) and 3 cheats (star, path, path-plus-disjoint,
triangle), each time exhibiting a satisfying assignment of `Σ(C′)` (M53-T12) unless the configuration is one of
the two named exceptions; the two-disjoint-cheats case additionally uses Lemma 7.2-style geometry (no two
transversal endpoints can all be blocked without collapsing `|A−B|` below 5). *Proof verdict:* closes — the
case analysis is exhaustive and each sub-case's witness is given explicitly in the source. *Rests on it:*
`CLAUDE.md` G32 ("μ ≥ 3 inside K"), G36 (same, cited as the mechanism); every later descent's floor reasoning.
*Prior art:* ours — descent-specific combinatorics, no discipline-neutral restatement attempted (it is a case
analysis on a specific 2-SAT reduction's satisfiability). *Kernel:* declined — same reasoning as M53-T12; no
consumer has asked for a kernel form of the case analysis, and the measured floor (never observed below three
cheats on any object) is the fact actually used downstream.

**M53-T14 — The K(√247) witness: a 5-chromatic unit-distance graph outside K, with no √5 or √7. [tools; the
M53 implementer]** Spindling the fabric's forced 8/3 pair (`x`, `y`; forced equal in every proper 4-colouring,
G9) by the rotation `cos θ = 119/128`, `sin θ = 3√247/128` gives a 5-chromatic unit-distance graph: the full
construction has 3,905 points and 27,593 unit edges (8 cross chords, verified unit to 60-digit precision, no
near miss); its 1-minimal forcing core, shrunk by greedy outside-in deletion, has 588 vertices and 2,886 unit
edges (every vertex necessary), and core ∪ copy is a **1,175-point, 5,773-edge** 5-chromatic unit-distance graph
with 6 cross chords, coordinates in `ℚ(√3,√11,√247)` — a field containing neither `√5` nor `√7`, the first two
witnesses (de Grey, Heule) both need. *Proof:* `plans/FIELD-WALL-THEOREM.md` §7.5 and
`plans/FIELD-WALL-SESSION-HANDOFF.md` item 9 (T20); the graph refuses four colours by a direct SAT ask (not a
forced-pair argument on the union) and admits five, on the constructed object; `tools/forced_spindle.py`,
`data/m53/forced-spindle-{full,core-8over3}.json`. *Proof verdict:* closes (tools grade — exact geometry, an
UNSAT-then-SAT pair of certificates on the specific object; `247 = 13·19 ≡ 7 (mod 8)` confirms the field
prediction of M53-T5/M53-T6). *Rests on it:* `CLAUDE.md` G55's later credit of the underlying 8/3 forced pair
to Jannis Harder (Polymath16, 28 April 2018) — this witness is a rediscovery of Harder's construction genre, on
this project's own fabric, found independently before the attribution was traced (row 47 already credits
Harder for the forced pair itself; this entry is about the *spindled witness graph*, which M53 built without
knowing of Harder's prior construction). *Prior art:* **the forced pair itself is Jannis Harder's**
(`CLAUDE.md` G55, Polymath16 first thread, 28 April 2018, credited at row 47); **the spindle-to-witness
construction is the standard technique** (`[deGrey2018]`, `[Heule2019]`); what is new here is the specific
5-chromatic *object* (fabric, core size, field) — a smaller witness than de Grey's 791-vertex forcer (single
pair, no √5/√7). No independent zbMATH search run beyond the already-credited Harder/Polymath16 provenance.
*Kernel:* declined — exact-arithmetic tools grade only; no kernel certificate attempted (`plans/FIELD-WALL-SESSION-HANDOFF.md`
item 5 lists "kernel certificates: Theorem B and A′… the 1,175-point witness through the M06 pipeline with a
√247 leaf added to the tower" as an open, unrun idea).

**M53-T15 — The K(√23) witness: the 8/√3 forced pair spindled. [tools; the M53 implementer]** The same
construction applied to the fabric's forced 8/√3 pair gives a 5-chromatic unit-distance graph with coordinates
in `ℚ(√3,√11,√23)` (`759 = 3·11·23 ∼ 23` up to a square factor). *Proof:* `plans/FIELD-WALL-THEOREM.md` §7.5,
one sentence ("the same construction at the 8/√3 pairs gives ℚ(√3,√11,√23)"); the full-object size and the
1-minimal core are **not separately recorded** in the read material (only the 8/3 witness's core is shrunk to
588 in the source; the 8/√3 witness is left at its full size). *Proof verdict:* **unsure** — the sentence
asserts the construction succeeds but the source gives no independent certificate address for the 8/√3 case
distinct from the 8/3 one (the SAT ask and the exact-geometry check are not separately quoted); the M54 plan
later treats "pair 2 = (813, 1939)" as its own object with its own forcing-critical census (M54-T3), which
appears to be the same forced pair carried forward, but nothing in this batch's material re-derives the 8/√3
witness's four-colour refusal from scratch. *Rests on it:* row 47's text, which states the field as fact.
*Prior art:* same as M53-T14 — an instance of the same spindle technique at a different forced distance.
*Kernel:* declined — same reasoning as M53-T14, and additionally blocked on the *proof verdict: unsure* above.

## Readings and measurements that were called theorems

- **The wall-break census** (`plans/FIELD-WALL-THEOREM.md` §7.4, `plans/FIELD-WALL-SESSION-HANDOFF.md` item 6,
  T18): over 950,371 pairs of the descent object at distance < 2, 1,435 distinct radicands; 32 square in `K`
  (140,195 in-field pairs); exactly five break the wall alone (4,221 pairs, 0.44%, dominated by the √5-class);
  205 radicands break at one 2-adic prime only; 523,608 pairs (two thirds of the out-of-field material) are
  2-adically inert everywhere. This is a **measurement** on one specific object (`tools/wall_break_test.py`),
  not a general theorem — the explanation offered ("every point of the object has the Exoo–Ismailescu shape…
  so every radicand lies in ℚ(√33), whose two 2-adic images are rational") is a *reading*, with its own
  falsifier (a differently-shaped object realizing a radicand class the census does not see). Not filed in § B.
- **"Single wall-breaking points kill nothing"** (§7.4, T19): 0 of 3,936 in-field survivors killed by the
  8,442-point wall-breaking pool (19 ms median replay); the 573k-point partner pool at five-minute walls read
  394 of 394 undecided. A **measurement with a negative/inconclusive result**, not a theorem; explicitly
  recorded in the source as open ("whether combined wall-breaking material kills at five colours is open").
- **The rigidity dial** (`plans/FIELD-WALL-SESSION-HANDOFF.md` item 8, Q10): on the 1,953-point unit part, all
  four-colour forced-equal pairs sit at 2-adic valuation 6 (163/178 at 8/3, 8/11 at 8/√3), none at valuation 2
  or 4. The **zero rows are a theorem** ("forced-equal ⟹ positive valuation" is M53-T1's residue colouring
  applied contrapositively — a pair the colouring separates cannot be forced equal), already covered by
  M53-T1/T3; the **nonzero counts (163/178, 8/11) are measurements** on one specific object, not general
  claims, and are not filed separately.
- **Corollary 6.6's worked consequences beyond the two exact values** (`χ_res` at Heule's and de Grey's
  fields) are computations reading off the definition, not separate theorems.

## Conjectures surfaced, not claimed

- None found with a stated but unclosed proof, **except M53-T15's flagged *unsure*** (the 8/√3 witness's own
  four-colour refusal is asserted, not independently re-derived from the source material available to this
  batch).

## Prior art re-attributed

- **M53-T3 (Theorem B): the value χ(K²) = 4 is `[Fischer1994]`'s** (1994), already recorded at `LEDGER.md`
  row 57 and `CLAUDE.md` § Publication — no new attribution made here, cross-referenced for completeness since
  the theorem's *hand proof* (this file) predates that discovery by fourteen days and the project believed
  itself first when it was proved.
- **M53-T6 (Proposition 6.4, corrected): is `LEDGER.md` row 63 / milestone FS-36's theorem** — flagged for
  batch 5, not re-filed.
- **M53-T4 (Lemma 4.1): the minimality claim is `[Moorhouse2010]` Prop. 1.4(b)** — already recorded in
  `BIBLIOGRAPHY.md`'s own entry for that paper; noted here as the theorem-audit's confirmation.
- **M53-T7 (Corollary 6.5): the real-quadratic classification is `[Fischer1990]` Thms 8–10** — already
  self-corrected in the source file's own §10.1 (2026-09-06); noted here as confirmation, no new finding.

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M53-T1 | stub (FS-47) — abstract machinery kernel (row 57), number-field step not proved generally |
| M53-T2 | kernel, by a different (simpler) proof, one event later (B1, row 57) — this lemma's own Galois argument not formalized |
| M53-T3 | kernel (row 57, `FieldWall4.lean`), by a different proof than this file's route; the VALUE is `[Fischer1994]`'s |
| M53-T4 | declined — elementary, no consumer; prior art `[Moorhouse2010]` Prop. 1.4(b) |
| M53-T5 | declined — subsumed by field-specific kernel instances |
| M53-T6 | not filed here — = row 63/FS-36, batch 5 |
| M53-T7 | declined — superseded by row 74's certified census; prior art `[Fischer1990]` Thms 8–10 |
| M53-T8 | declined — no consumer; cross-batch note for row 50/M56 to check against |
| M53-T9 | geometric half kernel already (row 45, `PartnerLattice.lean`); field-theoretic corollary declined |
| M53-T10 | declined — ad hoc, tool-side |
| M53-T11 | kernel, as a direct instance (row 57's module) |
| M53-T12 | declined — tool-side 2-SAT bookkeeping |
| M53-T13 | declined — case analysis, no kernel consumer |
| M53-T14 | declined — tools grade only, no kernel certificate attempted |
| M53-T15 | declined — additionally blocked on *unsure* |
