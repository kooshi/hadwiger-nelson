*Brief for FS-84's stage **S4** (post-ban: **runs from 2026-10-01, not before** — it uses SAT and finders), the colouring side of "ℚ(√47):
five colours". Opus 5.5. Written by J29 (FS-84's planner) from `plans/FS84-five-colours-47.md` §S. Staffing and launch are the owner's.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **FS-84's implementer for S4**, in `/home/kooshi/source/lean-dir`. Read `CLAUDE.md` (§ Building's two
PROTECTED paragraphs above all), `WORKFLOW.md`, `DEBRUIJN.md` from disk and **`data/crunch-2026-09-25/briefs/STANDING-RULES.md`, part of this
brief**; read the plan in full and S1's record if it exists. **No subagents** (`CLAUDE.md` § Delegation: staffing is Kooshi's budget decision).

**Why.** FS-81 left 25 lattices over ℚ(√47) that no capped screen coloured (10 minimal). A lattice four-coloured leaves the list; a lattice
that survives is still **not a refusal** (G21). This stage can only colour: it cannot decide `χ(ℚ(√47)²)`. Every outcome counts.

## Steps, cheapest first (stop each lattice at its first certified colouring)

1. **S1c's formula characters**, if S1 produced any: check each exactly (Fractions) on the lattice's unit vectors; certify with FS-81's K1
   checker (`tools/fs81_colour_check.py`). Seconds.
2. **The UNKNOWN residue targets** re-asked: `scripts/slot.py --mem 8 --cpus 16 -- python3 tools/fs84_s4_d47.py recheck --budget 600`
   (≤ 375 asks, ≈ 62 CPU-h worst case, 4 h wall on 16 cores). **Hazard, checked by the planner:** `tools/fs81_d47.py` hard-codes `OUT = data/fs81/phaseD/d47` (line 42) and `recheck` *removes* sweep records there for re-evaluation — it would rewrite FS-81's committed record. So copy it to `tools/fs84_s4_d47.py` with `OUT` under `data/fs84/s4/` (seeded by copying FS-81's JSONL files), never edit or run the original's `recheck`. **Verify first** (T2): `command -v kissat`, the copy's `selftest` exit 0, and `git status data/fs81` clean after a dry start. The copy resumes from its own JSONL caches: resume = re-run the same command.
3. **Quotients at `N = 16–20`** on the minimal survivors (the admissible `N` only; G68), clique-pinned (one edge — `ω = 2`), precedence over
   unpinned colours only, Galois flip `√47 ↦ −√47` broken (G27). 4 h wall.
4. **A four-colour finder on the antipodal quotient** (G58: `z ↦ −z` with a colour involution fixing a colour). 2 h wall.

**Predictions to score** (plan §P, verbatim ids): P-1p (0.25), P-surv (0.50). **Pre-decided:** if every minimal survivor colours, the report
says the ten were an artefact of capped screens and names the next survivors — not that ℚ(√47) is "closer to four".

**Rules.** Every run under `scripts/slot.py` with an honest `--mem`; `setsid` with a pgid file; kill by pgid and verify by effect; no `pkill -f`,
no pipe into `head` on a command whose cleanup matters; checkpoints outside `build/`; halt on any unexplained crash. Record
`plans/FS84-S4-colouring.md` (stages `Stage n — SAVED`, "Theorems this phase proved"), data `data/fs84/s4/`, tools `tools/fs84_s4_*.py`,
commits "FS84-S4: stage n", push, never force-push. Budget about 3 h of agent time and 350k tokens; hand back by 420k. Keep a
would-have-searched log only for moves beyond this brief. Report in standing rule 9's form to `data/crunch-2026-09-25/reports/FS84-S4.md` and by
SendMessage to the owner.
