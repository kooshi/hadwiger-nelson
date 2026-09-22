#!/usr/bin/env python3
"""Independent checks of ARCHITECTURE.md against the code. Run it after any edit to the module map; it shares no code with whatever wrote the map: the import graph
comes from scripts/build_order.py, names from a fresh scan of Proofs/, purchases from scripts/Axioms.lean."""
import re, sys, importlib.util
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
path = Path(sys.argv[1]) if len(sys.argv) > 1 else REPO / 'ARCHITECTURE.md'
arch = path.read_text()
failures = []


def fail(msg):
    failures.append(msg)
    print('FAIL', msg)


# ---- 1/2: coverage and imports, against scripts/build_order.py --------------------------------------
spec = importlib.util.spec_from_file_location('bo', REPO / 'scripts/build_order.py')
bo = importlib.util.module_from_spec(spec)
spec.loader.exec_module(bo)
graph = bo.modules()
P = 'Proofs.HadwigerNelson.'


def short(k):
    return 'Basic' if k == 'Proofs.Basic' else k[len(P):].replace('.', '/')


mods = {short(k): {short(i) for i in v} for k, v in graph.items() if k != 'Proofs'}
GEN = re.compile(r'^Instances/[^/]+/(Cnf|HalfA|Critical)/')
hand = {m for m in mods if not GEN.match(m)}

sec3 = arch.split('\n## 3. ', 1)[1].split('\n## 4. ', 1)[0]
rows, famrows = {}, []
for ln in sec3.splitlines():
    if not ln.startswith('| `'):
        continue
    cells = [c.strip() for c in ln.strip().strip('|').split(' | ')]
    name = cells[0].strip('`')
    if name.endswith('/'):
        famrows.append(cells)
        continue
    if name in rows:
        fail(f'module named in two rows: {name}')
    rows[name] = cells


def expand(cell):
    out = set()
    if cell.strip() == '—':
        return out
    for tok in re.findall(r'`([^`]+)`', cell):
        m = re.match(r'^(.*?)(\d+)…(\d+)$', tok)
        if m:
            w = len(m.group(2))
            out |= {f'{m.group(1)}{i:0{w}d}' for i in range(int(m.group(2)), int(m.group(3)) + 1)}
        else:
            out.add(tok)
    return out


miss, extra = sorted(hand - set(rows)), sorted(set(rows) - hand)
print(f'[1] non-generated modules on disk: {len(hand)}; module rows in § 3: {len(rows)}; missing: {miss}; extra: {extra}')
if miss or extra:
    fail('module coverage')
top = sorted(p.stem for p in (REPO / 'Proofs/HadwigerNelson').glob('*.lean'))
inst = sorted(m for m in hand if m.startswith('Instances/'))
print(f'    Proofs/HadwigerNelson/*.lean: {len(top)} files, {sum(t in rows for t in top)} named; '
      f'non-generated Instances modules: {len(inst)}, {sum(i in rows for i in inst)} named')
mism = 0
for name, cells in rows.items():
    stated, real = expand(cells[2]), mods[name]
    if stated != real:
        mism += 1
        fail(f'imports of {name}: stated-only {sorted(stated - real)}, real-only {sorted(real - stated)}')
print(f'[2] Imports cells vs scripts/build_order.py: {len(rows)} rows compared, {mism} mismatches')

for cells in famrows:
    fam = cells[0].strip('`')
    members = {m for m in mods if m.startswith(fam)}
    n_disk = len(list((REPO / 'Proofs/HadwigerNelson' / fam).glob('*.lean')))
    outside = {i for m in members for i in mods[m] if not i.startswith(fam)}
    consumers = {m for m in hand if mods[m] & members}
    okc = int(cells[2].replace(',', '')) == n_disk == len(members)
    oki, oku = expand(cells[3]) == outside, expand(cells[4]) == consumers
    print(f'    family {fam}: count {"ok" if okc else "BAD"} ({n_disk}), imports {"ok" if oki else "BAD"}, consumers {"ok" if oku else "BAD"}')
    if not (okc and oki and oku):
        fail(f'family row {fam}')
gen_total = sum(1 for m in mods if GEN.match(m))
stated_total = sum(int(c[2].replace(',', '')) for c in famrows)
print(f'    generated files on disk {gen_total}, in family rows {stated_total}')
if gen_total != stated_total:
    fail('family totals')

