exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import subprocess
HEAD=subprocess.run(["git","-C",ROOT,"rev-parse","--short","HEAD"],capture_output=True,text=True).stdout.strip()
P="Proofs/HadwigerNelson/Plane/"
def decl(path,prefix):
    full=path if path.startswith("/") else ROOT+path
    ls=[l.rstrip("\n") for l in open(full)]
    idx=[i for i,l in enumerate(ls) if l.startswith(prefix)]
    assert len(idx)==1,(path,prefix,len(idx))
    i=idx[0]; s=i; j=i-1
    while j>=0 and ls[j].startswith("@["): j-=1
    if j>=0 and ls[j].rstrip().endswith("-/"):
        while j>=0 and not ls[j].startswith("/--"): j-=1
        s=j
    e=i
    if prefix.startswith("theorem"):
        while not ls[e].rstrip().endswith(":= by") and not ls[e].rstrip().endswith(":="): e+=1
    else:
        while e+1<len(ls) and ls[e+1].strip()!="": e+=1
    return i+1,"\n".join(ls[s:e+1])
def block(path,prefix):
    n,t=decl(path,prefix)
    return "```lean\n"+t+"\n```\n*source: `"+path+"` l. "+str(n)+"*\n"
UA=P+"ValidMap/UnitArc.lean"; CO=P+"ValidMap/Contact.lean"; VB=P+"ValidMap/Basic.lean"; AM=P+"ArcMap.lean"; LM=P+"LocalMap.lean"; PB=P+"Basic.lean"
TE=WT+"fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean"
defs=[(AM,"def Valid "),(AM,"def coloursAt "),(AM,"def Covers "),(AM,"def IsPlaneMap "),(PB,"noncomputable def ringPt "),
      (LM,"noncomputable def ringArc "),(LM,"def coneAt "),(LM,"def OnRingArc "),(LM,"def IsRingArc "),(LM,"def IsChangePoint "),
      (VB,"def hornSet "),(VB,"def shadow "),(VB,"def IsClear "),(VB,"def HasSectors "),(VB,"def IsHorn "),(VB,"def IsFlankAbove "),
      (VB,"def IsFlankBelow "),(VB,"def MergeAvailable "),(VB,"def RayAvailable "),(VB,"def ShaveAvailable "),(VB,"def DoublyShadowed "),
      (VB,"def TerminalOn "),(VB,"def Terminal "),(VB,"def IsStuck "),(VB,"def Condition5 "),(VB,"def IsCoveringPair ")]
