# Brief FS131-KN3 — the chain under "the plane over the field of √47 needs five colours": make its hypotheses closed statements about a field, type its first layer, and cut the rest into modules

*Written 2026-10-13 17:02 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KN3
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow (§ A kernel milestone: this is the largest module of the backlog's restart, so it opens with its own short §G and §PA — the second for the entropy of a measure-preserving map and for every printed statement the chain reads)
  role: the kernel lane's planner for a long chain — you are its architect and you type its first layer: the definitions the library lacks, the chain's hypotheses as closed statements about a field, the interface run at the smaller set, the printed theorem declared with its four items; then you cut everything below into modules with a claim list each, for the planners and implementers who follow
  launch: now, in a tree of your own; two other planners type other modules on branches `fs131-wnf` and `fs131-wkc` — you touch neither, and neither touches the files you will write; nothing is landing
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a statement defect (a leaf untrue as written, vacuous, or needing a hypothesis it lacks), for a definition whose choice will bind later modules (say the two forms you weighed), for a printed statement whose page you cannot find or whose printed form differs from the form the chain uses, and with one line when the first layer compiles; the report goes to `data/fs131/reports/FS131-KN3.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-KN3-chain-plan.md` (new, on branch `fs131-wch`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wch` (branch `fs131-wch`, cut from `main` at `5906b3bc`; **the tree is a retired job's, moved: its `.lake/build` is older than the branch by the two landings of 2026-10-07 — modules under `Proofs/HadwigerNelson/Plane/` that nothing in the chain imports — so iteration on the chain's files works as it stands, and your first build compiles those**): new modules of the chain under `Proofs/HadwigerNelson/` and their lines in the build's lists; `plans/FS131-KN3-chain-plan.md`; `data/fs131/kn3/` (the claim lists you cut go here as drafts, one file per later module); `data/fs131/reports/FS131-KN3.md`. **No statement that is through the gate is changed in place**: where an existing hypothesis-shaped definition should change, type the new form beside it and say what the landing would retire. Nothing on `main`
  budget: about 400k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit on your branch) after the readback, after §G and §PA, after each definition is typed, when the first layer compiles, and after each later module's claim list is cut; hand back when the architecture is final, or earlier at a saved stage — a successor can take any stage from your record

Hello. This is the long one. Take the time it needs; the stages are there so that nothing is lost if the session is.

## Why this job

The project is being wound down and published. Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The finding the field would most want, by this morning's ranking, is that the plane over the field of the square root
of 47 needs exactly five colours, with the general statement behind it: the plane over a real number field takes its
least residue value whenever that value is at most five. A paper posted last week asks that question in print. In this
library the upper half is kernel-checked with no hypothesis. The lower half is kernel-checked only as a composition
over named hypotheses, and this morning's map found that those hypotheses are not yet statements about a field at
all: they are stated over an abstract interface whose set, sub-set and entropy function are free data.

Your job is to turn that into an honest chain: every hypothesis a closed statement, every definition in the library,
the one printed rigidity theorem declared against its page, and everything of ours underneath cut into modules that
other minds can plan and build. Three records were written today for you to stand on:

- `plans/FS131-KN1-number-field-kernel-map.md` — the map: its section "The chain: rows 120, 121, 123, 127" (the kernel theorems as they stand, the 23
  leaves, the outside statements), § X5 (every outside theorem with the planner's call and what it searched in
  Mathlib), § X6 and § X7;
- `plans/FS131-EN1-derivation.md` — a deriver's reading of the whole chain made this afternoon: **its § 8.1 is the table to build from**
  (seventeen hand results on the path, each with its derivation address and the map's leaf; what is off the path; the
  printed and classical statements the proofs read), § 8.2 lists shorter routes it saw, and its entries carry the
  arguments;
- `plans/FS100-K-kernel-47.md` — last month's dependency map, with two slips the deriver found (its node M); its
  prices are not to be used.

## The statements

Fixed in `data/fs131/claims-NF2.md` before your launch. The leaves that make the first layer, as the map wrote them:

> NF2-LEAF-01: `T + A` as a set of `SpectralChain.Dual F` — the torsion characters plus the characters with an additive real lift (`CharacterColouring.torsionBy`, `.archimedean` are the same sets in the model `M →+ ℝ/ℤ`; one bridge between the two models of a character). Its stability under `rot u`, and its measurability: `T` is countable because `R/NR` is finite (X02D:100, Lemma F: "A torsion-free abelian group `A` of rank `n` has `|A/mA| ≤ mⁿ`"), and `A` is the image of a finite-dimensional real space.
> — source: data/fs131/claims-NF2.md § The chain's leaves (the map's, numbered as there)

> NF2-LEAF-02: The chain run at the interface `E := TA := T + A`: one closed sentence, **MR⁺(F)** — every finite rotation-invariant measure on `Dual F` null on `T + A` has every Fourier coefficient off `0` equal to `0` — and SP-Cor from `BochnerHerglotz`, `InvariantMeasureOnClosed`, `APlus0` and MR⁺ (an instance of `Interface.x4_eq_empty`, whose `hRU` is then `τ(∅) = 0`). **R-U leaves the path** (X6).
> — source: data/fs131/claims-NF2.md § The chain's leaves (the map's, numbered as there)

> NF2-LEAF-13: **Kolmogorov–Sinai entropy** `h_μ(T)` of a measure-preserving map for an invariant probability measure, with the conditional form `h_ρ(γ | 𝒜)` on an invariant sub-σ-algebra. Mathlib at the pin has none (searched "kolmogorov.?sinai", "measure.theoretic entropy", "metric entropy"; found `Dynamics/TopologicalEntropy/`, `SpecialFunctions/BinaryEntropy`, `Log/NegMulLog`). Every printed input below is a sentence about it. `plans/STUB-mr-in-lean.md` notes that `[OAIMath2026]` family 015 has conditional entropy for countable partitions in Lean at another pin, headers only read: a port candidate, to be read before this is typed from scratch.
> — source: data/fs131/claims-NF2.md § The chain's leaves (the map's, numbered as there)

> NF2-LEAF-14: **The pieces**: for `Γ = ⟨u, w⟩ ⊂ U` and a finitely generated `ℤ[Γ]`-submodule `M ⊆ ℤ[U_F]` with `ℚM = F(i)`, the dual `M̂` with the action of `Γ ≅ ℤ²`, and the predicates of the printed theorem on a `ℤ^d`-action by automorphisms of a compact abelian group: solenoid, totally irreducible, virtually cyclic. Mathlib: none (searched "solenoid").
> — source: data/fs131/claims-NF2.md § The chain's leaves (the map's, numbered as there)

> NF2-LEAF-15: **Haar measure on the dual in the page's own form.** `SpectralChain.Dual` carries a σ-algebra and no topology; the chain reads Haar only through Fourier coefficients (`SpectralInputs.IsHaarFourier`). To declare a statement that says "`µ = m_X`" term for term, state it over Mathlib's `PontryaginDual` of the discrete `M` and derive the Fourier form.
> — source: data/fs131/claims-NF2.md § The chain's leaves (the map's, numbered as there)

> NF2-LEAF-16: `[EinsiedlerLindenstrauss2022]` Thm 1.2 (p. 2) — the import the chain reads (X7).
> — source: data/fs131/claims-NF2.md § The chain's leaves (the map's, numbered as there)

> NF2-LEAF-20: PE-2 (D:191): Lemma F (X02D:100); PE-1′, the pieces meet the printed hypotheses (X02D:146); Lemma W (X02D:156); Lemma Γ (X02D § 3.1, :181) over leaves 16, 17 (T2, T4); from `Γ` to `U` (X02D § 3.2, :196) over T1, T3.
> — source: data/fs131/claims-NF2.md § The chain's leaves (the map's, numbered as there)

> NF2-LEAF-21: EF_F⁺ (D:162): the model of the dual as `𝔸_𝒮/D` (FS105:76, FS105-B-M1; X01D § 2.0, :113); Lemma PF, the product-formula gap (X01D:208; Mathlib has the product formula, `NumberField.prod_abs_eq_one`); an expanding place (X01D § 3.2, :214); Lemma 3.1′ (X01D:226); Lemma 3.2′ (a), the pigeonhole with the rational unit vectors as multipliers (X01D § 3.4, :246) over the height count (FS105:106, :110); two scales and one global point (X01D § 3.5–3.6); leaves (§ 3.7); wandering shells (§ 3.8, :301; FS105:86).
> — source: data/fs131/claims-NF2.md § The chain's leaves (the map's, numbered as there)

> NF2-LEAF-22: MR⁺(F) from 20 and 21 — the kernel's `Interface.mr_of_pe2_efPlus` at `E := T + A`, where its unused clause `hHE` (Haar-null `E`) is not needed at all.
> — source: data/fs131/claims-NF2.md § The chain's leaves (the map's, numbered as there)

How the chain is run, from the deriver:

> NF2-MRPLUS: MR⁺(F): every finite rotation-invariant measure on the dual of ℤ[U_F] that gives T + A measure 0 has every Fourier coefficient off 0 equal to 0.
> — source: data/fs131/claims-NF2.md § How the chain is run (the deriver's five statements, each derived by hand, one mind)

> NF2-MRPLUS-SCOPE: 2026-10-13 16:34 UTC — **EN1-MRPLUS holds in a narrower form than written; found by the deriver (FS131-EN1, its Stage 5).** Its words: "TRUE in a narrower form than 'F a real number field' — for every real number field with R_F = O′ (no stable dyadic place ramified in F(i)/F), and with 'finite measure' read as finite positive measure. (a) Scope: EF_F⁺'s three proofs need R = O′; at row 100's exception fields MR⁺ is a GAP exactly where MR is. The class of rows 121 and 123 (L ≥ 5) lies inside R = O′, so the path loses nothing. (b) Under the literal signed reading (τ signed, τ(T + A) = 0) it is false: the difference of two archimedean circle measures." A Lean statement of MR⁺ carries both: the field's hypothesis and positivity.
> — source: data/fs131/claims-NF2.md § How the chain is run (the deriver's five statements, each derived by hand, one mind)

> NF2-FROM-TWO: MR⁺(F) follows from PE-2 and EF_F⁺ alone: EF_F⁺'s conclusion is already about T + A (a zero-entropy invariant measure is carried by T + A), so for an invariant τ null on T + A, τ = a·m + τ′ (PE-2), τ′ ≤ τ is null on T + A and, by EF_F⁺, null off it, so τ′ = 0.
> — source: data/fs131/claims-NF2.md § How the chain is run (the deriver's five statements, each derived by hand, one mind)

> NF2-SPCOR: SP-Cor at S = ∅ needs only MR⁺(F) and A⁺ at S = ∅; run at E := T + A, the hypothesis R-U is τ(∅) = 0.
> — source: data/fs131/claims-NF2.md § How the chain is run (the deriver's five statements, each derived by hand, one mind)

> NF2-APLUS: nothing in A⁺ at S = ∅ (SI-3, SI-4, N2 at S = ∅) reads E beyond T + A; N2 at S = ∅ does still need N1 (a) at S = ∅ — the characters continuous for the profinite-plus-archimedean topology are exactly T + A.
> — source: data/fs131/claims-NF2.md § How the chain is run (the deriver's five statements, each derived by hand, one mind)

> NF2-OFFPATH: the hand result R-U, with the split-place topology under it, and N1's clauses about the split places and "Haar(E) = 0", are not on the path of ledger rows 121 and 123 (the plane over the field of √47 needs five colours; the main clause through five); the split-place E stays what it was for the selection results and Theorem C at S ≠ ∅ (rows 112, 116–118).
> — source: data/fs131/claims-NF2.md § How the chain is run (the deriver's five statements, each derived by hand, one mind)

> NF2-NC: any size or price of a leaf (the map says none of leaves 8–23 is sized); that the leaf list is complete (the deriver's table names two results read on the path that are not numbered leaves: the density of the ring in its completion, and the ring equalling its maximal order away from the exception fields); that the printed rigidity theorem is formalized (it is declared, with its four items); that any leaf is new mathematics.
> — source: data/fs131/claims-NF2.md § Not claimed

The other fourteen leaves are in the claim list, numbered as in the map; you cut them into later modules.

**Rulings already made, which bind the architecture** (mine, each logged with its alternative in the backlog's
inventory, items 642, 646, 651):

1. The interface is run at the smaller set, the torsion and archimedean characters; the single sentence the chain
   reads is typed for positive finite measures and for fields with no ramified stable dyadic place, as the deriver's
   scope line says.
2. **The printed theorem declared is Theorem 1.3 of the Einsiedler–Lindenstrauss paper, with the sense its hypothesis
   is forced to have written into the Lean statement and said in its four items; this project's deduction of Theorem
   1.2 from it is a leaf to formalize.** The reason: the paper proves 1.3; 1.2's printed proof is an outline and its
   deduction is ours; Kooshi's rule is that everything of ours on the path is formalized. If the page shows that 1.2
   has a complete printed proof, tell me — that would change this.
3. The eigenvalue bound at the dyadic targets is the deriver's elementary fourth-moment count (its entry EN1-UQ4,
   with the exact spectra at 64 and 128), not a second printed bound in characteristic 2, which no record cites by
   page.
4. Herglotz–Bochner and Markov–Kakutani are formalized, each as a module of its own; the other outside statements
   are declared or formalized by the map's § X5 calls until you find reason to change one.

**Three questions the deriver left for you** (its report, `data/fs131/reports/FS131-EN1.md`): the hypothesis-shaped
definition for the entropy split carries a conjunct the proof never uses (restate beside it, or prove the conjunct —
say which and why); one definition of the smaller set has to serve both the pigeonhole lemma, which names it in an
adelic model, and the spectral lemmas, which read it as a group of continuous characters; and two results read on the
path are not numbered leaves (the density of the ring in its completion; the ring equalling its maximal order).

## Done means

1. **Readback** (a saved stage): the sixteen quoted lines checked against the claim list, and the claim list's leaves
   against the map; the kernel theorems of the chain read in the source (`Proofs/HadwigerNelson/SpectralChain.lean`
   and what it imports), each hypothesis listed with what it would take to make it a closed statement.
2. **§G and §PA, short** (a saved stage): the grokkings on the kernel's cost and the gate that bear on a chain this
   long, by number; and for each printed statement the chain reads — the rigidity theorem first — where it is
   printed, whether the page is held (`~/source/library/`), the statement as printed, and what Mathlib or any other
   Lean development already has. A paper not held is named with its address for Kooshi to fetch; do not work around
   a blocked fetch.
3. **The first layer, typed and compiling** (stages as you go): the smaller set as a set of the dual with what the
   chain needs of it; the entropy of a measure-preserving map and its conditional form, with the few lemmas the
   statements need and an inhabitant; what the printed theorem's statement needs (the pieces, the measure on the
   dual with a topology); the printed theorem declared, its four items drafted; the two deductions (the entropy
   split; the pigeonhole carried to the field) as closed statements with `sorry`; the single sentence proved from
   them; the headline restated at the concrete interface so that its hypotheses are exactly those closed statements
   and the classical ones. Every definition with an inhabitant, every statement read back aloud against its claim.
4. **The architecture**: every remaining leaf, and the two unnumbered results, assigned to a module; for each module
   a draft claim list under `data/fs131/kn3/` (statements exact enough to type, each with its derivation address
   from the deriver's table), what it imports, what it exports, and which modules can be planned and built at the
   same time without sharing a file. Say which two or three modules you would start next and why.
5. **Sizes only from what you typed or read in full**; an unknown is written as unknown. Formalization effort is not
   a reason to leave a leaf out or to import what is ours (`CLAUDE.md` § Counter-priors, the quotation on Lean).
6. The report, with drafts for the files you do not write.

## What is yours to decide

Every definition's form; the module map; whether a classical statement is formalized or declared; whether the
existing abstract interface is kept with a concrete instance or replaced beside itself; the order of the later
modules. If typing shows that a leaf is false, or that the chain can be shorter than the deriver's table, send it at
once — a statement defect goes to the derive lane the same hour.

Not yours here: pricing the formalization of the printed rigidity theorem itself (a job of its own, later); any
change in place to a statement through the gate; the upper half and the residue homomorphism (another planner has
them on branch `fs131-wnf`).

## The machine

**This session is on the laptop: 12 cores, 31 GB — the desktop's numbers in `RUNNING.md` and `LEAN.md` do not apply
today.** Run the memory tool as

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --name kn3 -- <command>`

One file through `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration: under the
slot with `--mem 8 --cpus 2` from inside your worktree — measured today at 3 to 24 seconds and 3.6 GB. A build is one
at a time on this machine and two other planners may be building: on exit 75 wait and retry.
`--mem 18 --cpus 10 -- env MEMMAX=18G BATCH=2 ./scripts/build.sh` from inside the worktree; never `lake build`. The
build's numbers are unmeasured here: tell me what the first one used. Stop a process by its PID, never by matching
its command line. `/tmp` is wiped at power-off: anything your record cites lives under `data/fs131/kn3/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**;
a failed push is not an error to fix.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).
