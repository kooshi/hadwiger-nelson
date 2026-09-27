*Brief for job **LX**: a blind second derivation of the ℚ⁴ compulsion law, then `[Johnson1982]` read in full against Theorem A. Opus 5.5,
2026-09-27. Written by the product owner. **Sized for about 250k tokens by the harness's count, as guidance.***

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/consolidation-2026-09-27/briefs/STANDING-RULES.md` is part of
this brief; read it first, rule 0 first.**

## Stage 1 is blind — the fence

Stage 1 is a second mind on a result one mind derived this morning. **Until your stage 1 is saved and committed, do not open:** anything under
`data/consolidation-2026-09-27/` except this brief and `STANDING-RULES.md`; `plans/CONSOLIDATION-2026-09-27.md`; `CLOSED-QUESTIONS.md`; the
`BIBLIOGRAPHY.md` rows naming Zaks (`[Zaks1989]`, `[Zaks1992]`, `[Zaks1999]`, `[Zaks1990conn]`, and the library row for the IX(2) issue); `git log -p` or `git show` of any commit from today; the session transcripts
(`~/.claude/projects/-home-kooshi-source-lean-dir/`), `chats-bak/`, and any scratchpad file you did not create. Read the primary sources instead.
Log in your record every file you open during stage 1.

## Stage 1 — the ℚ⁴ law (blind)

**The setting.** The unit-distance graph on `ℚ⁴` (points of `ℚ⁴`, adjacent at Euclidean distance exactly 1); `χ(ℚ⁴) = 4` (Benda–Perles). For a
pair `x, y ∈ ℚ⁴`: *forced equal* if every proper 4-colouring gives them one colour; *forced different* if every one gives them different colours;
*free* otherwise. `v₂` is the 2-adic valuation on `ℚ`.

**The claim to check** (derived at one mind, stated here verbatim from its report): *"a pair is forced to one colour iff `v₂(|x − y|²) ≥ 1`;
a pair is forced to different colours iff `v₂(|x − y|²) = 0`; a pair is free iff `v₂(|x − y|²) < 0`."* Its stated inputs: Zaks's Lemma 1 (and
his Lemmas 1–2 and Theorem 3), *"Benda–Perles's `[H⁴ : D] = 2`"*, and *"the quaternion residue of row 57's remark"*. Its stated corollary (its report, l. 64): *"So a four-colouring of `ℚ⁴` forbidding both 1 and `d` exists iff `d² = p/q` with
`p` and `q` odd."*, answering, it says, `[Johnson2006]` p. 212's question.

**The sources:** Zaks 1999, Geombinatorics IX(2) pp. 90–95, in `~/source/library/geombinatorics/geombinatorics-v09-n2-1999-10.pdf` (an image scan:
standing rule 9); `[BendaPerles2000]`, Geombinatorics IX(3) pp. 113–126, in `~/source/library/geombinatorics/geombinatorics-v09-n3-2000-01.pdf`;
`[Johnson2006]` p. 212, in `~/source/library/pdf/johnson-2006-coloring-rational-points-forbid-distance-one-geombinatorics-16-1-209-218.pdf`;
`LEDGER.md` row 57.

**Derive each of the three clauses and the corollary yourself**, from the sources, at [hand]: TRUE, FALSE (with a counterexample), or GAP (the
missing step named). Quote Johnson 2006 p. 212's question verbatim and say whether the corollary answers it as posed. Save and commit stage 1;
then send the owner a SendMessage of at most 10 lines with your verdicts, before stage 2.

## Stage 2 — `[Johnson1982]` against Theorem A (sighted; the fence is lifted)

`[Johnson1982]`: P. D. Johnson, *Coloring abelian groups*, Discrete Math. 40 (1982) 219–223, now held at
`~/source/library/pdf/johnson-1982-coloring-abelian-groups-discrete-math-40-219-223.pdf` (text layer; Kooshi's download). Read it in full, statements
verbatim with pages. Then read `LEDGER.md` rows 52–57 and § The claim list, `CLOSED-QUESTIONS.md` §1.2, `CLAUDE.md` § The prior-art position, and
LV's verdict P1 (`data/consolidation-2026-09-27/reports/LV.md`): Theorem A's coset construction is `[Fischer1990]` Thm 1(i) and Benda–Perles's
(ℚ², ℚ³); its metric-free form over any abelian group was left "not found in print" pending this paper. **Say exactly what Johnson 1982 proves, and
whether it holds Theorem A's metric-free form — in full, in part (which part), or not.** Mine its reference list into `BIBLIOGRAPHY.md`.

## Rules

- **Touch only:** `BIBLIOGRAPHY.md` (the `[Johnson1982]` entry and entries for its references — commit the file promptly after each edit: job FP
  is editing other parts of it now; on a rebase conflict keep both sides), and `data/consolidation-2026-09-27/lx/`. Every other change — ledger
  rows, the claim list, `CLOSED-QUESTIONS.md`, `CLAUDE.md` — goes into your record as a draft for the owner, with old and new text.
- **Record:** `data/consolidation-2026-09-27/lx/record.md`, with a heading "Theorems this phase proved".
- Commits by explicit path, subjects "LX: stage n". Never amend; push after each; never force-push.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- **Report** to `data/consolidation-2026-09-27/reports/LX.md`, committed, and by SendMessage to `"main"`. Your final turn's text: "LX idle; report sent
  to the owner by SendMessage".

Thank you.
