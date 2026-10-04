#!/usr/bin/env python3
"""FS129-Z1: check that every lost theorem filed by the record job quotes its source verbatim.

For each entry: the statement's head (the text before " — " that introduces a quotation, or the whole statement) must occur in the
source's theorem line (a table row or a bullet), and every double-quoted segment of the statement must occur in the source file.
Whitespace is collapsed, the blockquote marker "> " and the table escape "\\|" are removed before comparing.

  python3 tools/fs129_z1_lost_check.py           expect "lost-check: 16 entries, 0 problems"
  python3 tools/fs129_z1_lost_check.py --fault   one statement altered in memory: must report a problem and exit 1
"""
import re
import sys
from pathlib import Path

PLANS = Path(__file__).resolve().parent.parent / "plans"
# entry -> (file it is filed in, source file, the source's theorem-line marker)
LOST = {
    "J45-N1": ("FS84-SI-D", "FS84-SI-D", "| J45-N1 |"), "J45-N2": ("FS84-SI-D", "FS84-SI-D", "| J45-N2 |"),
    "J45-SI-4": ("FS84-SI-D", "FS84-SI-D", "| J45-SI-4 |"), "J45-SI-5": ("FS84-SI-D", "FS84-SI-D", "| J45-SI-5 |"),
    "J45-SI-J": ("FS84-SI-D", "FS84-SI-D", "| J45-SI-J |"), "J45-SI-C": ("FS84-SI-D", "FS84-SI-D", "| J45-SI-C |"),
    "J45-SP-oi": ("FS84-SI-D", "FS84-SI-D", "| J45-SP-oi |"), "J45-SP-if": ("FS84-SI-D", "FS84-SI-D", "| J45-SP-if |"),
    "S1b": ("FS84-S1", "FS84-S1", "| S1b |"), "S1b-47": ("FS84-S1", "FS84-S1", "| S1b-47 |"),
    "S1d-K": ("FS84-S1", "FS84-S1", "| S1d-K |"), "S1e": ("FS84-S1", "FS84-S1", "| S1e |"),
    "X25B-PZ": ("FS100", "FS100-X25B", "- **X25B-PZ**"), "X25B-L1": ("FS100", "FS100-X25B", "- **X25B-L1**"),
    "X22D-FLK2": ("FS100", "FS100-X22D", "| X22D-FLK2 |"), "HOLE-t": ("FS106", "FS106-TQ", "- **HOLE-t / C-Q-HOLEa**"),
}


def clean(s):
    s = s.replace("\\|", "|")
    s = re.sub(r"(?m)^>\s?", "", s)
    s = s.replace("**", "")
    return re.sub(r"\s+", " ", s).strip()


def statement(path, name):
    lines = path.read_text().split("\n")
    for i, ln in enumerate(lines):
        if ln.strip() == f"derivation: {name}":
            out = []
            for l2 in lines[i + 1:]:
                if not l2.strip() or not l2.startswith(" "):
                    break
                m = re.match(r"^  ([a-z][a-z ]*?):\s?(.*)$", l2)
                if m and not l2.startswith("    "):
                    if out:
                        break
                    if m.group(1) == "statement":
                        out.append(m.group(2))
                elif out:
                    out.append(l2.strip())
            return " ".join(out)
    return None


def theorem_line(text, marker):
    for i, ln in enumerate(text.split("\n")):
        if ln.startswith(marker):
            block = [ln]
            for l2 in text.split("\n")[i + 1:]:
                if marker.startswith("- ") and l2.startswith("  ") and not l2.startswith("- "):
                    block.append(l2)
                else:
                    break
            return clean(" ".join(block))
    return None


def main(fault):
    bad = 0
    for name, (home, src, marker) in LOST.items():
        st = statement(PLANS / f"{home}-derivation.md", name)
        if st is None:
            print(f"MISSING {name} in {home}"); bad += 1; continue
        if fault and name == "J45-N1":
            st = st.replace("Haar-null", "Haar-positive")
        src_text = (PLANS / f"{src}-derivation.md").read_text()
        line = theorem_line(src_text, marker)
        head = clean(re.split(r" — (?:as |Lemma |its two)", st)[0])
        if line is None or head not in line:
            print(f"HEAD NOT IN SOURCE LINE {name}"); bad += 1
        for q in re.findall(r"\"([^\"]+)\"", st):
            if clean(q) not in clean(src_text):
                print(f"QUOTE NOT IN SOURCE {name}: {q[:60]}"); bad += 1
    print(f"lost-check: {len(LOST)} entries, {bad} problems" + (" (fault planted)" if fault else ""))
    return bad


if __name__ == "__main__":
    sys.exit(1 if main("--fault" in sys.argv[1:]) else 0)
