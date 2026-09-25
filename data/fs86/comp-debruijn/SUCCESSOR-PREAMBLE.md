# Successor preamble: de Bruijn, FS-86 stage C competitor (written 2026-09-25, context about 210k)

You take over de Bruijn's seat in FS-86's derivation competition. Coxeter is the competitor, Poros the advisor; the owner is `main`.

## Read these first
- Brief: `/home/kooshi/source/lean-dir/data/fs86/briefs/C-competitor-brief-debruijn.md`, then `C-addendum-2.md` in the same directory.
  These are the only two files under `data/fs86/briefs/` you may open.
- The working file (you are its only writer): `FS86-C-deBruijn.md`, in this directory.

## The rules
- Commit nothing; everything stays in this scratch directory.
- Do not run `git log`. Do not read the close inventory, other scratch directories or `~/source/lean-dir-owner/`.
- No subagents, forks or workflows.
- No finite-witness search until 2026-10-01. Keep the "would have searched here" log.
- Every hand-back is exactly "de Bruijn idle; no content in this hand-back; my reports go to the owner by SendMessage".
- Every report goes by SendMessage to `main`. Hints to Coxeter (id: see the newest seat section below; `a797f9a29d11ce2db` is stale) are teasing only: movement, never mechanism.
- Poros is `a4bf413a466f63e3d`. Tell the owner when live context passes about 400k.

## State (round 1 reported; round 2 running to 2026-09-29 18:00)
- **Round-1 claim: K1, "shown to hold".** X = "(0, 4) is four-colour forced in the plane over `ℚ₂(√3)`" (Theorem A, §1.2).
  - Poros adjudicates the killing test at the end of round 1.
  - The owner has confirmed step 1 of Theorem A (the embedding).
  - Theorem B (§1.4) is on the owner's verification list.
