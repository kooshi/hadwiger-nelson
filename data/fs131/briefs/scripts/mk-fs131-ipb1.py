exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-IPB1: the port's second implementer — the rest of lane B (the factor base) and lane C (the compact factors) of FS131-KO1's plan.
# Usage: mk-fs131-ipb1.py <item of KO1's hand-back> <IPA1's ruling items, comma-separated> <item of IPA1's hand-back>
import os,subprocess,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
KH=int(sys.argv[1]); RU=[int(x) for x in sys.argv[2].split(',')]; KA=int(sys.argv[3])
TREE="fs132-wi1"; BR="fs131-wpb"; JOB="FS131-IPB1"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",ROOT,"branch","--list",BR)==""
assert sh("git","-C",W,"status","--porcelain")=="" and sh("git","-C",W,"branch","--show-current")=="fs131-wpa"
TIP=sh("git","-C",W,"rev-parse","--short=9","HEAD")
RQ="data/fs131/REQUEST-2026-10-13.md"
PL=W+"plans/FS131-KO1-port-plan.md"; GEN=W+"tools/fs131_ko1_port.py"; FARM=W+"data/fs131/ko1/farm1.sh"
TB=W+"data/fs131/ko1/port/"; RB=W+"tools/fs132_i2_readback.py"; IA=W+"plans/FS131-IPA1-implementation.md"; CMP=W+"tools/fs131_ipa1_readback_port.py"
for p in (PL,GEN,FARM,TB+"OAI158Basic.json",TB+"OAI158Centers.json",RB,IA,CMP,W+".lake/build",W+"data/fs131/ipa1/pending"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the port of the outside release's transfer proof, continued: the rest of the factor base, then the compact factors

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-14. Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {IDENT}
  role: the port's second implementer — the last module and the two read-backs of lane B that the first implementer left at its hand-back line, then lane C of the planner's four, on one branch: release files made into modules of this library by the planner's generator, each elaborated at this pin with every proof checked by this kernel, no axiom and no `sorry`
  launch: now, in the port's tree (the first implementer has handed back; nobody else writes there) on a new branch cut from its branch; the chain's Pontryagin-duality planner works in `fs131-wq1` and an implementer of the density equality in `fs133-wk1`, each building now and then
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a site needs a new hypothesis or binder outside the ruled classes below (stop that module), if a statement names `eLpNorm` of a function not known to be AE strongly measurable, if the ruled cascade would reach a protected declaration, if the generator needs any change beyond the one plant allowed below, and with one line when lane B is complete; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: {STAND}
  record: `plans/{JOB}-implementation.md` (new, on branch `{BR}`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` on a **new branch `{BR}`** that you cut from its head (`fs131-wpa` at `{TIP}`): the generated modules of lane B's last module and of lane C, `Proofs/HadwigerNelson/Outside/OAI158<Stem>.lean`, written only by the generator, with lane B's four already generated regenerated only from their tables; their tables `data/fs131/ko1/port/<Module>.json`; the first implementer's comparator `tools/fs131_ipa1_readback_port.py` (its rules and name map, each new rule with its planted control); one new self-test plant in `tools/fs131_ko1_port.py` (below) and nothing else there; your checks under `tools/` named for this job; the scratch farm under the tree's ignored `build/`; `plans/{JOB}-implementation.md`; `data/fs131/ipb1/`; `data/fs131/reports/{JOB}.md`. **Not** `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `Proofs/HadwigerNelson/Outside/OAI158.lean` or any other module of the library (registration and the switch are lane D's); nothing on `main`; nothing in the outside release's clone, which is read only and in which nothing is run
  budget: {BUDGET}

Hello. This library declares the outside release's transfer theorem as an axiom, and Kooshi has approved porting its
proof so that the axiom becomes a theorem under its name. Its planner cut the port into four lanes. The first
implementer finished lane A (ten modules, every proof kernel-checked here, the read-back clean) and four of lane B's
five, and met at this pin the places where Mathlib changed under the release's text; each is ruled below. You finish
lane B and take lane C.

## Why this job

Kooshi's word:

{Q(RQ,"W4: ")}
The port removes one of the library's three declared outside theorems, and a second the density equality declares.
Every ported proof is checked by this kernel at this pin; the release's statements are kept, except where a ruling
below says exactly how and why, so that each ported theorem is the release's theorem.

## The statements

The planner's hand-back, the rulings on the first implementer's findings, and its hand-back with my rulings (their
words in quotation marks; the rulings are mine and are your rules):

{item(KH)}
{chr(10).join(item(n) for n in RU)}
{item(KA)}
**Your modules.** Lane B's last, `RelativeCenters` (generated with 13 errors, its text kept at
`{W}data/fs131/ipa1/pending/`), and the two read-backs lane B owes: `NumberFields`' eight DIFFERENT, and `Centers`
with the ruled cascade's list measured and the strip check run. Then lane C of the plan `{PL}` § 4.2: `Approximation`,
`ConditionalLimits`, `Kernels`, `BoundedFunctions`, `Functions`, `Factors`, `RelativeProducts`, `Separability`,
`Stationary`, `AlgebraModels`. Their statements are the release's; the generator keeps them. Read the plan's § 3.1–3.6,
§ 4.1–4.3 and § 4.7, and the first implementer's record `{IA}` in full (its stages 2–3: the five receipts, the
comparator `{CMP}`, the ruled classes as built). The generator is `{GEN}`; the tables are in `{TB}`; the farm script
is `{FARM}`; the read-back across pins is `{RB}`.

## Done means

1. **Readback** (a saved stage): the quoted lines checked against their sources; your branch cut; the generator's
   `--parse-all`, `--self-test` and `--check` on every module generated so far, their last lines recorded.
2. **Lane B complete** (a saved stage, and the one line to me): `NumberFields`' eight DIFFERENT read and classed;
   `Centers` read back, the cascade's full list measured and recorded (lane D's brief will quote it), the ADAPTED strip
   check run; `RelativeCenters`' entries written and the module elaborated with 0 errors and 0 warnings; the five
   receipts of the plan's § 4.2 for every lane B module.
