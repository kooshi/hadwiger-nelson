# FS112-YB3 — round-3 blind verification of FS-112's construction side (the chain's end at a unit arc; the two pinned corners)

*Job FS112-YB3, de Bruijn on Opus 5.5, launched 2026-09-27 at HEAD `8f01c225`. Brief: `data/fs112/briefs/YB112-verify-construction.md`, overridden by the
instance file `data/fs112/briefs/YB3-112-instance.md`, with `data/fs112/briefs/STANDING-RULES.md`. The side verified is FS112-Y3 (round 3); its record,
tools and outputs stay fenced until my step 3 (every verdict below on Y3's nine claims) is committed. Every object below is a local fragment, not a map
of the plane.*

## Theorems this phase proved

*(filled at the end of step 3; one line per theorem, its grade and its address)*

## Would have searched here (standing rule 3)

*(one line per move I would have made by search, and what I did instead)*

## Fence log (standing rule 13; brief § Fences; instance)

1. Start-up, `git log --oneline -8` (to see whether I was resuming) printed one commit subject **beyond the start-up snapshot `8f01c225`**:
   `1cc4986f FS-112 inventory: YB3 launched` — a neutral subject; nothing else of it read. Logged as a touch of `git log` beyond the snapshot.
2. Start-up, `ls data/fs112/briefs/` printed the **file names** of the briefs (the fenced ones by name only: A112, A2-112, A3-112, N112, N2-112, N3-112,
   NB*, P112, PA112, Y2-112, Y3-112, YB112-instance, YB2-112-instance); none opened but mine, my instance file and `STANDING-RULES.md`.
3. Start-up, `ls data/fs112/` printed **directory names**, among them the fenced `fs112-a`, `fs112-a2`, `fs112-a3`, `fs112-n`, `fs112-nb`, `fs112-nb2`,
   `fs112-y`, `reports` — names only; nothing in the fenced ones listed, opened or grepped. `ls data/fs112/reports/ | head -0` printed nothing.
4. Read in full, open to me by the instance: `plans/FS112-Y-construction.md` (it holds rounds 1–2 only: Y's stages 1–2 and Y2's § Continuation, ll. 1–651;
   no Y3 text), `plans/FS112-YB-verification.md` (in parts: head, stages 3–4), `plans/FS112-YB2-verification.md` (in full).
5. My scratch directory is `scratchpad/fs112-yb3/`; nothing else in the shared scratchpad was listed or opened.

## Stage 1 — SAVED: reading; the quotation check

### 1.1 Read from disk, in this order

`STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors **from disk** (296,992 bytes at `8f01c225`; link 2 on disk carries the
`[GwynStavrianos2022]` sentence my context's snapshot lacks; I work from disk), G20, G21, G22, G60 (unchanged from my snapshot); `LEDGER.md` rows
133–134 as the claim list quotes them; `data/fs112/claims.md` **in full** (§0, §3 and §7 closely); `plans/FS112-unit-arc-half.md` stage 5 (§§5.1, 5.2,
5.4–5.7 and the addendum; **not §5.3**); `plans/FS112-PA-reading.md` (stages 4 and 8); `plans/FS112-Y-construction.md` ll. 1–651 (Y and Y2);
`plans/FS112-YB2-verification.md` in full; `plans/FS112-YB-verification.md` stages 1, 3, 4; **FS-110's chain in its proof record**,
`plans/FS110-N-proof.md` stage N4-2 (§§2.1–2.8: N4-SHADOW, N4-FLANK, N4-SHAVE, N4-RAY, N4-STUCK, N4-PROP, N4-FIN, N4-TERM) and the statements in
`plans/FS110-derivation.md` ll. 50–100; `[AxenovichEtAl2014]` p. 8 (text layer); `[Polymath2021]` pp. 194, 197–200 (PDF pp. 30, 33–36, text layer).
The frozen FS-110 tools and YB2's checker are read at stage 2, where I use them.

### 1.2 Quotation check (standing rule 5) — `tools/fs112_yb3_quotes.py`, output `data/fs112/fs112-yb3/quotes.out`

19 quotations: the brief's `[AxenovichEtAl2014]` sentences; the standing rules' five Kooshi quotations; C-CHAIN-8 and C-CHAIN-9 (which the claims
build on); the two GAPs of Y2 that Y3-STRIPCUT and Y3-DISK-T* answer; and **the instance's nine Y3 claims**.
- **9 FOUND verbatim** (whitespace, typographic quotes, backticks normalised).
- **1 punctuation-only difference**: standing rule 4's *"A proven theorem about why its impossible is also valid. All novel knowledge is a success."*
  carries a terminal period inside the quotation marks that `CLAUDE.md` (Frontier item 23) does not have — the words exact (YB2 found the same).
- **9 FENCED**: the nine Y3 claims are quoted from `plans/FS112-Y3-construction.md`'s table, which I may not open before step 3; they are checked
  after step 3 (`--after-step3`), at stage 5.
- `--self-test` (`quotes-selftest.out`): one word altered in the Axenovich quotation turns it MISSING while its faithful twin is FOUND.

**No paraphrase found in my brief, instance or standing rules.** One naming point: the instance says to use YB2's labels for the disk and YB's for the
strip where a symbol is defined only in the fenced record. `T*`, `T2_0`, `Y_0`, `Z^L_0`, `C_k` are **defined in Y2's section**, which is open, so I use
Y2's labels for them (the claims' own words); the correspondence with YB2's labels is stated at stage 2 so that either can be read. `N`, `E`, `q2`, `K`
are defined in the claims' own text; I take the readings stated at stage 3.

## Stage 1 — SAVED
