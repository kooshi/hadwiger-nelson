exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import sys,subprocess
N=sys.argv[1]  # 7 (wave 7's second planner, the four-colour rows) or 8 (wave 8's second planner, the semi-hub rows)
KP="plans/FS131-kernel-plan.md"
PIDENT="de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow"
TREE="fs131-w"+N; JOB=f"FS131-K{N}b"; W=WT+TREE+"/"
TIP=subprocess.run(["git","-C",W,"rev-parse","--short","HEAD"],capture_output=True,text=True).stdout.strip()
REC=W+f"plans/FS131-w{N}-kernel-plan.md"
P="Proofs/HadwigerNelson/Plane/"
if N=="7":
    TITLE="the thirteen four-colour rows — the tactic edge, the bowtie and the lune, the pinwheel — stated over a foundation you write"
    ROLE="wave 7's second planner — read the arguments the first pass did not, write the four-colour foundation (the tactic edge, the degree-4 vertex of four colours, the lens, the Reuleaux bowtie, the pinwheel), then state the thirteen four-colour rows and the two clauses left of route T as new modules, `sorry` at each leaf, each statement read back against its row, a plan and a price per leaf, the inhabitants and vacuity lines, and a handoff implementers can split by file"
    FIXED=f"the wave's four existing modules (`{P}SimpleOn.lean` is shared with waves 8 and 9 by ancestry and is not edited by anyone; `{P}RouteT/Basic.lean`, `{P}RouteT/Rainbow.lean`, `{P}RouteT/Count.lean` are fixed: an implementer is proving the last two on a branch cut from this one — a statement you need there is a message, a lemma you need beside them goes in a module of your own)"
    NEW=f"new modules only under `{P}FourColour/` (the first pass proposed `Local`, `Bowtie`, `BowtieFragment`, `Pinwheel`; the layout is yours)"
    INTRO='''You are finishing the plan of wave 7 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 7 is twenty rows about a vertex where four colours meet in a tight six-colour map. Its
first planner stated the seven rows of route T's count on a combinatorial map, proved three of them in part or whole, fixed what "simple"
means on a fragment (`ArcMap.SimpleOn`), and disposed the other thirteen from their entries only — it read none of their arguments, and says
so. Those thirteen, and two clauses of route T that need their vocabulary, are yours.'''
    WHY='''A result counts as held only when its Lean module passes the gate. The thirteen rows are the local half of the unit-arc question — what
a four-colour vertex of degree 4 forces within an explicit radius: the bowtie's stop, the pinwheel's exclusion with its two exceptions
(`LEDGER.md` rows 137–138; `CLAUDE.md` § Where the problem stands, item 31). The first
planner flagged four of their filed statements as likely to hide a hypothesis, from the entries' own words: you are the first mind in this
milestone to read their arguments.'''
    ITEMS=[512,513,514,508]
    RQ=["### 4.1 The dispositions","| FS114-N3-LOCAL |","| FS114-N4-LEMMAS |","| FS114-N5-GRING |","| FS114-Y2-BOWTIE |","| FS114-Y3-RSTOP |","| FS114-Y4-LUNE |","| FS114-Y4-RSTOPALL |","| FS114-Y6-HALF |","| FS114-N6-NOQ |","| FS114-N7-QOPP |","| FS114-Y5-PINALL |","| FS129-SR3-E2ONE |","| FS114-Y6-E2RED |","| FS114-N2-ENDS |","| FS114-N3-JOINT |","Merged (the CSV's):",
        "### 4.2 The four-colour foundation the second pass writes","- **a tactic edge** at `p`","- **a degree-4 vertex of four colours**","- **a lens** (N3-SEC)","- **the pinwheel**:","### 4.3 Held for Keryx's ruling","**The second planning pass, FS131-K7b**"]
    NLEAF="20 `sorry` leaves in two files, none yours"
    FIRST='''2. **The four flagged places first**, each from its argument: FS114-N3-LOCAL's N3-FACE without "far"; N3-ODD's parity against
   FS116-N1-TWIST-LIT; FS114-N4-LEMMAS' N4-LENS without the non-Siamese hypothesis its own *not claimed* line requires; FS114-N7-QOPP's
   unstated class. Each is confirmed or cleared, with the line of the argument that decides it. A confirmed one is a message to me at once
   (ruling 512 (iii)) — and say which kind you have: a *statement* that needs a hypothesis its entry lacks, or a *route* that reads more than
   the statement needs (a shorter-route note, no defect). One mid-job report this session was the second kind and was retracted by its
   reporter within the hour; check which before you send.'''
    FOUND=f'''4. **The foundation**: § 4.2's vocabulary as definitions with a spec example each, written with `debruijn-domain-modeling` and
   `debruijn-experience-modeling` (each invoked fresh) over what `main` already holds (waves 3–5: ring arcs, `BothKind`, the bends; wave 4's
   `bowtie` is another object — name yours apart). **Waves 8 and 9 read the tactic edge and the bowtie**: when the foundation module builds
   with no `sorry`, commit it alone and send me the hash, so a sibling branch takes it by ancestry and nobody re-declares a name (inventory
   items 511, 523). Wave 8's own foundation (`Plane/RingCalculus/Basic`: `TileAt`, `IsTip`, `GermOnQWith`, `QFreeRing`, and more) is whole at
   `26b08395` on `origin/fs131-w8`; if a row of yours wants one of its names, tell me before you re-state anything — the answer is a merge of
   that one commit, which I will ask of you then.
5. **The rows, stated**: the thirteen, FS114-N2-ENDS's second sentence and N3-PAY, each with `sorry` at its leaves and read back against its
   row. Ruling 514 (a) fixed the first pass's six held dispositions at their defaults, from entries only: a default that fails on your reading
   of the argument is a message, not a redo. **FS114-N7-QOPP has a reader in flight**: wave 8 takes it as a hypothesis under a name of its
   own (its planner proposed `QArcsJoinOpposite F p`, from the entry's first sentence, `plans/FS114-derivation.md` l. 793); send me your
   statement of it when it is fixed, so the two are stated to meet at the join.
6. **FS114-Y2-BOWTIE's kernel route, decided and priced**: the explicit twenty-tile map is this wave's inhabitant and the one wave 8's
   star rows owe; the first pass names the route to price it against (`{P}SixFragment.lean`, 2,229 lines). If it is one implementer's job
   on its own, say so in the handoff.'''
    VAC='''7. **Vacuity and inhabitants**: the pinwheel's rows are refutations with no held fragment at `1 + ε` outside its two exceptions — each
   docstring says so in `LEAN.md` § The gate's form and names the object meeting the local hypotheses but one. Every other structure-valued
   hypothesis has a named Lean inhabitant or an owed one named.'''
    SCOPE="Thirteen rows over a foundation nobody has written may be more than this pass holds: the four flags, the foundation and the bowtie rows first, the pinwheel after; stopping at a saved stage and saying exactly where a third pass takes over is a good report."
    YOURS="The modules and their layout, the form of each statement within what its row claims, which rows are one theorem and its corollary (the first pass proposed three merges), what is formalized and what is named as a hypothesis, the bowtie's kernel route, and the order after the four flags."
