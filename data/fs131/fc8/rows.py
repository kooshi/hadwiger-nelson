# FS131-FC8: the owed rows. Each row names its draft's text (read from its record by script, never retyped), its slot and how many
# times the slot's words occur on main; `ready` rows carry an apply function that file_owed.py runs after asserting every slot.
import re, sys
from common import *
from leanx import block as lblock, rec

def bq(path, start_marker, stop_marker=None):
    """text of the blockquote group that follows start_marker in a record, flattened."""
    t = rd(path); i = t.index(start_marker) + len(start_marker); lines = t[i:].split("\n"); out = []; started = False
    for l in lines:
        if l.startswith(">"): started = True; out.append(l[1:].strip())
        elif started and not l.strip(): break
        elif started: break
    return flat(" ".join(out))

ROWS = []   # dicts
def row(id, item, source, draft, file=None, slot=None, status="CHECK", note="", cnt=None, apply=None):
    ROWS.append(dict(id=id, item=item, source=source, draft=draft, file=file, slot=slot, status=status, note=note, cnt=cnt, apply=apply))

def after_apply(file, anchor, add):
    def f(s):
        ms = list(re.finditer(pat(anchor), s)); assert len(ms) == 1, (file, anchor[:60], len(ms)); return s[:ms[0].end()] + add + s[ms[0].end():]
    return (file, f)
def repl_apply(file, old, new):
    def f(s):
        ms = list(re.finditer(pat(old), s)); assert len(ms) == 1, (file, old[:60], len(ms)); return s[:ms[0].start()] + new + s[ms[0].end():]
    return (file, f)

ER1 = "plans/FS131-ER1-davies-reading.md"
PR1 = "data/fs131/filing2/pr1-drafts.md"
def pr1_quoted(label):  # the *Replaces* "…" *with:* "…" pair of a PR1 draft, flattened
    t = rd(PR1); i = t.index(label); j = t.index("\n- **D", i + 5) if "\n- **D" in t[i + 5:] else len(t); b = flat(t[i:j])
    m = re.search(r'\*Replaces\* "(.*?)" \*with:\* "(.*?)"\.?\s*$', b); assert m, label; return m.group(1), m.group(2)

# ---------------- the Davies / README corrections (D1-D8) ----------------
o, n = pr1_quoted("- **D1.")
row("D1", "CLAUDE.md l.158: 'not new … names the plane as its aim' replaced (README job D1; item 948 ruling 1)", "list A, C (items 948, 951; PR1 D1)", PR1 + " D1", "CLAUDE.md", o, "ready", cnt=count("CLAUDE.md", o), apply=repl_apply("CLAUDE.md", o, n))
o, n = pr1_quoted("- **D2.")
row("D2", "CLAUDE.md l.196: 'the result is new (`[Davies2026]`)' replaced (D2)", "list A (948, 951; D2)", PR1 + " D2", "CLAUDE.md", o, "ready", cnt=count("CLAUDE.md", o), apply=repl_apply("CLAUDE.md", o, n))
o, n = pr1_quoted("- **D3.")
row("D3", "plans/FRONTIER-STUBS.md l.28: 'Not new: …' replaced (D3)", "list A (948, 951; D3)", PR1 + " D3", "plans/FRONTIER-STUBS.md", o, "ready", cnt=count("plans/FRONTIER-STUBS.md", o), apply=repl_apply("plans/FRONTIER-STUBS.md", o, n))
o, n = pr1_quoted("- **D4.")
row("D4", "plans/STUB-one-class-transfer.md l.3: prior-art line replaced (D4)", "list A (948, 951; D4)", PR1 + " D4", "plans/STUB-one-class-transfer.md", o, "ready", cnt=count("plans/STUB-one-class-transfer.md", o), apply=repl_apply("plans/STUB-one-class-transfer.md", o, n))
o, n = pr1_quoted("- **D6.")
row("D6", "LEDGER row 123 'Not claimed': the kernel proof no longer unclaimed (D6)", "list A (951; D6; also the 'notes for row 123')", PR1 + " D6", "LEDGER.md", o, "ready", cnt=count("LEDGER.md", o), apply=repl_apply("LEDGER.md", o, n))
o, n = pr1_quoted("- **D8.")
row("D8", "ARCHITECTURE.md § 5 'Assumed as hypotheses': 102 pairs, 52 statements -> 108, 55 (D8; 'the counts in ARCHITECTURE § 5')", "list A (951; D8; A: counts)", PR1 + " D8", "ARCHITECTURE.md", o, "ready", cnt=count("ARCHITECTURE.md", o), apply=repl_apply("ARCHITECTURE.md", o, n))
# D7: follows the grade's closing "]" of row 120
t7 = flat(rd(PR1)); m7 = re.search(r'\*\*D7\..*?a proposal:\s*"(.*?)"\s*\(`zeroEntropyCarried`', t7); d7 = m7.group(1)
r120 = re.search(r"\|\s*120\s*\|", rd("LEDGER.md")); 
row("D7", "LEDGER row 120's grade: the filer's kernel wording follows the closing ']' (D7 as its proposal reads; coordinator's choice 1)", "list A (951; D7; 'notes for row 120')", PR1 + " D7", "LEDGER.md",
    "the closing ']' of row 120's grade bracket (the row opens '| 120 |'; the grade is the bracket '[hand; …]')", "CHECK",
    note="the draft says 'follows the grade's closing ]' without quoting the words that precede it; a row-120 grade bracket with nested brackets is not found by script exactly once (see slot probe in owed.md)", cnt=None)

# ---------------- ER1 § 9.2 drafts (D5) ----------------
t92 = rd(ER1); i92 = t92.index("### 9.2 Draft lines")
def er1_bq(marker): return bq(ER1, marker)
b = flat(t92[i92:])
# D5 first: BIBLIOGRAPHY.md [Davies2026]'s second cell, from "**Read: the abstract, …**" through "… announced."
d5new = bq(ER1, "*with:*\n\n", None) if False else None
# the first blockquote after the BIBLIOGRAPHY [Davies2026] heading
k = t92.index("**`BIBLIOGRAPHY.md`, the row `[Davies2026]`, its second cell.**"); d5text = bq(ER1, t92[k:k + 600].split("*with:*")[0] + "*with:*") if False else None
def first_bq_after(marker):
    t = t92; i = t.index(marker); sub = t[i:]; m = re.search(r"\n> (.*?)(?:\n\n|\Z)", sub, flags=re.S); return flat(re.sub(r"\n> ?", " ", m.group(1)))
