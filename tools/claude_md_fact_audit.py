#!/usr/bin/env python3
"""Fact audit for an edit of CLAUDE.md + LEDGER.md: which fact tokens were in the old version and are NOWHERE in the new one.

The corpus audited is CLAUDE.md followed by LEDGER.md (the novel-results ledger, extracted from CLAUDE.md § Frontier on
2026-09-22; at a base revision where LEDGER.md does not exist the ledger is still inside CLAUDE.md and the corpus is that file
alone, so an audit across the extraction sees every row survive).

Usage (standard library only; run from the repository root):

    python3 tools/claude_md_fact_audit.py                      # git HEAD:{CLAUDE,LEDGER}.md  against  ./{CLAUDE,LEDGER}.md
    python3 tools/claude_md_fact_audit.py --base d0df4f82      # any git revision as the old version
    python3 tools/claude_md_fact_audit.py --old a.md --new b.md
    python3 tools/claude_md_fact_audit.py --moves moves.txt    # also write the relocation map (see below)
    python3 tools/claude_md_fact_audit.py --words              # also list vocabulary that vanished (noisy; a reading aid)
    python3 tools/claude_md_fact_audit.py --self-test          # plant faults and watch each one fire
    python3 tools/claude_md_fact_audit.py --dupes              # literally repeated 10-word runs: the one-home rule's tripwire

What it checks, and what FAILS the run (exit status 1):
  * every fact token of the old version still occurs at least once in the new one -- dates, bibliography keys,
    backticked spans, identifiers (FS-nn, Mnn, Gnn, row nn, ...), theorem references, numbers, grade tags, proper
    names, and every whitespace-delimited chunk holding a digit or a mathematical character;
  * every grokking's status tag (the bracket after its title) is unchanged;
  * the PROTECTED regions are byte-identical (a region is the blank-line-delimited block holding the tag
    "[PROTECTED -- never compress, trim" plus the blocks after it, up to the next block that opens with "**" or "#";
    the header's rule ABOUT the tag quotes it with an ellipsis and is not a region);
  * the sentence scripts/gate_report.py reads ("current audit reads N clean and M declared purchases") still
    matches, with the same N and M;
  * no heading disappeared (other files cite sections by name).
  * every `row N` and `GN` the new version cites exists as a ledger row or a grokking (no dangling pointer).
It prints bytes per section before and after.

Deliberate re-spellings go in NORMALISE (applied to BOTH versions before extraction, so old and new spellings meet);
tokens deliberately allowed to vanish go in ALLOW with the reason. Both tables are printed on every run: an allowance
is a reviewed decision, never a silent one.

WHAT THIS CANNOT SEE: a number can survive while the sentence that gave it meaning is gone, and a small number
("5") that occurs a hundred times hides the loss of one occurrence. This audit is the floor, not the check.
The relocation map (--moves) lists, per entry (ledger row, grokking, numbered item, table row, section), the tokens
that LEFT that entry and the entries where they now occur -- the places a reader has to check by reading.
"""
from __future__ import annotations

import argparse
import re
import subprocess
import sys
from collections import Counter, defaultdict
from pathlib import Path

# (regex, replacement, reason) -- applied to BOTH versions before token extraction.
NORMALISE: list[tuple[str, str, str]] = [
    (r"(?<=\d),(?=\d{3}(?!\d))", "", "thousands separators: 1,581 and 1581 are one number"),
    (r"ℚ\(√3,√11\)", "K", "legend macro K := ℚ(√3,√11) (§ Notation)"),
    (r"ℚ\(√3,√5,√7,√11\)", "K(√5,√7)", "K(√d) adjoins √d (§ Notation): de Grey's field"),
    (r"ℚ\(√3,(√[57]),√11\)", r"K(\1)", "K(√d) adjoins √d (§ Notation)"),
    (r"ℚ\(√3,√11,(√\d+)\)", r"K(\1)", "K(√d) adjoins √d (§ Notation)"),
    (r"UD\(𝔽(_[qp]|[₀-₉]+), ?2\)", r"Γ\1", "legend macro Γ_q := UD(𝔽_q, 2) (§ Notation; rows 70-71 already used it)"),
]