- **Proved.**
  - Theorem A: the 2-adic plane is rigid.
  - Corollary A1: F(R) ≠ 0 iff every colouring extends to the 2-adic plane.
  - Theorem B: 2-adically continuous colourings are pullbacks.
  - Lemma W: the wall lemma.
  - Proposition S, the parts proved: S-i, S-ii, S-iii (dyadic torsion only), S-iv (archimedean parts with no split part).
  - §2.3: split-free points of Θ₄ are torsion.
  - Proposition A-tf, parts (i) and (iii): the class-level "no" needs only 4 ∉ F_tf (Poros's scope note).
  - §2.4: on type-B planes, K3 collapses to K2.
  - C0: pair correlations cannot pin on a real field (the Bessel obstruction).
  - Theorem C: F_μ = P for non-real analogues such as ℚ(√−709). Its equidistribution lemmas are sketched.
- **Retractions: 1.** §2.2, (S-iii) and (S-iv).
- **Search log: 3 lines.**

## Added in round 2, after the preamble was first written
- §5, **Proposition T1** [hand, with one cited external theorem]: `4 ∈ F_tf` ⟺ some number field `E ⊂ ℚ₂(√3)`, real or not, carries a
  finite triangle-free forcer of (0, 4).
  - `4 ∉ F_tf` would be a sweeping "no".
  - `4 ∈ F_tf` needs only one rigid triangle-free field.
  - Reading §5.3: the non-real Theorem-C fields are rigid, and ℚ(√59)'s obstruction is its real place.
  - §5.4: upgrading `F_μ` to `F` is open.
- §6, **Theorem D₀** [hand]: no threshold walls. Two different pullbacks cannot sit on the two sides of a level set, with
  residue-dependent offsets, of an additive function. The proof is a finite descent through gap-freeness.
  - This is the one natural "no" construction that exploits the real place's bounded circle.
  - **Proposition D** (arbitrary two-phase partitions) is conditional on a Waring-type lemma for norm-one elements.
- **Search log: 5 lines.**

## Open, with the next move first
1. **Is 4 ∈ F_tf?** That is: is (0, 4) forced by a finite configuration in the 2-adic plane whose induced graph is triangle-free?
   - This is the sharp local half. "No" gives a class-level "no".
   - A point to use: local triangle-free forcers can be moved to algebraic ones, over number fields `E ⊂ ℚ₂(√3)`, possibly non-real.
   - Over real `E` a forcer would be at Soifer strength; over non-real `E` it would not.
2. Write Theorem C's equidistribution lemmas as proofs: Weyl on S-unit boxes, and Chebotarev for the torus residues.
   Then ask whether Theorem C upgrades from `F_μ` to `F` for non-real `E`.
3. Proposition A-tf (ii) as a proof (fibre genericity).
4. Proposition S's hard half: the Gauss-sum lemma for mixed torsion frequencies, and the split-place frequencies.
5. Θ₄(F) = torsion at split places. This is FS-83's k = 4 question; Coxeter may be on it.

## Seat II (de Bruijn successor, 2026-09-24 23:30 → ), state for a third seat
- Coxeter is now a successor: `a5d43b5c29772ef48` (the old id is stood down). Poros `a4bf413a466f63e3d` replayed every card (A–D) to seat II.
- Verifier corrections recorded in place (§1.2, §1.3, §4.1, §6.1).
- **Theorem D (§6.2) is now unconditional** (the Waring lemma is bypassed by U₄-multiplicative closure plus the identity
  −1 = 5·(−(3+4i)/5) + 5·(−(3−4i)/5) + 5). **Theorem H (§6.3), new:** unique continuation from a residue-offset half-space, for any field and any gap-free periodic colouring.
  Both were reported to the owner, who confirmed D's steps (b) and (d).
- §6.4: a light prior-art gate. Kari–Szabados's forced periodicity (annihilating polynomials) is flagged, not read.
- Seat II token count at the report: about 320k. Next: the three-phase case of D, or HD1 made rigorous.
- Update: Theorem D′ (§6.3a) and the stripe case were added and reported. Seat II's last report was at about 352k.
- Update: C-S2 tight at levels 1–5 (§6.5, `cs2_tower.py`). The owner's named prior-art item was read in part (§6.6): G75's one-family
  identity is Puzynina's exceptional case, det(B+I) = 0, and row 85 should cite Kari–Szabados and Herva–Kari for the framework. Seat II stopped near 385k.

## Seat III (de Bruijn, 2026-09-25), state for a fourth seat
- Competitor: the third Coxeter, `a8b60e0003eef1dd0` (it sent one hint: an Erdős conjecture let it close a "crowded corner"; the main floor is still open).
  Poros `a4bf413a466f63e3d` replayed HD1–HD4 to seat III; their text is summarised in the working file's §7 header, not verbatim.
- The verifier's notes on D, D′ and H are recorded in §6.7, marked as the verifier's. Reconstructions of its two completeness fixes are labelled as seat III's.
- **§7 (new): HD1 made precise.**
  - 7.1: the intrinsic classes `T` (torsion) and `A` (archimedean). The split part is defined only modulo global elements.
  - 7.2: **HD1-fin** proved. `Θ₄ ∩ (T + A + Fin)` is the finite set of pullback characters. Also: every band, every field; and a new
    case of Proposition S, (S-v).
  - 7.3: **HD1-cert** proved. HD1 holds iff one finite exact certificate exists on two lattices. That computation is a post-ban job.
  - 7.4: **a gap in Theorem C**. Its equidistribution step is representative-dependent, so Theorem C is downgraded to spectral measures
    on `T + A + Fin` (retraction 2, partial).
  - 7.5: why weak approximation cannot finish HD1 (the product formula). What would finish it: an S-adic Berend theorem with an
    isometric archimedean centre (Berend, TAMS 286 (1984), unread), or the certificate after the ban.
  - 7.6: **HD4 proved.**
- Retractions this side: 2. Search log: 8 lines.
- Open, next first:
  1. Repair Theorem C (§7.4) by averaging over the other generators' exponents, the equidistribution in open subgroups of `O_v^×`.
     The catch: `X_n`-dependent torsion factors at split places outside `S_n` might average below −1/3; check that first.
  2. HD1's generic case (§7.5).
  3. The three-phase case (§6.3a).
  4. Is "2-adically constant on one ball" enough to force a pullback? It is not reachable by H or D as they stand (seat III's attempt).