D5text = first_bq_after("**`BIBLIOGRAPHY.md`, the row `[Davies2026]`, its second cell.**")
bibt = rd("BIBLIOGRAPHY.md")
m5 = re.search(pat("**Read: the abstract, Theorem 1.1 and the introduction's passages on rational points and `ℚ(√n)²`") + r".*?" + pat("A full reading is owed before rows 121–123 or 128 are announced."), bibt, flags=re.S)
n5 = len(re.findall(pat("**Read: the abstract, Theorem 1.1 and the introduction's passages on rational points and `ℚ(√n)²`") + r".*?" + pat("A full reading is owed before rows 121–123 or 128 are announced."), bibt, flags=re.S))
def ap5(s):
    mm = list(re.finditer(pat("**Read: the abstract, Theorem 1.1 and the introduction's passages on rational points and `ℚ(√n)²`") + r"[^|]*?" + pat("A full reading is owed before rows 121–123 or 128 are announced."), s)); assert len(mm) == 1
    return s[:mm[0].start()] + D5text + s[mm[0].end():]
row("D5a", "BIBLIOGRAPHY.md l.978 [Davies2026]'s second cell -> 'Read in full' (ER1 § 9.2 first draft; item 655 'to read in full')", "lists A, C (948, 951 D5; 655)", ER1 + " § 9.2, first draft", "BIBLIOGRAPHY.md",
    "from '**Read: the abstract, Theorem 1.1 and the introduction's passages on rational points and `ℚ(√n)²`**' through 'A full reading is owed before rows 121–123 or 128 are announced.' (within one table cell)", "ready", cnt=len(re.findall(pat("**Read: the abstract, Theorem 1.1 and the introduction's passages on rational points and `ℚ(√n)²`") + r"[^|]*?" + pat("A full reading is owed before rows 121–123 or 128 are announced."), bibt)),
    apply=("BIBLIOGRAPHY.md", ap5))
# DeCorte status line
a = "§6.1, Lemmas 6.1–6.2 (FS107-P, 2026-09-27)"; tdc = re.search(r'\*with:?\*\s*"(; the statement of Lemma 5\.6.*?)"\.', t92, flags=re.S).group(1); tdc = flat(tdc)
row("D5b", "BIBLIOGRAPHY.md [DeCorteOliveiraVallentin2022] read-status line follows '§6.1, Lemmas 6.1–6.2 (FS107-P, 2026-09-27)' (ER1 § 9.2; item 655)", "list C (655)", ER1 + " § 9.2, second draft", "BIBLIOGRAPHY.md", a, "ready", cnt=count("BIBLIOGRAPHY.md", a), apply=after_apply("BIBLIOGRAPHY.md", a, tdc))
def er1_follow(label, anchor, file, rid, item, source):
    # the blockquote after the marker label
    txt = first_bq_after(label)
    row(rid, item, source, ER1 + " § 9.2, " + label.strip("*`").split(",")[0], file, anchor, "ready", cnt=count(file, anchor), apply=after_apply(file, anchor, " " + txt))
er1_follow("**`LEDGER.md` row 121, its \"Prior art\" clause.**", 'so novelty is "not found", never "first".', "LEDGER.md", "L121pa", "LEDGER row 121 prior-art clause: Davies posed it again (ER1 § 9.2)", "lists A, C (651/655; 'notes for row 121')")
er1_follow("**`LEDGER.md` row 123, its \"Prior art\" clause.**", 'so "not found", never "first".', "LEDGER.md", "L123pa", "LEDGER row 123 prior-art clause (ER1 § 9.2)", "lists A, C (655; 'notes for row 123')")
er1_follow("**`LEDGER.md` row 128, its \"Prior art\" clause.**", "independent, and theirs is the theorem;", "LEDGER.md", "L128pa", "LEDGER row 128 prior-art clause (ER1 § 9.2; supersedes PN1 § 3.10 item 4)", "lists A, C (644, 655; 'notes for row 128')")
er1_follow("**`LEDGER.md` row 129, its \"Prior art\" clause.**", "the descriptive-combinatorics neighbours named, unread (`plans/FS133-one-class-transfer.md` § PA.4));", "LEDGER.md", "L129pa", "LEDGER row 129 prior-art clause (ER1 § 9.2)", "list C (655)")

# ---------------- D7: row 120's grade ----------------
ROWS[:] = [r for r in ROWS if r["id"] != "D7"]
a7 = "at degree 16 one checking walk (FS105-W)]**"
row("D7", "LEDGER row 120's grade: the filer's kernel wording follows the grade's closing ']' (D7 as its proposal reads; coordinator's choice 1)", "list A (951; D7; 'notes for row 120')", PR1 + " D7", "LEDGER.md",
    "after '" + a7 + "' (the grade bracket's end, with the bold's closing '**'; the draft says 'follows the grade's closing \"]\"' and names no words)", "ready", cnt=count("LEDGER.md", a7), apply=after_apply("LEDGER.md", a7, " " + d7),
    note="placed after the bold's closing '**' so the draft's own bold run is not nested in the grade's")

# ---------------- KN1 X9: row 127 ----------------
KN1 = "plans/FS131-KN1-number-field-kernel-map.md"
tk = flat(rd(KN1)); mk = re.search(r'`LEDGER\.md` row 127, replace "(.*?)" by "(.*?)"\.', tk); o127, n127 = mk.group(1), mk.group(2)
row("L127kn1", "LEDGER row 127: 'every link it names is [hand] and stays so' replaced (KN1 § X9)", "list C (643, 'rows 52, 57, 121, 127')", KN1 + " § X9, row 127", "LEDGER.md", o127, "ready", cnt=count("LEDGER.md", o127), apply=repl_apply("LEDGER.md", o127, n127))
row("L52kn1", "LEDGER row 52: 'In the kernel since wave 2' sentence and grade (KN1 § X9)", "list C (643)", KN1 + " § X9, row 52", "LEDGER.md", "row 52 already reads '[kernel for the bound; hand + tools for the two values]' and '**In the kernel** (the standard three): the residue homomorphism at a usable prime … (`Arith.exists_placeHom`, FS-131 wave 2; …'", "filed",
    note="filed by supersession: a later draft (FS131-LU1 filing) wrote both for the same words; commit probed below")
