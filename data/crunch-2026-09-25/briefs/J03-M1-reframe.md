*Brief for crunch job **J03**: the reframe and subplan of milestone M1, FS-91 opened as "the character local–global theorem, and band
rigidity to nine colours". Opus 5.5, 2026-09-25. Written by the crunch planner (`plans/CRUNCH-2026-09-25-queue.md` §2). This is the
template for every crunch reframe (§4.2 of the queue file).*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the milestone's planner**, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. The house rules are `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md`; read all three from disk, since the
copy loaded at your start may be stale. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.** The
owner coordinates and reviews by artifact. The plan is yours; the choices are Kooshi's, through the owner.

## What you are doing, and why it is one job

WORKFLOW opens every milestone with the reframe: the re-grokking (3.1, **§G**), the prior-art gate (3.2, **§PA**) and, for a derivation
milestone, the invariant question (3.3, **§IQ**). Then come the subplan (4) and the modeling passes (6). In this crunch one job does all
of that and also writes the briefs for the milestone's jobs, so that no separate planner is needed. The crunch has 16 hours, so the
reframe is kept in proportion by five devices (queue file §1.9), and it is never skipped.
- **Walk every entry fresh from disk, one line each, with no batching:** every grokking G1–G76, every `LEDGER.md` row 1–97 by its
  mechanism, and every `[method]` rule in `CLAUDE.md` § Grokkings, § Building and § The gate. Read `LEDGER.md` in full.
- **Use the terse verdict lines:** `G54 — bears: <≤ 25 words> → stage <n>`; `silent: <≤ 10 words>`; `falsifiable: registered as P-<x>`.
- **§PA is time-boxed at about 45 minutes and 60k tokens**, run in the recognition's words and with the zbMATH API for discovery (WORKFLOW
  3.2 item 8). Record negatives.
- **The owner scores §G from your report's bears list**, and a clerk counts completeness mechanically. So make every entry findable by its
  id at the start of its line.

## The milestone

**M1's questions**, sharpened by the crunch advisor (Poros) and the FS-91 stub (`plans/STUB-band-rigidity-six.md`, read in full):

1. **The character local–global theorem** (the advisor's F2, verbatim): "A character `k`-colouring of `F²` forces a `k`-colourable residue
   target", taken "at k = 4, 5 now, and to k ≤ 9 if PA-B3 survives its blind verifier". "The product step is the Tardif reading's PA-T4,
   or a direct sumset argument; the archimedean circle is the new factor." "It turns rows 96–97's per-field corollaries into one class
   theorem." Read `plans/PA-tardif2023.md` (PA-T4, PA-T5) and `plans/FS89-derivation.md` CL2, CL4, CL5.
2. **Six at the exposed fields** (the stub's question 2): character six-colourings of ℚ(√167) (usable planes 23, 43, …), of `K(√7)` and
   of de Grey's field `K(√5,√7)`. At 23, `α(Γ₂₃) ≤ 97` gives ratio 0.183 > 1/6, so FS-89's five-colour ratio argument does not transfer,
   and a direct level-one argument is needed. **At the ban's edge:** checking every additive character of `Γ₂₃` and `Γ₄₃` against the
   band is `q − 1` classes, a finite set fixed by a derivation. Brief it as that, logged, never as a search. **Note** what a positive
   answer would mean: a six-colour band character of `Γ₂₃` at level one would six-colour `Γ₂₃`, the window member G56 says would be the
   first exactly six-chromatic finite plane. Register that outcome's probability honestly.
3. **One prime** (the stub's question 3): U3 (`RS₄({p})` false at every single prime `p ≡ 1 (mod 4)`, proved at 5 only) and `MS₄({5})`.
   The advisor's note for its brief: the torsion-order lists are close-inventory item 17's kind (Kooshi's ruling is still carried). "Brief
   them as complete enumerations with the derivation that fixes the set, never as 'try orders until one works'."
4. **Three colours (FS-82, absorbed).** Two stage-0 jobs are already running on it: J02 derives the advisor's sketch, and J09 derives
   the same statements blind. **Do not duplicate them.** Consume their result only as a named hypothesis until both have reported.
5. **PA-B3** (band rigidity to nine colours). Stage-0 job J01 is verifying it now. Consume it only as a named hypothesis ("given PA-B3,
   unverified") until J01 reports TRUE.

## Read first, from disk

- `CLAUDE.md` in full, from disk. The Frontier items 24–25 and G76 were rewritten today.
- `LEDGER.md` in full.
- `plans/FS89-rational-band-rigidity.md` §0, §IQ and §R-close.
- `plans/FS89-derivation.md`.
- The stubs FS-91, FS-82 and FS-83 (`plans/STUB-layer-method-five-colours.md`).
- `plans/PROTOCOL-competitor-and-advisor.md` §3, the seventh run: one derivation agent plus a blind verifier with a fixed list.
- As briefs to copy the house form from: `data/fs89/briefs/S1-D-derivation-brief.md` and `data/fs89/briefs/S1-VB-verifier-brief.md`.
- The crunch queue file, §1 and §4.

**Not blind, but fenced in one direction.** You may read J01's, J02's and J09's records as they appear. Write nothing that tells a blind
job a route it is fenced from. Your plan file is fenced from J09 and from every verifier until that verifier's verdicts are committed, so
routes may live in it; the verifiers' briefs must not carry them.

## What to produce

**1. The plan, `plans/FS91-character-local-global.md`**, in this order:
- §G, with G.1 grokkings, G.2 rows, G.3 method rules, and G.4, what the re-grokking changed;
- §PA;
- §IQ, the five items of WORKFLOW 3.3;
- §S, the stages as jobs;
- §P, the registered predictions, with probabilities, before any stage-1 job runs;
- §M, the modeling passes: invoke `debruijn-domain-modeling` and `debruijn-obligation-modeling` freshly with the Skill tool, applied to
  the statements;
- §X, your would-have-searched log.

Save after each section.

**2. The briefs**, one file each under `data/crunch-2026-09-25/briefs/`, in the house form of queue file §4.1, each pointing to
`STANDING-RULES.md`:
- **J07**, the derivation of question 1;
- **J08**, the derivation of question 2;
- **J12**, the derivation of question 3;
- **J10, J11, J13**, the blind verifiers of J07, J08 and J12. **Write each verifier's fixed claim list now, before any claim exists**
  (FS-89's V-A): the target statements, quoted verbatim from your §S, with the verified inputs listed and the fences named. Include
  FS-89's cheap fallback: a lemma-statement phase after a blind phase stalls.

Size every job to about 2–3 hours and 350k harness tokens, with a stop rule and a stage list. If a question is bigger, split it and add
queue lines.

**3. Your report**, standing rule 9. Its RESULT line carries:
- the counts (grokkings, rows, rules walked; bears / silent / falsifiable);
- the milestone's question in one sentence;
- §IQ's structural form in one sentence.

List the bears as INVENTORY lines, `bears — G<n>: <what it changes> — §G.1`, and the six jobs as SPAWN lines.

## Stages

1. The quotation check, then §G.1 (about 80k). Save.
2. §G.2–G.4 (about 80k). Save.
3. §PA (about 60k). Save.
4. §IQ, §S and §P (about 50k). Save.
5. §M, and the six briefs (about 60k). Save and report.

- **Paths:** `data/fs91/j03/` for anything the plan needs beside it.
- **Budget:** about 350k in the harness's count. Hand back by 420k. If stage 5 does not fit, write J07's and J10's briefs first, then J08
  and J11, then J12 and J13, and report what is left.