# token -> reason it may vanish. Keep this small and reviewed.
ALLOW: dict[str, str] = {
    "ℚ(√p,√q)²": "row 57's spelling of Fischer's plane; its home, § Publication, says 'the plane over ℚ(√p,√q)'",
    "SUSPENDED": "§ Publication's trigger was SUSPENDED (2026-09-19) pending [Fischer1994]; read and verified 2026-09-22, it resolved to 'has not fired' — the value is his",
    # The FS-66 stub row's phrasings (FS-66 closed 2026-09-21; the row left the ranked table and its facts moved to row 75,
    # item 17 and § Notation, which spell the same objects `UD(ℤ/p^k, 2)`, `UD(ℤ/529, 2)` and "χ(G_k) is non-increasing").
    "UD(ℤ/p²,2)": "the FS-66 stub row; § Notation now writes the tower as UD(ℤ/p^k, 2)",
    "UD(ℤ/529,2)": "the FS-66 stub row; item 17 and row 75 write UD(ℤ/529, 2)",
    "χ(level": "the FS-66 stub row's 'χ(level two) ≤ χ(level one)'; § Notation says χ(G_k) is non-increasing in k",
    "Pilot": "the FS-66 stub row's 'Pilot:'; row 75 and G66 say 'the pilot'",
    # WORKFLOW 2.0 (2026-09-22) renumbered the reframe: the prior-art gate is step 3.2 (was 3a), the knowledge audit 3.1 (was 3g).
    "3a": "WORKFLOW 2.0: the prior-art gate is step 3.2; G49 and the grokkings intro now say 3.2",
    "3g": "WORKFLOW 2.0: the re-grokking is step 3.1; the grokkings intro now says 3.1",
    "G1–G54": "the stable-identifier range in the grokkings intro, extended to G1–G67 when G67 was minted (2026-09-22)",
    "G1–G67": "the stable-identifier range, extended to G1–G68 when G68 (the quotient/fan-gap screen) was minted (2026-09-22)",
    "G1–G68": "the stable-identifier range, extended to G1–G69 when G69 (rigidity prime by prime) was minted (2026-09-22)",
    "G1–G69": "the stable-identifier range, extended to G1–G70 when G70 (√3-clean is residue, Coxeter's theorem) was minted at FS-71's close (2026-09-22)",
    # FS-71, the theorem audit (2026-09-22): grade tags corrected where the audit found the mechanism was a hand derivation.
    "[kernel for ρ₁₅; measured for ρ₆₃]": "G12's old tag; FS-71 batch 1 (M31-T1) found the law a hand derivation confirmed at 26 censuses, kernel for the ρ₁₅ instance",
    "G12:[kernel for ρ₁₅; measured for ρ₆₃]": "FS-71 batch 1: G12 re-graded [hand, confirmed at 26 exact censuses; kernel for the ρ₁₅ instance] (M31-T1)",
    "G20:[kernel + measured]": "FS-71 batch 1: G20 re-graded [hand + kernel + measured] — the boundary-tightness argument is M36-T1, a hand derivation",
    "G52:[measured + reading, one instance with a positive control]": "FS-71 batch 4b: G52's necessary half is a hand theorem (the σ-criterion, M63G-T4/T5); the tag now says so",
    "G54:[kernel one way; derived the other; the table computed]": "FS-71 batch 5b: the tight-forcing direction is a hand theorem (FS38-D2-A/B), graded so in row 67 and its entry",
    "[GarciaMarcoKnauer]": "G58's yearless key, corrected to [GarciaMarcoKnauer2024] by FS-71 batch 6a",
    "arXiv:2303.06262": "G58 cited the wrong arXiv id (it is Cervantes–Krebs); the García-Marco–Knauer paper is arXiv:2405.19543 (FS-71 batch 6a)",
    "6723": "the vacuity gate's declaration count, 6723 -> 6728 when Instances/ThreeFive (five declarations) joined Proofs.lean at FS-70's close (2026-09-22)",
    "declarations=6723": "the same count, as the gate report prints it",
    "FS38-D2-A/B": "the LEDGER.md § B placeholder row FS-71 was to backfill; batch 5b indexed FS-38's seven theorems under their own rows (§ S.2) and removed the placeholder row that named them as pending",
    "FS66-W/E/T": "the same placeholder row's FS-66 half; the whole row is one line, so batch 5b's removal (on filing FS-38, per the brief) drops it too — batch 6 adds FS-66's own § B rows fresh, with no placeholder to clean up",
    # FS-73's close (2026-09-23): the gate counts moved and rows 78-79 joined the ledger; FS-59's three-colour routes were answered.
    "6728": "the vacuity gate's declaration count, 6728 -> 6795 at FS-73's close (the Kempe layer and FS-72's lattices joined the library)",
    "declarations=6728": "the same count, as the gate report prints it",
    "270": "vacuity's refutations-skipped count, 270 -> 278 at FS-73's close",
    "refutations-skipped=270": "the same count, as the gate report prints it",
    "262": "vacuity's sites count, 262 -> 275 at FS-73's close",
    "sites=262": "the same count, as the gate report prints it",
    "240": "vacuity's generic count, 240 -> 253 at FS-73's close",
    "generic=240": "the same count, as the gate report prints it",
    "1–75": "the ledger's row range in § The novel-results ledger's pointer, extended to 1–79 at FS-73's close",
    "R9": "the old FS-59 row's first experiment (the chain route on Kooshi's 7-cycle triangle); superseded at three colours by FS-73's Theta_3 (row 79); its text stays in plans/STUB-four-colours-167.md §3a",
    "R9's": "the same, possessive",
    "R5–R8": "the old FS-59 row's instruments (degree-aimed asks, core growth, the rigidity dial, the order parameter); kept in plans/STUB-four-colours-167.md §3a, carried to the five-colour question there",
    "c(3w)": "R9's pinned ask c(0) != c(3w); plans/STUB-four-colours-167.md §3a",
    "w′": "R9's identity 1/6 = 1 + 1 - w - w-bar - w' - w-bar'; plans/STUB-four-colours-167.md §3a",
    "w̄′": "the same identity",
    "G68/G69": "the old open-milestones sentence 'FS-59's R9 stays deferred, re-aimed by G68/G69'; FS-73 closed and R9 is answered",
    "MASCOT-T6's": "the old open-milestones sentence naming FS-73's bearings; G70 names MASCOT-T6 as its source",
}