c=f'''# FS131-E7 — the claim list: a model or a contradiction for four hypothesis sets, and one question beside them

*Fixed by Keryx, 2026-10-06, before the job launches. Statements and definitions copied by script from `main` at `{HEAD}` (`n3_end_four_colours` from
branch `fs131-w5c`'s tree); no grade, no prior, no route. A later change is a dated line at the foot.*

## The statements

### a4six

{block(UA,"theorem a4six ")}
### straddlers_third

{block(UA,"theorem straddlers_third ")}
### nb4p

{block(UA,"theorem nb4p ")}
### flank_ne_of_doublyShadowed

{block(CO,"theorem flank_ne_of_doublyShadowed ")}
### n3_end_four_colours (one of the family Q5 is about; on `fs131-w5c`, not yet on `main`)

{block(TE,"theorem n3_end_four_colours ")}
## The definitions they use

'''+"\n".join(block(p,d) for p,d in defs)+'''
## The questions

**Q1 — `a4six`.** Is there a `k`, an `F : ArcMap k`, a point `v` and colours `a`, `b` satisfying `hF`, `hv`, `hab`, `habs` and `hno` at once? Answer with such an object exhibited exactly, each of the five checked on it; or with a derivation that the five are contradictory; or with the step where neither is reached.

**Q2 — `straddlers_third`.** Is there a `k`, an `F : ArcMap k`, a point `v`, an angle `θ` and colours `X`, `X'` satisfying `hF`, `hv`, `hcompl`, `hX`, `hX'` and `hna` at once? Answer in the same three forms.

**Q3 — `nb4p`.** The theorem concludes `False` from `hF`, `hv`, `h4`, `hy`, `hring` and `hnb`. Is there a `G : ArcMap 6` with `v`, `ψ`, `X`, `X'` satisfying the first four at once; one satisfying the first four with `hring`; and one satisfying the first four with `hnb`? Answer each in the same three forms.

**Q4 — `flank_ne_of_doublyShadowed`.** Is there a `k`, an `F : ArcMap k`, a point `v`, reals `α`, `κ₁`, `κ₂` and colours `g`, `h` satisfying `hF`, `h5`, `hv`, `h1`, `h12`, `h2`, `hg`, `hh` and `hD` at once? Answer in the same three forms.

**Q5 — a stuck vertex in a terminal map of the plane.** Is there a `k ≥ 7`, an `F : ArcMap k` and a point `v` with `F.Valid`, `F.IsPlaneMap`, `F.Terminal` and `F.IsStuck v`? Answer with such a map exhibited exactly, with a derivation that none exists, or with the step where neither is reached.

*Not claimed*: anything at six colours on a map of the plane (an object there is a valid six-map of the plane, the open problem); the truth of the five theorems (each is kernel-checked, or, for `n3_end_four_colours`, proved on its branch); any other theorem of FS131-QA4's lists.
'''
open(ROOT+"data/fs131/claims-E7.md","w").write(c)
CL="data/fs131/claims-E7.md"; QA="plans/FS131-QA4-audit.md"
H62="6.2 The list of what is owed, ranked by what rests on the theorem"
H41="4.1 `main` (`d4403f09`): 145 heads"; H43="4.3 Wave 5c (`87e95385`): 44 heads"
b=f'''# Brief FS131-E7 — four theorems with no known example of their hypotheses, and a stuck vertex in a terminal map: a model or a contradiction for each

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-E7
  identity: Ephodos — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; its § A derivation job is this job
  role: derive five fixed questions, each to one of three verdicts — an object exhibited exactly that satisfies the hypotheses at once, a derivation that they are contradictory, or "not derived; stalls at" a named step — and say what each verdict does to the theorem and to the theorems that read it
  launch: when a slot frees, beside de Bruijn implementers on wave 5's branches; you write on `main`, to paths no other job writes
  mission: § Why this job
  statements: § The questions
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a contradiction among a theorem's hypotheses (at once: its readers must be traced), a model an implementer can use, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-E7.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` § Make the gate fail, and watch it fail, before you build any check
  record: `plans/FS131-E7-derivation.md`
  touches: `plans/FS131-E7-derivation.md`, `data/fs131/e7/` (your scripts and any scratch Lean live here too, not in `tools/`: a landing of wave 5 is coming, and commits to `main` outside `plans/` and `data/` would make it re-run its gate — inventory ruling 415 (b)), `data/fs131/reports/FS131-E7.md`
  budget: about 300k by the harness's count, as guidance; hand back at a saved stage before about 450k — read your token count at every saved stage

Hello. The Lean backlog (FS-131) turns this project's hand-derived results into kernel-checked ones. Its gate asks one thing the kernel cannot: that every
theorem's hypotheses hold together on some real object, because a theorem whose hypotheses are contradictory is true and says nothing. An audit, FS131-QA4,
read 318 theorems against that rule. It broke none. For all but a handful it found a Lean object or wrote a hand model. For four theorems it found neither
a model nor a contradiction, and it left one question about a whole family. Those five are yours.

## Why this job

The rule is in `LEAN.md` § The gate — read its whole bullet, which begins and turns at these two lines:

{Q("LEAN.md","- **Every theorem whose hypothesis is a structure** (a colouring,","§ The gate")}
{Q("LEAN.md","  real instance and the gate stays green. **The inhabitant satisfies every hypothesis","§ The gate")}
All four of your theorems are on `main`, kernel-checked, and are rungs of this project's main line: `a4six` and `nb4p`, with its child
`straddlers_third`, are FS112-A4SIX and FS112-NB4P, the count behind "every tight six-map with unit arcs has a vertex of at least four colours"
(`LEDGER.md` row 135), and `flank_ne_of_doublyShadowed` is read by the stuck vertex's structure theorem under Condition 5 (FS110-N4-STUCK, row 134;
`Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` l. 2395). If the hypotheses of one of them
cannot hold together, the theorem is empty where the derivation thought it spoke, and everything that reads it must be re-read; if they can, the model is
what the next job builds in Lean. Both outcomes are results — Kooshi: *"A proven theorem about why its impossible is also valid. All novel knowledge is
a success."* (`plans/STANDING-RULES.md` rule 4). The audit's rows that pose them, and the rulings that launch you:

{Q(QA,"| 9 | Neither a model nor a contradiction found:",H62)}
{Q(QA,"| 10 | The OPEN class:",H62)}
{Q(QA,"| A4SIX, NB4P (`a4six`, `straddlers_third`, `nb4p` [R]; `UnitArc`; 3)",H41)}
{Q(QA,"| horns and flanks under Condition 5 (",H41)}
{Q(QA,"| N3-END, Y3-END-NEEDS, CV-HD, C-DOUBLE, CV-CLASS, C-ENDS, the runs (",H43)}
{item(426)}
{item(427)}
What is known going in, each a fact with its address and none of it a route:
- `sixFrag` (`Proofs/HadwigerNelson/Plane/SixFragment.lean`) is the candidate an earlier audit named for Q1–Q3 and nobody checked. It is a valid
  six-coloured fragment (`sixFrag_valid`) covering `B̄(0, R)` for `R < 3/2` (`sixFrag_covers`); all six colours meet at `0`
  (`sixFrag_coloursAt_zero`), and its whole unit circle about `0` is boundary (`sixFrag_sphere_subset_Γ`). My inference, not a checked fact: a model
  inside it would sit at a point other than `0`.
- For Q4 the audit's hand model of a horn with both flanks under Condition 5 on a plane map is FS131-E6's twelve-colour map
  (`plans/FS131-E6-derivation.md` §§ 3.1–3.3); the audit says `DoublyShadowed` fails there.
- For Q5 the audit's candidate is "the completed bowtie" (`plans/FS131-QA4-audit.md` § 3.5): the Lean fragment `bowtie`
  (`Proofs/HadwigerNelson/Plane/ValidMap/BaseSteps.lean`) is valid and stuck at `0` and does not cover the unit disc; completed by fresh-coloured cells
  it is argued valid and stuck at `0`, and whether the completion can be made terminal everywhere is unchecked. Q5 is beside FS-115's question (c)
  (`plans/STUB-stuck-ray.md`), which asks the same at six colours.

## The questions

The claim list is `data/fs131/claims-E7.md`: the five statements and every definition they use, copied by script, then the questions. Read it whole.

{Q(CL,"**Q1 — `a4six`.**","§ The questions")}
{Q(CL,"**Q2 — `straddlers_third`.**","§ The questions")}
{Q(CL,"**Q3 — `nb4p`.**","§ The questions")}
{Q(CL,"**Q4 — `flank_ne_of_doublyShadowed`.**","§ The questions")}
{Q(CL,"**Q5 — a stuck vertex in a terminal map of the plane.**","§ The questions")}
{Q(CL,"*Not claimed*:","§ The questions")}
The theorems' first lines, at their sources (the claim list has each whole, with its docstring):

{Q(UA,"theorem a4six ")}
{Q(UA,"theorem straddlers_third ")}
{Q(UA,"theorem nb4p ")}
{Q(CO,"theorem flank_ne_of_doublyShadowed ")}
## Done means

1. **Your readback first**: check the quotations above against their sources and the claim list's statements against the Lean files; restate the five
   questions in your record; read the audit's §§ 3–4 and 6 (`plans/FS131-QA4-audit.md`), the derivations the theorems formalize at the addresses their
   docstrings give (`plans/FS112-N-proof.md` § 2.1 for NB4P and its straddlers; `plans/FS112-derivation.md` for A4SIX; `plans/FS110-N-proof.md` § 2.2
   for N4-SHAVE and N4-STUCK), and `plans/STUB-stuck-ray.md` for Q5. Register a prediction per question before its written derivation. Commit and push.
2. **A verdict per question**, in your lane's derivation form (statement, uses only, not claimed, argument, verdict, grade, minds, model, prior art,
   handoff), saving after each. A model is exhibited exactly — its domain, its arcs, its colouring by formula — with every hypothesis checked on it
   clause by clause, and a word on which clauses it exercises (an object on which a hypothesis holds because a set is empty is a weaker model; say so).
   Checks are by hand, exact arithmetic or computer algebra, each with a control that goes red on a planted fault; no search (a step a search could
   decide is a `search request` in your report). You may elaborate a scratch Lean file against the idle tree
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop` (`main`'s line; `lake env lean` under `/home/kooshi/source/lean-dir/scripts/slot.py --mem 12
   --cpus 4 --`, as the audit did — its files are `data/fs131/qa4/QA4Bowtie.lean` and `data/fs131/qa4/QA4Collar.lean`); it is a check, graded as one, and you change
   nothing in that tree and never build.
3. **For a contradiction**: message me at once with the theorem and the two hypotheses that collide. Then trace it — which theorems read the empty
   one (`rg` its name under `Proofs/` on `main` and in the worktrees `fs131-w5`, `fs131-w5c`), what the hand derivation it formalizes meant to say
   there, and the smallest repair to the statement, drafted with its exact Lean-level change for the planner.
4. **For a model**: the handoff an implementer needs to build it in Lean — the object by formula, the library pieces it can reuse
   (`ArcMap.recolour`, `sevenBrickMap`, `sixFrag`, `l60Frag`, `bowtie`), and a line for the theorem's docstring naming it.
5. **Q5 last**, with what budget is left: it is the largest and the one with a bearing outside this milestone. Its verdict, or its stall at a named
   step, is drafted as one bearing line for `plans/STUB-stuck-ray.md` (I file it), and says what it does to the docstrings of the stuck family on
   `fs131-w5c` (`n3_end*` and their neighbours: a model, "a refutation step: no model expected" with the theorem, or "open").
6. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed; your derive gate
   (`.claude/skills/ephodos/scripts/derive_gate.py all plans/FS131-E7-derivation.md`, from `plans/`) green; the report in standing rule 11's form.
   Stopping at a saved stage with some questions answered and the rest open at named steps is a good report.

## What is yours to decide

The order of Q1–Q4, the route to each, and the form of every model. Attack the questions themselves: if a hypothesis is satisfiable only in a
degenerate way the theorem's source never meant, or a theorem's hypotheses are consistent only at a number of colours the statement's readers never
use, that is a finding; say so with the address. If Q3's three sub-questions show one of `hring`, `hnb` is idle (the first four with the other already
contradictory), say that too. You are closer to these statements than I am; where my framing above is wrong, correct it in your record.

## The machine

No Lean build is needed for this job. A check that needs more than a few gigabytes runs under the slot
(`/home/kooshi/source/lean-dir/scripts/slot.py --mem 8 --cpus 4 -- <command>`, `RUNNING.md` § Building). `/tmp` on this machine is a tmpfs, wiped at
power-off: keep anything your record cites under `data/fs131/e7/`. {NOSPAWN}
'''
open(ROOT+"data/fs131/briefs/FS131-E7-models.md","w").write(b)