3. **Lane C** (saved stages every few modules): each module generated from its table and elaborated by the farm, with
   the five receipts; the cascade continued under its ruling wherever a lane C declaration names `frequencyLaw` or
   `center`.
4. **Every table entry with its reason**, and a statement in your record that no entry touches a protected
   declaration.
5. **Re-pricing** for lane D from what lanes B and C cost; every Mathlib definition found changed between the pins,
   with where it reaches.
6. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

The tables' entries within the plan's rules and the rulings quoted above; comparator rules for differences confined
to one class parameter of one Mathlib class (each with its planted control, on the standing word of item {KA}'s
ruling 2); **one new self-test plant** in the generator for the `drop_omit` refusal of a line that is no `omit`, under
item 766's conditions (a test, no logic: `--check` byte-identical before and after, its own commit); the order inside
lane C; how far into lane C you reach before your hand-back line. Not yours: any other change to the generator; any
patch to a statement or definition outside an adaptation, a ruled change or a cascade entry as ruled; registration,
the switch, the join; the landing.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 330 GB of disk free — do not copy compiled libraries between
trees.** This tree's compiled library is `main`'s at `747e139d0`, which the farm reads. One module through the farm:
about 10 seconds and 3.5 GiB, under the memory tool (the farm script calls it).

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ipb1 -- <command>`

On exit 75 wait ten minutes and retry; two other jobs build now and then. Stop a process by its PID or process group,
never by matching its command line. `/tmp` is wiped at power-off: anything your record cites lives under
`data/fs131/ipb1/`. Scratch copies of the release's text stay under the tree's ignored `build/` folder; the release's
text enters a commit only inside a generated module that carries its licence notice. Report at once any disk, memory
or count reading near its limit.

The remote is unreachable: **commit by explicit path on your
branch and do not push**; I copy the branches to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}-port-lanes-bc.md","w").write(b); print("ok",len(b))
