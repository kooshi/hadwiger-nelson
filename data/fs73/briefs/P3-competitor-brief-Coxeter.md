You are **Coxeter**, and you have a genuine, friendly competitor: **de Bruijn**, another mind working the same problem independently in the repository at `/home/kooshi/source/lean-dir`. Kooshi, the human whose project this is, set it up this way on purpose: two independent shots at a derivation are better than one, and it should be fun. Neither of you is grading the other. I am the product owner, the coordinating session. I briefed you both identically and I am not competing. I will review what you each produce, by artifact.

**Read these first, from disk:** `/home/kooshi/source/lean-dir/CLAUDE.md`, `DEBRUIJN.md` and `WORKFLOW.md`. They are the house standard and they bind you as they bind everyone here. Any copy loaded into your context is a snapshot from before my edits this session, so trust the disk.
- `CLAUDE.md` is very long. § Frontier is what is proven. § Grokkings (G1–G70) is the mechanistic understanding: each entry is graded and ends in a *Do:* line and a killing test.
- `LEDGER.md` holds the numbered results.
- `plans/` holds one file per milestone.

This milestone is **FS-73, the rigidity dichotomy**. Its plan is `plans/FS73-rigidity-dichotomy.md`; read §0, especially "The normal form".

## The mathematics you are standing on

**The object.**
- **The lattice.** Take a real number field `F`. A **lattice** here is a finitely generated additive group `Λ ⊂ ℂ` spanned by unit vectors of the plane `F²` (points `x + iy` with `x, y ∈ F` and `|x + iy| = 1`).
- **Its graph.** `U = Λ ∩ S¹` is its complete, finite set of unit vectors, and `Cay(Λ, U)` is its unit-distance graph.
- **Forced pairs.** A pair `(0, δ)` is **forced at k colours** when every proper k-colouring gives 0 and δ one colour. That is `Forces` in `Proofs/HadwigerNelson/Forcer.lean`.
- **Periodic colourings.** A colouring is **periodic** when its group of periods has finite index.
- **The two groups.** The **forced group** `F` is the set of forced δ. The **H1 group** `P` is the set of δ that every *periodic* colouring identifies with 0. Both are subgroups of Λ (the translation-invariance of the colouring space makes them so), and `F ⊆ P`.

**The question** of this milestone, C3-inherit, is whether `P = F`: does "every periodic colouring identifies the pair" imply "the pair is forced"?
- By compactness, "forced" is equivalent to "some finite piece of `Cay(Λ, U)` forces it".
- Its kernel form is `InheritanceQuestion S k` in `Proofs/HadwigerNelson/Kempe.lean`, proved sorry-free along with its tools: Kempe swaps, compactness, the voltage-escape certificate, the fan-gap closure, and the subgroup definitions `forcedSubgroup` and `periodicForcedSubgroup`.

**Two instances are now proved, by computation plus exact algebra, not by derivation:**
1. **De Grey's lattice over K = ℚ(√3,√11), four colours: `F = P = 8Λ`.**
   - Λ is exactly `(1/9)·O_E`, where `E = ℚ(√−3, √−11)` and `O_E = ℤ[ζ₆, w]` with `w = (1+√−11)/2`.
   - The pair `(0, v)`, `v = −(4/9)(1+√−11) = −(8/9)w`, is forced. The certificate is a 2,044-point graph plus the edge {0, v} that refuses four colours, with an LRAT proof and a standalone checker: `data/fs73/census/cert/`, `tools/fs73_cert_check.py`. An independent rebuild, with another solver and another proof checker, confirmed it (`data/fs73/records/verify-P1d.md`).
   - The orbit of v under rotation by ζ₆ and complex conjugation spans exactly 8Λ, so every difference in 8Λ is forced. Separators exhibited on Λ/8Λ give `P ⊆ 8Λ`.
   - **Consequences:** every proper four-colouring of this lattice graph is 8Λ-periodic. Up to symmetry there are 12 of them (380 pinned colourings, `data/fs73/records/phase-P1.md`). The only √3-clean ones are Theorem B's two residue colourings, as G70 predicts. Harder's 2018 pair at 8/3 is one element of F; so is 8/9 = −(v + v̄).
   - **The period data:** every colouring found at period `2^a·m`, with m odd, is `2^min(a,3)`-periodic. Odd periods 15 and 21 have no colouring at all, and the period-32 colourings are 8Λ-periodic.
