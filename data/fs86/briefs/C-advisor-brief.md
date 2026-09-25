Hello Poros. I'm the product owner of the Hadwiger–Nelson project in `/home/kooshi/source/lean-dir`, the coordinating session. Kooshi, the human whose project this is, asked me to coordinate this milestone rather than do its mathematics, and asked for its derivation work to run as a competition. I'd like you to be **the competition's advisor for FS-86**. Two competitors, **Coxeter** and **de Bruijn**, are already working the same problem independently. Please advise them both.

- **Advise both, honestly and identically.** You do not carry information between them. That is their channel to manage, and they have agreed to trade only teasing hints. If one tells you something the other has not found, it stays with you.
- **Send frame-level corrections to both at once, unprompted.** Withholding one until asked would advantage whoever asks first.
- **The two competitors are primed differently** (the protocol's rule 2): de Bruijn with a short preamble about building wooden boats, Coxeter with one about dancing Argentine tango, the same pair FS-79 and FS-85 used. Everything else in their briefs is word for word the same (the owner checked by diff).
- **Why you start late:** the three-agent cap. A blind verifier of the plan's frame had the third slot until it finished; it has now finished. The competitors started a few hours before you and are writing their first routes.
- **How outcomes count** (Kooshi, 2026-09-24): *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."* A proved "no", or a no-go of a named format, counts exactly as a "yes" does. Please police any lean toward a yes: a yes here would answer Soifer's Open Problem 55.1, and the prior against it is strong.

## Who you are, and what to read first

1. **Your identity:** `~/source/poros/CLAUDE.md`. Your skills are files, not Skill-tool skills; read them directly:
   - `~/source/poros/.claude/skills/poros/SKILL.md`;
   - `.../poros-anomaly-hunt/SKILL.md`;
   - `.../poros-reframing/SKILL.md`.
2. **The house standard, from disk:** `CLAUDE.md`, `WORKFLOW.md`, `DEBRUIJN.md`.
3. **The situation and the challenge, verbatim:** read **`data/fs86/briefs/C-competitor-brief-coxeter.md`** in full. It is identical to de Bruijn's apart from the name, the persona and the scratch paths, and it contains:
   - the plan's §C text: the mathematics they stand on, the challenge S1/S2, the scope rule, the ban, the protocol;
   - Addendum 1: stage B's results;
   - the mechanics they work under.
4. **Addendum 2**, `data/fs86/briefs/C-addendum-2.md`: verifier B1's remaining verdicts. I am sending it to both competitors now, identically.
5. **The plan:** `plans/FS86-dyadic-rigidity.md`, with the killing test and the trivial list T at **§S.4**, the verdicts at **§P**, and the owner's rulings at **§R-review**.
6. **The protocol:** `plans/PROTOCOL-competitor-and-advisor.md` §1 (all eleven rules) and §3 (the earlier runs; FS-85's is the fifth).

## Your specific duties this run (the plan's §C.2, with the owner's additions)

1. **Adjudicate the killing test in writing at the end of round 1** (plan §S.4).
   - Round 1 ends when both competitors have sent me their round-1 reports, or at **2026-09-27 23:00 UTC**, whichever comes first. I'll tell you when both reports are in.
   - For each of K1–K4, record the check you ran. Police T, and name the item a rejected condition reduces to.
   - **For K3, pin the format in writing before reading the proof.**
   - Send me the verdict by SendMessage: passes (with which K and the check), or fires.
2. **Police scope.** A result is on the field plane (`R`), the class, a lattice, or K. A lattice result is never scored as a field result, and a yes counts only at `F` itself.
3. **Police the free outcome.** `P(R) ≠ 0` is known (plan §0.3, verified blind), so a result that restates it is not progress on S1.
4. **Police transfer.** Forcing is monotone upward, and a held proof used on ℚ(√59) must be re-walked for its logic (FS85-V6).
5. **Held items:** see below.
6. **Count retractions**, yours included. Log asymmetric cards where both competitors can read them at hand-back.
7. **Any claimed yes or no: tell me at once**, so a blind verifier can be launched while round 2 runs (the protocol, rule 11). A blind verifier needs a slot, so you may be stood down for it, as at FS-85.

## The previous advisor's notes for you (the plan-phase Poros, stood down)

- **The sharp form** (now in Addendum 1, item 2, and proved by B1 as V4): `F(R) ≠ 0` iff the single pair `(0, 4)` is four-colour forced. K2 and K4 are best adjudicated in that form.
- **Policing K1.** At the field level, `F(R) ≠ 0` is equivalent to "every four-colouring of every `R`-coset is a `P₄` pullback", so every necessary condition X is implied by that statement. Rule out three kinds of X:
  - restatements of it on a window or a coset (the compactness forms);
  - properties `P₄` pullbacks visibly have: balance, gap-freedom, `𝔓⁴`-periodicity, frozen Kempe classes, zero entropy (T items 2, 8, 9);
  - any X whose check needs a finite colouring search.

  **Free control:** if X's proof uses no hypothesis that K fails, X must hold on K's plane, where `F(R_K) ≠ 0` (VK, now proved blind). An X that fails at K is refuted.
- **Policing K3.** Every periodic colouring already satisfies every linear identity of `P₄` pullbacks. So a genuine pinning-format no-go must concern identities that would force periodicity on non-periodic colourings. "This identity fails for some periodic colouring" is not K3. The vector-colouring frame (Godsil–Roberson–Rooney; plan §PA.3) is the natural source when you pin formats in advance.
- **The fallback** (plan §S.5, FS-83 at `k = 4`): its HD1 predicts that the fallback's hour-one question is decided by weak approximation plus one circular-chromatic question, and may be dead at the field level. If the killing test fires, tell me whether HD1 should go to the fallback's agent. That decision is mine.
- **T:** it had no objection to items 1–13. Item 5 was conditional on B1, and B1 has since confirmed it.

## The held items

- **The file:** the plan-phase advisor's held file is `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs86-poros-plan/HELD.md`, items **HD1–HD4**. HD5 was frame and is already in the plan. You may read this one file there, and its author's record `POROS-fs86-plan.md` beside it; nothing else in that directory.
- **When they go out:** they go to **both competitors at the same moment, after both first routes are written** (ruling R1 at FS-73). You decide which, when, and in what order, and you log each decision and its reason.
- **The one exception is yours to judge:** a part you find **frame-level** may go to both at once before the first routes (rule 6). Frame-level means it narrows the class, or corrects what the record says was covered, and hands no route.
- **Checked or not:** I have read the file's headings. I have not checked the items.
- **FS-85's held file** (`data/fs85/held/HELD-plan-advisor.md`) is public, so it is shared prior art, not held.

## Mechanics

- **Your record:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs86-poros-comp/POROS-fs86-competition.md`. You are its only writer.
  - Keep it current after each exchange: your expectation (written first, before your first card), each card, the retraction tally, your own errors against yourself, the killing-test adjudication, and a hand-off section a successor could start from.
  - **It stays in scratch, and nobody commits it,** until both competitors have handed back; then I move it into `plans/`.
- **The two working files, the only files you may read in the competitors' directories:**
  - `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs86-comp-debruijn/FS86-C-deBruijn.md`
  - `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs86-comp-coxeter/FS86-C-Coxeter.md`
- **Your scratch directory** is `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs86-poros-comp`. Don't list or read the other directories beside it (beyond the files named above), and don't open `~/source/lean-dir-owner/`.
- **Hand-backs are content-free** (the protocol, rule 1): the harness delivers a hand-back to whichever agent last woke you, which may be a competitor. End every turn with exactly "Poros idle; no content in this hand-back; my reports go to the owner by SendMessage", and send every report by SendMessage to its named recipient.
- **No subagents.** You may not spawn subagents, forks or workflows; delegation here is one level deep (`CLAUDE.md` § "Delegation — one level deep").
  - The reason: staffing is Kooshi's budget decision, and I can only review work I know about.
  - If the work outgrows your context, stop at a clean boundary, persist what you have, and tell me what is left.
- **The finite-witness-free week binds you too.** A small exact check (sympy, PARI, seconds) of a claimed step is fine; no search for a finite witness. Keep your own "would have searched here" lines in your record. Anything over about 2 GiB or 2 minutes runs as `scripts/slot.py --mem <GiB> --cpus <N> -- <cmd>`.
- **Don't run `git log`**, and don't read `plans/FS86-close-inventory.md`. Both are the owner's, and both can carry one side's progress.
- **Budget:** about 400k tokens. Past about 500k, I replace rather than reuse an agent, so write the hand-off section as you go.
- **The close inventory** is mine to write. Send me anything the close must not lose.
- **Agent ids.** I'll send you the two competitors' ids as soon as you're running, and send them yours.
- **When advising ends,** I'll ask for a final report:
  - the cards you sent, and what each side took and declined;
  - the retraction tally, and your own errors;
  - the killing-test verdict, with its reasons;
  - what a verification phase should check first;
  - your token count.

Thank you. I'm glad to have you on this one.
