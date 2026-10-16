exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-PV3: the Clerk's privacy check of every unpushed commit before the push Kooshi asked for (W22), by the standing protocol (W8-W9).
# The guard's command and the raw-output folder are given in the launch message only: neither is written into the repository.
# Usage: mk-fs131-pv3.py <tree> <branch> <head-sha>
import subprocess,os,sys
def sh(*a): return subprocess.run(list(a),capture_output=True,text=True).stdout.strip()
now=sh("date","-u","+%Y-%m-%d %H:%M UTC")
TREE,BR,HEAD=sys.argv[1],sys.argv[2],sys.argv[3]; JOB="FS131-PV3"; W=WT+TREE+"/"
fresh(JOB)
assert sh("git","-C",W,"branch","--show-current")==BR
assert sh("git","-C",W,"rev-parse","--short=9","HEAD")==HEAD
BASE=sh("git","-C",ROOT,"rev-parse","--short=9","origin/main")
N=sh("git","-C",ROOT,"rev-list","--count",f"{BASE}..{HEAD}")
W8=Q("data/fs131/REQUEST-2026-10-13.md","W8: ")
R8=Q("data/fs131/REQUEST-2026-10-13.md","**W8, read by Keryx")
R13=Q("plans/STANDING-RULES.md","13. ")
b=f'''# Brief {JOB} — the privacy check before a push: every unpushed commit, every file version and message it would publish

*Written {now} by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: {JOB}
  identity: the Clerk — your agent file (`.claude/agents/clerk.md`) is your identity and your workflow; here you run a mechanical check and report what it finds, deciding nothing
  role: the privacy check Kooshi asked for before the next push to the public repository — the publication guard over everything the push would publish, with the identities and sizes beside it
  launch: now, in a worktree with no Lean build, on a branch at the last commit to be pushed; beside you two kernel jobs in other worktrees, writing none of your files
  mission: § Why this job
  statements: § Why this job
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage at once if the guard refuses anything or a check cannot run; the report goes to `data/fs131/reports/{JOB}.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full (never push; everything committed may be published)
  record: `data/fs131/reports/{JOB}.md` (new)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/{TREE}` (branch `{BR}` at `{HEAD}`; no Lean build): your script under `data/fs131/pv3/` (start from the last check's script, `data/fs131/pv2/check.py`, copied there) and `data/fs131/reports/{JOB}.md`; the guard's raw output only in the scratch folder your launch message names, never in the repository. Commit on your branch by explicit path; the coordinator merges it; never push
  budget: about 120k by the harness's count, as guidance; save a stage after the script runs; hand back before about 200k

Hello. The repository is public, and the commits on this laptop have not been pushed yet. Kooshi has asked for them to be
shipped, and his standing rule is that a clerk checks them first. Since the last push this laptop's history was rewritten
to remove wording the guard refused (inventory item 1025), and a commit hook now runs the guard on every commit; your check
is the one that covers everything at once, including what the hook skips (binary files, files over 10 MB).

## Why this job

{W8}
My reading of it, from the same file:

{R8}
The rule every committed file already follows:

{R13}
## What is checked

The range is every commit in `{BASE}..{HEAD}` ({N} commits; `{BASE}` is `origin/main` as fetched at this brief's writing).
A push publishes every one of them, so an intermediate version of a file counts as much as the last.

1. **Every file version:** for each commit in the range, every file it adds or modifies, at that commit's version
   (`git show <commit>:<path>`), written under the scratch folder and passed to the guard. A file that is not text goes on a
   separate list (path, commit, size, type) and is not passed.
2. **Every commit message,** in full, passed to the guard.
3. **Identities:** every distinct author and committer name and e-mail address in the range, counted.
4. **Sizes:** every file version above 10 MB, with its size (GitHub refuses a file above 100 MB).
4b. **Compressed files** (`.gz`): decompress each version under the scratch folder and pass the text to the guard; a match
   in the compressed bytes themselves is noise (two such false matches were seen at the last landing), so report the
   decompressed result.
5. **Names:** every path in the range whose name looks like a credential or a transcript (the names ".env", "auth.json",
   "*.pem", "id_*", "*.key", "*.jsonl", or anything under a folder named "chats-bak") — listed by path only. **Never open such a file**, not even to
   pass it to the guard: say it is there and stop.

The guard's command is in your launch message; it reads private lists that are never written into the repository.

## Done means

1. **The script** (`data/fs131/pv3/check.py`, from the last check's `data/fs131/pv2/check.py`, with one planted refusal and one planted name match run first as its controls, each seen to fire): it takes the guard's command and the scratch folder as arguments (it
   names neither itself), walks the range, runs 1–5, and prints a summary of counts. Run it; save a stage.
2. **The report**, in the standing rules' form: the range and its commit count; file versions checked, non-text files
   listed, messages checked; the guard's refusal count; the identities with their counts; the large files; the name
   matches. **For any refusal, give only the commit, the path and the line number — never the matched text**, because
   the report is committed and may be published. End with one line: `CLEAN` if the guard refused nothing, no name
   matched and every identity is the one noreply address, or `NOT CLEAN` with the reason.

## What is yours to decide

How the script walks the range and batches the guard's calls. Nothing else: if a check cannot run as written, say so and
stop rather than substitute another.
'''
out=ROOT+f"data/fs131/briefs/{JOB}-privacy-check.md"
open(out,"w").write(b); print(out)
