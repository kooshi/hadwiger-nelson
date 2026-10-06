#!/usr/bin/env python3
"""FS131-I10F — the statement check: the four leaves' statements, and every declaration that stood in the three files
at the base commit, are byte-identical at the base commit and in the working tree.

What is compared, per declaration: the text from its keyword (`theorem` / `def`, with any attribute line) up to the
`:= by` / `:=` that opens its body (for a `def`, the whole definition up to the next blank line). The docstrings and the
proofs are not compared. A declaration present at the base and absent now is a failure; new declarations are listed.

Usage:  tools/fs131_i10f_stmt.py [--base 330d2f48] [--fault]
  --fault  plants a one-token change in the working-tree copy of one statement (in memory) and must exit 1.
Exit 0: every base statement is unchanged.  Exit 1: a difference (or the planted fault).
"""
import argparse
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FILES = [
    "Proofs/HadwigerNelson/Arith/ProductFactor.lean",
    "Proofs/HadwigerNelson/Arith/MajorityVote.lean",
    "Proofs/HadwigerNelson/Arith/NegCircleModel.lean",
]
LEAVES = ["contVec_prod_eq", "ae_eq_measurable_of_majority", "exists_parityHom", "negCircle_trivial_bot"]

DECL = re.compile(r"^(?:@\[[^\]]*\]\s*)?(?:private\s+|protected\s+|noncomputable\s+)*(theorem|def|lemma|abbrev|structure|instance)\s+(\S+)",
                  re.M)


def statements(text: str) -> dict:
    """name -> statement text (keyword line up to the body opener)."""
    out = {}
    for m in DECL.finditer(text):
        kind, name = m.group(1), m.group(2)
        start = m.start()
        rest = text[start:]
        if kind in ("def", "abbrev", "structure", "instance"):
            end = rest.find("\n\n")
            stmt = rest if end < 0 else rest[:end]
        else:
            # a theorem's statement ends at the first ":= by" or ":=\n" or " :=" at the end of a line
            mm = re.search(r":=\s*(by\b|$)", rest, re.M)
            if mm is None:
                raise SystemExit(f"no body opener found for {name}")
            stmt = rest[:mm.start()]
        if name in out:
            raise SystemExit(f"declared twice in one file: {name}")
        out[name] = stmt.rstrip()
    return out


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--base", default="330d2f48")
    ap.add_argument("--fault", action="store_true")
    args = ap.parse_args()
    bad = 0
    seen_leaves = set()
    compared = 0
    for f in FILES:
        base_text = subprocess.run(["git", "show", f"{args.base}:{f}"], cwd=ROOT, check=True, capture_output=True,
                                   text=True).stdout
        now_text = (ROOT / f).read_text()
        if args.fault and f.endswith("MajorityVote.lean"):
            # the fault goes inside the leaf's own statement: a helper stated earlier in the file carries the same
            # hypothesis text, and a change there is a change to a new declaration, which this check does not compare
            # (the first version of this fault landed there and did not fire).
            at = now_text.index("theorem ae_eq_measurable_of_majority")
            head, tail = now_text[:at], now_text[at:]
            assert "(hp : p < 1 / 2)" in tail
            now_text = head + tail.replace("(hp : p < 1 / 2)", "(hp : p ≤ 1 / 2)", 1)
        base, now = statements(base_text), statements(now_text)
        for name, stmt in base.items():
            compared += 1
            if name in LEAVES:
                seen_leaves.add(name)
            if name not in now:
                print(f"MISSING   {f} :: {name}")
                bad += 1
            elif now[name] != stmt:
                print(f"CHANGED   {f} :: {name}")
                bad += 1
            else:
                print(f"same      {f} :: {name}")
        for name in now:
            if name not in base:
                print(f"new       {f} :: {name}")
    missing_leaves = [x for x in LEAVES if x not in seen_leaves]
    if missing_leaves:
        print(f"LEAF NOT FOUND AT BASE: {missing_leaves}")
        bad += 1
    if compared == 0:
        print("NOTHING COMPARED")
        bad += 1
    print(f"compared {compared} base statements ({len(seen_leaves)} of {len(LEAVES)} leaves among them); differences: {bad}")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
