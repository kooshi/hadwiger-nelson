# Brief FS131-EN1 — does the proof that two number-field results rest on really need the split places? Five statements a kernel planner read off the kernel proof, to derive or refute from the derivations

*Written 2026-10-13 16:15 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-EN1
  identity: Ephodos, the deriver — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; this is a derivation job on a fixed claim list
  role: the deriver on five statements proposed by the kernel lane's planner — a shorter route under the lower bound for planes over number fields, read off a kernel proof and checked by nobody; you derive each from the derivation entries it names, or find where it fails, before a Lean module is planned on it
  launch: now, on `main`; beside you the planner who proposed them maps the library on a branch of its own, and the asking lane ranks findings under `plans/` — you write no file either writes
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you; you may read the planner's branch
  channel: message the coordinator ("main") by SendMessage **with each statement's verdict as it is reached** (the planner is waiting on the fourth above all); at once for a statement that is false as worded, or true only in a narrower form — say the form; the report goes to `data/fs131/reports/FS131-EN1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS131-EN1-derivation.md` (new)
  touches: `plans/FS131-EN1-derivation.md`, `data/fs131/en1/`, `data/fs131/reports/FS131-EN1.md`; on `main`, committed by explicit path. Nothing else: an erratum to an older derivation file is drafted in your record, not written there
  budget: about 250k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit) after the readback and after each statement's verdict; hand back before you would guess 400k

Hello. This is a short job with a large lever on it.

## Why this job

The project is being wound down and published, and Kooshi's rule for what goes out is this:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The first things to be formalized are the results about planes over number fields, and the best of them — that the
plane over the field of the square root of 47 needs exactly five colours, and the general statement it is a case of —
rest on a chain of hand results. One link of that chain, the one the record calls R-U, sits on the topology of the
split places, and a month ago the kernel lane priced it in months.

This morning the kernel planner, reading the kernel proof that already assembles the chain over named hypotheses,
noticed that the proof never uses the set the split places define except through a smaller set — the torsion and
archimedean characters — and proposed that for these two results R-U is not on the path at all. If that is right, the
longest leaf of the first module disappears. If it is wrong in any clause, a module planned on it is wasted. It is one
mind's reading of a Lean proof; nobody has read the derivations with this question. You are that reading.

No answer is the wanted one. "False, and here is the step that reads the larger set" is as useful to the planner as
"derived".

## The statements

Fixed in `data/fs131/claims-EN1.md` before your launch, in the proposer's words:

> EN1-MRPLUS: MR⁺(F): every finite rotation-invariant measure on the dual of ℤ[U_F] that gives T + A measure 0 has every Fourier coefficient off 0 equal to 0.
> — source: data/fs131/claims-EN1.md § Statements

> EN1-FROM-TWO: MR⁺(F) follows from PE-2 and EF_F⁺ alone: EF_F⁺'s conclusion is already about T + A (a zero-entropy invariant measure is carried by T + A), so for an invariant τ null on T + A, τ = a·m + τ′ (PE-2), τ′ ≤ τ is null on T + A and, by EF_F⁺, null off it, so τ′ = 0.
> — source: data/fs131/claims-EN1.md § Statements

> EN1-SPCOR: SP-Cor at S = ∅ needs only MR⁺(F) and A⁺ at S = ∅; run at E := T + A, the hypothesis R-U is τ(∅) = 0.
> — source: data/fs131/claims-EN1.md § Statements

> EN1-APLUS: nothing in A⁺ at S = ∅ (SI-3, SI-4, N2 at S = ∅) reads E beyond T + A; N2 at S = ∅ does still need N1 (a) at S = ∅ — the characters continuous for the profinite-plus-archimedean topology are exactly T + A.
> — source: data/fs131/claims-EN1.md § Statements

> EN1-OFFPATH: the hand result R-U, with the split-place topology under it, and N1's clauses about the split places and "Haar(E) = 0", are not on the path of ledger rows 121 and 123 (the plane over the field of √47 needs five colours; the main clause through five); the split-place E stays what it was for the selection results and Theorem C at S ≠ ∅ (rows 112, 116–118).
> — source: data/fs131/claims-EN1.md § Statements