# The real tag reads "[PROTECTED — never compress, trim or paraphrase …]"; the header's RULE about the tag quotes it as
# "[PROTECTED — never compress …]" and is an ordinary paragraph (the budget line in it changes when Kooshi raises the budget).
PROTECTED_TAG = "[PROTECTED — never compress, trim"
GATE_RE = re.compile(r"current audit reads (\d+) clean and (\d+) declared purchases")
MATH = set("αβγδεζηθικλμνξπρστυφχψωΓΔΘΛΞΠΣΦΨΩℚℝℤℂℕ𝔽𝔭𝔓√≤≥≠≡≈∈∉⊆⊂⊇⊄∣∤∀∃∧∨¬⟹⟸⟺→↦×·∞∅∩∪⌈⌉⌊⌋₀₁₂₃₄₅₆₇₈₉⁰¹²³⁴⁵⁶⁷⁸⁹ⁿ⁻⁺′̄±−½∑∏")
STRIP = ".,;:!?\"'“”‘’—–-*`|…~"


def normalise(text: str, table=None) -> str:
    for pat, rep, _ in (NORMALISE if table is None else table):
        text = re.sub(pat, rep, text)
    return text


def _balance(tok: str) -> str:
    for o, c in ("()", "[]", "{}"):
        while tok.startswith(o) and tok.count(o) > tok.count(c):
            tok = tok[1:]
        while tok.endswith(c) and tok.count(c) > tok.count(o):
            tok = tok[:-1]
    if len(tok) > 2 and tok[0] + tok[-1] in ("()", "[]") and not any(c in tok[1:-1] for c in "()[]"):
        tok = tok[1:-1]                                         # "(161)" and "161" are one token
    return tok


def chunks(text: str):
    for raw in text.replace("`", " ").split():
        tok = raw
        for _ in range(4):
            tok = _balance(tok.strip(STRIP))
        tok = re.sub(r"-[A-Za-z][A-Za-z-]*$", "", tok)          # 1581-vertex -> 1581
        tok = re.sub(r"^[A-Za-z]+-(?=\d)", "", tok)              # disc-316 -> 316 (identifiers are the id class's business)
        if re.fullmatch(r"\d+(?:\.\d+)?", tok):
            continue                                            # a bare number is the num class's business
        if tok and (any(ch.isdigit() for ch in tok) or any(ch in MATH for ch in tok)):
            yield tok


