#!/usr/bin/env python3
"""FS131-FCS1: file FS131-ICS1's drafts D1-D8, D10, D12, D14 and FS131-PAS1 4.4 item 1, verbatim.
Draft texts are sliced from the plan files, never retyped. Every slot must occur exactly once
(whitespace-insensitive) before anything is written. PLANT=<n> alters slot n by one character (must fail).
Run from the worktree root: python3 data/fs131/fcs1/file.py [--dry]"""
import re, sys, os

DRY = '--dry' in sys.argv
PLANT = int(os.environ.get('PLANT', '0'))
ICS = open('plans/FS131-ICS1-class.md', encoding='utf-8').read()
PAS = open('plans/FS131-PAS1-prior-art.md', encoding='utf-8').read()

def flat(s): return re.sub(r'\s+', ' ', s).strip()

def draft(label):
    i = ICS.index('\n**%s ' % label, ICS.index('## Drafts for the front page'))
    j = re.compile(r'\n\n(\*\*D\d+ |## )').search(ICS, i + 3).start()
    return flat(ICS[i:j])

def between(p, a, b):
    i = p.index(a) + len(a)
    return p[i:p.index(b, i)]

SUBS = [("prior art not yet searched", "prior art not found in print as a classification (FS131-PAS1)"),
        ("statement not yet searched", "statement not found in print as a classification (FS131-PAS1)")]
subcount = {s[0]: [] for s in SUBS}
def subst(text, where):
    for a, b in SUBS:
        n = text.count(a)
        if n:
            subcount[a].append((where, n))
            text = text.replace(a, b)
    return text

edits = []  # (id, file, old, new)
def E(i, f, old, new): edits.append((i, f, old, new))
def lastq(p, a): return p[p.index(a) + len(a):-1]

p = draft('D1')
E('D1', 'CLAUDE.md', between(p, 'Replace "', '" with:'), between(p, 'with: "', '".'))
p = draft('D2')
E('D2a1', 'CLAUDE.md', "with sixty-four imported records (twelve of them the three-colour criterion's",
  "with eighty imported records (twelve of them the three-colour criterion's")
ins = between(p, 'closing parenthesis: "', '". (b)')
E('D2a2', 'CLAUDE.md', '`borelChromaticNumber_padicPlane_three`); from `[OAIMath2026]` family 158',
  '`borelChromaticNumber_padicPlane_three`' + ins + '); from `[OAIMath2026]` family 158')
E('D2b1', 'CLAUDE.md', "with twenty-seven, fourteen of which rest on Weil's bound too (",
  "with thirty-four, twenty-one of which rest on Weil's bound too (")
ins = between(p, 'insert "', '".')
assert ins.startswith(', and FS131-ICS1'), ins[:40]
E('D2b2', 'CLAUDE.md', "`Collapse/Headline`; the collapse's general form",
  '`Collapse/Headline`' + ins + "; the collapse's general form")
p = draft('D3')
E('D3', 'CLAUDE.md', between(p, 'Replace "', '" with "'), between(p, '" with "', '". (Check:'))
p = draft('D4')
E('D4', 'CLAUDE.md', between(p, 'Replace "', '" with "'), between(p, '" with "', '"; the second'))
p = draft('D5')
E('D5', 'CLAUDE.md', 'REGEX5', between(p, ' with "', '".'))
p = draft('D6')
new6 = subst(lastq(p, 'insert: "'), 'D6')
E('D6', 'plans/KERNEL-HOLDS.md', "the derivation is this project's, and the kernel's check is this landing's;",
  "the derivation is this project's, and the kernel's check is this landing's; " + new6)
p = draft('D7')
E('D7a', 'LEDGER.md', "the family (44 of 52, `d ≤ 3000`), CLS in full and ℚ(√23, ∛2) keep the derivation's grade:**",
  subst(between(p, 'with: "', '". And in the row'), 'D7'))
pa = between(p, 'after "', '", add: "').lstrip('…')
addp = subst(between(p, ', add: "', '" The row'), 'D7')
i = PAS.index('1. **`LEDGER.md` row 123**'); j = PAS.index('\n2. **`plans/FS100-derivation.md`', i)
q = flat(PAS[i:j])
pas1 = between(q, 'after *"so "not found", never "first"."*: *"', '"*')
# the row's prior-art sentence ends with pa; D7's sentence then PAS1's item follows at "never first" -- separate slots
E('D7b', 'LEDGER.md', pa, pa + ' ' + addp)
E('PAS1-1', 'LEDGER.md', 'so "not found", never "first".', 'so "not found", never "first". ' + pas1)
E('D7c', 'LEDGER.md', '`tools/x26b_spectra.py`, `tools/x26b_uq_colour.py` | FS-100 stage 5, wave 3 (crunch 2026-09-26) |',
  '`tools/x26b_spectra.py`, `tools/x26b_uq_colour.py`; `Proofs/HadwigerNelson/Instances/SqrtFiveClass.lean`, `Rigidity/FourColourPlaces.lean`, `Instances/SqrtTwentyThreeCbrtTwo.lean`, `Arith/StableAboveUsable.lean`; `plans/FS131-ICS1-class.md` | FS-100 stage 5, wave 3 (crunch 2026-09-26) |')