else:
    TITLE="the nine semi-hub rows and two more, the plans for two stated leaves, and the hypothesis from wave 7"
    ROLE="wave 8's second planner — read the arguments the first pass did not, then state the nine semi-hub rows, FS116-N2-SIXRING and FS116-RING-TWIST-C as new modules over the wave's foundation, `sorry` at each leaf, each statement read back against its row; write the plans for `outerAdj` and `doubleTip`; define the three words the foundation lacks; state wave 7's FS114-N7-QOPP as a named hypothesis; a plan and a price per leaf, the inhabitants and vacuity lines, and a handoff implementers can split by file"
    FIXED=f"the wave's three existing modules (`{P}RingCalculus/Basic.lean` is shared with wave 9 by ancestry and is not edited by anyone; `{P}RingCalculus/Star.lean` and `{P}RingCalculus/Empty.lean` are fixed: an implementer is proving them on a branch cut from this one — the one exception is the *statements* of `outerAdj` and `doubleTip` in `Empty`, the two leaves that implementer leaves alone, which are yours to correct if their arguments require: tell me first, and edit nothing else in that file)"
    NEW=f"new modules only under `{P}RingCalculus/` (the plan names `SemiHub`; FS116-N2-SIXRING and FS116-RING-TWIST-C, which the first pass assigned to `Star`, go in a module of yours that imports it)"
    INTRO='''You are finishing the plan of wave 8 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 8 is twenty-two rows of the ring calculus — what the unit circle about a vertex of a
valid map carries, in the class with no Siamese pair. Its first planner wrote the foundation, proved three rows and stated eight more, and
disposed eleven from their entries only: the nine *semi-hub* rows and two others. Those eleven are yours, with the plans for two leaves it
stated without reading their arguments.'''
    WHY='''A result counts as held only when its Lean module passes the gate. The semi-hub rows say what a ring passes to the vertices it
places, the held ground of the frontier's first-ranked stub, the (Q) ring (`plans/STUB-q-ring.md`; `LEDGER.md` rows 145–150) — and the
first planner names three words in them that its foundation does not define, each of which it expects to hide a statement defect. You are
the first mind in this milestone to read their arguments.'''
    ITEMS=[518,524,525,498]
    RQ=["## Stage 2 — SAVED: the dispositions","| FS116-N2-SIXRING |","| FS116-RING-TWIST-C |","| FS116-N3-PAIR |","| FS116-N3-STAR2 |","| FS116-N3-CONE |","| FS116-N3-CROSS |","| FS116-V5-OUT2 |","| FS116-V5-QCOL |","| FS116-V5-DICHO |","| FS116-N3-SEMI |","| FS116-RING-TRANSFER-QC |","| FS129-SR3-OUTERADJ (carrying FS116-V6-ADJ) |","| FS129-MR1-DOUBLETIP |","**The hypothesis from wave 7**:",
        "### 3.3 Seams left open, by name (for the second pass)","- **`IsSemiHub`, `IsFullSemiHub`**","- **Words the SemiHub rows use and the foundation does not define**:","- **`GammaFreeRing`** reads","- **No concrete tip.**","- **`outerAdj`**, **`doubleTip`**:","### 5.5 Inhabitants and vacuity","### 5.6 The handoff","- **The second planning pass (K8b)** takes:"]
    NLEAF="10 `sorry` leaves in two files, none yours to prove"
    FIRST='''2. **The first pass's questions first**, each from its argument: is FS116-V5-OUT2 exactly `star_outer_cone` (then it is a citation, not a
   declaration); do `outerAdj` and `doubleTip` stand as stated (the first pass read their entries only, and names a candidate narrowing of
   `doubleTip`'s `SimpleOn` hypothesis); what the three undefined words mean in the arguments that use them. A filed statement that needs a
   hypothesis its entry lacks is a message to me at once — and say which kind you have: a *statement* defect, or a *route* that reads more
   than the statement needs (a shorter-route note, no defect). One mid-job report this session was the second kind and was retracted by its
   reporter within the hour; check which before you send.'''
    FOUND='''4. **The three words, defined**: "an edge of `p` between two tiles in a window", "a cone of zero angle", "the tiles of `p`,
   counter-clockwise" — each a definition in a module of yours with a spec example, by `debruijn-domain-modeling` invoked fresh, read against
   every argument that uses it; and the pair-generic helper for semi-hubs if the rows want statements uniform in the pair. `Basic` is not
   edited: wave 9's planner holds it by ancestry.
5. **The rows, stated**: the nine semi-hub rows, FS116-N2-SIXRING and FS116-RING-TWIST-C, each with `sorry` at its leaves and read back
   against its row. **FS114-N7-QOPP enters three of them as a hypothesis under a name of this wave's own** (ruling 498; the first pass
   proposed `QArcsJoinOpposite F p`, from the first sentence of `plans/FS114-derivation.md` l. 793) — a `Prop`-valued definition, never an
   axiom. Wave 7's second planner is stating the row itself, and has sent me the form it intends — **provisional, from its mid-job message
   of 2026-10-06 (inventory item 546), not yet in a saved stage; I relay the final Lean text when its skeleton builds**. In its words: for
   `hA : F.IsRingArc p u v c c'`, `c ∈ coloursAt p`, `c' ∈ coloursAt p`, in a valid non-Siamese map, any `k`, any number of colours at
   `p`, no "simple": (i) every tile `T` of colour `c` with `p` in its closure has `coneAt T p ⊆ angleIcc (v − π/2) (u + π/2)` and holds
   the whole arc in its closure; (ii) every tile `T′` of colour `c′` with `p` in its closure has `coneAt T′ p ⊆ angleIcc (v + π/2)
   (u + 3π/2)`; (iii) hence `c ≠ c′` and the two cones share no direction; and, adding `(coloursAt p).ncard = 4` and `SimpleOn` at `p`:
   (iv) every colour of `p` other than `c`, `c′` is absent at `ringPt p θ` for `θ ∈ Ioo u v`. So "opposite" arrives as two explicit cone
   windows, not as a position in a cyclic order: define yours so that this discharges it, and if your three rows consume another form
   (a cyclic position among four tiles), send me that form — it asked. **A second meeting point** (the same message): its FS114-N3-ODD,
   stated with closed arcs, is the case "no arc of `Γ` meets the window" of FS116-RING-TWIST-C's last clause — state TWIST-C so that the
   two are one theorem and a corollary at the join. Send me your definition when it is fixed. FS116-RING-TRANSFER-QC is a conjunction of four of the others: a bundling theorem, or no declaration, by your reading.
6. **The plans for `outerAdj` and `doubleTip`**: their arguments read (`plans/FS129-SR3-audit.md` §§ 2.2–2.3, `plans/FS129-MR1-audit.md`), a
   plan per child, and each statement confirmed or corrected (`outerAdj` is already stated at the corrected reading of inventory item 518).'''
    VAC='''7. **Vacuity and inhabitants**: the first pass's § 5.5 says which hypotheses have no Lean term yet (a change point of a four-colour vertex
   — wave 7's bowtie is the owed inhabitant) and which are satisfiability-open at six colours (the hub and (Q)-ring questions): each new
   docstring says which, in `LEAN.md` § The gate's form, with the object meeting the local hypotheses but one. FS116-RING-TWIST-C's hypotheses
   have no held model at six colours, by its entry: say so there.'''
    SCOPE="Eleven rows and two plans may be more than this pass holds: the questions and the three words first, then the rows in the order of their dependencies; stopping at a saved stage and saying exactly where a third pass takes over is a good report."
    YOURS="The modules and their layout, the form of each statement within what its row claims, the three definitions, which rows are one theorem and its corollary or a citation of a proved one, what is formalized and what is named as a hypothesis, and the order after the first pass's questions."
