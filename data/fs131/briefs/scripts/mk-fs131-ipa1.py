exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IPA1: the port's first implementer — lanes A (the spectral base) and B (the factor base) of FS131-KO1's plan.
# Usage: mk-fs131-ipa1.py <item of KO1's trial ruling> <item of KO1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KT,KH=int(sys.argv[1]),int(sys.argv[2])
TREE="fs132-wi1"; BR="fs131-wpa"; JOB="FS131-IPA1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")=="fs131-wp1"
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
RQ="data/fs131/REQUEST-2026-10-13.md"
PL=W+"plans/FS131-KO1-port-plan.md"; GEN=W+"tools/fs131_ko1_port.py"; FARM=W+"data/fs131/ko1/farm1.sh"
TB=W+"data/fs131/ko1/port/"; RB=W+"tools/fs132_i2_readback.py"; IA=WT+"fs133-wk1/plans/FS133-IA1-implementation.md"
for p in (PL,GEN,FARM,TB+"OAI158Basic.json",TB+"OAI158Centers.json",RB,IA,W+".lake/build"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the port of the outside release's transfer proof, first two lanes: the spectral base and the factor base

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-14. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the port's first implementer — lanes A and B of its planner's four, one after the other on one branch: fifteen files of the outside release made into modules of this library by the planner's generator, each elaborated at this pin with every proof checked by this kernel, no axiom and no `sorry`
  launch: now, in the port planner's tree (its job is finished; nobody else writes there) on a new branch; the chain's planner works in `fs131-wq1` and the chain's implementer in `fs131-wch`, each building now and then
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a site of the adaptation class would need a new hypothesis or binder (stop that module), if a Mathlib definition other than `Measure.map` changed between the pins reaches a release definition or statement, if the generator needs any change (it is frozen: a defect in it is a tool defect for me), and with one line when lane A's ten modules elaborate; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wp1` at `{TIP}`): the fifteen generated modules of lanes A and B, `Proofs/HadwigerNelson/Outside/OAI158<Stem>.lean`, written only by the generator; their tables `data/fs131/ko1/port/<Module>.json` (the two trial tables of lane A and the one of lane B included); your checks under `tools/` named for this job (the strip check of the plan's § 4.3, as `tools/fs131_ipa1_strip.py`, if you write the first adaptation); the scratch farm under the tree's ignored `build/`; `plans/{JOB}-implementation.md`; `data/fs131/ipa1/`; `data/fs131/reports/{JOB}.md`. **Not** the generator `tools/fs131_ko1_port.py`, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `Proofs/HadwigerNelson/Outside/OAI158.lean` or any other module of the library (registration and the switch are lane D's); nothing on `main`; nothing in the outside release's clone, which is read only and in which nothing is run
  budget: {BUDGET}

Hello. This library declares one theorem of the outside release as an axiom: the transfer from an arbitrary proper
colouring of the plane to a measurable one proper at almost every unit pair, on which twelve of its records rest.
Kooshi has approved porting the release's proof of it, so that the axiom becomes a theorem under its present name.
Its planner measured the proof's cone, ran a trial on three files, and cut the work into four lanes. You take the
first two.

## Why this job

Kooshi's word:

{Q(RQ,"W4: ")}
The port removes one of the library's three declared outside theorems, and with it a second one the density equality
declares, whose cone lies inside this one's. Every ported proof is checked by this kernel at this pin; the release's
statements are kept, so that each ported theorem is the release's theorem.

## The statements

The planner's trial and my ruling on it, then its hand-back and my rulings (their words in quotation marks):

{item(KT)}
{item(KH)}
**Your modules.** The plan `{PL}` § 4.2's lanes **A** — `Basic` and `InvariantMean` (the trial's, tables written, 0
errors), `SmallArcs`, `PhaseEncoding`, `Characters`, `PhaseCollision`, `Multipliers`, `ConditionalSelection`,
`FourierTests`, `ConditionalSpectrum` — and **B** — `Centers` (the trial's: five renames in its table, its adaptations
to write), `Amenability`, `NumberFields`, `Selections`, `RelativeCenters`. Lane A first; lane B regenerates `Basic`
from its table, so it follows on the same branch. Their statements are the release's; the generator keeps them. Read
the plan's § 3.1–3.6 (the generator, whole files, the trial, the exposure), § 4.1 (how a module is made; the farm),
§ 4.2 (the five receipts each lane gives, for its own modules), § 4.3 (the adaptation class and its conditions) and
§ 4.7 (open risks). The generator is `{GEN}`; the tables are in `{TB}`; the farm script is `{FARM}`; the read-back
across pins is `{RB}`, imported as a module the way FS133-IA1 did (`{IA}`, its stage 2).

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; your branch cut; the generator's
   `--parse-all` and, with the trial's three modules generated into place, its `--self-test` and `--check` run and
   their last lines recorded (the self-test reads the modules where `--check` does, so it passes only once they are
   generated: item 759).
2. **Lane A** (saved stages every few modules): each of its ten modules generated from its table and elaborated by
   the farm, with the five receipts of § 4.2 for each.
3. **Lane B** (saved stages every few modules): the same for its five, `Centers`' adaptations written under § 4.3's
   conditions, with the strip check and its planted control if you write the first adaptation.
4. **Every table entry with its reason**, and a statement in your record that no entry touches a protected
   declaration (the target statements, a declaration the density branch shares, anything a statement of ours names).
5. **Re-pricing** for lanes C and D from what lanes A and B cost, and the plan's risk 2 (another Mathlib definition
   that changed between the pins) reported for every module you elaborated, with the pricing dump finished if you
   choose to.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The tables' entries within the plan's rules — patches to proofs, renames, the adaptation sites, the scoped and global
instances, the dropped imports; the order inside a lane; whether to finish the pricing dump; how far into lane B you
reach before your hand-back line. Not yours: the generator; any patch to a statement or a definition other than an
adaptation under § 4.3's conditions; any adaptation needing a new hypothesis; registration, the switch, the join; the
landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is `main`'s at `747e139d0`, which the farm reads. One module through the farm:
about 10 seconds and 3.5 GiB, under the memory tool (the farm script calls it).

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ipa1 -- <command>`

On exit 75 wait ten minutes and retry; two other jobs build now and then. Stop a process by its PID or process group,
never by matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under
`data/fs131/ipa1/`. Scratch copies of the release's text stay under the tree's ignored `build/` folder; the release's
text enters a commit only inside a generated module that carries its licence notice. Report at once any disk, memory
or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-port-lanes-ab.md","w").write(b); print("ok",len(b))
