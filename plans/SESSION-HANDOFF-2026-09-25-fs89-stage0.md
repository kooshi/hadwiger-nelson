# Session handoff: FS-89 at Stage 0 (2026-09-25)

*Written by the product owner for a reader with no conversation memory. It supersedes `plans/SESSION-HANDOFF-2026-09-25-fs86-open.md`.
That file's §1 rules table still applies, with the additions in §1 below.*

## 0. First acts

1. **FS-89 Stage 1 is complete: RQ₄ and RQ₅ are proved, at hand grade, with every lemma re-derived blind (items 27, 28, 36, 37). The close planner is live** (item 40; brief `data/fs89/briefs/CL-close-planner-brief.md`). The close planner is the inventory's writer until it hands back. Then: review the close by artifact (hashes, the fact audit, the gates), push, and ask Kooshi about a next-step advisor.
   `…/scratchpad/owner-fs89/live-agents.md`; never quote them to Kooshi.
   - **Verifier G** is blind-checking the next-step advisor's gluing sketch.
     - Brief: `data/fs89/briefs/S0A-gluing-verifier-brief.md`. Record: `plans/FS89-S0A-gluing-verification.md`.
     - **Finished** (items 10, 12, 14): every verdict true; the rational statement is exactly equivalent to the uniform one over every field (a reduction, not an escape); the advisor's "one prime suffices" overclaims (the one-prime route also needs bounded torsion order).
   - **S0B** is computing the exact four-colour band set `Θ₄(U₅)` of the rational unit circle at the prime 5. Kooshi ruled this computation allowed under the ban.
     - Brief: `data/fs89/briefs/S0B-band-set-brief.md`. Record: `plans/FS89-S0B-band-set.md`.
     - **Finished** (items 13, 16, 17): `Θ₄(U₅) ⊄ T + A` (the order-3 points lie inside the parity disc at four colours), so one prime is not enough. Torsion orders are unbounded at one prime (a reading), and the prime 13 kills the one-switch escapes (derived). The rational statement is not refuted.
2. **Verify every agent commit hash against `git log`, push, and log each result in `plans/FS89-close-inventory.md`** (items 1–40 so far). You are its only writer. Check one step of every key claim yourself.
3. **Read, in this order:**
   - `plans/FS89-close-inventory.md`;
   - `plans/POROS-2026-09-25-fs86-next.md` (the advisor's recommendation Kooshi accepted);
   - `plans/STUB-isometric-measure-rigidity.md` (FS-89; the banner first);
   - `plans/FS86-dyadic-rigidity.md` §R-close;
   - `LEDGER.md` rows 88–94;
   - `CLAUDE.md` G74, G75, G76.

## 1. Rules in force (additions since the FS-86 handoff)

| rule | source |
|---|---|
| **The finite-witness-free week runs to 2026-10-01.** Kooshi ruled the exact band-set computation allowed. The ban's intent, in his words: "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time." | FS-89 inventory item 2 |
| **Work in stages, from the first turn:** short responses, and the working file saved after every step. At FS-86 a competitor lost three responses to the output-token limit, and no message reached it. | FS-86 inventory item 39; the protocol, sixth run |
| **Quote statements verbatim in briefs; never paraphrase.** Two paraphrases dropped conditions at FS-86. | FS-86 items 46, 67 |
| **Tell a competition's advisor of every stand-down and launch.** | FS-86 item 44 |
| **Quiet blind verifiers during a live competition:** briefs in the owner's scratch, no commits, reports to the owner only; competitor progress held in an owner scratch copy of the inventory and restored at hand-back. | FS-86 items 40–68 |
| Unchanged: three agents at most, all Opus 5.5; no child spawns children (in every brief, with the reason); replace above about 500k; content-free hand-backs; commit by explicit path, never amend; push freely, never force-push; frozen tools; `scripts/slot.py`; never `lake build`; halt on an unexplained crash. | earlier handoffs |

## 2. What comes after Stage 0 (the advisor's plan, Kooshi accepted)

- **If the gluing holds and S0B reports:** open the planner's reframe (WORKFLOW 3: §G, §PA, §IQ), with both Stage-0 records as input.
  - The milestone's object becomes **the rational statement**: every four-colour band character of `ℤ[U_ℚ]` is torsion plus archimedean.
  - Verifier G's caveat: that statement is the `F = ℚ` case and carries the same infinitely-many-split-places difficulty. The route is a reduction, not an escape.
  - The closed-set rigidity of Furstenberg and Berend is the lever. Read Berend 1983 and 1984 in full; add a `[Furstenberg1967]` entry.
- **The shape after Stage 0 is decided: one derivation agent plus a blind verifier** (Kooshi, inventory item 11: "Let's go ahead and try one agent plus verifier this time"). The planner designs Stage 1 in that shape.
- **If the gluing fails:** the advisor recommends FS-87 kernel work plus the T721 audit, keeping FS-89 as reading only.

## 3. Pending decisions for Kooshi (the defaults hold if he says nothing)

1. ~~Stage 1's shape~~: **decided** — one derivation agent plus a blind verifier (item 11).
2. **The name "de Grey's lattice"** (FS-89 item 5; `BIBLIOGRAPHY.md` § E). Default: keep it in closed records, and describe the lattice in new writing.
3. **FS-90's two sanctioned hours.** Default: T721's audit only if Heule's graph can be fetched; otherwise banked to 2026-10-01.

## 4. Where things stand

- **The record.** Ledger rows 1–94; grokkings G1–G76; stubs FS-1 to FS-90.
- **`CLAUDE.md`** is 274,970 bytes of 275,000. The next close must compress again.
- **The fact-audit base** for FS-89's close is 052707ac, the commit that opened `plans/FS89-close-inventory.md`. `--dupes` stands at 11.
- **Corrections owed at FS-89's close** (inventory item 4):
  - G76 and the FS-89 stub say "measure rigidity", but the problem is closed-set rigidity;
  - `[Furstenberg1967]` needs a bibliography entry;
  - FS-90 (b)'s price needs the step of obtaining the graph.
- **Carried:** the audit of `[AmbrusEtAl2023]`; reading debts (Soifer 2019, de Grey 2026, Haugstrup 2026, Berend 1984, Einsiedler–Lindenstrauss); the Johnson papers.