row("L57kn1", "LEDGER row 57: 'Not proved' clause closed at usable primes (KN1 § X9)", "list C (643)", KN1 + " § X9, row 57", "LEDGER.md", "after '**Not proved:** … of size N(𝔭).' (the draft elides the middle)", "CHECK",
    note="slot not found: row 57 holds neither 'Not proved' nor 'of size N(𝔭)' (0 and 0 occurrences) and `placeHom_base` occurs 0 times in LEDGER.md; the row's current text must be read to place the sentence", cnt=0)
row("L121kn1", "LEDGER row 121: 'every link it names is [hand]' (KN1 § X9 names rows 121 and 127)", "list C (643)", KN1 + " § X9 (a draft for row 127 only)", "LEDGER.md", "'every link it names is [hand]' occurs once, in row 127", "no draft",
    note="item 643 lists row 121 beside 127, but § X9 drafts words for row 127 only; row 121 holds no such phrase")

# ---------------- PN1: the claim list's 'Not ours' phrase ----------------
PN1 = "plans/POROS-2026-10-13-number-field-findings.md"
tp = flat(rd(PN1)); mp = re.search(r'it replaces "(the chain theorem, prime inversion in its general form \(every number field, every prime\) and the two- and three-colour classifications \(GPT Astra, G55\))"\): \*(the chain theorem.*?T2 to T5\))\*', tp)
op, np_ = mp.group(1), mp.group(2)
row("CL-notours", "LEDGER § The claim list, 'Not ours': the phrase narrowed to what § B's index states (item 640)", "list C (640; PN1 § 2.1 item 6)", PN1 + " § 2.1 item 6 (also § 3.10 item 1)", "LEDGER.md", op, "ready", cnt=count("LEDGER.md", op), apply=repl_apply("LEDGER.md", op, np_),
    note="the draft cites ASTRA-2026-09-14-T2 to T5; § B holds T2 and T5 (2 occurrences each) but PN1's own quoted index lines are T3 and T4 — reported, not changed")

# ---------------- CLOSED-QUESTIONS (ER1 § 9.2) ----------------
cq17_anchor = "is the answer to the general one as far as finite witnesses reach."
cq17 = first_bq_after("**`CLOSED-QUESTIONS.md` § 1.7, the block of posers.**")
row("CQ17", "CLOSED-QUESTIONS § 1.7: a fourth posing, by Davies (ER1 § 9.2; item 644; supersedes PN1 § 3.10 item 3)", "list C (644, 655)", ER1 + " § 9.2", "CLOSED-QUESTIONS.md", "after '" + cq17_anchor + "' (inside a blockquote)", "ready", cnt=count("CLOSED-QUESTIONS.md", cq17_anchor),
    apply=after_apply("CLOSED-QUESTIONS.md", cq17_anchor, "\n>\n> " + cq17))
k3 = t92.index("**`CLOSED-QUESTIONS.md` § 3 (Adjacent and open), new items at its end**"); sub = t92[k3:]; mm = re.search(r"\n((?:> .*\n?)+)", sub); lines = [l[2:] if l.startswith("> ") else l[1:] for l in mm.group(1).rstrip("\n").split("\n")]
items = []; 
for l in lines:
    if l.startswith("- "): items.append(l[2:].strip())
    elif items: items[-1] += " " + l.strip()
cq3 = "\n".join("- " + flat(x) for x in items)
a3 = "## §4 — The deferral, stated so this file cannot be mistaken for a publication plan"
def ap3(s):
    ms = list(re.finditer(r"\n\n---\n\n" + re.escape(a3), s)); assert len(ms) == 1; return s[:ms[0].start()] + "\n" + cq3 + s[ms[0].start():]
row("CQ3", "CLOSED-QUESTIONS § 3: five items Davies poses, at the section's end (ER1 § 9.2; item 644)", "list C (644, 655)", ER1 + " § 9.2 (5 bullets)", "CLOSED-QUESTIONS.md", "the end of § 3, before the '---' that precedes '" + a3 + "'", "ready", cnt=count("CLOSED-QUESTIONS.md", a3), apply=("CLOSED-QUESTIONS.md", ap3),
    note="the draft's five bullets are joined as single lines (the file wraps at about 100 columns; the filer does not re-wrap)")

# ---------------- row 130: the older sentence (ER1 § 9.2) ----------------
t130 = flat(rd(ER1))
m130 = re.search(r'\*and, in the same row, replaces\* "(.*?)" \*with\* "(.*?)"\. \*\*`CLAUDE\.md`', t130)
new130 = m130.group(2)
o130a, o130b = [x.strip() for x in m130.group(1).split("…")]
rx130 = pat(o130a) + r"[^|]*?" + pat(o130b)
n130 = len(re.findall(rx130, rd("LEDGER.md")))
def ap130(s):
    ms = list(re.finditer(rx130, s)); assert len(ms) == 1, len(ms); return s[:ms[0].start()] + new130 + s[ms[0].end():]
row("L130b", "LEDGER row 130: Falconer's chi_m 'is one step further …' replaced by 'is the same number …' (ER1 § 9.2; accepted since the module passed the gate, FS131-LC1)", "list C (655)", ER1 + " § 9.2, row 130 second replacement", "LEDGER.md", "from '" + o130a + "' through '" + o130b + "' (the draft's '…' is the middle, matched within one line)", "ready", cnt=n130, apply=("LEDGER.md", ap130))
row("L130a", "LEDGER row 130 'Not claimed' (ER1 § 9.2, first replacement, 'only once accepted')", "list C (655)", ER1 + " § 9.2", "LEDGER.md", "old words absent: the row's 'Not claimed' now reads '… `χ_B` against `χ_m` (the lemma's colouring is Lebesgue measurable …' (0 occurrences of the draft's old text)", "filed", note="filed by supersession: FS131-FC1's drafts (commit bb20b8aee) wrote this clause from the landing's record")
row("CLAUDE-falc", "CLAUDE.md § Where the problem stands: Falconer's chi_m 'one step further, a GAP' (ER1 § 9.2, 'only once accepted')", "list C (655)", ER1 + " § 9.2", "CLAUDE.md", "old words absent (0 occurrences); the page reads 'Falconer's everywhere-proper Lebesgue-measurable `χ_m` is the same number …'", "filed", note="filed by supersession: FS131-FC1 (bb20b8aee)")

