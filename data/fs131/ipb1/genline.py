#!/usr/bin/env python3
"""FS131-IPB1: map lines of a generated module back to the release file's lines (iteration aid; never evidence).
Each copied declaration opens with a docstring carrying `[OAIMath2026]` `File.lean:K`, K its keyword line at the
release; the declaration's lines follow in order, so a generated line maps to K + (its distance from the generated
keyword line).  Usage: genline.py <Module> <generated line> …  (prints release line and its text)."""
import re
import sys
import pathlib
W = pathlib.Path("/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wi1")
sys.path.insert(0, str(W / "tools"))
import importlib.util
spec = importlib.util.spec_from_file_location("p", W / "tools/fs131_ko1_port.py")
P = importlib.util.module_from_spec(spec)
spec.loader.exec_module(P)
mod = sys.argv[1]
gen = (W / f"Proofs/HadwigerNelson/Outside/{mod}.lean").read_text().split("\n")
rel = (P.CLONE / P.SRCROOT / P.REL_OF_MOD[mod][1]).read_text().split("\n")
for a in sys.argv[2:]:
    g = int(a)
    k = g - 1
    while k >= 0 and not re.search(r"`\[OAIMath2026\]` `\w+\.lean:(\d+)`", gen[k]):
        k -= 1
    K = int(re.search(r"`\[OAIMath2026\]` `\w+\.lean:(\d+)`", gen[k]).group(1))
    j = k
    while not P.KEYWORD.match(gen[j]):
        j += 1
    r = K + (g - 1 - j)
    print(f"gen {g} -> release {r}: {rel[r - 1].strip()[:110]}")