p = draft('D8')
E('D8a', 'ROADMAP.md', 'REGEX8', between(p, 'with: "', '" And in the appendix'))
E('D8b', 'ROADMAP.md', between(p, 'replace "', '" with "'), between(p, '" with "', '" (its kernel'))
p = ICS[ICS.index('**D10 '):ICS.index('**D11 ')]
bl = [flat(b) for b in re.split(r'\n(?=- ")', p[p.index('\n- "') + 1:].strip('\n'))]
assert len(bl) == 10, len(bl)
bullets = []
for b in bl:
    assert b.startswith('- "') and b.endswith('"'), b[:40]
    bullets.append('- ' + b[3:-1])
E('D10', 'LEAN.md', '(inventory item 1026).\n\n## The package', '(inventory item 1026).\n' + '\n'.join(bullets) + '\n\n## The package')
p = draft('D12')
E('D12', 'ARCHITECTURE.md', '`tca_of_five_le_localBound : 5 ≤ localBound F → TCA F`. | `Arith/WeilKloosterman`',
  '`tca_of_five_le_localBound : 5 ≤ localBound F → TCA F`. ' + between(p, 'description "', '"') + ' | `Arith/WeilKloosterman`')
p = draft('D14')
E('D14', 'CLOSED-QUESTIONS.md', 'REGEX14', p[p.index('): ') + 3:])

def rx(old):
    return re.compile(r'\s+'.join(re.escape(t) for t in old.split()))
SPECIAL = {
 'REGEX5': re.compile(r'Last filed: \*\*three colours on abelian Cayley graphs\*\* \(FS131-KTC1,.*?no value of `χ\(ℝ²\)` moved\); before it,', re.S),
 'REGEX8': re.compile(r'1\. \*\*Not stored as theorems\*\*.*?complex place\.', re.S),
 'REGEX14': re.compile(r'> \*\*And again in October 2026\*\* — `\[Davies2026\]` p\. 5[^\n]*\n'),
}
cache = {}
def load(f):
    if f not in cache: cache[f] = open(f, encoding='utf-8').read()
    return cache[f]
plan = []
for n, (i, f, old, new) in enumerate(edits, 1):
    text = load(f)
    if old in SPECIAL:
        pat = SPECIAL[old]
        ms = list(pat.finditer(text)) if PLANT != n else []
    else:
        o = old
        if PLANT == n: o = o[:-1] + ('X' if o[-1] != 'X' else 'Y')
        ms = list(rx(o).finditer(text))
    print('%-6s %-26s matches=%d' % (i, f, len(ms)))
    plan.append((i, f, ms, new))
bad = [x[0] for x in plan if len(x[2]) != 1]
if bad:
    print('FAIL: slots not found exactly once:', bad); sys.exit(1)
for a, c in subcount.items(): print('substitution', repr(a), c)
assert sorted(len(v) for v in subcount.values()) == [1, 1], subcount

# the moved Last-filed entry
m5 = [x for x in plan if x[0] == 'D5'][0][2][0]
par = re.search(r'(\(FS131-KTC1,.*?no value of `χ\(ℝ²\)` moved\));', m5.group(0), re.S).group(1)
moved = 'before it **three colours on abelian Cayley graphs** ' + par
fil = load('plans/FILINGS.md')
anchor = 'before it **the p-adic plane**'
assert fil.count(anchor) == 1
print('moved entry:', moved[:90], '...', moved[-60:])
if DRY:
    print('dry run: nothing written'); sys.exit(0)

byfile = {}
for i, f, ms, new in plan: byfile.setdefault(f, []).append((ms[0], i, new))
for f, lst in byfile.items():
    text = load(f)
    for m, i, new in sorted(lst, key=lambda t: -t[0].start()):
        if i == 'D14':
            text = text[:m.end()] + '\n> ' + new + '\n' + text[m.end():]
        else:
            text = text[:m.start()] + new + text[m.end():]
    open(f, 'w', encoding='utf-8').write(text)
fil = fil.replace(anchor, moved + '\n\n' + anchor, 1)
open('plans/FILINGS.md', 'w', encoding='utf-8').write(fil)
print('written')
