#!/usr/bin/env python3
"""FS131-QA1: code-quality measurements over the backlog's Lean, read with `git show` (never a worktree).

Measures, per body (own files only, as fs131_qa1_dupes.BODIES defines them):
  * non-terminal bare `simp` (a bare `simp`/`simp at`/`simp [..]` line followed, in the same proof, by another tactic line
    at the same or deeper indentation — Mathlib's "flexible tactic" smell; heuristic);
  * WIP markers (`TODO`, `FIXME`, `XXX`, `wip`, `#check`, `#eval` outside docs, `dbg_trace`, `set_option trace`);
  * linter workarounds (`have _ :=`, `set_option linter.… false`, `_h…` binders in a theorem's signature);
  * docstrings that still say `sorry`/`skeleton` on declarations whose proof has none;
  * module sizes;
  * the same signature (binders and conclusion, names stripped) declared under different names in different bodies.
Usage: fs131_qa1_quality.py [--self-test]
"""
import collections
import json
import re
import subprocess
import sys
import importlib.util

HERE = __file__.rsplit("/", 1)[0]


def _load(name, fn):
    spec = importlib.util.spec_from_file_location(name, f"{HERE}/{fn}")
    m = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(m)
    return m


D = _load("decls", "fs131_qa1_decls.py")
U = _load("dupes", "fs131_qa1_dupes.py")

BARE_SIMP = re.compile(r"(?<![\w.])simp(?!\s*only)(?![_?a-zA-Z])")
WIP = re.compile(r"\b(TODO|FIXME|XXX)\b|\bwip\b|^\s*#check\b|^\s*#eval\b|dbg_trace|set_option trace\.", re.I | re.M)
LINTER = re.compile(r"\bhave\s+_\s*:?=|set_option\s+linter\.\S+\s+false")


def indent(s):
    return len(s) - len(s.lstrip(" "))


def nonterminal_simps(code_lines):
    """Indices of bare-simp lines followed (within the declaration) by a tactic line at >= the same indentation."""
    out = []
    for i, ln in enumerate(code_lines):
        s = re.sub(r"@\[[^\]]*\]", "", ln).strip()  # an attribute `@[simp]` is not a tactic
        if not s or not BARE_SIMP.search(s) or s.startswith("simpa") or "simp_all" in s:
            continue
        # skip simps used as a term-level closer inside another tactic (`by simp`, `<;> simp`, `(by simp)`)
        if re.search(r"by\s+simp|<;>\s*simp|\bsimp\s*\)", s):
            continue
        j = i + 1
        while j < len(code_lines) and not code_lines[j].strip():
            j += 1
        if j < len(code_lines):
            nxt = code_lines[j]
            if indent(nxt) >= indent(ln) and not nxt.strip().startswith(("·", "|", "--")):
                out.append(i)
    return out


def body_files(body):
    return U.own_files(body)


def measure(body):
    ref = U.BODIES[body][0]
    res = collections.Counter()
    hits = collections.defaultdict(list)
    sizes = {}
    sigs = []
    for p in body_files(body):
        text = D.git_show(ref, p)
        if text is None:
            continue
        short = p.split("HadwigerNelson/")[-1]
        sizes[short] = text.count("\n")
        for m in WIP.finditer(D.strip_comments(text)):
            line = text[:m.start()].count("\n") + 1
            hits["wip"].append(f"{short}:{line} {m.group(0).strip()}")
        for d in D.parse(text):
            code = D.strip_comments("\n".join(text.split("\n")[d["line"] - 1:d["line"] - 1 + d["lines"]])).split("\n")
            for i in nonterminal_simps(code):
                res["nonterminal_simp"] += 1
                hits["nonterminal_simp"].append(f"{short}:{d['line'] + i}")
            for ln_i, ln in enumerate(code):
                if LINTER.search(ln):
                    res["linter_workaround"] += 1
                    hits["linter_workaround"].append(f"{short}:{d['line'] + ln_i} {ln.strip()[:70]}")
            if d["kind"] in ("theorem", "lemma") and re.search(r"\(_[A-Za-z]\w*\s*:", d["sig"]):
                res["unused_binder_in_sig"] += 1
                hits["unused_binder_in_sig"].append(f"{short}:{d['line']} {d['name']}")
            if d["counts"]["sorry"] == 0 and d["has_doc"] and re.search(r"\bsorry|skeleton\b", d["doc"]):
                res["stale_doc_sorry"] += 1
                hits["stale_doc_sorry"].append(f"{short}:{d['line']} {d['name']}")
            if d["kind"] in ("theorem", "lemma"):
                sig = re.sub(r"^\S+\s+\S+", "", d["sig"]).strip()  # drop `theorem name`
                if len(sig) > 25:
                    sigs.append((sig, body, short, d["line"], d["name"]))
    return res, hits, sizes, sigs


def report():
    all_sigs = []
    out = {}
    for body in U.BODIES:
        res, hits, sizes, sigs = measure(body)
        all_sigs += sigs
        out[body] = {"counts": dict(res), "hits": {k: v for k, v in hits.items()}, "sizes": sizes}
        big = sorted(sizes.items(), key=lambda kv: -kv[1])[:4]
        print(f"== {body}: " + ", ".join(f"{k}={v}" for k, v in sorted(res.items())) +
              f"; WIP markers={len(hits['wip'])}; largest: " + ", ".join(f"{k} {v}" for k, v in big))
    by_sig = collections.defaultdict(list)
    for sig, body, short, line, name in all_sigs:
        by_sig[sig].append((body, short, line, name))
    dup = {s: v for s, v in by_sig.items() if len({(b, f) for b, f, _, _ in v}) > 1 and len({n for *_, n in v}) > 1}
    print(f"== same signature, different names, different files: {len(dup)}")
    for s, v in sorted(dup.items(), key=lambda kv: kv[0])[:40]:
        print("   " + " | ".join(f"{b}:{f}:{l} {n}" for b, f, l, n in v) + f"   :: {s[:110]}")
    out["sig_dupes"] = [[list(x) for x in v] + [s] for s, v in dup.items()]
    with open("data/fs131/qa1/quality.json", "w") as fh:
        json.dump(out, fh, ensure_ascii=False, indent=1)


def self_test():
    code = ["@[simp] theorem foo : x := by", "  intro x", "  simp at h", "  exact h", "", "  rcases h with a | b",
            "  · simp", "  · simp only [x]", "  have := by simp", "  simp"]
    got = nonterminal_simps(code)
    ok = got == [2]
    print("self-test:", "OK" if ok else f"FAIL {got}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(self_test() if sys.argv[1:] == ["--self-test"] else report() or 0)
