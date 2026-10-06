#!/usr/bin/env python3
"""FS131-IF1: bring `scripts/axioms-controls.txt` to the library's state with no declared import.

The three controls that read the library's state return to FS131-T3's values (`a09b2254`): `baseline` 0/0/0 with the
older-form digest matching, `imported_declared` 1/1/1, `banner_dropped` with no consequence beyond the banner itself.
Run once, from the worktree's root; each replacement must match exactly once or the script stops."""
p = 'scripts/axioms-controls.txt'
s = open(p).read()


def rep(a, b):
    global s
    assert s.count(a) == 1, (a, s.count(a))
    s = s.replace(a, b)


rep("""# The `baseline` and `imported_declared` counts, and `banner_dropped`'s two consequences, read the library's state: one declared
# import (`falconer_lemma2_nonempty`, FS-131 wave 2) with four IMPORTED records (FS131-I2n, inventory items 259–260). A later
# import moves them again (item 259's tool defect owed).
""", """# The `baseline` and `imported_declared` counts, and `banner_dropped`'s consequences, read the library's state: no declared
# import (FS131-IF1: the first, `falconer_lemma2_nonempty`, is a theorem), so the shipped audit's IMPORTED section is empty and
# every IMPORTED control plants its own axiom. A later import moves them again — per declared import, `declared` and `library`
# rise by one in both controls and `imported` by its records, the `old` digests' texts follow, and `banner_dropped` gains
# `FAIL outside-banners <one of its records>` and `FAIL stale-declaration <the axiom>` (FS131-I2n's edit, `082f86c9`, is the
# pattern; item 259's tool defect owed).
""")
rep("""## control baseline
## expect PASS
## expect COUNT imported=4
## expect COUNT declared=1
## expect COUNT library=1
## digest old 0 the sentence is in its older form, which records no imported count, and the audit has 4 imported
""", """## control baseline
## expect PASS
## expect COUNT imported=0
## expect COUNT declared=0
## expect COUNT library=0
## digest old 0 match (clean and purchases compared; the sentence is in its older form
""")
rep("""## control imported_declared
## expect PASS
## expect COUNT imported=5
## expect COUNT declared=2
## expect COUNT library=2
""", """## control imported_declared
## expect PASS
## expect COUNT imported=1
## expect COUNT declared=1
## expect COUNT library=1
""")
rep("""## digest old 0 the sentence is in its older form, which records no imported count, and the audit has 5 imported
""", """## digest old 0 the sentence is in its older form, which records no imported count, and the audit has 1 imported
""")
rep("""## control banner_dropped
## expect FAIL banners IMPORTED
## expect FAIL outside-banners falconer_reduction
## expect FAIL stale-declaration falconer_lemma2_nonempty
## drop-banner IMPORTED
""", """## control banner_dropped
## expect FAIL banners IMPORTED
## drop-banner IMPORTED
""")
open(p, 'w').write(s)
print("controls edited")
