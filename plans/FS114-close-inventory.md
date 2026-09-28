# FS-114 close inventory (opened by the milestone planner FS114-P, 2026-09-27, from `plans/FS112-close-inventory.md`'s header; WORKFLOW 5 — the owner is its only writer until the close)

*Milestone: FS-114, the unit-arc question (its central statement, the global step): can a six-map with unit arcs have a vertex of four colours or a
repeated colour within 3 of every point? (`plans/STUB-global-step.md`; plan `plans/FS114-unit-arc-question.md`). One line per item with its source.*

## Items

| # | kind | item | source | status |
|---|---|---|---|---|
| 1 | owner ruling | **Kooshi, 2026-09-28 ~03:45 UTC, on the held Sirgedas fetch:** *"I found that the google group is still there, and I can see it. Want to use my chrome profile to archive it?"*, then *"rather than use that, can you just use a script or playwright to load my profile and surgically download that group? I don't want to hand over my whole browser."* The group proved public, so **no profile was used**: Playwright drove system Chrome headless in a fresh, empty profile with a host allow-list (`tools/fetch_hn_google_group.py`). All 11 conversations archived, every message count matching the listing, plus 2 attachments: `~/source/library/hadwiger-nelson-problem-group/` (README). Drive, YouTube and imgur links out of the threads not fetched | Kooshi; owner | done |
| 2 | prior-art debt | **Sirgedas's non-Siamese attempt is held, unread**: a tile-by-tile searcher, thread "Graph Coloring by Simulation" (`threads/J_Tw1_hUxQI.txt`; "siamese" at lines 715, 4378, 4409, 4504, 4888). `BIBLIOGRAPHY.md`'s row updated to "Held, unread". Sent to FS114-P for §PA | owner | open |
| 3 | prior-art debt | `[Higuchi2001]` and `[Mohar2002]` cited in `plans/FS114-unit-arc-question.md` and not in `BIBLIOGRAPHY.md` (`bib_audit` FAIL, 2026-09-27 ~22:55); the planner's touch list excludes the bibliography, so the rows are owed at the close or by the owner | `tools/bib_audit.py` | open |
| 4 | prior-art debt | From FS-112's front page (FS112-X): `[Oostema2020]`'s last page ("389"; OpenAlex reads 355, a record defect) unchecked | `plans/FS112-close-inventory.md` item 79 | open |