# ---------------- LEAN.md ----------------
def lean_flat(): return flat(rd("LEAN.md"))
def filed_probe(b): return flat(b.replace("\n", " "))[2:90] in lean_flat()
def before_heading(h, bullets):
    def f(s):
        ms = list(re.finditer(r"\n\n" + re.escape(h) + r"\n", s)); assert len(ms) == 1, (h, len(ms)); return s[:ms[0].start()] + "\n" + "\n".join(bullets) + s[ms[0].start():]
    return ("LEAN.md", f)
def after_line(prefix, bullets):
    def f(s):
        ls = s.split("\n"); ix = [i for i, l in enumerate(ls) if l.startswith(prefix)]; assert len(ix) == 1, (prefix, len(ix)); ls[ix[0] + 1:ix[0] + 1] = bullets; return "\n".join(ls)
    return ("LEAN.md", f)
SEARCH = "## Searching — Lean"; PKG = "## The package"; COST = "## The kernel's cost model"
def lean_row(job, label, bullets, sect, draft, source="list B (10-14 owed list), list A (the older handoff's § 6 lines)", note="", extra=None):
    if sect == "S": file_slot = "the end of § Searching — Lean (immediately before the heading '" + PKG + "')"; ap = before_heading(PKG, bullets); cnt = len(re.findall(r"\n\n" + re.escape(PKG) + r"\n", rd("LEAN.md")))
    elif sect == "C": file_slot = "the end of § The kernel's cost model (after the bullet \"A kernel leaf priced from a plan's table is priced high\"; immediately before '" + SEARCH + "')"; ap = before_heading(SEARCH, bullets); cnt = len(re.findall(r"\n\n" + re.escape(SEARCH) + r"\n", rd("LEAN.md")))
    elif sect == "B": file_slot = "after the bullet '**On the laptop** (12 cores …' of § Building"; ap = after_line("- **On the laptop**", bullets); cnt = sum(1 for l in rd("LEAN.md").split("\n") if l.startswith("- **On the laptop**"))
    elif sect == "A": file_slot = "after the paragraph '**An outside Lean proof may be ported instead of imported**' of § Assumptions"; ap = after_line("- **An outside Lean proof may be ported instead of imported**", bullets); cnt = sum(1 for l in rd("LEAN.md").split("\n") if l.startswith("- **An outside Lean proof may be ported instead of imported**"))
    nf = sum(filed_probe(b) for b in bullets)
    if nf: status, note2 = "CHECK", f"{nf} of {len(bullets)} bullets already stand in LEAN.md"
    else: status, note2 = "ready", ""
    row("LEAN-" + label, f"LEAN.md: {len(bullets)} line(s) drafted by {job} ({'§ Searching — Lean' if sect=='S' else '§ The kernel’s cost model' if sect=='C' else '§ Building' if sect=='B' else '§ Assumptions'})", source, draft, "LEAN.md", file_slot, status, note=(note + " " + note2).strip(), cnt=cnt, apply=ap)
    ROWS[-1]["bullets"] = bullets

def quote_range(job, a, b, after=': "'):
    t = open(rec(job)).read().split("\n"); s = flat(" ".join(t[a - 1:b])); i = s.index(after) + len(after); s = s[i:]; assert s.endswith('"') or s.endswith('".'), s[-30:]; return "- " + s.rstrip(".").rstrip('"') if s.endswith('".') else "- " + s[:-1]
def rec_lines(job, a, b): return open(rec(job)).read().split("\n")[a - 1:b]

lean_row("FS131-KN3", "KN3", [quote_range("KN3", 410, 414, 'a new line: "')], "S", "plans/FS131-KN3-chain-plan.md § Drafts for files I do not write, l. 410 (the axiom-binders line; item 659 (a))", "list C (659 (a))")
row("LEAN-A-binder-rule", "LEAN.md § Assumptions: a rule that an axiom's binders are written in its own signature and read back from the kernel's side (item 659 (a), 'to file at the next filing from its words')", "list C (659 (a))", "inventory item 659, ruling (a), in the coordinator's words (no lane drafted the section's text)", "LEAN.md", "§ Assumptions, position not named", "CHECK",
    note="the ruling names the rule and a checker for the gate's list, not a position in § Assumptions nor a sentence to file; KN3's own draft of the same fact is the § Searching — Lean line filed in the row above", cnt=None)
# KN7
kn7s = quote_range("KN7", 655, 659, 'a new line: "')
lean_row("FS131-KN7", "KN7", [kn7s], "S", "plans/FS131-KN7-chain-next.md l. 655–659", "list B")
row("LEAN-KN7-A", "LEAN.md § Assumptions, item 2, an instance (KN7 l. 660–662)", "list B", "plans/FS131-KN7-chain-next.md l. 660–662", "LEAN.md", "§ Assumptions item 2 — 'an instance' (the draft names the item and not the words it follows)", "CHECK", note="the position inside item 2 (a long numbered item) is not named; the same item took FS133-IA1's D5 at the density landing (FS131-FC6)", cnt=None)
# KN8
kn8 = [quote_range("KN8", 414, 418, 'a new line: "')]
t = flat(" ".join(rec_lines("KN8", 498, 504))); qs = re.findall(r'"([^"]+)"', t); assert len(qs) == 2, qs
kn8 += ["- " + q for q in qs]
lean_row("FS131-KN8", "KN8", kn8, "S", "plans/FS131-KN8-chain-split.md l. 414–417 (§ 3.5) and l. 498–502", "list B")
for job, st, stop in (("KN9", 438, None), ("KT1", 381, None), ("K8B1", 408, None), ("KPD1", 377, None), ("KR1", 416, None), ("K12A", 347, None)):
    bl = lblock(job, st)
    if job == "KN9": bl = [x for x in bl if not x.startswith("- **`Rigidity/Pieces`")]
    lean_row("FS131-" + job, job, bl, "S", f"plans/FS131-{job}-*.md § at l. {st} (the draft block under the heading, its bullets)", "list B")
