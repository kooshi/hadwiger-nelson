# FS114-Y2 — the construction side of FS-114, round 2 (the meeting point, from the other end)

*Job FS114-Y2 (de Bruijn, Opus 5.5), 2026-09-28, from `data/fs114/briefs/Y2-114-construction-round2.md`, the round-2 card
`data/fs114/briefs/ROUND2-card.md`, FS114-Y's brief `data/fs114/briefs/Y114-construction.md` and `data/fs114/briefs/STANDING-RULES.md` (all
four read in full, rule 0 first). Working files `data/fs114/fs114-y2/`; exact checks `tools/fs114_y2_*.py`; my scratch
`scratchpad/fs114-y2/` (regenerable only). Every verdict here is about a possible object: the class of valid maps is not known to be non-empty.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| (filled stage by stage) | | | |

## Would-have-searched-here log (standing rule 3)

- (filled stage by stage)

## Fence log (standing rule 13; the brief's § Fences)

1. At start-up `ls plans/FS114* data/fs114/ data/fs114/*` listed, by **name only**, the fenced `plans/FS114-N-proof.md`,
   `plans/FS114-NB-verification.md`, `plans/FS114-close-inventory.md`, the directories `data/fs114/fs114-n`, `fs114-n2`, `fs114-nb` with their file
   names (`count.out`, `quotes.out`, …), `data/fs114/reports/` with its six file names, and the brief file names in `data/fs114/briefs/` (among them
   the proof side's round-2 brief `N3-114-proof-round2.md`). Nothing in them was opened or grepped.
2. At start-up `git log --oneline -15` showed ten commit subjects beyond the five of the start-up snapshot (all neutral: `FS114-N2: stage 2/3`,
   `FS114-YB: stage 1a/1b/1/2`, `FS114-NB: stage 1/2`, `FS-114 inventory: …`, `YB instance: date`). Subjects only; no `git log -p`.
3. `ls tools/fs114_* tools/fs112_*` listed by name the proof side's round-1 tools (`tools/fs114_n_count.py`, `fs114_n2_count.py`, `fs114_nb_*`,
   …). Not opened.
4. FS114-Y's quotation tool reads a paper text from FS114-Y's scratch subdirectory (`scratchpad/fs114-y/sv.txt`), a file this job did not create;
   so I did **not** run it and wrote my own (`tools/fs114_y2_quotes.py`), regenerating the text into `scratchpad/fs114-y2/`.

## Stage 1a — SAVED: reading, the quotation check, and the shared result from FS114-CV

### 1a.1 Read from disk, in this order (reading status per section, G50)

- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first; `CLAUDE.md` § The aim and § Counter-priors in context from disk at start-up); my round-2
  brief; the card; FS114-Y's brief.
