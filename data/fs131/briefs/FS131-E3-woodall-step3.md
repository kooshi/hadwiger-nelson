# Brief FS131-E3 — Woodall's step 3 for the Lean chain: derive the modification, or a route around it

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-E3
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job
  role: derive two fixed questions to a verdict each — Woodall's step 3 as the Lean chain states it (derived, refuted, or a GAP at a named step), and whether the chain's conclusion can avoid it
  launch: now, beside FS131-I3h (wave 3's implementer) and FS131-T3 (gate tooling), each in its own tree
  mission: § Why this job
  statements: § The questions
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a refutation, a route the formalizers can use at once, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-E3.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS131-E3-derivation.md`
  touches: `plans/FS131-E3-derivation.md`, `tools/fs131_e3_*.py`, `data/fs131/e3/`, `data/fs131/reports/FS131-E3.md`
  budget: about 350k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. "Maps need six colours" — Woodall's 1973 theorem as this project repaired it today — is nearly whole in Lean. Two of its three modules are proved,
E1-NO45 (the lemma a deriver found this morning to bypass two broken steps of Woodall's proof) closed in Lean exactly as derived, and steps 5 and 6 are
proved. Two leaves remain. One, the existence of a sector picture at every point, has a route. The other is **Woodall's step 3**: recolour a valid map near
its vertices so that a colour repeated at a vertex sits on zero-angle sectors only. The implementer who reached it (FS131-IWb) re-priced it at 1,500–3,000
lines and found that the record has no derivation of the global modification with every clause, so it comes to you first.

## Why this job

`CLAUDE.md` § The aim, item 4, and `LEDGER.md` row 132 hold "maps need six for arc maps" through this chain; route M's reduction of `χ_m⁰(ℝ²) ≥ 6` rests on
it. Step 3 is the last mathematical piece between the chain and a kernel proof. Either a derivation precise enough for a planner, or a route that makes
the step unnecessary, closes it; a counterexample would be a finding of the first size. Kooshi: *"A proven theorem about why its impossible is also valid.
All novel knowledge is a success."* (`plans/STANDING-RULES.md` rule 4).

## The questions

The claim list is `data/fs131/claims-E3.md`: the definitions and the Lean statement copied by script, the chain's consumer, FS110-W-MERGE (the local step at
one vertex, two minds), then the questions. Read it whole. They open:

> **Q1 — Woodall's step 3, as stated.** Is `exists_woodallMerged` true: does every valid plane arc map have a valid plane arc map, Condition 5 kept, in which
> — source: data/fs131/claims-E3.md § The questions

> **Q2 — a route around it.** Does the chain's conclusion (`aeMap6`: no valid five-coloured plane arc map) follow without the modification — for instance by
> — source: data/fs131/claims-E3.md § The questions

## Done means

1. **Your readback first**: check both quotations against the claim list and the claim list's quotations against their sources; restate the questions in
   your record; read FS110-W-MERGE's argument where its entry points (N § Continuation — FS110-N3 §2.2, in `plans/FS110-N-proof.md`; NB3 §2.2, in
   `plans/FS110-NB3-verification.md`) and `[Woodall1973]` § 3
   step 3 (`~/source/library/pdf/jcta-1973-woodall-distances-realized-covering-plane.pdf`, p. 197, from the page image), with addresses. Register your
   predictions per question before the written derivation.
2. **A verdict per question**, in your lane's derivation form. For Q1 derived: the modification written so a planner can state its children — the set of
   vertices touched, the recolouring at each, the radii and why they can be chosen uniformly in each bounded set, why validity, local finiteness, the plane
   domain and Condition 5 survive, and why `WoodallMerged` holds after. For Q2: the route, the lemmas it needs, and their cost compared with Q1's.
3. A recommendation, with its reason, of which route the chain's planner should take.
4. Your record in stages headed "Stage n — SAVED", committed by explicit path; your derive gate (`.claude/skills/ephodos/scripts/derive_gate.py all
   plans/FS131-E3-derivation.md`, from `plans/`) green; the report in standing rule 11's form. Stopping at a saved stage with a question left, named, is a
   good report.

## What is yours to decide

The route and the order. Attack the statement: if `exists_woodallMerged` as stated asks for more than the chain needs (`aeMap6` uses only `WoodallMerged`'s
consequence through `aeMap6_merged`), say what weaker statement serves, and if the definitions hide a case that breaks it, say so with the address.

## The machine

No Lean builds are needed for this job; exact checks under the slot if any is heavy (`/home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 --
<command>`). You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).
