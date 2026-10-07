exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# SEARCH-2026-10-07: the day's search — does a six-sector turning ring exist near the closed unit disc with triangle points only?
E4="plans/FS132-E4-derivation.md"; SQ="plans/SEARCH-QUEUE.md"; RQ="data/external/EXT-OAI1-request.md"
REQ=Q(SQ,"| 10 | 2026-10-07, FS132-E4 |")
L4=Q(E4,"- **L4 — the six-sector ring `a, b, n, a, b, n`**","Stage 3")
L5=Q(E4,"- **L5 — the six-sector ring `a, b, a, b, a, b`.**","Stage 3")
L6=Q(E4,"- **L6 — open: the side that is not pure.**","Stage 3")
TE=Q(E4,"derivation: C132-TURN-EDGE","Stage 3")
AL=Q(E4,"derivation: C132-ALT","Stage 3")
ND=Q(E4,"### What a colouring by formula would need (not built)","Stage 3")
KW=Q(RQ,"> […] I'll hand the reins over to you […].")
b=f'''# Brief SEARCH-2026-10-07 — the day's search: does a six-coloured "turning ring" exist around a three-way meeting point? One request, finite and exact

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), in the session Kooshi handed over. Launch line: "Your brief is on disk: read it in full first."*

brief: SEARCH-2026-10-07
  identity: the Searcher — your agent file (`.claude/agents/searcher.md`) is your identity and your lane's workflow
  role: the day's search run, outside the milestone loop: one request — decide by exact enumeration whether a six-colouring can exist near the closed unit disc about a point where three colour classes meet, with the other three colours going round its unit circle in the turning order a, b, n, a, b, n and every meeting point three-way; keep any model in a form an exact checker re-checks; report the result or the bounded null
  launch: now, into a free slot; a deriver and a planner of the kernel lane are running, the planner building Lean under the slot with up to 40 GiB
  mission: § Why this job
  statements: § The request
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you (a planner of the kernel lane is fenced from the derivers' records: you do not message it, and your commit subjects say what was run, not what was found)
  channel: message the coordinator ("main") by SendMessage **at once if you find a model** (with its address and what checks it), and otherwise only for a question you cannot work around; the report goes to `data/search/2026-10-07/report.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` is part of it too: read it in full before any run
  record: `plans/SEARCH-2026-10-07.md`
  touches: `plans/SEARCH-2026-10-07.md`, `data/search/2026-10-07/` (every script, certificate and output — not `tools/`); **not** any deriver's record, the claim list, the queue (`{SQ}` is the coordinator's), any Lean file
  budget: about 200k by the harness's count, as guidance; hand back at a saved stage before about 300k. Wallclock window: about one hour from launch; memory: at most 16 GiB and 12 cores per run under `scripts/slot.py`

Hello. Since three days ago the problem this project works on is six or seven: an outside proof, now this project's literature,
removed five and showed that the plane's chromatic number is that of measurable colourings proper at almost every unit pair. Last
night and tonight five derivers worked out what such a six-colouring would have to do around a point where colour classes meet.
Everything they could exclude, they excluded by hand. One configuration is left standing that no argument reached and no formula
produced — and its author says, in its own report, that deciding it is a finite enumeration with an exact checker. That is your
lane, and tonight it is the one search this project has.

## Why this job

Kooshi's instruction for the night:

{KW}
Around a point `x` where three classes meet, the unit circle about `x` carries the three *other* colours. If they turn —
a, b, n, a, b, n in six sectors — then at every second ring point all three of them are forced to meet in three wedges whose
interfaces lie on the unit circles about the neighbouring ring points, and those neighbours are ring points of the same kind.
Whether the six can carry each other's arcs consistently around the hexagon, with the remaining sides filled and every unit
pair proper, nobody knows. **Both outcomes are results.** A model is the first six-coloured structure this project has met that
no map of segments and arcs can be — the YES side's first object of its own, to be extended outward. A null over a stated
family says the simplest turning ring is dead, and by which constraint. Do not lean toward either.

## The request

{REQ}
Its source, at one mind's grade, a few hours old (`{E4}`, Stage 3 — read the stage whole: the entries, the list L1–L8 under
C132-PLACE with its wedge table, the argument for C132-TURN-EDGE, "Where C132-TURN stalls" and the section quoted last below):

{L4}
{L6}
{TE}
{ND}
**Your positive control is in the same record**: the *alternating* six-sector ring is excluded there by hand in step form, so a
search that can decide the turning ring must reject the alternating one, and must say by which constraint:

{L5}
{AL}
The exact checker of this kind that the project already holds is `tools/fs110_y_fragments.py` (read it; the held fragment "T2"
it checks is the one object of the required local shape, at four-colour points and not three-way ones). Queue line 9 is not
today's.

## Done means

1. **Your decision, first**, in your record: exactly what is enumerated — the family of local structures (the six ring points,
   the wedges L4 forces at the outer-pure ones, the fillings of the sides that are not pure from the labels the transfer
   leaves, how far from the unit circle the model extends, which sets of sides are tried), what "proper" is checked as (exact
   arithmetic: every pair at distance exactly 1 between regions, on the boundaries as the held checker treats them), and what
   is **not** in the family — so that a null is a null *of that family* and reads as nothing more. If the request as written
   does not determine a finite family, say what you added to make it one.
2. **The controls before the run** (`RUNNING.md` § Make the gate fail, and watch it fail): the checker accepts a known good
   object of this shape (the held fragment) and rejects a planted fault; the search rejects the alternating ring; each seen.
3. **The run**, under the slot, checkpointed so that a kill redoes one unit of work: a model with its certificate, re-checked
   by the exact checker from a cold start — **message me at once** — or the null, with the count of cases, the constraint
   that killed each class of them, and the widest family you can state the null for.
4. **What the result means and does not**, in your own words, in the record: a model is local — say the radius it reaches and
   what stops it; a null is of your family — say the nearest structure outside it (twelve sectors; sectors of unequal angle;
   curved sector boundaries; a ring with an impure arc).
5. Your record in stages headed "Stage n — SAVED", committed by explicit path and pushed, with neutral commit subjects (what
   was run, never what was found); the report in standing rule 11's form.

## What is yours to decide

The family, the encoding, the order, the solver or the plain enumeration, and when the window is spent. If the request is not
a search — if a short hand argument decides it once the constraints are written down — say so and stop: that is a finding for
the derivers' lane, with the argument's shape. You start no agents of your own (standing rule 1: delegation is one level deep,
because the coordinator can only review work it knows exists).
'''
open(ROOT+"data/search/briefs/SEARCH-2026-10-07.md","w").write(b)
print("written SEARCH-2026-10-07",len(b))