- `plans/FS114-Y-construction.md`, in full; `plans/FS114-YB-verification.md`, in full (with YB's rainbow third-case fragment, `tools/fs114_yb_run2.py`
  `rainbow()` and `data/fs114/fs114-yb/rainbow.out`; the checker's header, `tools/fs114_yb_exact.py` lines 1–80).
- `plans/FS114-unit-arc-question.md` §G part 3, §IQ, 5.0–5.4 (5.3 open to this job, per my brief).
- `data/fs114/claims.md`, in full.
- `plans/FS112-Y-construction.md` stages 4–5 (the disk's rules, tiles, colours and read-off), for the disk's four-colour corners' edges.
- `plans/FS114-CV-verification.md`: the theorem table's CV-EXISTS row and the rows at lines 189–192 (after the owner's message; see 1a.3).

### 1a.2 Quotation check (standing rule 5)

`tools/fs114_y2_quotes.py`: **21 of 21 FOUND** (`data/fs114/fs114-y2/quotes.out`) — Kooshi's three quotations and Question 2 in FS114-Y's brief
(Question 2 against the claim list and against the paper's text); the standing rules' four Kooshi quotations; the card's seven sentences this record
works (K1, K2, the extreme's shape, the tactic-edge sentence, the charge sentence, repeat (A), the meeting point); the claim list's C114-LOCAL-F and
de Grey's Siamese definition; CV-EXISTS, FS114-Y-PAIRSHARE and YB's third rainbow case from their open records. Self-test PASS
(`quotes-selftest.out`: an altered word MISSING, its faithful twin FOUND, the faithful quotation against the wrong file MISSING).
**What cannot be checked:** the card's statements about the proof side (N114-RD, N114-EULER, N2-SLACK, N2-ENDS, N2-KILL, N2-GSD, N2-VCAP, N2-DIAM)
are the owner's quotations or summaries of fenced records; I work them **as the card states them** and quote the card. My round-2 brief quotes nothing
but its own hand-back sentence.

### 1a.3 The shared result (the owner's message during stage 1a), and where it bears

FS114-CV's **CV-EXISTS** (one mind; `plans/FS114-CV-verification.md` theorem table, verbatim): "every valid map has a vertex of at least four colours —
in the map itself, no modification needed, no residue, no ray step". With it, the owner notes, C114-LOCAL-F alone is the NO. **Where it bears here:**
every fragment I build that holds a disc of radius `R` about a vertex of at least four colours is a point on C114-LOCAL-F's dial; only `R > φ²/√2 ≈
1.8512` (FS114-Y-DIAL, two minds) moves it. K1's fragment holds a four-colour vertex `p`, so its radius about `p` is read on that dial too.

## Stage 1a — SAVED

## Stage 1b (in progress): K1's killing test — registered before the first run (G21; both outcomes reachable)

**The second shared result** (the owner's message during stage 1b): FS114-CVB, blind, confirms CV-EXISTS (now two minds, blind to each other), needing
neither CV-HD nor C-ENDS; so C114-LOCAL-F alone is the unit-arc NO, Siamese or not, at two minds. Also, 2–1: in C114-THOM-TOP `M − x` stays connected at
a pinch point and breaks at a hole (`plans/FS114-CVB-verification.md`, open). Where it bears: as 1a.3 — every fragment here is read on C114-LOCAL-F's dial.

**The object** (`tools/fs114_y2_k1.py`, its docstring the rule in words): **the Reuleaux bowtie** — a vertex `p` where two Reuleaux triangles of width 1,
`t1 = (p, q1, q2)` and `t3 = (p, q4, q3)` (`q1 = e(30°)`, `q2 = e(−30°)`, `q3 = e(210°)`, `q4 = e(150°)`), meet corner to corner, with `t2` above and
`t4` below; all four edges at `p` are unit arcs about `q1…q4`. Twenty tiles, every point in `ℚ(√3)`, the design `D2`-symmetric with the colour maps
`(1 3)(5 6)` and `(2 4)(5 6)`. How each shape was derived (no search): §1b.1, written after the run.

**Registered predictions** (before the first run):
- faithful: **ACCEPT** on every same-colour pair; **no distinct same-colour pair at minimum below 1** (non-Siamese); every non-rim piece shared by exactly
  two tiles; the rim at distance at least `R0 = 3√3/5 ≈ 1.039` from `p`; `p` a degree-4 vertex of colours 1–4 whose four edges are unit arcs about
  `q1…q4`; each `q_i` a vertex of at least four colours (five: `t_in`, `W`, `T`, `V`, `L`); each `T_i` of the outer tile's colour, meeting the closed unit
  disc about `p` only at `q_i`. **Reachable otherwise:** a REJECT (the derivation of §1b.1 wrong at a named pair), a distinct pair at minimum below 1, a
  piece unmatched, a `T_i` touching its inner tile elsewhere.
- plant `v5` (`V` coloured 5, images by the colour maps): **REJECT exactly** `(L1,V)`, `(L4,V'')`, `(L2,V')`, `(L3,V''')`.
- plant `wide_t1` (the `T1 | W` edge leaves `q1` at 300° instead of 330°, all four images): **REJECT exactly** `(t4,T1)`, `(t4,T4)`, `(t2,T2)`, `(t2,T3)`.
