*Instance file for job **FS112-NB3**, the round-3 blind verifier of FS-112's proof side. Its brief is `data/fs112/briefs/NB112-verify-proof.md`; this
file is part of it and overrides it where they differ. Filled in by the owner on 2026-09-27, when FS112-N3 handed back.*

## Overrides of the brief for this instance

- **Your job id** is FS112-NB3; **your record** `plans/FS112-NB3-verification.md`; **your working directory** `data/fs112/fs112-nb3/`; **your tools**
  `tools/fs112_nb3_*.py`; **your commit subjects** "FS112-NB3: stage n"; **your report** `data/fs112/reports/FS112-NB3.md`; **your scratch** `scratchpad/fs112-nb3/`.
- **The side verified:** round 3 of the proof side, FS112-N3 — the section "§ Continuation — FS112-N3" of `plans/FS112-N-proof.md`, its tools
  `tools/fs112_n3_*.py` and outputs under `data/fs112/fs112-n/` named `n3*`. **All fenced until your stage 1 is committed.** Open to you: the earlier sections
  of `plans/FS112-N-proof.md` (rounds 1–2), both finished proof-side verifiers (`plans/FS112-NB-verification.md`, `plans/FS112-NB2-verification.md`, their
  reports and tools), and FS-110's close as N's brief lists it — row 134's base in particular (`plans/FS110-CB-verification.md`, `…-CD-…`, `…-CE-…`).
- **Also fenced:** every advisor's record and working directory (including `data/fs112/fs112-a3/`, which holds card R), and the construction side's files and
  its verifiers' (`plans/FS112-Y-construction.md`, `plans/FS112-Y3-construction.md`, `data/fs112/fs112-y/`, `tools/fs112_y*`, `plans/FS112-YB*-verification.md`,
  `data/fs112/fs112-yb*/`).

## Why this one matters

The side's own words (`data/fs112/reports/FS112-N3.md` l. 13): *"N3-BASE is one mind and flattering to the NO side — a blind second mind (NB3) on its table, with the ring lemmas N2-ROT/N2-HEX under P17 (not walked by me) as its named check, is the priority before anything rests on N3-DENSE3."* It
reduces the unit-arc half, at the base, to vertices of four or more colours or a repeated colour. **Audit it at the rate of a result you would like to be
false** (standing rule 4; `CLAUDE.md` G21). **The named check the side asks for:** the ring lemmas N2-ROT and N2-HEX (from round 2; in `plans/FS112-N-proof.md`
§ Continuation — FS112-N2, open to you) that the Prop. 17 step uses, which the side did not walk.

## The statements to derive (verbatim from N3's "theorems this continuation proved" table; each claimed, its grade withheld)

**Priority: N3-BASE and the lemmas under it (NOBOTH, FAIL, ANTI, COR3, I / II / P′), then N3-DENSE3, then the R1 lemmas, then N3-END.**

- **N3-BASE:** "the base refutes a valid map near a cubic trichromatic `u` unless `B̄(u, 2)` holds a vertex of `≥ 4` colours or a repeated colour"
- **N3-DENSE3:** "every closed disc of radius 3 of a valid map holds a vertex of `≥ 4` colours or a repeated colour"
- **N3-NOBOTH:** "a both-centre is a vertex with `≥ 4` colours or a repeated colour"
- **N3-FAIL:** "the strip at `q ∈ ω(u)` fails only at a leaving centre; there `C` allows only the unit arcs' inner colours inside, outer outside"
- **N3-ANTI:** "CE5 (the Antipodal Lemma) survives unit arcs, by counting in-votes"
- **N3-COR3:** "a close complementary pair of cubic trichromatic vertices sits on a unit rhombus whose other corners are four-colour double leaving centres"
- **N3-I / N3-II / N3-P′:** "(i) never fails; (ii) fails only at a four-colour or repeated-colour vertex; same-multicolour cubic trichromatic vertices are never at distance 1"
- **N3-STEP:** "along a stuck chain neither `λ` nor `υ` decreases and one of them strictly increases at every step"
- **N3-LEN:** "with every horn curvature in a finite set `K`, a chain has at most `2\|K\| − 1` vertices; a one-sided infinite chain carries infinitely many curvatures"
- **N3-RAYR:** "on an upward-infinite chain `−1/(k+1) ≤ λ_k < 0`: the horn at `P_k` needs a boundary arc of radius `≥ k+1` (mirror downward)"
- **N3-PER:** "a doubly periodic valid map has a periodic terminal modification (so finitely many arc classes)"
- **N3-END:** "a stuck chain's end with horn bound `−1` has a four-colour, repeated-colour vertex one step beyond and a both-kind unit arc centred two steps beyond (or is the doubly bounded one-vertex chain)"

"The base" is row 134's (S–V Cor. 1 almost everywhere, as FS110-CB, CD and CE derive it). "A both-centre", "a leaving centre", `C`, "in-votes", "(i)" and "(ii)"
are the side's round-3 terms: where a statement uses a term defined only in the fenced section, derive it under the most natural reading and name the reading.

**After stage 1 is committed:** read N3's section and tools and list every divergence (truth, scope, grade) with both addresses — your brief's stage 2.
