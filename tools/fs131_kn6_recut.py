#!/usr/bin/env python3
"""FS131-KN6 stage 4: the two draft claim lists the deriver's answers change, rewritten with every statement of the
deriver's COPIED from its entry (`plans/FS131-EN2-derivation.md`, the `statement:` field of a `derivation:` block, its
lines joined) and every leaf line copied from the fixed claim list (`data/fs131/claims-NF2.md`).

  fs131_kn6_recut.py            write data/fs131/kn3/claims-M7-entropy-split.md and claims-M8-zero-entropy-carried.md
                                from the templates data/fs131/kn6/recut-M7.tmpl and recut-M8.tmpl ({{EN2-…}} and
                                {{NF2-…}} are the copied lines)
  fs131_kn6_recut.py --check    regenerate in memory and compare with the files; exit 1 on a difference
  fs131_kn6_recut.py --check --plant   the same with one character of one entry changed in memory: must exit 1
"""
import pathlib, re, sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
EN2 = ROOT / "plans/FS131-EN2-derivation.md"
NF2 = ROOT / "data/fs131/claims-NF2.md"
OUT = {"M7": "data/fs131/kn3/claims-M7-entropy-split.md", "M8": "data/fs131/kn3/claims-M8-zero-entropy-carried.md"}


def entries(text):
    out, lines = {}, text.splitlines()
    for i, l in enumerate(lines):
        m = re.match(r"^derivation: (EN2-[A-Z0-9-]+)$", l)
        if not m:
            continue
        assert lines[i + 1].startswith("  statement: "), (m.group(1), lines[i + 1])
        parts, j = [lines[i + 1][len("  statement: "):]], i + 2
        while not re.match(r"^  [a-z][a-z ]*: ", lines[j]):
            parts.append(lines[j].strip()); j += 1
        out[m.group(1)] = (" ".join(parts), i + 1)
    return out


def leaves(text):
    return {m.group(1): m.group(2) for m in (re.match(r"^(NF2-[A-Z0-9-]+): (.*)$", l) for l in text.splitlines()) if m}


def render(tmpl, en, nf):
    def sub(m):
        k = m.group(1)
        if k in en:
            return f"> {k}: {en[k][0]}\n> — source: plans/FS131-EN2-derivation.md, the entry at l. {en[k][1]}"
        return f"> {k}: {nf[k]}\n> — source: data/fs131/claims-NF2.md § The chain's leaves"
    return re.sub(r"\{\{((?:EN2|NF2)-[A-Z0-9-]+)\}\}", sub, tmpl)


def main():
    check, plant = "--check" in sys.argv, "--plant" in sys.argv
    en, nf = entries(EN2.read_text()), leaves(NF2.read_text())
    if plant:
        s, n = en["EN2-ZE"]
        en["EN2-ZE"] = (s.replace("1 − η", "1 − 2η", 1), n)
    bad = 0
    for k, rel in OUT.items():
        text = render((ROOT / f"data/fs131/kn6/recut-{k}.tmpl").read_text(), en, nf)
        if check:
            same = (ROOT / rel).read_text() == text
            print(f"{rel}: {'identical' if same else 'DIFFERS'}")
            bad += not same
        else:
            (ROOT / rel).write_text(text)
            print(f"wrote {rel}: {text.count('> EN2-')} entries of the deriver, {text.count('> NF2-')} leaves")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