> EN1-NC: that any of these is new mathematics; that R-U is false or unneeded elsewhere; anything about rows other than 121 and 123; that the kernel's present theorems already state MR⁺(F) (they are stated over an abstract interface).
> — source: data/fs131/claims-EN1.md § Not claimed

Where the proposer read them from: `Proofs/HadwigerNelson/SpectralChain.lean` — the theorem
`Interface.mr_of_pe2_efPlus` at its line 196 and `x4_eq_empty` near line 519 (the proposer says a clause named `hHE`
there is bound and never used). Where the hand results live: `plans/FS100-derivation.md` (the entries FS100-EFP at
about line 162, -EFZ, -PE1, -PE2, -MR, and § 4 for the corollary), the derivation files that hold the entries named
J45 (R-U at their § 5.4; N1 and N2), SI-3 and SI-4 — find them by `rg` over `plans/*-derivation.md` and say in your
record which file each is in —, `plans/FS100-K-kernel-47.md` § 1.3–1.4 (the dependency map the kernel lane drew a month
ago, with R-U on the path), and `LEDGER.md` rows 120, 121 and 123.

## Done means

1. **Readback** (a saved stage): the six quoted lines checked against the claim list; each statement restated in your
   own words with every symbol resolved to its entry and address; anything you cannot resolve said at once.
2. **Each statement at a verdict** — derived, with its argument from the entries; or false, with the step; or true in a
   narrower form, stated — in your lane's entry form, through your gate. For EN1-APLUS that means reading SI-3, SI-4
   and N2 at S = ∅ line by line for every use of the larger set, and listing each use with what it needs of it.
3. **Attack the fifth statement from the other side**: walk the whole chain under rows 121 and 123 as the record
   derives it, start to finish, and list every place the split places, R-U or "Haar(E) = 0" are read — not only the
   places the proposer named. A dependency that enters by a lemma nobody thought of is the failure this job exists to
   find.
4. **What the planner needs, said plainly at the end**: the list of hand results that *are* on the path of rows 121 and
   123 after your reading, each with its entry's address, so that the map's leaves can be checked against it.

## What is yours to decide

The order; whether a statement is better split; the form of a narrower true statement. If you see a still shorter
route, say so in a section of its own, marked as yours and unchecked — do not fold it into a verdict.

Not yours here: the Lean statements; the choice of which printed theorem is declared (ruled: the theorem proved in
print, with our deduction of its corollary formalized); anything about rows other than 121 and 123.

## The machine

This session is on the laptop, away from the remote: **commit by explicit path and do not push** — the server is
unreachable, and a failed push is not an error to fix. `/tmp` is wiped at power-off: anything
your record cites lives under `data/fs131/en1/`. No search and no Lean build is part of this job.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).

## Amendment 1 (2026-10-13 16:25 UTC) — two more questions from the planner's finished map, on the same chain; and a correction to this brief

**The correction first.** Your readback found that my sentence on where the unused clause `hHE` sits did not match the
proposer's words. You were right to hold to the claim list: the five statements are as fixed there, and my sentence in
§ The statements about that clause was a paraphrase of mine — disregard it and read the Lean source.

**Two questions.** The planner's map is finished and on `main` (`plans/FS131-KN1-number-field-kernel-map.md`; the chain
is its section "The chain: rows 120, 121, 123, 127", leaves 8 and 18). Its report asks the derive lane:

> - question for another lane (the deriver) — which bound does CLS use on the dyadic inert targets U_Q, Q = 2^f ≥ 64? The held Weil import is "characteristic not 2"; if a Kloosterman bound in characteristic 2 is read, it is a second printed statement not yet declared — record, chain leaf 8
> — source: data/fs131/reports/FS131-KN1.md

> - question for another lane (the deriver) — does EF_F⁺'s Lemma 3.1′ need Shannon–McMillan–Breiman, or only the definition of entropy? — record, chain leaf 18
> — source: data/fs131/reports/FS131-KN1.md

Each is a reading of the derivation entries, not a new derivation: say what the entry's argument actually uses, with
the address of the step, and whether a printed statement beyond those already declared is read. Answer them after the
five statements, as two short sections of your record, and include them in your message when they are done. If either
turns out to need a derivation and not a reading, say so and stop there — that would be a job of its own.

Nothing else changes. You start no agents of your own (standing rule 1: delegation is one level deep, because the
coordinator can only review work it knows exists).