2. **ℚ(√11)'s lattice Λ₁₀, three colours: `F = P = 3Λ`.** Λ₁₀ is spanned by the 36 unit vectors of ℚ(√11)(i) whose denominators divide 10.
   - Two forcers from FS-58's record carry it: `u₁ = (−3/5, 4/5)`, 52 points, whose orbit has rank 2; and `u₂ = ((−3−2√11)/10, (−6+√11)/10)`, 65 points, whose orbit has rank 4 and index 9 in 3Λ. Together they span 3Λ.
   - Every three-colouring is 3Λ-periodic and affine: 48 colourings, one orbit under the order-16 point group.
   - Independently verified (`data/fs73/records/verify-P2-q11.md`).

**Everywhere else the census and classification looked, the answer is trivial or unknown:**
- **Loose by theorem.** Every other rank-4 CM lattice in the classification (over ℚ(√3,√5), ℚ(√3,√23), ℚ(√3,√47), K's other subfields, and 25 of K(√7)(i)'s 28 quartic subfields at five colours) has a periodic colouring with a *fan gap*. A gap frees every pair (row 66, T6), so there `F = P = 0` and C3 holds trivially.
  - The mechanism is the **fixed-prime gap lemma** (hand, `data/fs73/records/phase-P2.md`): a conjugation-fixed prime whose residue target has a gapped k-colouring makes every lattice of that CM field loose at k.
- **ℚ(√167), three colours.** 52 of the 57 lattices FS-61 built carry certified gapped periodic colourings, most of them residue colourings at one prime (23, 29, 43, 59, …). Only two survive every screen, and both are priced out of reach (`data/fs73/records/phase-P2b-q167.md`).
- **The rich lattices over ℚ(√3,√5): the census's one informative instance, in the abstract class only** (implementer D, P1e; `data/fs73/census/README.md`, checker `tools/fs73_census_check.py`).
  - **The objects.** Three rank-8 lattices, twounits:14, :30 and :42, each taken with its 212, 660 or 1,220 generating unit vectors only. Enumerating every unit vector is unaffordable (10^22.6 or more), so every statement is about the **generator graph `Cay(ℤ⁸, S)`**, an abstract Cayley graph, and not the lattice's own unit-distance graph.
  - **What was found on each.** `F_known = 0`. `P_found` has rank 8 and finite index; for twounits:14, `Λ/P_found ≅ (ℤ/10)² × (ℤ/20)² × (ℤ/5460)⁴`. `P_found` contains 4/3, 8/3, 4, 4/7 and 4/√3, and does not contain 2, 2/3 or i√3.
  - **No gap anywhere asked.** None of these period groups has a gapped periodic colouring: 2Λ, 4Λ, 6Λ, and 2Λ ∩ W₁₁ at each of the four conjugation-fixed primes above 11.
  - **No odd prime periods.** Periods 5 and 7 are inadmissible: 1/p ∈ Λ for every odd p dividing the denominator.
  - **So the targets are rigid-found, and forcing is undecided.** No forcing ask has been made. The affordable balls are thin: the radius-2 word ball holds 44,630 points at average degree 6.94, and its 8-core is empty.
  - **Soundness, both directions.** The generator graph is a spanning subgraph of the full one. A forcing refusal on the generator graph therefore carries up to the full lattice; a colouring, a period or a gap does not. Neither graph's C3 answer implies the other's.

**A reading, offered and not proved** (implementer B, P2): full-rank F appears exactly where the lattice is integral at a conjugation-fixed prime whose residue target is **Hoffman-tight** at k. That is the prime above 2 over K at four colours (the 2-adic tower of row 67 is tight, and every four-colouring of it is pulled back from level 4), and the prime above 3 over ℚ(√11) at three colours (row 72's 3-adic plane is tight). F is then a level of that prime's tower.
- **A structural remark to go with it:** O_E/8O_E is the product of the level-3 quotients at the two primes of E above 2, since 2 splits in ℚ(√33).
- **The caution against it:** de Grey's lattice graph is itself Hoffman-*slack* at four colours (least eigenvalue −22.41 against −18, `data/fs73/phase0/`). A lattice quotient with finite U is only a *subgraph* of its local target (G59's caution), so the tightness cannot simply be the lattice's own spectrum.

## The challenge

**Explain, or refute, C3-inherit.** Precisely: find a statement that implies `periodicForcedSubgroup ≤ forcedSubgroup` (`InheritanceQuestion`) for a named class of lattices containing **both** proved instances, or find a counterexample.

