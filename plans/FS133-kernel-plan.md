# FS133-K1 — the kernel plan for the one-class transfer

*de Bruijn, the planner; job FS133-K1 (brief: `data/fs133/briefs/FS133-K1-kernel-plan.md`). The claim list is
`data/fs133/claims-K1.md`; the derivation is `plans/FS133-E1-derivation.md` (thirteen entries, one mind), read from the
start — this job is not blind. Working files: `data/fs133/k1/`. The outside release is `[OAIMath2026]` family 158 at
commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read, never written), compiled at its
own pin by the audit (`~/.cache/ext-oai1/lean`, EXT-OAI1).*

## Theorems this phase proved

None: a planning job. The skeleton's statements are typed and compile with `sorry` at every leaf (stage 4).

## Stage 1 — SAVED: the readback

**1.1 The brief against the claim list, the claim list against the derivation.** `data/fs133/k1/readback.py` (the
E1 job's tool does not read a source address that carries a `§` section, and is another job's; this one does both
readbacks):

- `readback.py brief` — the nine quotations of the brief, each quoted line a substring of its source: **9 matched,
  0 mismatched**, exit 0 (`readback-brief.out`). With `--fault` (the last character of each quoted line changed):
  0 matched, 9 mismatched, exit 1 (`readback-brief-fault.out`).
- `readback.py claims` — each `K133-<ID>` line of `data/fs133/claims-K1.md` against the `statement:` field of the
  entry `C133-<ID>` at the line number the claim list gives, wrapped lines joined; each `K133-NC-<ID>` against that
  entry's `not claimed:` field: **12 matched, 0 mismatched**, exit 0 (`readback-claims.out`); `K133-NC-ALL` has no
  entry (a line of the claim list's own) and is reported as such. With `--fault`: 0 matched, 12 mismatched, exit 1.

No mismatch, so no finding about the brief's quotations or the claim list's copies.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; both claim lists; the derivation whole
(894 lines); the release's `Ergodicity.lean` ll. 325–415, `Representations.lean` (outline, and ll. 165–193),
`Basic.lean` ll. 1–60 and 222–228, `BorelTransfer.lean` (outline, and ll. 59–68); `plans/EXT-OAI1-audit.md` stage 8's
"Not imported, and why"; the heads of `tools/fs132_k1_port.py` and `tools/fs132_i1_readback.py`.

**1.3 Each statement, its symbols resolved** — in § Stage 3, beside the Lean statement it became.
