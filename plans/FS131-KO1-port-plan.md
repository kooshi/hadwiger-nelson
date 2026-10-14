# FS131-KO1 — the plan for porting `[OAIMath2026]`'s transfer proof, so that two declared outside theorems become theorems under their present names

*de Bruijn, the planner; job FS131-KO1 (brief: `data/fs131/briefs/FS131-KO1-port-plan.md`, committed on `main` at
`36a0ddd06`). Branch `fs131-wp1`, cut from `main` at `747e139d0` in the worktree `.claude/worktrees/fs132-wi1`.
Working files: `data/fs131/ko1/`. The outside release is `[OAIMath2026]` family 158 at commit
`adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read, never written or run), compiled at its
own pin by the audit (`/home/kooshi/.cache/ext-oai1/lean`, read only).*

## Theorems this phase proved

None. A planning job: the cone, the overlap map, the switch, a trial of generated modules (the release's lemmas,
kernel-checked at this pin by elaboration, not this project's mathematics, and not part of the library), and the plan.

## Stage 1 — SAVED: the readback

**1.1 The branch.** The brief names `main` at `955b0bdda`; `main` had moved to `747e139d0` by launch (four commits:
FS131-FC3's filing and this brief's own commit `36a0ddd06`). No `.lean` file, `lakefile.toml`, `lake-manifest.json` or
`lean-toolchain` differs between `955b0bdda` and `747e139d0` (`git diff --stat … -- '*.lean' lakefile.toml
lake-manifest.json lean-toolchain`: empty), so the branch is cut from `747e139d0`, which holds the brief and the
current `LEAN.md` (sixteen lines filed by FC3, read in full at launch).

**1.2 The compiled library** — copied from `.claude/worktrees/fs131-wrc` (branch `fs131-f3` at `64ec24c16`, the tree
whose gate passed last; read only there). Its Lean sources are this branch's: `git diff --stat 64ec24c16 747e139d0 --
'*.lean' lakefile.toml lake-manifest.json lean-toolchain` is empty. `data/fs131/ko1/copy/copy-build.sh`: sha256 of
every file of the source's `.lake/build` before the copy, `cp -a`, sha256 of every file of the copy, sha256 of the
source again after; **20,712 files, the three listings identical** (`cmp` exit 0 twice; `data/fs131/ko1/copy/status.txt`;
the three listings hash alike, `listings.sha256`; one is kept, `build-files.sha256.xz`). `.lake/packages` is the main tree's,
by the tree's existing symlink.

**1.3 The brief's quotations** — `tools/fs131_ko1_readback.py` (each quotation, its lines joined, a substring of its
source; where the source names a section, the quotation lies under that heading): **5 matched, 0 mismatched**, exit 0
(`data/fs131/ko1/readback-brief.out`) — W4 against `data/fs131/REQUEST-2026-10-13.md`; the two rows of the audit's
table, each under `§ The pieces to adopt, and what each rests on (measured)` of `plans/EXT-OAI1-audit.md`; items 728
and 718 against `plans/FS131-close-inventory.md`. `--fault` (the last character of each quotation changed): 0 matched,
5 mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief.

**1.4 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the
gate fail; the audit `plans/EXT-OAI1-audit.md` stages 3, 4, 6 and 8 whole (the cone by text, the build, the proof's
shape and module graph, the pieces to adopt); `Outside/OAI158.lean` whole (the declared module on `main`); on the
density equality's branch `fs133-wb1` (tree `.claude/worktrees/fs133-wk1`, at `8ed85e9b8`, read only)
`Outside/OAI158Rigidity.lean` ll. 1–200 (the six copied definitions, the axiom, `residual_fourier_cross`, the model's
first helpers) and the generator `tools/fs133_ia1_port.py` whole; the three earlier ports' records at the places below.

**1.5 What each earlier port did at this pin** (the pattern this plan extends).

| port | generator | what it copied | patches at this pin | what it added to the method |
|---|---|---|---|---|
| FS132-K1 → FS132-I2 (on `main`, landed by FS132-L2) | `tools/fs132_k1_port.py`, `tools/fs132_i2_port.py` | the cone of four palette lemmas: 163 + K1's declarations, 1,791 source lines, in nine modules `Outside/OAI158Palette` … `OAI158States`, one per release file (`OAI158Palette` holds three) | 7 proof patches and 1 rename (`Set.domRestrict` → `Set.restrict`, on 32 lines, 19 in statements of intermediate lemmas, by ruling) — one fix per ~220 lines | the cone from the release's compiled constants (`ConeDump.lean`: `DECL`, `CONE`, `EDGE` lines); copy by line range; refuse a patch to a statement or a definition; imports from `ImportsDump.lean`; the definitions already in `Outside/OAI158` replaced by a `--` comment; a read-back across pins (`tools/fs132_i2_readback.py`) as an instrument |
| FS133-IA1 (on `fs133-wb1`, not landed) | `tools/fs133_ia1_port.py` | the cone of 25 targets in three release files, 48 declarations, 314 lines, one module `Outside/OAI158Transfer` | 5 proof patches (two renames, an unused simp argument, one Mathlib lemma that gained a hypothesis) — one per ~60 lines; 11 min 32 s from the generator's first line to a clean elaboration | the two release namespaces made one, a collision refused; `UPSTREAM` definitions checked to be declared upstream; `AUX_UNPORTED` (a generated `._proof_n` the release's elaborator shares across a file); `SCOPED` / `GLOBAL_INSTANCES`, every instance in exactly one; and the finding that the import list, not only the pin, chooses a stored statement's instance path (the two `CStarAlgebra` imports); leaf R: the release's stored statement rebuilt at this pin and checked by this kernel to be definitionally the declared one |
| FS131-IE1 (family 015, on `fs131-we1`) | `tools/fs131_ie1_port.py` | three whole files and three declarations, 72 declarations, 947 lines | 7 one-token renames, predicted exactly by its planner's trial | whole files read off the text (a declaration starts at a column-0 keyword); a scan for anything that runs code at elaboration before any copy; imports measured per module (`--mathlib-whole`, then the import dump, then elaboration); `DROP_OPEN` for namespaces absent under the module's imports |

Prices against practice in all three: the port's text was green within the first hour each time; what cost more was
the read-back across pins (FS132-I2) and the instance-path question (FS133-IA1).