def facts(text: str) -> dict[str, Counter]:
    """Token classes of one text (already normalised)."""
    out: dict[str, Counter] = defaultdict(Counter)
    out["date"].update(re.findall(r"\b\d{4}-\d{2}-\d{2}\b", text))
    out["bib"].update(re.findall(r"`(\[[A-Za-z][A-Za-z0-9]+\])`", text))
    # backticked identifiers, paths and commands; backticked MATHEMATICS is covered chunk by chunk below
    out["code"].update(c for c in re.findall(r"`([^`\n]+)`", text) if not any(ch in MATH for ch in c))
    out["id"].update(re.findall(r"\b(?:FS-\d+|arXiv:[\d.]+|[A-Z]{1,2}(?:-[A-Z]{1,2})?-?\d+(?:\.\d+)?[a-z]?)\b", text))
    for m in re.finditer(r"\b[Rr]ows?\s+((?:\d+(?:[–-]\d+)?)(?:(?:,\s*|\s+and\s+|,\s+and\s+)\d+(?:[–-]\d+)?)*)", text):
        for n in re.findall(r"\d+", m.group(1)):
            out["row"][f"row {n}"] += 1
    out["ref"].update(re.sub(r"\s+", " ", r) for r in re.findall(
        r"(?:Thms?\.?|Theorems?|Props?\.|Lemma|Table|Remark|Cor\.|Example|Open Problem|OP|§|¶)\s*[\dA-Z][\w.]*(?:\([ivx]+\))?", text))
    out["num"].update(re.findall(r"(?<![\w.])\d+(?:\.\d+)?", text))
    out["tag"].update(m.group(0) for m in re.finditer(r"(?<!`)\[[a-z][^\]\n]{1,90}\]", text))
    out["chunk"].update(chunks(text))
    lower = set(re.findall(r"\b[a-z][a-zé'’-]+\b", text))
    for w in re.findall(r"\b[A-Z][A-Za-zéúöü'’]+\b", text):
        if w.lower() not in lower:
            out["name"][w] += 1
    return out


def words(text: str) -> Counter:
    return Counter(w for w in re.findall(r"\b[a-zé][a-zé'’-]{4,}\b", text.lower()))


def entries(text: str) -> dict[str, str]:
    """Split into named entries: ledger rows, grokkings, numbered items, stub rows, else the enclosing heading."""
    out: dict[str, list[str]] = defaultdict(list)
    heading, key = "(top)", "(top)"
    for line in text.split("\n"):
        if re.match(r"^#{1,4} ", line):
            heading = key = line.lstrip("# ").strip()
        elif m := re.match(r"^\| [\d–]+ \| \*{0,2}(FS-\d+)", line):
            key = f"paths {m.group(1)}"
        elif m := re.match(r"^\| (\d+) \|", line):
            key = f"row {m.group(1)}"
        elif m := re.match(r"^\* \*\*(G\d+) ", line):
            key = m.group(1)
        elif (m := re.match(r"^(\d+)\. \*\*", line)) and "problem stands" in heading:
            key = f"stands item {m.group(1)}"
        elif line.startswith("|") and not key.startswith(("row", "paths")):
            key = heading
        elif not line.strip() and not key.startswith("G"):
            key = heading
        out[key].append(line)
    return {k: "\n".join(v) for k, v in out.items()}


def protected_regions(text: str) -> list[str]:
    blocks = re.split(r"\n[ \t]*\n", text)
    regions, i = [], 0
    while i < len(blocks):
        if PROTECTED_TAG in blocks[i]:
            j = i + 1
            while j < len(blocks) and not blocks[j].lstrip().startswith(("**", "#")):
                j += 1
            regions.append("\n\n".join(blocks[i:j]))
            i = j
        else:
            i += 1
    return regions