# ---- 3: every backticked Lean identifier exists ------------------------------------------------------
names = set()
decl = re.compile(r"^\s*(?:@\[[^\]]*\]\s*)?(?:(?:private|protected|noncomputable|nonrec|partial|unsafe)\s+)*"
                  r"(?:theorem|lemma|def|abbrev|structure|inductive|class|instance|opaque|axiom)\s+([^\s:({\[]+)", re.M)
for f in (REPO / 'Proofs').rglob('*.lean'):
    if re.search(r'/(Cnf|HalfA)/', str(f)):
        continue
    s = f.read_text(errors='replace')
    for n in decl.findall(s):
        names.add(n)
        names.update(n.split('.'))
    for n in re.findall(r'^namespace\s+(\S+)', s, re.M):
        names.update(n.split('.'))
    for n in re.findall(r"^\s{2,}([A-Za-z_][\w₀-₉']*)\s*:", s, re.M):
        names.add(n)
toks = sorted(set(re.findall(r'`([^`\n]+)`', arch)))
idents = [t for t in toks if re.fullmatch(r"[A-Za-z_][\w.'₀-₉]*", t) and '/' not in t]
unknown = [t for t in idents if t.split('.')[-1] not in names]
print(f'[3] backticked single-token identifiers: {len(idents)}; not declared anywhere in Proofs/: {unknown}')


# ---- 3b: dotted identifiers: the prefix must be the declaration's own dotted name or a namespace in its file
decl_files = {}
for f in (REPO / 'Proofs').rglob('*.lean'):
    if re.search(r'/(Cnf|HalfA)/', str(f)):
        continue
    s2 = f.read_text(errors='replace')
    nss2 = set()
    for n in re.findall(r'^namespace\s+(\S+)', s2, re.M):
        parts = n.split('.')
        nss2.update('.'.join(parts[i:]) for i in range(len(parts)))
        nss2.update(parts)
    for n in decl.findall(s2):
        decl_files.setdefault(n, []).append(nss2)
dotted_bad = []
for t in idents:
    if '.' not in t or t.split('.')[-1].endswith(('lean', 'md', 'py', 'sh')):
        continue
    if t.startswith(('Std.', 'Lean.', 'Nat.', 'Real.', 'Classical.', 'List.', 'SimpleGraph.chromaticNumber', 'DefaultClause.', 'Formula.', 'native_decide.')):
        continue
    parts = t.split('.')
    ok = False
    for i in range(1, len(parts)):
        prefix, rest = '.'.join(parts[:i]), '.'.join(parts[i:])
        if t in decl_files:
            ok = True
        for nss2 in decl_files.get(rest, []):
            if prefix in nss2:
                ok = True
    if not ok:
        dotted_bad.append(t)
print(f'[3b] dotted identifiers whose namespace could not be matched to a declaring file: {dotted_bad}')
# theorem names inside longer backticked spans (e.g. `Q4.eval : Q4 →+* ℝ`) are not checked; list the spans
# of the form `name …` whose first word is snake_case, so they can be eyeballed
spans = [t for t in toks if ' ' in t and re.match(r'^[a-z][\w.₀-₉]*_[\w.₀-₉]*\b', t)]
print(f'    multi-word spans starting with a snake_case word (checked by eye): {spans}')

# ---- 4: headings that other files cite ---------------------------------------------------------------
need = ['## 1. ', '## 2. ', '### 2.1 ', '### 2.2 ', '### 2.3 ', '## 3. ', '## 4. Roadmap', '## 5. Trust', '## 6. ', '## 7. ']
absent = [h for h in need if not re.search('^' + re.escape(h), arch, re.M)]
print(f'[4] cited headings (§ 2.1, § 2.3, § 3, § 4/§ Roadmap, § 5/§ Trust, § 6, § 7): missing {absent}')
if absent:
    fail('headings')
split_fact = 'Split.lean' in arch.split('## 4. Roadmap', 1)[1].split('## 5. Trust', 1)[0]
print(f'    § 4 carries the Split.lean stale-prose fact (cited by tools/emit_mask.py): {split_fact}')
if not split_fact:
    fail('split fact')


