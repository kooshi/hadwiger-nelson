# FS129-L1 — the Lean backlog's input: record

*The Clerk, Sonnet 5.5, 2026-10-03. Brief: `data/fs129/briefs/FS129-L1-backlog.md`. Script: `tools/fs129_l1_backlog.py`. Output: `plans/LEAN-BACKLOG.md`. Everything in the output is read from files by the script; nothing is judged.*

## Theorems this phase proved

none — a filing job.

## Stage 1 — SAVED (readback)

### The brief's quotations against their sources

Compared as whitespace-normalised substrings (line breaks joined), by a one-off python check:

| quotation in the brief | source | result |
|---|---|---|
| Kooshi's four answers, "1. yes, we don't want O(N^2) here. … so it'll pick up the latest changes." (§ Why this job) | `plans/FS129-cross-application-audit.md` § 1 (the decisions block, line 14) | identical |
| the plan's Stage 6 sentence, "`plans/LEAN-BACKLOG.md`: `lean-order.md` with stage 4's merges applied, each statement quoted by script from its derivation file, each" (the brief gives it as § 3. The shape) | same file, Stage 6, lines 96–98 | identical |
| the coordinator's words, "the audit prepares its input — the build order from the dependency map, and the merged and strengthened statements — so that the backlog formalizes each statement once, in its strong form" | same file § 1, question 3 (line 25) | identical |
| the sentence's continuation, "with its *not claimed* line and its upstream ids" | same file, Stage 6, line 98 | identical |

No mismatch. Two small findings about the brief, neither a defect in a quotation:
- the Stage 6 sentence sits under `## 3. The shape: one index, three passes, then the record` in the plan; the brief's address `§ 3. The shape` is right;
- the brief says the order has 178 entries and that three seeds are conditional: `data/fs129/index/lean-order-corrected.md` has 178 table rows, 78 SEED roles and three roles reading "SEED (conditional: handoff begins `none`)" (FS116-Y4-SPOKE, TC1-SQRT3-DYADIC, TC1-STANDING-FIVE), as inventory item 13 says.

### What a row of § The order must contain, in my words

Each row stands for one entry of the corrected Lean order, in the corrected file's order (dependencies first). It carries: the entry's id; its address (`plans/<file>:<line>`, the line of its header); its role as the corrected file writes it (SEED, upstream, ROUTE-ONLY, CYCLE, or a seed marked conditional); the statement exactly as filed, taken by the script from the derivation file (for an entry in the older grammar the header's own words, since such an entry has no `statement:` field), with any dated erratum or correction filed under the entry quoted below it; the *not claimed* line exactly as filed (empty where the entry has none, and listed); its grade and its minds as filed; its upstream ids, which are the order file's `needs`; its `handoff:` (or, in the older grammar, `*Kernel:*`) line, since the conditional seeds and the backlog read it; and the merge notes, each the audit's own line, quoted with its list address, where a merge or a "do not formalize as stated" applies. Cautions are attached by their inventory item.

The order's source is `data/fs129/index/lean-order-corrected.md`, never `lean-order.md`. The derivation text comes from `plans/*-derivation.md` through the census parser (`tools/fs71_ledger_b_check.py` and, for the newer grammar, the Ephodos gate it imports). The merges come from the four audits' lists (SR1 § 6.2, SR2 § 4.3, SA1 § 6.3, SR3 § 5.1), copied by the script into `data/fs129/l1/merges.csv` with their addresses.

### Reading budget

The brief's reading list fits: the script reads the files itself. I read the four audits' list sections, the inventory items named, the corrected order and its README, and the census and gate sources, in part.
