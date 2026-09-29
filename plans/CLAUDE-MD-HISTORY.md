# Text retired from `CLAUDE.md` as history — recorded, not loaded

*`CLAUDE.md` holds current state only, with its history in git (its header's rule). Text below left it verbatim when it was rewritten
to current state, so that `tools/claude_md_fact_audit.py`, which joins this file to its corpus, can confirm nothing was lost. Keryx is
this file's writer.*

## The size-budget paragraph, as it stood before 2026-09-28's budgets

*Replaced on 2026-09-28 when Kooshi set the budgets at 80 kB for `CLAUDE.md` and 200 kB for the grokkings file.*

**Size budget: keep this file under 300,000 bytes** (it applies: Kooshi suspended it for the 2026-09-26 reframe — *"Ignore the 300kB limit while you reframe the file."* — and it was restored at FS-106's close, 2026-09-27) (Kooshi, 2026-09-26, at the ×2×3 crunch's end, after it ran unbounded: *"the 300kB limit returns, and we'll likely need to find a way to extract what's not necessary, treat the grokkings there as a cache for a dedicated grokking file, or merge things to reduce it from here on out. There's just too much new knowledge to carry in every session."*; the same day he chose design (b) of `plans/PROPOSAL-claude-md-knowledge-cache.md` — *"Implement b on the file. Remove incidentals, keep intrinsics."* — and E1's pass took the file from 299,491 to 282,481 bytes: the second and later instances of rules to `plans/GROKKING-INSTANCES.md`, the "Not ours" list to `LEDGER.md`, the paths-forward rows ranked ≥ 30 to `plans/FRONTIER-STUBS.md` alone; E2's check restored two intrinsics the pass had moved (283,274), and F1's audit of the git history (Kooshi: *"It's been a long struggle to maintain the balance."*) restored the reasons and killing tests the compression passes since 2026-09-10 had cut, the stories to the same file (291,306 bytes); *"We'll revisit a cache implementation next time we hit the cap at a point where we're too dense to compress or remove further incidentals."*; at the 2026-09-25 crunch's end: back to 300,000 after a temporary 325,000 during it; the no-loss pass that followed took the file to 283,826 and found almost nothing more that touches no reasoning) (Kooshi, 2026-09-11: the budget is on *this file
itself*, not on the files it imports — there is a lot here worth remembering; raised from 150,000 to
200,000 on 2026-09-15 after a rule's reasoning was trimmed to fit and its loss cost hours, from 200,000 to 250,000
on 2026-09-17 with the file at 199,785 bytes, from 250,000 to 275,000 on 2026-09-21 with the file at 249,994 after a
no-loss compression pass measured its floor at about 228,000, and from 275,000 to 300,000 on 2026-09-25 with the file at 274,995
(*"It probably still won't be enough, but hopefully it'll buy time"*) — a ceiling reached is a ceiling that starts costing content,
and the current-state-only rule, not the byte count, is what keeps this file honest). The budget is
a ceiling and never a licence: the current-state-only rule above does the real work, and superseded text
comes out whether or not there is room for it.