# ---- 5: trust purchases ------------------------------------------------------------------------------
def strip_comments(s):
    out, i, depth, n = [], 0, 0, len(s)
    while i < n:
        if s.startswith('/-', i):
            depth += 1
            i += 2
            continue
        if depth and s.startswith('-/', i):
            depth -= 1
            i += 2
            continue
        if depth:
            out.append('\n' if s[i] == '\n' else ' ')
            i += 1
            continue
        if s.startswith('--', i):
            j = s.find('\n', i)
            j = n if j < 0 else j
            out.append(' ' * (j - i))
            i = j
            continue
        out.append(s[i])
        i += 1
    return ''.join(out)


uses = []
for f in sorted((REPO / 'Proofs').rglob('*.lean')):
    s = f.read_text(errors='replace')
    if 'native_decide' not in s:
        continue
    code = strip_comments(s)
    for no, ln in enumerate(code.split('\n'), 1):
        if 'native_decide' in ln:
            uses.append(f'{f.relative_to(REPO)}:{no}')
print(f'[5] native_decide in code with comments stripped: {len(uses)} uses: {uses}')
trust = arch.split('### The purchases', 1)[1].split('\n**', 1)[0]
table = re.findall(r'^\| `([^`]+)` \|', trust, re.M)
ax = (REPO / 'scripts/Axioms.lean').read_text().split('=== PURCHASED ===', 1)[1]
env = re.findall(r'^#print axioms (\S+)', ax, re.M)
src = []
for f in (REPO / 'Proofs').rglob('*.lean'):
    s = f.read_text(errors='replace')
    for m in re.finditer(r'^/-- \*\*Trust purchase:.*?-/\s*\n(?:@\[[^\]]*\]\s*)?(?:theorem|def|lemma)\s+(\S+)', s, re.M | re.S):
        src.append(m.group(1))
print(f'    purchase table: {sorted(table)}')
print(f'    scripts/Axioms.lean PURCHASED: {sorted(env)}')
print(f'    source doc strings "Trust purchase": {sorted(src)}')
if not (sorted(table) == sorted(env) == sorted(src)):
    fail('purchase ledgers disagree')
if not all(u.startswith('Proofs/HadwigerNelson/Instances/SpindleBound.lean') for u in uses):
    fail('native_decide outside SpindleBound')

# ---- 6: cited paths exist ----------------------------------------------------------------------------
paths = [t for t in toks if ' ' not in t and ('/' in t or re.search(r'\.(lean|md|py|sh)$', t))
         and not re.search(r'[<…{*]', t)]
bad_paths = []
for p in paths:
    q = p.rstrip('/')
    cands = [REPO / q, REPO / 'Proofs/HadwigerNelson' / q, REPO / 'Proofs/HadwigerNelson' / (q + '.lean')]
    if not any(c.exists() for c in cands):
        bad_paths.append(p)
print(f'[6] backticked paths: {len(paths)}; not found: {bad_paths}')

# ---- 7: ledger rows named exist and mention the module or one of its identifiers --------------------
# the ledger lives in LEDGER.md since 2026-09-22 (extracted from CLAUDE.md § Frontier); fall back to CLAUDE.md for older trees
ledger_path = REPO / 'LEDGER.md' if (REPO / 'LEDGER.md').exists() else REPO / 'CLAUDE.md'
ledger_sec = ledger_path.read_text().split('### The novel-results ledger', 1)[1].split('\n### ', 1)[0]
ledger = {int(m.group(1)): m.group(2) for m in re.finditer(r'^\| (\d+) \|(.*)$', ledger_sec, re.M)}
soft = []
for name, cells in rows.items():
    rowcell = cells[3]
    if rowcell == '—':
        continue
    nums = set()
    for part in rowcell.split(','):
        part = part.strip()
        m = re.match(r'^(\d+)–(\d+)$', part)
        nums |= set(range(int(m.group(1)), int(m.group(2)) + 1)) if m else {int(part)}
    stem = name.split('/')[-1]
    ids = {t.split('.')[-1] for t in re.findall(r'`([^`]+)`', cells[1])}
    for r in sorted(nums):
        if r not in ledger:
            fail(f'{name}: ledger row {r} does not exist')
            continue
        text = ledger[r]
        if not (re.search(r'\b' + re.escape(stem) + r'\b', text) or any(i and i in text for i in ids)):
            soft.append((name, r))
print(f'[7] ledger rows cited exist; rows whose text mentions neither the module nor any identifier in its description: {soft}')

print('\nRESULT:', 'PASS' if not failures else f'{len(failures)} failure(s)')
sys.exit(1 if failures else 0)