ITEMQ="\n".join(item(n) for n in ITEMS)+"\n"
RECQ="\n".join(Q(REC,p) for p in RQ)+"\n"
b=f'''# Brief {JOB} — wave {N}'s second planning pass: {TITLE}

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: {PIDENT}
  role: {ROLE}
  launch: when a slot frees, in the tree the first pass (FS131-K{N}) handed back; the wave's first implementer proves that pass's leaves on a branch of its own, cut from a commit of this branch
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect in a row (at once, with the entry's address and the line of the argument: it goes to a deriver), a change you find you need in a module that is fixed (below), a generalization or a shorter route, an outside theorem you would import, a row that cannot be stated at the class its argument reads, the hash of a shared module, or a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full (§ The gate: the inhabitant rule and the doubled-name check; § Searching — Lean, last bullet: two branches never state one lemma under one name), and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w{N}-kernel-plan.md` (on branch `{TREE}`; the first pass's record — your stages continue its numbering, headed {JOB})
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{TREE}`, at `{TIP}`): **{NEW}**, with `Proofs.lean` and `ARCHITECTURE.md` for them; `scripts/Axioms.lean` (a block of your own, headed "{JOB}", above the `=== PURCHASED ===` banner), `plans/FS131-w{N}-kernel-plan.md`, `tools/fs131_k{N}b_*.py`, `data/fs131/k{N}b/`, `data/fs131/reports/{JOB}.md`; **not** {FIXED}, any landed module beyond new declarations, `main`, `CLAUDE.md`, `LEDGER.md`, `LEAN.md`
  budget: {BUDGET}

Hello. {INTRO}

## Why this job

{WHY} Kooshi, on pricing this work:

{KOOSHI}
What the first pass handed back and the rulings in force (read each item whole in the inventory):

{ITEMQ}The milestone's plan binds every wave's planning job (read its §§ 7.1–7.5 whole):

{Q(KP,"### 7.3 What each wave's planning job must hold")}
{Q(KP,"1. **Reads its rows' derivation entries in full**")}
{Q(KP,"3. **States every row at the class its argument reads**")}
{Q(KP,"5. **Checks vacuity at the seam**")}
## The statements

What is yours, in the first pass's words — its dispositions of your rows (each from the row's entry only where its "read" column says E), its
list of what the foundation lacks, and its handoff. Read its record whole
(`/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}/plans/FS131-w{N}-kernel-plan.md`); these are the lines that are yours:

{RECQ}## Done means

1. **Your readback first**: check every quotation above against its source; read the first pass's record whole, the wave's modules, and the
   plan's §§ 7.1–7.5. Register, before reading the unread arguments: which rows you expect to hide a statement defect, which to be one
   theorem, and how many you will state. Build the branch once as given ({NLEAF}). Open your stages in the record with what you may and may
   not change. Commit and push.
{FIRST}
3. **The arguments, read in full** — the records the first pass names for each row, with their verifiers' — before a row is stated; its
   dispositions revised where an argument reads a different class than its entry. A row whose argument does not support its statement is a
   message to me at once.
{FOUND}
{VAC}
8. **Rows over `SimpleOn`, a caution found today** (inventory item 533 (d)): a non-existence row stated with `F.SimpleOn S` implies the
   row as filed (`Simple.simpleOn`), but a row that is an implication between two class statements does not — its hypothesis grows with
   the class too. State such a row in both readings (on the disc, and literal `Simple`); one argument proves both.
9. **The skeleton**: builds through the worktree's `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md`
   (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; no new `axiom`, no `native_decide`; `./scripts/dupnames.sh` on
   your tree — no name declared by two modules (wave 8's first pass lost a build to three names already declared on `main`).
10. **Your record**: a plan per leaf (route, the Mathlib and library lemmas confirmed with `#check`, what is hard, a price **in lines of Lean
   and in implementer jobs, never in days** (inventory item 541: this milestone's planners' line counts have been right to within a factor of
   two and their day counts high by ten in jobs; one job proves about 1,300 lines) — re-priced from the first two leaves you prove), the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), and a handoff for
   implementers by file. A leaf you can prove in about an hour, prove, and say so.
11. The report, in standing rule 11's form. You do not merge another branch into this one unless I ask it by message, run the gate, or touch
    `main`. Leave no background process running, and keep what your record cites under `data/fs131/k{N}b/`. {SCOPE}

## What is yours to decide

{YOURS} One mind planned what you stand on and did not read your rows' arguments: where the foundation does not carry what a row reads, say so
by message before working around it — a change now is cheap. Attack the rows: a statement true only at a narrower class than its entry says
is the finding this job is best placed to make. Three failed attempts on one route is a dispatch to the companion your identity names, never
a fourth. {NOSPAWN}

{MACHINE}'''
open(ROOT+"data/fs131/briefs/"+JOB+f"-wave{N}-second.md","w").write(b)
print("written",JOB,"at tip",TIP)