def token_proxy(text: str) -> int:
    """A PROXY for model tokens (no tokenizer is available offline): an ASCII word costs ceil(len/6), a digit run ceil(len/3),
    every other ASCII non-space character 1, and a non-ASCII character 1 per 2 bytes of its UTF-8 form rounded up (so α is 1,
    ≤ and ₂ are 2, 𝔽 is 2). Good for comparing two versions of one file; not a count."""
    n = 0
    for m in re.finditer(r"[A-Za-z]+|\d+|\S", text):
        g = m.group(0)
        if g[0].isascii() and g[0].isalpha():
            n += -(-len(g) // 6)
        elif g[0].isdigit():
            n += -(-len(g) // 3)
        elif g.isascii():
            n += 1
        else:
            n += -(-len(g.encode()) // 2)
    return n


def section_bytes(text: str) -> list[tuple[str, int]]:
    out, cur, size = [], "(preamble)", 0
    for line in text.split("\n"):
        if re.match(r"^#{1,3} ", line):
            out.append((cur, size))
            cur, size = line.strip(), 0
        size += len(line.encode()) + 1
    out.append((cur, size))
    return out


STRONG = ("date", "bib", "code", "id", "row", "ref", "num", "tag", "chunk", "name")


def audit(old: str, new: str, *, table=None, allow=None, moves: str | None = None, show_words=False, quiet=False) -> list[str]:
    """Return the list of failures (empty = pass). Prints the report unless quiet."""
    say = (lambda *a: None) if quiet else print
    allow = ALLOW if allow is None else allow
    fails: list[str] = []
    o_n, n_n = normalise(old, table), normalise(new, table)
    fo, fn = facts(o_n), facts(n_n)
    if sum(len(c) for c in fo.values()) < 100:
        fails.append("the extractor found almost nothing in the OLD version: the audit is blind, not green")
    say(f"bytes: {len(old.encode()):,} -> {len(new.encode()):,}  ({len(new.encode()) - len(old.encode()):+,})")
    say(f"token PROXY (see token_proxy; not a tokenizer): {token_proxy(old):,} -> {token_proxy(new):,}  ({token_proxy(new) - token_proxy(old):+,})")
    for cls in STRONG:
        lost = sorted(t for t in fo[cls] if t not in fn[cls] and t not in allow)
        if cls == "name":   # a name survives inside a bibliography key: Cranston in [CranstonRabern2015]
            lost = [t for t in lost if re.sub(r"['’]s$", "", t) not in n_n]
        say(f"[{cls}] {len(fo[cls])} distinct before, {len(fn[cls])} after, LOST {len(lost)}")
        for t in lost:
            say(f"    LOST {cls}: {t!r}  (was ×{fo[cls][t]})")
            fails.append(f"lost {cls} token {t!r}")
    # grokking status tags
    eo, en = entries(o_n), entries(n_n)
    for k, body in eo.items():
        if re.fullmatch(r"G\d+", k):
            head = re.match(r"\* \*\*G\d+ — .*?\*\*", body, re.S)
            tag_o = re.search(r"\[[^\]]+\]", head.group(0)) if head else None
            nb = en.get(k)
            if nb is None:
                fails.append(f"grokking {k} is gone")
                continue
            head_n = re.match(r"\* \*\*G\d+ — .*?\*\*", nb, re.S)
            tag_n = re.search(r"\[[^\]]+\]", head_n.group(0)) if head_n else None
            a = re.sub(r"\s+", " ", tag_o.group(0)) if tag_o else None
            b = re.sub(r"\s+", " ", tag_n.group(0)) if tag_n else None
            if a != b and f"{k}:{a}" not in allow:
                fails.append(f"grokking {k} status tag changed: {a} -> {b}")
    for k in eo:
        if k.startswith("row ") and k not in en:
            fails.append(f"ledger {k} is gone")
    # pointers: a file that points instead of retelling must not point at nothing
    rows_n = {k[4:] for k in en if k.startswith("row ")}
    groks_n = {k for k in en if re.fullmatch(r"G\d+", k)}
    dangling = sorted({t for t in fn["row"] if t[4:] not in rows_n}
                      | {g for g in re.findall(r"\bG\d{1,2}\b", n_n) if g not in groks_n})
    say(f"pointers: {len(fn['row'])} distinct row references, {len(groks_n)} grokkings; dangling: {dangling or 'none'}")
    for d in dangling:
        if d not in allow:
            fails.append(f"dangling pointer: {d} is cited and no such entry exists")
    # protected regions
    po, pn = protected_regions(old), protected_regions(new)
    say(f"PROTECTED regions: {len(po)} before ({', '.join(str(len(p.encode())) for p in po)} bytes), {len(pn)} after")
    if len(po) < 2:
        fails.append(f"found only {len(po)} PROTECTED regions in the OLD version (expected 2): the check is blind")
    if po != pn:
        fails.append("a PROTECTED region is not byte-identical")
    # gate sentence
    go, gn = GATE_RE.search(re.sub(r"\s+", " ", old)), GATE_RE.search(re.sub(r"\s+", " ", new))
    if not gn:
        fails.append("the gate-report sentence no longer matches scripts/gate_report.py's regex")
    elif go and go.groups() != gn.groups():
        fails.append(f"the gate-report counts changed: {go.groups()} -> {gn.groups()}")
    say(f"gate sentence: {gn.group(0) if gn else 'MISSING'}")
    # headings
    ho = [l for l in old.split("\n") if re.match(r"^#{1,4} ", l)]
    hn = set(l for l in new.split("\n") if re.match(r"^#{1,4} ", l))
    for h in ho:
        if h not in hn and h not in allow:
            fails.append(f"heading disappeared (other files cite sections by name): {h!r}")
    # sections
    so, sn = section_bytes(old), dict(section_bytes(new))
    say("\nbytes per section (before -> after):")
    for name, b in so:
        a = sn.pop(name, None)
        say(f"  {b:8,} -> {a if a is None else format(a, '8,')}  {('' if a is None else format(a - b, '+,')):>8}  {name}")
    for name, a in sn.items():
        say(f"  {'new':>8} -> {a:8,}  {'':>8}  {name}")
    if show_words:
        wo, wn = words(o_n), words(n_n)
        gone = sorted(w for w in wo if w not in wn)
        say(f"\nvocabulary that vanished ({len(gone)} words; a reading aid, never a failure):")
        say("  " + " ".join(gone))
    if moves:
        lines = []
        where: dict[tuple[str, str], list[str]] = defaultdict(list)
        f_en = {k: facts(v) for k, v in en.items()}
        for k, f in f_en.items():
            for cls in STRONG:
                for t in f[cls]:
                    where[(cls, t)].append(k)
        for k, body in eo.items():
            f_old, f_new = facts(body), f_en.get(k, defaultdict(Counter))
            left = [(cls, t) for cls in ("date", "bib", "code", "id", "row", "ref", "num", "chunk", "name")
                    for t in f_old[cls] if t not in f_new[cls] and not (cls == "num" and len(t) < 2)]
            if left:
                lines.append(f"== {k}: {len(left)} tokens left this entry")
                for cls, t in sorted(set(left)):
                    homes = where.get((cls, t), [])
                    lines.append(f"   {cls:5} {t!r} -> {', '.join(homes[:5]) if homes else 'NOWHERE'}{' …' if len(homes) > 5 else ''}")
        Path(moves).write_text("\n".join(lines) + "\n", encoding="utf-8")
        say(f"\nrelocation map: {len(lines)} lines -> {moves}")
    say("\nnormalisations in force:")
    for pat, rep, why in (NORMALISE if table is None else table):
        say(f"  {pat!r} -> {rep!r}: {why}")
    say(f"allowances in force: {len(allow)}")
    for t, why in allow.items():
        say(f"  {t!r}: {why}")
    say("")
    for f in fails:
        say("FAIL:", f)
    say("AUDIT " + ("FAILED" if fails else "PASSED") + f" ({len(fails)} failure(s))")
    return fails


def self_test(text: str) -> int:
    """Plant one fault at a time in a copy of `text`; each must fire for its own reason, and the faithful copy must pass."""
    f = facts(normalise(text))
    once_num = next(t for t, c in sorted(f["num"].items()) if c == 1 and len(t) >= 4 and text.count(t) == 1)
    once_bib = next(t for t, c in sorted(f["bib"].items()) if c == 1 and text.count(t) == 1)
    region = protected_regions(text)[1]
    heading = next(l for l in text.split("\n") if l.startswith("### "))
    respell = [("ϱ63", "ρ₆₃", "self-test macro: a spelling nobody will ever put in the real table")]
    plants = [
        ("faithful copy", text, None, None, False),
        (f"one number deleted ({once_num})", text.replace(once_num, "", 1), None, "lost num", True),
        (f"one bibliography key deleted ({once_bib})", text.replace(once_bib, "[x]", 1), None, "lost bib", True),
        ("one PROTECTED byte changed", text.replace(region, region[:200] + ("x" if region[200] != "x" else "y") + region[201:], 1), None, "PROTECTED", True),
        ("gate sentence broken", text.replace("declared purchases", "declared purchase", 1), None, "gate-report", True),
        ("heading renamed", text.replace(heading, heading + " (renamed)", 1), None, "heading disappeared", True),
        ("a pointer to a row that does not exist", text.replace("(row 68)", "(row 968)", 1), None, "dangling pointer", True),
        ("re-spelling WITHOUT a normalisation entry", text.replace("ρ₆₃", "ϱ63"), None, "lost", True),
        ("the same re-spelling WITH its entry", text.replace("ρ₆₃", "ϱ63"), NORMALISE + respell, None, False),
    ]
    bad = 0
    for name, planted, table, needle, must_fail in plants:
        fails = audit(text, planted, table=table, quiet=True)
        fired = bool(fails)
        right_reason = (not must_fail) or any(needle in x for x in fails)
        ok = fired == must_fail and right_reason
        bad += not ok
        print(f"  {'ok ' if ok else 'BAD'}  {name}: {'fired' if fired else 'passed'}"
              + (f" -- {fails[0]}" if fails else "") + ("" if right_reason else f"  [wrong reason; wanted {needle!r}]"))
    if "ρ₆₃" not in text:
        print("  BAD  the re-spelling plants are vacuous: 'ρ₆₃' does not occur in the text under test")
        bad += 1
    print("SELF-TEST " + ("FAILED" if bad else "PASSED"))
    return 1 if bad else 0


def dupes(text: str, n: int = 10) -> None:
    """List every run of n words that occurs twice or more, outside the PROTECTED regions, merged into maximal runs:
    the one-home-per-fact rule's tripwire at a milestone close (it sees literal retelling only, never paraphrase)."""
    for r in protected_regions(text):
        text = text.replace(r, "")
    w = text.split()
    seen: dict[tuple, int] = {}
    hit = [False] * len(w)
    for i in range(len(w) - n + 1):
        k = tuple(w[i:i + n])
        if k in seen:
            for j in range(i, i + n):
                hit[j] = True
        else:
            seen[k] = i
    runs, i = [], 0
    while i < len(w):
        if hit[i]:
            j = i
            while j < len(w) and hit[j]:
                j += 1
            runs.append(" ".join(w[i:j]))
            i = j
        else:
            i += 1
    total = sum(len(r.encode()) for r in runs)
    print(f"{len(runs)} repeated runs of >= {n} words, {total:,} bytes in second and later tellings:")
    for r in sorted(runs, key=len, reverse=True):
        print(f"  {len(r.encode()):5,} B  {r[:150]}{'…' if len(r) > 150 else ''}")


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--base", default="HEAD", help="git revision holding the old version (default HEAD)")
    ap.add_argument("--old", help="read the old version from this file instead of git")
    ap.add_argument("--new", default="CLAUDE.md")
    ap.add_argument("--ledger", default="LEDGER.md", help="the ledger file joined to the corpus (missing = ledger inside CLAUDE.md)")
    ap.add_argument("--moves", help="write the relocation map to this path")
    ap.add_argument("--words", action="store_true")
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--dupes", action="store_true", help="list literally repeated 10-word runs in the NEW file, then exit")
    a = ap.parse_args()

    def corpus_files(main: str, ledger: str) -> str:
        text = Path(main).read_text(encoding="utf-8")
        if ledger and Path(ledger).exists():
            text += "\n\n" + Path(ledger).read_text(encoding="utf-8")
        return text

    def corpus_rev(rev: str) -> str | None:
        r = subprocess.run(["git", "show", f"{rev}:CLAUDE.md"], capture_output=True)
        if r.returncode != 0:
            print(f"AUDIT COULD NOT RUN: git show {rev}:CLAUDE.md failed: {r.stderr.decode().strip()}", file=sys.stderr)
            return None
        text = r.stdout.decode("utf-8")
        r2 = subprocess.run(["git", "show", f"{rev}:{a.ledger}"], capture_output=True)
        if r2.returncode == 0:   # the ledger exists at that revision as its own file
            text += "\n\n" + r2.stdout.decode("utf-8")
        return text

    if a.dupes:
        dupes(corpus_files(a.new, a.ledger))
        return 0
    if a.old:
        old = Path(a.old).read_text(encoding="utf-8")
    else:
        old = corpus_rev(a.base)
        if old is None:
            return 2
    if a.self_test:
        return self_test(old)
    new = corpus_files(a.new, a.ledger)
    return 1 if audit(old, new, moves=a.moves, show_words=a.words) else 0


if __name__ == "__main__":
    sys.exit(main())