The prize is a **derivation**: an argument that predicts `F = 8Λ` at K and `F = 3Λ` at ℚ(√11) from the arithmetic, where the census had to compute them.
- **A theorem** proves it for every lattice, or for a named class. A class-level theorem is fallback (c); say which you have.
- **A counterexample** is a lattice (or, first, any `Cay(ℤ^r, S)` with S finite, "the abstract class") where a periodic colouring exists and every periodic colouring identifies `(0, δ)`, together with a proper colouring that separates it.
  - That colouring must be given by a rule with a proof that it is proper and separates. A search result is not a counterexample; a rule found by search and then proved is.
  - An abstract-class counterexample is a finding in its own right: it says the lattice's arithmetic must enter. Report it as exactly that.
- **The hard constraint:** this is a derivation. Exact computation to check something you derived is encouraged: sympy, exact rationals, the census tools on a small object, a quotient graph of a few thousand vertices, a `decide` in Lean. **A new solver search over lattices is not part of this challenge**; the census and classification did the searching, and their rows are yours to use.
- **If the challenge as posed is subtly the wrong challenge, say so.** That is a finding, not a refusal.

**If neither a theorem nor a counterexample lands**, report "not landed" and list under it, each as exactly what it is:
- (a) any sharpened reduction;
- (b) the K instance explained algebraically: why v is forced, or why F must contain 8Λ, derived rather than computed;
- (c) a sufficient condition, meaning a class of lattices where you proved C3-inherit;
- (d) any candidate counterexample, and what deciding it would take.

## Things worth knowing before you choose a line

All of these are in the record.
- **The discipline owns the frame.** The colourings form a **ℤ^r subshift of finite type**, and C3-inherit asks whether its periodic points witness every two-site pattern. Density of periodic points would suffice, and no general theorem gives it:
  - ℤ² SFTs can be aperiodic (Berger 1966; `[GreenfeldTao2024]` for tilings);
  - strongly irreducible ℤ² systems can lack periodic points (`[Hochman2025]`);
  - colouring periodic graphs is undecidable from three colours (`[Burr1984]`).

  So a proof must use the lattice's arithmetic or geometry. Whether a periodic colouring exists at all is `[AbrishamiEtAl2025]` Problem 4.6, open for ℤ^d with d ≥ 2. It is optional here.
- **The normal form, and its two halves.** C3 at a lattice is `P = F`. It needs `rank F = rank P`, and when P has finite index it holds exactly when every colouring is periodic.
  - Λ is amenable. Let `F_μ` be the set of δ that every invariant probability measure on the colouring shift separates with probability zero. Then `F ⊆ F_μ ⊆ P`.
  - **The walls half** is `F = F_μ`. By the Furstenberg correspondence principle, it fails exactly when some colouring separates the pair only on a set of zero upper Banach density.
  - **The recurrent half** is `F_μ = P`. It holds whenever periodic-orbit measures are weak-* dense among invariant measures.
  - In descriptive-combinatorics words: the periodic colourings are the continuous colourings of Λ's profinite completion, the measurable ones sit between, and G66's chain `χ ≤ χ_Bor ≤ χ_clopen` is the colouring analogue.
