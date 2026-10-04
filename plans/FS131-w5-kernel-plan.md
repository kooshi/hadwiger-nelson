# FS131-K5 — wave 5's kernel plan: termination, the stuck chains' ends, row 134's base, density

*de Bruijn, the planner (FS131-K5), 2026-10-04. Brief: `data/fs131/briefs/FS131-K5-wave5.md`. Branch `fs131-w5` (worktree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5`), from `fs131-w4` at `9a8de899`. The model this record follows is
`plans/FS131-kernel-plan.md` § 6; wave 4's vocabulary is `plans/FS131-w4-kernel-plan.md` §§ 2, 3.2, 14.*

## Theorems this phase proved

None: a planning job. Every row of wave 5 is stated with `sorry` at its leaves; the foundation's definitions carry spec examples only.

## Stage 1 — SAVED: the readback

### 1.1 The brief's quotations against their sources (standing rule 3)

| quotation in the brief | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | verbatim |
| "3. **States every row at the class its argument reads** (G92), reports each widening …" | `plans/FS131-kernel-plan.md` § 7.3 item 3 | verbatim (the brief truncates mid-sentence, marked) |
| "4. **Names every hypothesis from outside the backlog** in the declaration's docstring and in § 7.4's list; never imports a hand result of ours as an" | § 7.3 item 4 | verbatim (truncated) |
| "69. **Ruling — FS112-C-DOUBLE moves from wave 4 to wave 5** (K4b, message 2026-10-04): its proof is "a sketch over FS112-Y3-END-NEEDS's levels with n reversed and" | `plans/FS131-close-inventory.md` item 69 | verbatim (truncated) |
| "- **FLANK-Q's discharge obligation** [inventory items 79–80, ruled 2026-10-04]: `flankQ_upper`, `flankQ_lower` take `hQR` — every arc of `Γ` on `ω(N)` (resp." | `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` § 14.5, first bullet | verbatim (truncated); the same text is in this worktree's copy |
| "191. **Ruling: IWd's slot goes to wave 5's planner (FS131-K5), now.** Choice: launch the planner. Alternative weighed: a second wave-4 implementer on a branch" | inventory item 191 | verbatim (truncated) |

No mismatch. The brief's paraphrase "and FS112-N3-END's chain clause ("and the chain is the single vertex", inventory item 74)" matches item 74's
words ("N3-END's "the chain is the single vertex" not stated (needs wave 5's stuck-chain vocabulary …)").

### 1.2 The rows, the merged rows, the obligations, the caution

The statements are quoted verbatim, each with its address, its errata and merge notes, in **`data/fs131/k5/rows.md`**, generated from
`plans/LEAN-BACKLOG.md` by `tools/fs131_k5_rows.py` (`--check`: OK, 18 rows; `--plant`, one id dropped: FIRED). The backlog copy in this
worktree is byte-identical to `main`'s. The 13 rows (CSV `data/fs131/k1/dispositions.csv`, wave 5, *formalize*): FS114-BV-HEX, FS114-CVB-THOM,
FS112-N3-COR3, FS112-ROTHEX, FS112-N3-BASE, FS112-N3-DENSE3, FS114-CV-EXISTS, FS129-OR1-LOCALDENSE, FS129-SR2-DISC1TS, FS114-CV-HD,
FS112-N2-TERM, FS112-C-ENDS, FS112-C-DOUBLE. Merged and carried: FS112-DISC1 → FS129-SR2-DISC1TS; FS112-N2-RED → FS112-N2-TERM ("RED's
procedure as TERM's lemma", SR2 item 13).

**Caution C116** governs FS112-C-ENDS, -C-DOUBLE, -N3-BASE: C-ENDS is formalized in its erratum's form ("*In a terminal valid map, the point of
the normal line one step beyond each finite end of a stuck chain has at least four colours.*", `plans/FS112-derivation.md:443` item 2);
C-DOUBLE's erratum (item 3) and N3-BASE's (item 5) are regrades only, changing no statement.

**The three obligations from wave 4** (§ 14.5 of its plan; inventory items 69, 74, 79):
1. FS112-C-DOUBLE with **FS112-Y3-END-NEEDS in its corrected form** as a supporting lemma, and the reading of its "terminal valid map" (`M*`
   or wave 4's `Terminal`) settled here.
2. **FLANK-Q unconditional**: `flankQ_upper`, `flankQ_lower` with `hQR` discharged from N2-TERM's clause 1.
3. **FS112-N3-END's chain clause** ("and the chain is the single vertex"), stated with the stuck-chain vocabulary.
And FS114-L60-WALK (merged into L60-LE, R8): its five consumers (FS112-N2-RED, -N3-COR3, -N3-BASE, -N3-DENSE3, FS114-CV-EXISTS) are stated
over `l60_le`'s non-strict bound — none of wave 5's statements reads a strict bound, so this holds by construction; its clause L60-D5 sits in
N3-BASE's setting and goes to the Row134Base job (§ 2.3).

### 1.3 The worktree builds as given

`./scripts/build.sh` under the slot (40 GiB, 8 cpus, `BATCH=4`): the result is in § 2.4 (run in the background while the foundation was
written; driver log `data/fs131/k5/build-stage1.log`).