row("LEAN-KR1-A", "LEAN.md § Assumptions: the four items for `Plane.OneAvoidingDensityBound`, 'should Kooshi rule declare' (KR1 § 6.3)", "list B (KR1)", "plans/FS131-KR1-chain-map.md § 6.3", None, None, "CHECK",
    note="conditional draft: Kooshi ruled 'Yes, prove the density bound' (W6; the bound is formalized, FS131-LDB1), so no declaration was made and the four items have no place; reported, nothing filed")
row("LEAN-KDB1", "LEAN.md lines of KDB1, IDB1, IDB2, IDB3 (cost model 2 + § Searching 3; IDB1's; IDB2's 4; IDB3's D2 3 and D3 4)", "list B", "plans/FS131-KDB1-density-bound.md l. 320–330 etc.", "LEAN.md", "-", "filed", note="filed by FS131-FC6 (commit 47e4b168d, the density bound's landing: its drafts 12 and 13 took these records' lines verbatim)")
for job, st, sec in (("KC13", 368, "C"), ("IKC1", 196, "C")):
    lean_row("FS131-" + job, job, lblock(job, st), sec, f"plans/FS131-{job}-*.md § at l. {st}", "list B")
for job, st in (("KM11", 356), ("ITK1", 286), ("IJ1", 248), ("IJ2", 226)):
    lean_row("FS131-" + job, job, lblock(job, st), "S", f"plans/FS131-{job}-*.md § at l. {st}", "list B")
ij3 = [l for l in open(R + "data/fs131/ij3/draft-lean-md.txt").read().split("\n") if l.startswith("- ")]
lean_row("FS131-IJ3", "IJ3", ij3, "S", "data/fs131/ij3/draft-lean-md.txt (7 lines; named by plans/FS131-IJ3-implementation.md l. 282)", "list B")
for job, st in (("IM11", 271), ("ILA1", 260), ("ICL1", 306), ("ICL2", 333), ("ICM1", 262), ("ICM2", 223)):
    lean_row("FS131-" + job, job, lblock(job, st), "S", f"plans/FS131-{job}-*.md § at l. {st}", "list B")
lean_row("FS131-IKC2", "IKC2", lblock("IKC2", 181), "S", "plans/FS131-IKC2-implementation.md § at l. 181", "list B")
lean_row("FS131-IKC3-C", "IKC3 (cost model)", lblock("IKC3", 301), "C", "plans/FS131-IKC3-implementation.md § at l. 301", "list B")
lean_row("FS131-IKC3-B", "IKC3 (Building)", lblock("IKC3", 290), "B", "plans/FS131-IKC3-implementation.md § at l. 290", "list B")
lean_row("FS131-IKC4-C", "IKC4 (cost model)", lblock("IKC4", 245), "C", "plans/FS131-IKC4-implementation.md § at l. 245", "list A (the price of IKC4; its lines), list B")
lean_row("FS131-IKC4-S", "IKC4 (§ Searching)", lblock("IKC4", 263), "S", "plans/FS131-IKC4-implementation.md § at l. 263", "list A, list B")
lean_row("FS131-IN1L", "IN1L", lblock("IN1L", 473), "S", "plans/FS131-IN1L-implementation.md § at l. 473 (one bullet, 'At the pin:', keeps its seven sub-bullets)", "list B")
lean_row("FS131-IDG1", "IDG1", lblock("IDG1", 389), "S", "plans/FS131-IDG1-implementation.md § at l. 389", "list B")
lean_row("FS131-IG1", "IG1", lblock("IG1", 313), "S", "plans/FS131-IG1-implementation.md § at l. 313", "list B")
row("LEAN-IPA1-IPB1", "LEAN.md classes of IPA1 (ruled-statement-change class) and IPB1 (COEFF, CLASS_PARAMS, EQSET, ascription and instance adaptations, inductive constructors) and plan § Drafts F1, F2", "list B", "gathered in plans/FS131-IPD1-implementation.md l. 363–366, which names them; the IPA1 and IPB1 records carry no LEAN.md block of their own", None, None, "CHECK",
    note="the words are named, not quoted: 'plan § Drafts F1 … F2' (which plan is not stated) and two classes in records whose headings were not found by script; a lane must point to the sentences")
ipd = flat(" ".join(rec_lines("IPD1", 363, 385)))
mb = re.search(r'\(b\) § Searching — Lean: \*"(.*?)"\*', ipd); mc = re.search(r'\(c\) § Searching — Lean: \*"(.*?)"\*', ipd)
lean_row("FS131-IPD1-b", "IPD1 (b)", ["- " + mb.group(1)], "S", "plans/FS131-IPD1-implementation.md l. 363–385, item (b)", "list B")
row("LEAN-IPD1-c", "LEAN.md § Searching — Lean: the private-declaration line (IPD1 (c))", "list B", "plans/FS131-IPD1-implementation.md l. 363–385, item (c)", "LEAN.md", "-", "filed", note="filed by FS131-FC4 (commit c26151a0b, the FS131-LP1 drafts), in the words of IPD1's line")
row("LEAN-IPD1-a", "LEAN.md § Assumptions 'after the adaptation line' (IPD1 (a)) ", "list B", "plans/FS131-IPD1-implementation.md l. 367–371", "LEAN.md", "'the adaptation line' of § Assumptions: 0 occurrences of 'adaptation line' or 'An adaptation' in LEAN.md", "CHECK", note="the line it follows is absent from LEAN.md (it belongs to the unfiled plan draft F1)", cnt=0)
row("LEAN-IPD1-d", "LEAN.md § Building: the symbolic-copy farm sentence (IPD1 (d))", "list B", "plans/FS131-IPD1-implementation.md l. 378–381", "LEAN.md", "-", "filed", note="the sentence 'A module whose upstream must change before it can elaborate (a port whose name an upstream axiom holds) …' stands in § Building; filed by an earlier filing (its commit not probed here)")
b23a = lblock("IP23", 285); b23s = lblock("IP23", 301)
lean_row("FS131-IP23-A", "IP23 D2", b23a, "A", "plans/FS131-IP23-implementation.md D2 (l. 285)", "list B")
lean_row("FS131-IP23-S", "IP23 D3", b23s, "S", "plans/FS131-IP23-implementation.md D3 (l. 301)", "list B")
lean_row("FS131-ITT1", "ITT1", lblock("ITT1", 256), "S", "plans/FS131-ITT1-implementation.md § at l. 256", "list B")

