exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# SEARCH-2026-10-14: the day's search — row 24: does a smaller relaxation of FS-66's fibre-density programme still clear 1/4
# at p = 19 (and p = 11), so that the kernel's certificate check at p = 19 shrinks?
import os,subprocess
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
JOB="SEARCH-2026-10-14"; SQ="plans/SEARCH-QUEUE.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
assert not os.path.exists(ROOT+f"plans/{JOB}.md") and not os.path.exists(ROOT+"data/search/2026-10-14")
REQ=Q(SQ,"| 24 | 2026-10-14, FS131-KC13 |")
D2=Q("data/fs131/claims-NF2.md","- 2026-10-14 — **The p = 19 certificate does not fit the present checker's form**","§ Dated lines")
F6="data/fs66/b1/"; WN=WT+"fs131-wnf/"
for p in (ROOT+F6+"cert-p11.json",ROOT+F6+"cert-p19.json",ROOT+F6+"probe-p11-minimal.log",ROOT+"plans/FS66-phase2-certificate.md",ROOT+"plans/FS66-derivation.md",
          WN+"plans/FS131-KC13-certificates.md",WN+"plans/FS131-IKC3-implementation.md",WN+"tools/fs131_ikc1_gen.py",ROOT+"RUNNING.md"): assert os.path.exists(p),p
b=f'''# Brief {JOB} — the day's search: is there a smaller certificate for the class-ratio bound at residue size 19?

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: the Searcher — your agent file (`.claude/agents/searcher.md`) is your identity and your lane's workflow
  role: the day's search run, outside the milestone loop: one request — whether a smaller relaxation of FS-66's fibre-density programme (a lower moment level, or fewer moment monomials) still proves the class-ratio bound below one quarter at residue size 19, and at 11, with an exact integer certificate in FS-66's format that FS-66's frozen checker accepts
  launch: now, into a free slot; four kernel-lane jobs run in other trees and share the memory tool
  mission: § Why this job
  statements: § The request
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once if you find a smaller certificate that the frozen checker accepts** (with its path, size and margin), and otherwise only for a question you cannot work around; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. `RUNNING.md` is part of it too: read it in full before any run
  record: `plans/{JOB}.md` (new)
  touches: `plans/{JOB}.md`, `data/search/2026-10-14/` (every script, certificate and output), `data/fs131/reports/{JOB}.md`; **not** `{F6}` (read only), any Lean file, any tree under `.claude/worktrees/`, the queue (`{SQ}` is the coordinator's). Commit on `main` by explicit path, your subjects saying what was run, not what was found
  budget: about 200k by the harness's count, as guidance; hand back at a saved stage before about 300k. Wallclock window: about ninety minutes from launch

Hello. The five-colour chain needs, at residue size 19, a bound on how large a set with no two points at unit distance
can be in the finite plane modulo 19 — below a quarter of its 361 points. The eigenvalue method cannot give it there;
FS-66 found an exact sum-of-squares certificate that does, at the second level of a moment relaxation. The kernel can
now check certificates of this kind (the checker is proved sound, and the one at residue size 11 is checked), but the
one at 19 is about 110 MB of Lean text and 40–50 minutes of kernel time in a new form that also needs a new soundness
proof. The margin at 19 is wide. A smaller relaxation that still clears a quarter would make all of that smaller.

## Why this job

A yes here shrinks the largest remaining kernel check of the chain and may spare a checker change and its
soundness proof; a no sends the certificate at 19 to an implementer in its new form.

## The request

The request as queued, and what the certificate costs now:

{REQ}
{D2}
Decide, by exact computation, whether FS-66's fibre-density programme at residue size 19 (n = 361) — and at 11 (n = 121) —
still certifies a ratio below 1/4 at a lower moment level, or with fewer moment monomials, than FS-66's certificate uses.
For each variant you try: the numerical solve (SCS, as FS-66 ran it; FS-66 recorded 82 s at 11 at the present level), the
bound it gives, and — where it clears 1/4 — an exact integer certificate rounded from it in FS-66's format, accepted by
FS-66's frozen checker beside the certificates in `{F6}`, with its size in bytes and its margin. A variant that does not
clear 1/4 is a result: record it.

**Where everything is.** FS-66's certificates and its earlier probes of smaller variants at 7 and 11 (`{F6}probe-*.log` —
read them first: some variants were tried there), its records `plans/FS66-phase2-certificate.md` and
`plans/FS66-derivation.md`; the certificate planner's record `{WN}plans/FS131-KC13-certificates.md` § 3.2 (what reduces the
kernel's cost, the margins 2.05 at 11 and 12.7 at 19) and the last certificate implementer's record
`{WN}plans/FS131-IKC3-implementation.md` § 3 (the encoding's sizes by part); the converter that turns a certificate into
Lean, `{WN}tools/fs131_ikc1_gen.py` (read only: it tells you which parts of a certificate cost the kernel most).

## Done means

1. **Readback** (a saved stage): the request restated; FS-66's earlier probes read and summarized — which variants were
   tried, at which sizes, with what result.
2. **The runs** (saved stages): each variant's solve, bound and time, in a table; for each that clears 1/4, the exact
   certificate, the frozen checker's verdict (with a planted corrupted copy watched being refused), its size, and how much of
   the kernel's cost it removes by the converter's own measure.
3. **The answer**: at 19, the smallest certificate found that clears 1/4, or "none smaller than FS-66's"; the same at 11.
4. The report in the standing rules' form. Leave no process running or queued.

## What is yours to decide

Which variants to try and in what order, within the window; the solver's settings; how the rounding to an exact
certificate is done (FS-66's own route first). Not yours: a change to FS-66's files or checker; any Lean file; the queue.

## The machine

**This session is on the laptop: 12 cores, 31 GB; about 318 GB of disk free.** Every run under the memory tool:

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name s1014 -- <command>`

Ask for at most 12 GiB without telling me first; four kernel-lane jobs share the slot. On exit 75 wait ten minutes and
retry. A cap kill under a `timeout` wrapper shows as exit 143, not 137. Stop a process by its PID, never by matching its
command line. `/tmp` is wiped at power-off: everything your record cites lives under `data/search/2026-10-14/`. Report at
once any disk, memory or count reading near its limit.

The remote is unreachable: **commit by explicit path and do not push**; I copy to a local backup.

{NOSPAWN}
'''
open(ROOT+f"data/fs131/briefs/{JOB}.md","w").write(b); print("ok",len(b))
