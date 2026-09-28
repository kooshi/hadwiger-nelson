#!/usr/bin/env python3
"""X1 stage 5, item 9: apply each close's proposed ticks to its inventory, and give the coordinator-logged items after them their where.

A ticked item's status becomes "<tick> (<close job>, `<ticks file>`)" (FS-112's form, "done (FS112-C, ticks.md)"); a status that already
carries a parenthetical detail keeps it, the tick appended after "; ". Run from anywhere:  python3 data/workflow3/x1/file_inventories.py [--dry]
"""
import re, sys
from common import read, write

X1 = "`plans/WORKFLOW3-X1-front-page.md`"
LATER = {  # the coordinator-logged items with no proposed tick: status "done (<where>)"
    "plans/FS114-close-inventory.md": {
        123: "done (the closes' `derivation:` ids carry the prefix; the census passes on them: X1 stage 2, " + X1 + ")",
        124: "done (`plans/WORKFLOW3-TB1-ledger-check.md` §2.2; the census re-run at the filing, exit 0: X1 stage 2)",
        125: "done (filed at the close by X1, " + X1 + " stages 2–5)",
        126: "done (filed at the close by X1, " + X1 + " stages 3–4, with F1, F9, F3, F2 and F6)",
    },
    "plans/FS111-close-inventory.md": {
        40: "done (the closes' `derivation:` ids carry the prefix; the census passes on them: X1 stage 2, " + X1 + ")",
        41: "done (`plans/WORKFLOW3-TB1-ledger-check.md` §2.2; the census re-run at the filing, exit 0: X1 stage 2)",
        42: "done (filed at the close by X1, " + X1 + " stages 2–5)",
        43: "done (filed at the close by X1, " + X1 + " stages 3–4, with F1, F9, F3, F2 and F6)",
    },
}
JOBS = {"plans/FS114-close-inventory.md": ("FS114-C", "data/fs114/fs114-c/ticks.md"),
        "plans/FS111-close-inventory.md": ("FS111-C", "data/fs111/fs111-c/ticks.md")}


def main(dry):
    for inv, (job, tk) in JOBS.items():
        ticks = {}
        for l in read(tk).split("\n"):
            if re.match(r"\| \d+ \|", l):
                c = [x.strip() for x in l.strip().strip("|").split("|")]
                ticks[int(c[0])] = c[2]
        lines = read(inv).split("\n")
        seen = set()
        for k, l in enumerate(lines):
            m = re.match(r"\| (\d+) \|", l)
            if not m:
                continue
            n = int(m.group(1))
            assert l.endswith(" |")
            i = l.rstrip(" |").rfind(" | ")
            head, status = l[:i], l[i + 3:-2]
            if n in ticks:
                add = f"{ticks[n]} ({job}, `{tk}`)"
                new = (status + "; " + add) if re.match(r"done \(", status) else add
            elif n in LATER[inv]:
                new = LATER[inv][n]
            else:
                continue
            lines[k] = f"{head} | {new} |"
            seen.add(n)
        want = set(ticks) | set(LATER[inv])
        assert seen == want, sorted(want ^ seen)
        nums = [int(re.match(r"\| (\d+) \|", l).group(1)) for l in lines if re.match(r"\| \d+ \|", l)]
        assert set(nums) == want, sorted(set(nums) ^ want)   # every item ticked or given its where
        print(f"{inv}: {len(seen)} items set ({len(ticks)} proposed ticks, {len(LATER[inv])} later items)")
        if not dry:
            write(inv, "\n".join(lines))


if __name__ == "__main__":
    main("--dry" in sys.argv)