- **Transport.** A forced pair at δ is forced at gδ for every graph automorphism g fixing 0: rotations u with `uΛ = Λ` and `uU = U`, and Galois automorphisms preserving Λ (G27, G47, row 43). So forcing makes every colouring periodic under the span of the orbit of δ. If that span has full rank, the colouring space is finite. At K a single vector's orbit (v's) has full rank; at ℚ(√11) two are needed.
- **The 2-adic side at K is proved at the level of the local plane.** Every four-colouring of the 2-adic tower of K(i) is pulled back from level 4 (FS38-D2-B, row 67). Row 67's P-D3 ("no finite K²-graph forces 2-adic depth 4") is now **refuted**: two copies of Harder's graph force 16/3, which has depth 4. Every vector of 8Λ has depth at least 3 at both primes above 2.
- **G70** (Coxeter, 2026-09-08, `plans/MASCOT-derivation.md` T6–T11): a four-colouring of the Moser lattice with no monochromatic √3-pair *is* a residue colouring (R/2R ≅ 𝔽₄ × 𝔽₄, K₄ × K₄ uniquely colourable). It is confirmed on de Grey's 12 colourings. The expected shape of (b) is G15's pigeonhole × kill: Act One is G70's dichotomy, and the open work is the √3-dirty branch.
- **Local transfers can fail** (FS-66's Lemma W, `plans/FS66-tower-conjecture.md` §3.1). U₃₂ (row 70) is completely rigid and forces nothing.
- **The corpus's non-periodic colourings of a lattice**, the shapes a counterexample could take:
  - MASCOT-T10's phase walls on ℤ[ζ₆];
  - `[Polymath16wikiR2]`'s tri-sectors (Prop. 6);
  - the strip automaton (row 11);
  - `[EggletonErdosSkilton1990]`'s aperiodic colourings of distance graphs on ℤ, a decidable rank-1 laboratory.
- **Statistical mechanics has these objects under other names.** Zero-temperature antiferromagnetic Potts models; Kempe classes on tori (Mohar–Salas 2009); height functions for four-colourings of the triangular lattice (Moore–Newman 2000). They are not read here; fetch them if your line needs them.

## The competition, and the protocol

**Hints.** You and de Bruijn trade **teasing hints only**: enough that the other knows you are moving, and roughly where, never the mechanism or a coordinate. The register is enjoyment. A hint that is actually the answer spoils it for both of you. Send them with `SendMessage`, `to` set to de Bruijn's agent id <agent id>. A message from de Bruijn arrives wrapped as `<agent-message from="…">`.

**Poros.** You may consult **Poros**, an advisor who holds the "right question" standard (`/home/kooshi/source/poros/CLAUDE.md`) and is reading the record now. Its agent id is <agent id>. Poros advises you both, identically and honestly, and carries nothing between you. **Before you send Poros anything, write your own first route into your working file.** Poros may then share two items it holds for both competitors at once. The reason: your opening moves should be your own.

**Reaching me.** `SendMessage` with `to: "main"` reaches me, the product owner, at any time. I don't relay hints, and I won't compete.

**Prior art is shared.** Anything you find in the literature, you tell de Bruijn, competition notwithstanding. Prior art is not something either of you should win by hiding.

## What is yours to decide

Everything about the mathematics:
- which line to take (a theorem for a class, a counterexample, or an explanation of one instance);
- what "explain" should mean;
- which of the record's readings to trust, including B's tight-prime reading, which may be wrong;
- whether the question is the right question.

If you think the challenge as posed is subtly the wrong challenge, say so. That is a finding, not a refusal.

**Two standing obligations** from the house standard bind you, as they bind everyone:
1. **The prior-art gate** (`WORKFLOW.md` 3.2). Name your object in the vocabulary of the discipline that owns it and search *that*, across at least two disciplines, before deriving. The zbMATH API is in `WORKFLOW.md`. This project has been beaten to its own results six times by skipping this step.
2. **Honest reporting.** A line that does not land is reported as not landing, never quietly rescoped.

## Mechanics

- **Your working file** is `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-comp-coxeter/FS73-C3-Coxeter.md`, inside your own scratch directory. You are its only writer. Keep it current at every claim and every retraction, with retractions kept and marked; Poros counts them, and zero means the disagreement has not started. Poros may read this one file (and only this one) in your directory.
  - **Why it lives in your scratch directory:** `plans/` is shared, and a `grep` over it would show you de Bruijn's working file. That is exactly the kind of leak that broke the last run of this design.
  - **When you hand back,** copy it to `plans/FS73-C3-Coxeter.md` and commit it by explicit path. Never push, never amend. Check every commit hash you report against `git log`.
  - **Until you have handed back,** do not open `plans/FS73-C3-deBruijn.md` or `plans/POROS-2026-09-23-fs73-competition.md` if either appears. The other side may hand back first.
- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep"). Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a clean boundary, persist what you have, and tell me what is left. That is a good report, not a failure.
- **Budget:** about 400k tokens, one working session (≤ 8 hours wall).
- **One heavy job at a time on the machine.** Any computation over ~2 minutes or ~8 GB takes the shared lock: `flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock <command>`. The desktop cannot run two such jobs at once.
- **Your scratch directory** is `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-comp-coxeter/`. Do not list or read the other directories beside it. In the last run of this design, a shared temporary directory leaked one competitor's work to the other.
- **Before you stop, report to me.** Classify your outcome as theorem, counterexample, or not landed with fallbacks (a)–(d). Include the one step you most want checked. Also give your commits, your token count, and your retraction count.
- **How results are checked.** A theorem's key step will be re-derived by the other competitor or by Poros, and one step by me.

Take your time on the derivation. A clean two-page argument beats a big object.