# ---------------- bibliography reading-status drafts: located, counted, not filed in stage 3 ----------------
def keyrows(key): return len(re.findall(r"^\| (?:\*\*)?`?\[" + re.escape(key) + r"\]", rd("BIBLIOGRAPHY.md"), flags=re.M))
def bibrow(id, item, source, draft, key, probe=None, extra=""):
    n = keyrows(key); filed = probe and (flat(probe) in flat(rd("BIBLIOGRAPHY.md")))
    st = "filed" if filed else ("ready" if n == 1 else "CHECK")
    row(id, item, source, draft, "BIBLIOGRAPHY.md", f"the end of the last (reading-status) cell of the row for [{key}] ({n} row(s) start with that key)", st, cnt=n,
        note=(extra + " NOT filed in stage 3: the script for a table-cell append was not written inside this job's budget; the slot is exact").strip() if st == "ready" else extra)
bibrow("BIB-EL-KN7", "BIBLIOGRAPHY [EinsiedlerLindenstrauss2022] reading status: KN7's pages read", "list B (bibliography lines)", "plans/FS131-KN7-chain-next.md l. 664–666", "EinsiedlerLindenstrauss2022", "p. 4 § 1.3's two constructions, § 4's opening")
bibrow("BIB-OAI-KN7", "BIBLIOGRAPHY [OAIMath2026] reading status: KN7's family-015 files elaborated", "list B", "plans/FS131-KN7-chain-next.md l. 666–669", "OAIMath2026", "family 015's `PrimePackets/KernelEntropy.lean` ll. 220–558")
bibrow("BIB-EL-KN3", "BIBLIOGRAPHY [EinsiedlerLindenstrauss2022] reading status: KN3's re-read of pp. 1–4", "list B/C (KN3)", "plans/FS131-KN3-chain-plan.md l. 415–420", "EinsiedlerLindenstrauss2022", "pp. 1–4 of arXiv v1 re-read from the PDF's text layer by FS131-KN3")
bibrow("BIB-OAI-KN3", "BIBLIOGRAPHY [OAIMath2026] family 015 entropy development surveyed (KN3)", "list B/C (KN3)", "plans/FS131-KN3-chain-plan.md l. 417–", "OAIMath2026", "its entropy development surveyed by statement (FS131-KN3")
bibrow("BIB-Rudin-KN8", "BIBLIOGRAPHY [Rudin1962] reading status: §§ 1.5, 2.1 cited, not read (KN8)", "list B (Rudin1962)", "plans/FS131-KN8-chain-split.md l. 503–506", "Rudin1962", "§§ 1.5 (the duality theorem), 2.1")
bibrow("BIB-Rudin-KPD1", "BIBLIOGRAPHY [Rudin1962] reading status appended (KPD1)", "list B (Rudin1962)", "plans/FS131-KPD1-pontryagin.md l. 392–394", "Rudin1962", "§§ 1.7 (the duality theorem) and 2.1 (annihilators)")
bibrow("BIB-KR1-Ambrus", "BIBLIOGRAPHY [AmbrusEtAl2023] reading status: Thm 1 re-read (KR1 § 6.2)", "list B", "plans/FS131-KR1-chain-map.md § 6.2 l. 384", "AmbrusEtAl2023", "re-read from the PDF's text layer by FS131-KR1")
bibrow("BIB-KR1-Rudin-Kak", "BIBLIOGRAPHY [Rudin1962], [Kakutani1938] cited by KR1's modules (§ 6.2)", "list B (Rudin1962)", "plans/FS131-KR1-chain-map.md § 6.2 l. 386", "Kakutani1938", "cited by FS131-KR1's modules")
bibrow("BIB-KR1-Levitz", "BIBLIOGRAPHY [LevitzMott1972] cited by Rigidity/BochnerTau (KR1 § 6.2)", "list B", "plans/FS131-KR1-chain-map.md § 6.2 l. 388", "LevitzMott1972", "cited by `Rigidity/BochnerTau`")
bibrow("BIB-KR1-KMOR", "BIBLIOGRAPHY [KMOR2016], [BachocEtAl2014], [Zhang2012] cited, not read (KR1 § 6.2)", "list B (KMOR2016)", "plans/FS131-KR1-chain-map.md § 6.2 l. 389–390", "KMOR2016", "cited in `plans/FS131-KR1-chain-map.md` § 2.5")
bibrow("BIB-K12A-Zhang", "BIBLIOGRAPHY [Zhang2012] reading status: Thm 1.8's counting typed (K12A § 6.2)", "list B", "plans/FS131-K12A-count.md § 6.2", "Zhang2012", "Thm 1.8's counting (social and lonely points) typed as")
bibrow("BIB-K12A-Bachoc", "BIBLIOGRAPHY [BachocEtAl2014]: off the count's path (K12A § 6.2)", "list B", "plans/FS131-K12A-count.md § 6.2", "BachocEtAl2014", "off the count's path since FS131-K12A")
bibrow("BIB-K12A-Ambrus", "BIBLIOGRAPHY [AmbrusEtAl2023]: read by K12A only through the typed statement (K12A § 6.2)", "list B", "plans/FS131-K12A-count.md § 6.2", "AmbrusEtAl2023", "read by FS131-K12A only through")
row("BIB-Tate-Weil", "BIBLIOGRAPHY: two new rows [Tate1950] and [Weil1967], 'not held, not read' (KN9; KN8 names the same two) ", "list B", "plans/FS131-KN9-chain-zero-entropy.md l. 452–458; plans/FS131-KN8-chain-split.md l. 503–508", "BIBLIOGRAPHY.md", "new table rows (position not named); `[Tate1950]` has %d row(s) already, `[Weil1967]` %d" % (keyrows("Tate1950"), keyrows("Weil1967")), "CHECK",
    note="two drafts touch the same rows (KN8 'a row … if the coordinator takes the declared route', KN9 'a row'); the table's insertion point and the rows' other columns are not drafted beyond role and 'not held, not read'")
