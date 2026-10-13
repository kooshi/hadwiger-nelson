exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-EN2: a deriver on two questions the five-colour chain's planner left for the derive lane.
import subprocess,os
now=subprocess.run(["date","-u","+%Y-%m-%d %H:%M UTC"],capture_output=True,text=True).stdout.strip()
JOB="FS131-EN2"; C="data/fs131/claims-EN2.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
assert not os.path.exists(ROOT+"data/fs131/briefs/"+JOB+"-two-questions.md")
ST="\n".join(Q(C,f"EN2-{n}: ","§ Statements") for n in ("MEAN","DECOMP"))
NC=Q(C,"EN2-NC: ","§ Not claimed")
STOP=Q("plans/FS131-EN1-derivation.md","**Whether a rearranged proof could live on convergence in mean","§ 7.2 Does EF_F⁺'s Lemma 3.1′ need Shannon–McMillan–Breiman, or only the definition of entropy? (the planner's leaf 18)")
KN3=WT+"fs131-wch/plans/FS131-KN3-chain-plan.md"
PDF="/home/kooshi/source/library/pdf/EinsiedlerFish2010-rigidity-measures-multiplicative-semigroup-polynomial-growth.pdf"
for p in (KN3,PDF): assert os.path.exists(p),p
b=f'''# Brief {JOB} — two questions that decide how much classical ergodic theory the five-colour chain must carry into the kernel

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: Ephodos, the deriver — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; this is a derivation job on a fixed claim list
  role: the deriver on two questions put to the derive lane by the kernel planner of the five-colour chain — each asks whether a hand proof of ours can be rearranged so that it reads less of the classical theory; you answer each with a written argument, or with the exact step that cannot be rearranged and why
  launch: now, on `main`; a landing is in flight on a branch and two planners work on branches of their own — you write no file any of them writes
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you; you may read every branch
  channel: message the coordinator ("main") by SendMessage **with each question's verdict as it is reached**; at once for a question that is ill-posed as worded (say the form that is well-posed), or if answering needs a fact about the outside library you cannot settle by reading; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS131-EN2-derivation.md` (new)
  touches: `plans/FS131-EN2-derivation.md`, `data/fs131/en2/`, `data/fs131/reports/{JOB}.md`; on `main`, committed by explicit path. Nothing else: an erratum to an older derivation file is drafted in your record, not written there
  budget: about 250k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit) after the readback and after each question's verdict; hand back before you would guess 400k

Hello. Two questions, each small on the page and large in what hangs on it.

## Why this job

The project is being wound down and published, and Kooshi's rule for what goes out is this:

{Q(RQ,"W2: ")}
The first-ranked finding is that the plane over the field of the square root of 47 needs exactly five colours, with
the general statement it is a case of. Under it sit two deductions of ours from one printed theorem: one for measures
of positive entropy (the record's PE-2) and one for measures of zero entropy (EF_F⁺, this project's transfer of
Einsiedler and Fish's method). A kernel planner laid out the whole chain as Lean modules today and found that two of
its modules cannot be planned until the derive lane says what they must read. One reads, as written, the
Shannon–McMillan–Breiman theorem, which is in neither Mathlib nor the outside library we build on; the other cites
the uniqueness of the ergodic decomposition, where the outside library proves only existence. Each classical theorem
that the chain really needs will be formalized — nobody is asking you to make one unnecessary. What the planner needs
is the truth about which is needed, in a form it can type.

No answer is the wanted one. "It cannot be rearranged, and this is the step" is as useful to the planner as a
rearranged proof, and is a result.

## The statements

Fixed in `data/fs131/claims-EN2.md` before your launch, in the asker's words:

{ST}
{NC}
Where the first was left by the deriver who read it this morning:

{STOP}
(the two sentences after that one in the same section give one fact "for whoever takes it" — read them there.)

Where everything is. The zero-entropy deduction: `plans/FS100-X01D-derivation.md` (Lemma 3.1′ at its § 3.3, the
pigeonhole at § 3.4, the comparison of scales through § 3.6) and its second derivation `plans/FS100-X12B-derivation.md`.
The positive-entropy deduction: `plans/FS100-X02D-derivation.md` § 3.2 and its second route § 3.3. The entries as
filed: `plans/FS100-derivation.md`. This morning's reading: `plans/FS131-EN1-derivation.md` § 7 and its table § 8.1.
The asker's record: `{KN3}` — its § 4.1 and § 4.2 say what the outside library holds of
entropy and of the ergodic decomposition, by declaration name, and its § Stage 6 holds the two questions in their
place. The outside library itself, read only: `~/source/math/lean/OAI/NumberTheory/DukePrimeDegree/Entropy/` — you
write nothing there and run nothing there. The paper whose method the zero-entropy deduction transfers:
`{PDF}` (its Theorem 2.1 is the form of the entropy theorem the deduction cites).

## Done means

1. **Readback** (a saved stage): the five quoted lines checked against their sources; each question restated with
   every name resolved to a line of a derivation file; for each, the list of places the classical theorem is read,
   and what is taken from it at each place (an existence, an identification of a limit, a property of the pieces).
2. **For each question, a verdict with its argument** (a saved stage each), one of:
   - *derived* — the rearranged argument written in full, each step naming what it reads, so that a planner can
     type its statements; and the statement of what the chain then reads instead (in words a planner can type);
   - *not derived; stalls at* — the exact step, what it needs that the weaker input does not give, and what you
     tried against it;
   - *a narrower or different statement serves* — its statement, its argument, and why it is enough for the place
     the chain uses it. For the first question this includes any shorter proof of the one thing the deduction takes
     from the theorem (a set of points whose atoms are not too small at every large scale, for a measure of zero
     entropy), if there is one that does not pass through the general theorem.
   Attack your own argument before you grade it: for the first, a measure and a partition on which convergence in
   mean holds and the conclusion you need fails, if one exists; for the second, a place where two decompositions
   that agree almost everywhere are treated as equal.
3. **For the kernel lane**, per question: the classical statements the module must then have, each as a sentence
   with its hypotheses, and whether the outside library's declarations named in the asker's § 4.2 already are those
   statements (read their stored statements, not their names).
4. The report in the standing rules' form, each entry at its grade with its mind count in words and what is not
   claimed.

## What is yours to decide

The route to each answer; whether a question splits into parts with different answers; how much of the surrounding
derivation must be re-read to answer honestly. Exact arithmetic or a small computation is yours to use where it
checks a step; no search.

Not yours: the Lean statements (the planner types them from your sentences); the printed theorem the chain declares;
whether a classical theorem, once needed, is formalized or imported.

{NOSPAWN}
'''
open(ROOT+"data/fs131/briefs/"+JOB+"-two-questions.md","w").write(b); print("ok",len(b))
