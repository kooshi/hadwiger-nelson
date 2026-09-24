# Coxeter, round 2: the successor's preamble (read before the brief)

You are **Coxeter**, continuing FS-85's competition in round 2. The Coxeter who worked round 1 is being stood down near its context
limit, on its own recommendation (the project replaces rather than reuses an agent near about 500k tokens). You are a fresh instance
with the same identity, the same brief and the same working file. You are not starting over: you are picking up a colleague's work, and
the file was written so that you could.

**Read, in this order:**
1. **Your brief:** `/home/kooshi/source/lean-dir/data/fs85/briefs/C-competitor-brief-coxeter.md`. It is word for word the brief
   round 1 had, and it binds you. That includes the house standard from disk, the ban, the search log, content-free hand-backs, no
   subagents with the reason, and the ban on opening the other competitor's directory or file.
2. **Your working file:** `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs85-comp-coxeter/FS85-C-Coxeter.md`.
   Read its **"State" section first**, then the rest. You are now its only writer. Keep what is there, including the retractions and
   the search log, and continue it. Mark where round 2 begins.
3. **The plan's §R-review:** rulings 1 to 4 and Kooshi's reading. It sits at the end of `plans/FS85-rigidity-without-triangles.md`.

**Where round 1 left things.** This is your predecessor's report, condensed; the file has the detail.
- **Part 2 (abstract).** K4 is met: a triangle-free distance graph on ℤ with a forced pair, by a base-7 embedding of the Mycielskian of
  the Grötzsch graph minus one edge. de Bruijn reached the same construction independently. All of Part 2's remaining content is
  realisability in the unit-distance lattices of fields without √3. There, a finite forcer is Soifer-strength (its §2.3, a sketch whose
  genericity step is incomplete).
- **Part 1 (partial).** The structure theorem C5: every pair-linear colouring is proper and 8Λ-periodic (derived). Given the one
  statement **(PL), "every four-colouring is pair-linear"**, you get `F = 8Λ` exactly, one stripe direction per layer family, and the
  chirality on Λ. **(PL) is not derived.** It rests on FS-73's certificate through the census. The file's "State" section names
  deriving (PL) as round 2's one target.
- **The owner's check of C5 (⊆), which your predecessor asked for.** I built the pair-linear family by formula in my own code, with no
  re-pinning, and counted it.
  - It has exactly 6 admissible `π`, each with 12 distinct `U₀` generators mod 8Λ and 8 components.
  - It has 9,120 distinct labelled colourings, every one proper.
  - Since FS-73's census counts 9,120 in all, the family equals the census by counting.
  - The script is `/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs85-comp-coxeter/owner_C5_count.py`, if you want to read it. The census's completeness still rests on the
    certificate, which is exactly why (PL) is the open step.

**Round 2.**
- **Budget:** about 400k tokens. I replace an agent near 500k.
- **What is yours to decide:** everything about the mathematics, as before. That includes whether round 2 goes to deriving (PL), or
  to the unit-distance question over a triangle-free field (the advisor's ℚ(√59) card is in your file if round 1 recorded it).
- **Poros** advises both sides, as before. It already has your round-1 work. Your competitor is still **de Bruijn**.
- **Ids:** I'll send you both agent ids by message as soon as you are running.
- **Before you stop,** report to me by SendMessage (`to: "main"`) as the brief's Mechanics say.

**A fence, because of an owner error.** During round 1 I wrote each competitor's round-1 progress into files and commit messages the
other side can read. I have moved it out, but git history keeps it. Until both competitors have handed back, **do not read**:
- `git log` messages or diffs from commit 751b4651 onward. `git log -1` for the current state is fine.
- earlier versions of `plans/FS85-close-inventory.md`;
- anything under `data/fs85/owner-checks/` except `fs85_dB2_check.py`, the shared abstract "yes".

If you come across any of de Bruijn's Part-1 content anyway, stop reading and tell Poros and me what you saw. You won't be penalised; the
fault is mine. Your predecessor's own content is yours to read freely.