row("BIB-Schur1912", "BIBLIOGRAPHY: Schur 1912, key Schur1912, 'recalled, not read'", "list B", "no draft found in the records scanned (named only by the 2026-10-14 handoff)", "BIBLIOGRAPHY.md", "-", "filed", note="a row `[Schur1912]` stands in BIBLIOGRAPHY.md (1 occurrence of the key); whether its words are the lane's draft was not checked")
row("BIB-AmbrusJ0", "BIBLIOGRAPHY [AmbrusEtAl2023]: p. 18's sign of J0′ (erratum line for the reading status)", "list B (895; IDB2)", "inventory item 895 names it ('not material'); IDB2's record not scanned for the line", "BIBLIOGRAPHY.md", "-", "no draft", note="0 occurrences of 'J₀′' in BIBLIOGRAPHY.md; the words of the erratum are not in item 895")
row("BIB-KDB1-KMOR-Ambrus", "BIBLIOGRAPHY [AmbrusEtAl2023] and [KMOR2016] read/role columns (KDB1)", "list B", "plans/FS131-KDB1-density-bound.md l. 315", "BIBLIOGRAPHY.md", "-", "filed", note="filed by FS131-FC6 (commit 47e4b168d): its drafts 10 and 11 took KDB1's lines")
row("BIB-PS2", "FS131-PS2's bibliography drafts D1-D5 (item 955)", "list A", "kept privately with the cleaning pass's record (not in this repository)", "BIBLIOGRAPHY.md", "-", "filed", note="filed by commit 228e3a3a4 (item 961): its message says 'D1, D2, D4, D5 filed'; D3 is not named as filed and its words are not in this repository: CHECK for the coordinator")

# ---------------- EN1 § 8.3 ----------------
EN1 = "plans/FS131-EN1-derivation.md"; te = flat(rd(EN1))
me = re.search(r'`LEDGER\.md`, row 121, the source cell\*\* — a correction owed\. It reads: "(.*?)"\. Proposed: "(.*?)"\. Source: § 6\.2', te)
row("L121src", "LEDGER row 121's source cell: four inputs not on the proof's path (EN1 § 8.3; item 651)", "lists A, C (651; 'notes for row 121')", EN1 + " § 8.3, first bullet", "LEDGER.md", me.group(1), "ready", cnt=count("LEDGER.md", me.group(1)), apply=repl_apply("LEDGER.md", me.group(1), me.group(2)))
for rid, item, src, draft, why in (
  ("ERR-FS84-N1", "plans/FS84-SI-D-derivation.md: dated erratum under J45-N1's 'Rests on it' line (EN1 § 8.3)", "list C (651), list B (J45's erratum, item 873 names the same file)", EN1 + " § 8.3, second bullet", "the target is a derivation record outside this brief's touches (front files and stubs only); its words are drafted, its slot ('under J45-N1's \"Rests on it\" line') not checked"),
  ("ERR-FS100-Q47", "plans/FS100-derivation.md: dated erratum under FS100-Q47 (EN1 § 8.3)", "list C (651)", EN1 + " § 8.3, third bullet", "the target is a derivation record outside this brief's touches"),
  ("ERR-FS100-L5", "plans/FS100-three-field-lemma.md § R-close 1.2, link L5 (EN1 § 8.3)", "list C (651)", EN1 + " § 8.3, fourth bullet", "EN1 says 'no erratum drafted'; outside touches"),
  ("ERR-K47", "plans/FS100-K-kernel-47.md l. 84 and l. 123: node M's 'm(E) = 0 (N1)' (EN1 § 8.3)", "list C (651)", EN1 + " § 8.3, fifth bullet", "logged as a slip of the old map, no words drafted; outside touches"),
  ("ERR-J45-KM11", "J45's erratum: rotation-invariance of A_∅ is 'routine, not new mathematics' (item 873; KM11)", "list B (873)", "inventory item 873 and plans/FS131-KM11-aplus.md (a correction owed to J45; the erratum's words not found drafted)", "target plans/FS84-SI-D-derivation.md is outside the brief's touches and no draft words were found")):
    row(rid, item, src, draft, None, None, "CHECK", note=why)
