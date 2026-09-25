# FS-89 — the missing theorem: measure rigidity for the unit-vector action with isometric archimedean directions (stub)

**Chosen 2026-09-25 as the next milestone, re-posed** (Kooshi: "I agree with the advisor's choice of next milestone"). The next-step advisor (`plans/POROS-2026-09-25-fs86-next.md` §3–§5) found that this stub files the missing theorem under the wrong kind of mathematics. de Bruijn's obstruction note (`plans/FS86-C-deBruijn.md` §7.5) asks for invariant **closed sets**, which is Furstenberg–Berend topological rigidity, proved in print. The stub instead asks for invariant **measures**, which is the open ×2×3-type problem. The re-posed route is G74's `5^{−k}` gluing: HD1 for every type-(B) field follows from one statement about the rational unit circle, that every four-colour band character of `ℤ[U_ℚ]` is torsion plus archimedean. The same step would give `Θ₄(ℚ(√47)) = ∅`. It is one mind's sketch and unverified. **Stage 0** is a blind check of the gluing, plus the exact band set of `ℤ[U₅]` at `[1/4, 3/4]`, which Kooshi ruled allowed under the ban. Close inventory: `plans/FS89-close-inventory.md`. The text below is the stub as minted.

*Minted 2026-09-25 at FS-86's close (Kooshi: "then we'll spawn an advisor to decide what to do next: the missing theorem, 2 hours of
sanctioned search time, or something else"). Rank 2 in `plans/FRONTIER-STUBS.md`. Written for a session with zero conversation memory.
Solver-free: it can run inside the finite-witness-free week (to 2026-10-01, `CLAUDE.md` § Toolchain).*

## The question, in plain words

The plane over ℚ(√59) needs exactly four colours and has no unit triangles. FS-86 proved (`LEDGER.md` rows 88–92, `plans/FS86-derivation.md`)
that either every four-colouring of it is periodic — and then each is read off one residue class modulo 4 at the prime above 2 — or some
four-colouring is not periodic at all; and that every natural way of building a non-periodic one fails. The ways that fail include gluing
two periodic colourings, defects confined to a half-plane, walls, stripes, colourings continuous at the prime above 2, Kempe swaps,
character colourings reading finitely many places, and measurable windows over finitely many places. What is left is a colouring whose
"character" reads **infinitely many split places**. Excluding it, the statement **HD1** (every band character `θ` with `θ(U_F) ⊆ [1/4, 3/4]`
is torsion), needs a rigidity theorem for invariant measures on the character group `R̂` under multiplication by unit vectors. That
theorem is not in print in the needed form: Berend's (1984) and Einsiedler–Lindenstrauss's work needs every direction to expand, and here
every unit vector is an **isometry** at the real places. **Both FS-86 competitors stopped at exactly this obstruction, independently**
(de Bruijn §7.5; Coxeter's C15 reading; G76).

## What is proved (the inputs), with addresses

- The frame: `F(R) ∈ {0, R ∩ 𝔓⁴}`; the question is whether `(0, 4)` is forced (row 88; FS86-V2–V4).
- HD1 for characters of finite type (FS86-dB-HDfin = Cx-C10, three derivations); the homogeneous part of `Θ₄` is torsion (FS86-Cx-C15).
- HD1-cert: HD1 iff a finite exact certificate exists on some finitely generated `Λ₁ ∋ 1` (`θ(1) ∈ {1/4, 1/2, 3/4}` on `Θ₄(Λ₁)`). It is
  semi-decidable with no size bound, and a non-torsion point gives `F(R) = 0` (FS86-dB-HDcert, two derivations). That is the search route,
  FS-90.
- The intrinsic classes: a character's split part is defined only modulo global elements (FS86-dB-HDint).
- Theorem C proves the averaged form on `T + A + Fin` for non-real analogues under H* (FS86-dB-C). **Lemma X** (a weight sequence with
  `liminf λ ≥ −1/3` on every character, equality only at the dyadic minimisers) would give the unrestricted form (D's C3).

## The sub-questions, cheapest first

1. **Read the literature first (G50):** Berend, TAMS 286 (1984); Einsiedler–Lindenstrauss (the `S`-adic and higher-rank measure-rigidity
   papers); Lindenstrauss's survey. The question to answer is whether an isometric archimedean centre is excluded by the method or only
   by the hypotheses. Bibliography rows exist (unread).
2. **Lemma X on characters with a non-principal, infinitely supported split part** (restores Theorem C unrestricted, and with it
   `F_μ = P` for ℚ(√−709)).
3. **The three-phase case** (de Bruijn §6.3a): residues where a colouring chooses among three pullbacks' colours; the `U₄` closed-walk
   trick has nothing to act on.
4. **C14 at infinitely many places or infinite dyadic depth** (Coxeter-3's remark; C's sketch for complex places).
5. **The non-real reading's killing test** (G76): a non-periodic four-colouring of ℚ(√−709)'s plane would refute "the obstruction is the
   real place".

## Bearing, stated honestly

None directly on χ ≥ 6. HD1 false gives `F(R) = 0` over ℚ(√59), a restricted negative that does **not** answer Soifer 55.1 (only a yes
crosses to the plane, row 86). HD1 true excludes every character colouring and leaves `F(R)` open. This is reading-room research, at low
confidence of landing in a week.

## Provisional bearings (WORKFLOW 3.1, at minting)

G76 (the obstruction), G71 and G73 (four colours have no height; averaged formats), G72 (pose it for every invariant measure), G60 (the
invariant-measure engine, `F ⊆ F_μ ⊆ P`), G66 (the odometer frame), G21 (a finite certificate's range), G51 (two minds met one wall: this
licenses a negative only if proved).
