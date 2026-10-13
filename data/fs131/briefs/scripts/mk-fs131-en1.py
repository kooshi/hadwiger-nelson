exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
# FS131-EN1: a deriver confirms or refutes a shorter route the kernel planner read off the kernel proof.
import subprocess
now=subprocess.run(["date","-u","+%Y-%m-%d %H:%M UTC"],capture_output=True,text=True).stdout.strip()
C="data/fs131/claims-EN1.md"; RQ="data/fs131/REQUEST-2026-10-13.md"
ST="\n".join(Q(C,f"EN1-{n}: ","§ Statements") for n in ("MRPLUS","FROM-TWO","SPCOR","APLUS","OFFPATH"))
NC=Q(C,"EN1-NC: ","§ Not claimed")
b=f'''# Brief FS131-EN1 — does the proof that two number-field results rest on really need the split places? Five statements a kernel planner read off the kernel proof, to derive or refute from the derivations

*Written {now} by Keryx, the coordinator (the top-level session), at Kooshi's word of today. Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-EN1
  identity: Ephodos, the deriver — your agent file (`.claude/agents/ephodos.md`) is your identity and your lane's workflow; this is a derivation job on a fixed claim list
  role: the deriver on five statements proposed by the kernel lane's planner — a shorter route under the lower bound for planes over number fields, read off a kernel proof and checked by nobody; you derive each from the derivation entries it names, or find where it fails, before a Lean module is planned on it
  launch: now, on `main`; beside you the planner who proposed them maps the library on a branch of its own, and the asking lane ranks findings under `plans/` — you write no file either writes
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you; you may read the planner's branch
  channel: message the coordinator ("main") by SendMessage **with each statement's verdict as it is reached** (the planner is waiting on the fourth above all); at once for a statement that is false as worded, or true only in a narrower form — say the form; the report goes to `data/fs131/reports/FS131-EN1.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full
  record: `plans/FS131-EN1-derivation.md` (new)
  touches: `plans/FS131-EN1-derivation.md`, `data/fs131/en1/`, `data/fs131/reports/FS131-EN1.md`; on `main`, committed by explicit path. Nothing else: an erratum to an older derivation file is drafted in your record, not written there
  budget: about 250k by the harness's count, as guidance; you cannot read that count, so save a stage (a commit) after the readback and after each statement's verdict; hand back before you would guess 400k

Hello. This is a short job with a large lever on it.

## Why this job

The project is being wound down and published, and Kooshi's rule for what goes out is this:

{Q(RQ,"W2: ")}
The first things to be formalized are the results about planes over number fields, and the best of them — that the
plane over the field of the square root of 47 needs exactly five colours, and the general statement it is a case of —
rest on a chain of hand results. One link of that chain, the one the record calls R-U, sits on the topology of the
split places, and a month ago the kernel lane priced it in months.

This morning the kernel planner, reading the kernel proof that already assembles the chain over named hypotheses,
noticed that the proof never uses the set the split places define except through a smaller set — the torsion and
archimedean characters — and proposed that for these two results R-U is not on the path at all. If that is right, the
longest leaf of the first module disappears. If it is wrong in any clause, a module planned on it is wasted. It is one
mind's reading of a Lean proof; nobody has read the derivations with this question. You are that reading.

No answer is the wanted one. "False, and here is the step that reads the larger set" is as useful to the planner as
"derived".

## The statements

Fixed in `data/fs131/claims-EN1.md` before your launch, in the proposer's words:

{ST}
{NC}
Where the proposer read them from: `Proofs/HadwigerNelson/SpectralChain.lean` — the theorem
`Interface.mr_of_pe2_efPlus` at its line 196 and `x4_eq_empty` near line 519 (the proposer says a clause named `hHE`
there is bound and never used). Where the hand results live: `plans/FS100-derivation.md` (the entries FS100-EFP at
about line 162, -EFZ, -PE1, -PE2, -MR, and § 4 for the corollary), the derivation files that hold the entries named
J45 (R-U at their § 5.4; N1 and N2), SI-3 and SI-4 — find them by `rg` over `plans/*-derivation.md` and say in your
record which file each is in —, `plans/FS100-K-kernel-47.md` § 1.3–1.4 (the dependency map the kernel lane drew a month
ago, with R-U on the path), and `LEDGER.md` rows 120, 121 and 123.

## Done means

1. **Readback** (a saved stage): the six quoted lines checked against the claim list; each statement restated in your
   own words with every symbol resolved to its entry and address; anything you cannot resolve said at once.
2. **Each statement at a verdict** — derived, with its argument from the entries; or false, with the step; or true in a
   narrower form, stated — in your lane's entry form, through your gate. For EN1-APLUS that means reading SI-3, SI-4
   and N2 at S = ∅ line by line for every use of the larger set, and listing each use with what it needs of it.
3. **Attack the fifth statement from the other side**: walk the whole chain under rows 121 and 123 as the record
   derives it, start to finish, and list every place the split places, R-U or "Haar(E) = 0" are read — not only the
   places the proposer named. A dependency that enters by a lemma nobody thought of is the failure this job exists to
   find.
4. **What the planner needs, said plainly at the end**: the list of hand results that *are* on the path of rows 121 and
   123 after your reading, each with its entry's address, so that the map's leaves can be checked against it.

## What is yours to decide

The order; whether a statement is better split; the form of a narrower true statement. If you see a still shorter
route, say so in a section of its own, marked as yours and unchecked — do not fold it into a verdict.

Not yours here: the Lean statements; the choice of which printed theorem is declared (ruled: the theorem proved in
print, with our deduction of its corollary formalized); anything about rows other than 121 and 123.

## The machine

This session is on the laptop, away from the remote: **commit by explicit path and do not push** — the server is
unreachable, and a failed push is not an error to fix. `/tmp` is wiped at power-off: anything
your record cites lives under `data/fs131/en1/`. No search and no Lean build is part of this job.

You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review
work it knows exists).
'''
open(ROOT+"data/fs131/briefs/FS131-EN1-shorter-route.md","w").write(b); print("ok",len(b))