# ---------------- items with no draft, or a draft whose slot is outside the brief's touches ----------------
nd = lambda id, item, src, says, now="": row(id, item, src, "no draft found", None, None, "no draft", note=(says + (" Now: " + now if now else "")))
nd("DIRECTION", "the direction change on the front page: CLAUDE.md § The aim takes W1 and W2; the open-milestones line (item 636)", "list C (636; the handoff of 2026-10-13 § 7)", "the lists say CLAUDE.md should take W1 (wind down and publish) and W2 ('Any finding of ours must be formalized') and the open-milestones line; no lane drafted the text (W1, W2 are verbatim in data/fs131/REQUEST-2026-10-13.md).", "CLAUDE.md § The aim ends 'the regularity wall …' with no wind-down clause; § Publication says nothing is published before it is formalized in Lean (Kooshi, 2026-10-03).")
nd("FALC-RED", "LEDGER: the row holding FS129-SA1-FALC-RED states chi_m >= k+1 for Falconer's number; its kernel form is for the Borel number (item 684; FS131-LC1 draft 13)", "list C (684)", "FS131-LC1 draft 13 says 'Not drafted as a replacement'.", "row 152 (the 'Falconer's fan' row) reads '… so χ_m(ℝ²) ≥ k + 1 for Falconer's everywhere-proper measurable chromatic number\" (FS129-SA1-FALC-RED; `[Falconer1981]` Lemmas 1–4 che…' (2 occurrences of FALC-RED in LEDGER.md)")
nd("WRITEUP-BANNER", "plans/STUB-writeup-main-clause-five.md: banner and fifth theorem (items 644, 655)", "list C (644)", "item 644 says the banner and the fifth theorem are 'in print and stronger since the outside release'; PN1 § 3.7 says what 'reads wrongly now' but drafts no replacement words.", "the stub's banner still leads with the collapse to a measurable number; theorem 5 still reads 'χ(ℝ²) ≥ 5 with no witness object'")
nd("PRICE-DENSITY", "the density bound's formalization price in items 818 and 823 ('3–6 agent-weeks') -> KDB1's price", "list B (845)", "item 845 says the price in items 818 and 823 is replaced by about 2,100–3,200 lines / 2.5–3.5 active hours; both are inventory items (this repository's records), not front files.", "'3–6 agent-weeks' occurs 0 times in CLAUDE.md, LEDGER.md, LEAN.md, BIBLIOGRAPHY.md, ARCHITECTURE.md, CLOSED-QUESTIONS.md, plans/FRONTIER-STUBS.md")
nd("PRICE-M13", "M13's prices (items 848, 893, 905)", "lists A, B", "848: the q ∈ {11,19} branch alone is 3,500–6,700 lines, the map's 2,500–5,000 omitted the soundness; 893: 2,800–4,500 lines left; 905: Lemma P 617 lines, exclusions 60 vs 300–500, exact spectra 200 + 300–600 vs 700–1,200. The prices live in plans/FS131-KR1-chain-map.md (outside the brief's touches).", "'2,500–5,000' occurs 0 times in the front files")
nd("PRICE-K2", "K2's price (item 886): about 2,450 lines against 1,550–2,000", "list B", "a price in plans/FS131-KC13-certificates.md / item 869 (outside the touches); no words drafted.")
nd("PRICE-F2", "F2's price / design (items 902; list A 'F2's design')", "lists A, B", "902: 40–50 minutes of kernel CPU, not the planner's 30; the design changes Cert and certOK; the words are not drafted for any file.")
nd("PRICE-OTHERS", "the dyadic certificates, IKC4, and the search's estimate (list A's 'prices to correct')", "list A", "the handoff names them without an item number; no draft found by search of the inventory items 893–915 for 'correction owed'.")
nd("EN1-UQ4", "EN1-UQ4's grade line (list A)", "list A", "the gate warned 'prior art owed' on EN1-UQ4 (item 651); the entry's grade reads '[hand + computed exactly at Q = 64, 128, 256] … one mind; no second mind; prior art owed'; no lane drafted a changed grade line.")
nd("J26-J49", "a grade note on J26/J49's records (plans/FS100-KT1-ambrus-ball.md and those it cites) (item 845)", "list B", "item 845: their checks rest on Watson §§ 13.74 and 15.31 which the route does not need; verdicts unchanged. Outside the touches; words not drafted.")
nd("EXT-OAI1", "plans/EXT-OAI1-audit.md: '16,600 → 12,005 lines'", "list B", "the audit (l. 699) reads 'six to eight jobs; about 16,600 lines'; the handoff gives the new number; outside the touches; no draft words.")
nd("VACUITY", "scripts/Vacuity.lean l. 561", "list B", "a file under scripts/, which this brief fences; no draft.", "l. 561 is a comment about 'imported `proper_to_borel_weak`' (whether stale was not judged)")
nd("KDB1-PROTO", "KDB1's prototype truncation of one 21-decimal coefficient (item 911)", "list B", "the correction is to data/fs131/kdb1/proto/proto_atoms.py, a planning instrument, outside the touches; no words drafted.")
nd("IDB1-HEAD", "the IDB1 record's mis-headed last section (item 895)", "list B", "plans/FS131-IDB1-implementation.md 'last section is headed as FS133-LD1's drafts … line 264 — a copy slip'; the record is outside the touches; no words drafted.")
nd("FS133-PRED", "FS-133's deriver's predictions to score", "list B", "scoring a prediction is a judgment, not the Clerk's; no draft found.")
row("DUPES+1", "the --dupes '+1 run'", "list B", "tooling; part of stage 4", None, None, "no draft", note="run in stage 4 (output under data/fs131/fc8/)")
row("README-HASH", "the README's 'gated at commit' hash", "list A", "the brief and the handoff of 2026-10-16 § 4 item 3 record it done ('752b11569')", None, None, "filed", note="done before this job, by the brief's account; not re-read")
row("FS136-NOTE", "FS-136's record note: the same dated parenthesis for C136-PARTNERS (FS124-F2 ruling 3 / item 52 (3))", "list C", "inventory item 52 of plans/FS124-close-inventory.md names it ('in the landing's words … `IsTriodCut.exists_opposite`'); the landing's words: plans/FS124-L2-landing.md draft 11 (c)", None, None, "CHECK",
    note="the target is FS-136's derivation record (plans/FS136-derivation.md), outside this brief's touches; the words are in the landing's draft 11 (c), which was filed in FS124-F2's filing for the FS-124 record")
row("RERANK", "the asking lane's parked re-rank draft (FS136-P2): FS-137 to rank 1, FS-136 to the open milestones, the stub line for plans/STUB-q-ring.md", "list C (636 (c), the handoff § 7)", "plans/POROS-2026-10-07-fs136-derived.md § Draft re-rank (l. 335–)", "plans/FRONTIER-STUBS.md", "the ranked-stubs table's row 1 (FS-136) and the open-milestones paragraph", "CHECK",
    note="filing it would re-rank the frontier: today's front page ranks FS-136 first and holds FS-137 unranked ('until the asking lane ranks it'), and item 636 (c) parked the frontier's open jobs; a ranking is the coordinator's and the asking lane's, not a copy")
row("AXIOMS-ARCH", "ARCHITECTURE.md § Trust: KN3 § 5.3 item 4's line with '(its σ-algebra … Borel one of the quotient (FS131-KN7))' added (KN7)", "list B (KN7 names it; not in the handoff's wording)", "plans/FS131-KN7-chain-next.md l. 663–664", "ARCHITECTURE.md", "§ Trust 'at the first landing that proves a record from the axiom'", "CHECK", note="conditional on a landing; the chain landed (FS131-LGT1) and § Trust may already carry the line: not probed")
