#!/usr/bin/env python3
"""FS131-L10B: `scripts/axioms-controls.txt` brought to the joined state — one declared import
(`StandingFive.kloosterman_bound`, wave 10) with eight IMPORTED records. Exact replacements, each matching once
(the pattern of FS131-I2n's `082f86c9` and of FS131-IF1's `data/fs131/if1/controls-edit.py`). The file as merged is
`fs131-wf1`'s: no declared import (0 / 0 / 0, 1 / 1 / 1, the banner alone)."""
import sys
p = 'scripts/axioms-controls.txt'
t = open(p, encoding='utf-8').read()
E = [
 ("# The `baseline` and `imported_declared` counts, and `banner_dropped`'s consequences, read the library's state: no declared\n"
  "# import (FS131-IF1: the first, `falconer_lemma2_nonempty`, is a theorem), so the shipped audit's IMPORTED section is empty and\n"
  "# every IMPORTED control plants its own axiom. A later import moves them again — per declared import, `declared` and `library`\n",
  "# The `baseline` and `imported_declared` counts, and `banner_dropped`'s consequences, read the library's state: one declared\n"
  "# import, `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207; FS-131 wave 10, FS131-L10B's join), with eight IMPORTED records.\n"
  "# (The first import, `falconer_lemma2_nonempty`, is a theorem since FS131-IF1.) A later import, or this one's proof, moves them\n"
  "# again — per declared import, `declared` and `library`\n"),
 ("## control baseline\n## expect PASS\n## expect COUNT imported=0\n## expect COUNT declared=0\n## expect COUNT library=0\n"
  "## digest old 0 match (clean and purchases compared; the sentence is in its older form\n",
  "## control baseline\n## expect PASS\n## expect COUNT imported=8\n## expect COUNT declared=1\n## expect COUNT library=1\n"
  "## digest old 0 the sentence is in its older form, which records no imported count, and the audit has 8 imported\n"),
 ("## control imported_declared\n## expect PASS\n## expect COUNT imported=1\n## expect COUNT declared=1\n## expect COUNT library=1\n",
  "## control imported_declared\n## expect PASS\n## expect COUNT imported=9\n## expect COUNT declared=2\n## expect COUNT library=2\n"),
 ("## digest old 0 the sentence is in its older form, which records no imported count, and the audit has 1 imported\n",
  "## digest old 0 the sentence is in its older form, which records no imported count, and the audit has 9 imported\n"),
 ("## control banner_dropped\n## expect FAIL banners IMPORTED\n## drop-banner IMPORTED\n",
  "## control banner_dropped\n## expect FAIL banners IMPORTED\n## expect FAIL outside-banners kloostermanBound_of_ringChar_ne_two\n"
  "## expect FAIL stale-declaration kloosterman_bound\n## drop-banner IMPORTED\n"),
]
for old, new in E:
    if t.count(old) != 1:
        sys.exit(f"REFUSED: matched {t.count(old)} times: {old[:70]!r}")
    t = t.replace(old, new)
if '--check' in sys.argv:
    print(f"controls-edit --check: PASS ({len(E)} edits); nothing written"); sys.exit(0)
open(p, 'w', encoding='utf-8').write(t)
print(f"controls-edit: written ({len(E)} edits)")
