# Brief FS133-E1 — FS-133, the one-class transfer: its opening, and the derivation of its claims in order

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word. Launch line: "Your brief is on disk: read it in full first."*

brief: FS133-E1
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; this job is its opening job (§G, §PA, §IQ, the plan) run short, followed at once by its derivation job on the claim list, which is already fixed
  role: open a short milestone and derive it — whether the densest measurable planar set with no two points at distance 1 has the same density as the best finite or fractional bound, with no hypothesis, as a consequence of an outside rigidity theorem that this project adopted as literature today and whose manuscript does not draw it; the one unchecked step first
  launch: now, in a free slot; an implementer is importing the outside theorems into Lean and a reviewer is sweeping the release's other families — you touch neither
  mission: § Why this job
  statements: § The claims
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind
  channel: message the coordinator ("main") by SendMessage **with C133-DENS's verdict as soon as it is saved** (derived, refuted, or stalls at a named step — everything else waits on it); **at once if your prior-art search finds the claim stated anywhere** (a preprint dated after 2026-10-06 is the likeliest: the proof it follows from is public); for a refutation of any claim; and for a question you cannot work around; the report goes to `data/fs133/reports/FS133-E1.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS133-E1-derivation.md`
  touches: `plans/FS133-E1-derivation.md`, `plans/FS133-one-class-transfer.md` (the milestone's plan: its §G, §PA, §IQ), `data/fs133/` but for the claim list (`data/fs133/claims.md` is the coordinator's: a statement you find wrong is a message), `data/fs133/reports/FS133-E1.md`; **not** any derivation file of another milestone (a correction owed is a draft in your record), any Lean file, `CLAUDE.md`, `LEDGER.md`, the stub (its bearing lines are redrafted in your record), the outside clone at `/home/kooshi/source/math` (read it; write nothing into it)
  budget: about 350k by the harness's count, as guidance (your launch preloads the grokkings, about 150k); hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. Yesterday an outside organisation published a Lean-formalized proof that the plane is not five-colourable. This project built
it today on the standard three axioms, read its manuscript in full, and adopted it as literature. Its engine is a rigidity theorem:
at the plane of algebraic points, every probability on the character group that is invariant under the algebraic rotations and null
on the continuous characters is Haar. The manuscript uses it for colourings. The colleague who read the manuscript saw that the same
theorem, run for a single colour class, appears to give something the manuscript does not state: that the best density of a measurable
planar set avoiding unit distance equals the bound every finite unit-distance graph gives — with no hypothesis. This project holds
that equality only given an outside conjecture-strength input. One step of the sketch is unchecked. The asking lane has made it a
milestone and put it first, because its value decays with the calendar: the proof it follows from is public.

## Why this job

Kooshi's instruction for the release is to build on it and move first ("definitely build on it... write the stub", of this very
consequence). If the unchecked step closes, this is a result of this project's — a clause of a 2026 conjecture and a 1996 question
answered — on top of a theorem the kernel has accepted. If it does not close, the step where it stalls is a result too, and the
ledger's row keeps its condition for a known reason. Lean toward neither: the sketch is one mind's, written at the end of a long
reading, and its author named its own gap. His words:

> > You may use their proof as any other literature. Cite it, build on it, let's use it to slingshot us past anyone else working on this problem.
> — source: data/external/EXT-OAI1-request.md

> > 1. port or import: let's import and adopt parts piecemeal if needed. 2. indeed 3. definitely build on it... write the stub 4. not sure, probably allow, but audit what it does 5. pause the backlog, lets come to a stopping point, collect ourselves and have poros rerank.
> — source: data/external/EXT-OAI1-request.md

## The claims

The claim list is `data/fs133/claims.md`, fixed before this launch from the asking lane's stub: read it whole, then the stub whole
(`plans/STUB-one-class-transfer.md` — the mission, the card with both forms, the first claim, what each answer gives, the registered expectations, the prior
art and the risk of being second, the failure clauses). The four claims, first lines:

> **C133-DENS (posed) — the unchecked step.** Let `H : ℝ² × Ω → [0, 1]` be jointly measurable with `∫ H(x, ω) dμ(ω) = α` for every
> — source: plans/STUB-one-class-transfer.md

> - **C133-INV (posed).** At the algebraic plane `E = ℚ̄`: there is an `E ⋊ K`-invariant probability on the independent subsets of
> — source: plans/STUB-one-class-transfer.md

> - **C133-ONE (posed).** `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`: steps F3–F9 of the transfer
> — source: plans/STUB-one-class-transfer.md

> - **C133-HOM (posed, the structural form's first rung).** For a finite graph `H`: a homomorphism of the plane's unit-distance graph
> — source: plans/STUB-one-class-transfer.md


The sketch you start from, and the theorem it runs (read `plans/EXT-OAI2-reading.md` § 2.6 whole, with its stage 2 on the transfer's route and the
rigidity theorem's five moves):

> ### 2.6 One consequence the manuscript does not draw, sketched (one mind; a candidate, not a result of this job)
> — source: plans/EXT-OAI2-reading.md

## Done means

1. **Your readback, and a short opening.** Check the quotations against their sources. In the milestone's plan
   (`plans/FS133-one-class-transfer.md`): §G — the grokkings this question touches, each with its *bears* line, and the silent
   list; §IQ — the invariant question, with the structural form checked not to be the existence form reworded; **§PA — the
   prior-art gate, done before the derivation and again before your report**: the claim in the discipline's words and in a
   neighbouring discipline's (the fractional chromatic number of the plane; the density of sets avoiding distance 1; `m₁(ℝ²)`;
   measurable against arbitrary; Johnson's questions; the 2026 conjecture's first clause), arXiv listings from 2026-10-06 on, and
   what `BIBLIOGRAPHY.md` and `CLOSED-QUESTIONS.md` already hold — with what was searched and what was only seen in a listing.
   Register a prediction per claim. Commit and push.
2. **C133-DENS first — the unchecked step — and its verdict to me by message.** In your lane's derivation form (statement, uses
   only, not claimed, argument, verdict, grade, minds, model, prior art, handoff). A refutation is an exhibited object, checked,
   with a control that fires on a planted fault; no search.
3. **Then C133-INV, C133-ONE, C133-HOM, in that order**, each to a verdict, saving after each. For each: exactly which statements
   of the release it reads (by the manuscript's number and by the Lean name where the audit gives one —
   `plans/EXT-OAI1-audit.md` stage 6), and whether it reads the rigidity theorem itself, which the Lean import in progress does not
   declare (if it does, say so: the import gains a third theorem). And the trace: what `LEDGER.md` row 129 and the grokking it
   names become under each verdict, as replacement sentences in your record.
4. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; your derive gate
   (`.claude/skills/ephodos/scripts/derive_gate.py all plans/FS133-E1-derivation.md`, from `plans/`) green; the report in standing
   rule 11's form. Stopping at a saved stage with C133-DENS answered and the rest open at named steps is a good report.

## What is yours to decide

The route to each verdict; the form of any counterexample; whether a claim as posed is the right statement — a claim true only at
a narrower class than posed, or true more widely, is a finding, and the claim list is then amended by me from your message. The
sketch is a starting point, not a route you owe. You start no agents of your own (standing rule 1: delegation is one level deep,
because the coordinator can only review work it knows exists).

## The machine

No Lean build is needed. A check that needs more than a few gigabytes runs under the slot
(`/home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- <command>`); nothing runs outside it but short scripts. `/tmp` is
a tmpfs: keep what your record cites under `data/fs133/`.
