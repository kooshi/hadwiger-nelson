"""J24 stage 4: stub banners (M1 4.5, M2 4e, M3 R4.S and R5.1, J29), the five new stubs numbered FS-92..96, and the provisional-bearings
lines for G77 and G78 (WORKFLOW 9's forward propagation). Banners go under each stub's title, newest first (the files' convention).
Run: python3 data/crunch-2026-09-25/j24/stubs_apply.py [--dry] [--plant]"""
import re, sys
from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
DRY = '--dry' in sys.argv or '--plant' in sys.argv
errors = []
def renum(s):
    s = re.sub(r'(?<![A-Za-z0-9_₀-₉])N([1-5])(?![0-9])', lambda m: str(97 + int(m.group(1))), s)
    s = re.sub(r'\bnext-([a-e])\b', lambda m: str(103 + 'abcde'.index(m.group(1))), s)
    s = re.sub(r'(rows? )next\+2\b', r'\g<1>110', s); s = re.sub(r'(rows? )next\+1\b', r'\g<1>109', s)
    s = re.sub(r'rows next\+1, next\+2', 'rows 109, 110', s)
    s = re.sub(r'(rows? )next\b(?![-+–])', r'\g<1>108', s)
    for a, b in (('FS-M1a', 'FS-92'), ('FS-M1b', 'FS-93'), ('FS-M1c', 'FS-94')): s = s.replace(a, b)
    s = s.replace('`plans/STUB-rank-one-walls.md`', 'FS-95 (`plans/STUB-rank-one-walls.md`)').replace('`plans/STUB-windows-five-nonmixing.md`', 'FS-96 (`plans/STUB-windows-five-nonmixing.md`)')
    return s
P1 = (ROOT / 'plans/FS91-character-local-global.md').read_text()
P2 = (ROOT / 'plans/M2-kernel-lane.md').read_text()
P3 = (ROOT / 'plans/M3-exotic-colourings.md').read_text()
def sect(t, a, b): s = t.index(a); return t[s:t.index(b, s)]
banners = {}   # stub path -> list of paragraphs, in the order M1, M2, M3, J29
def add(path, text): banners.setdefault(path, []).append(renum(' '.join(text.split())))
for line in sect(P1, '#### 4.5', '#### 4.6').splitlines():
    m = re.match(r'^\| FS-\d+ `(plans/STUB-[^`]+)` \| > (.*) \|$', line)
    if m: add(m.group(1), m.group(2))
for m in re.finditer(r'^- \*\*`(plans/STUB-[^`]+)` \(FS-\d+\)(?:\.\*\*|\*\*, a pointer line:) "(.*?)"\s*$(?=\n- |\n\n)', sect(P2, '#### 4e.', '#### 4f.'), re.M | re.S):
    add(m.group(1), m.group(2))
s3 = sect(P3, '#### R4.S', '#### R4.Bib')
for m in re.finditer(r'^- `(plans/STUB-[^`]+)` \(FS-\d+\): "> (.*?)"\s*$(?=\n- |\n\n)', s3, re.M | re.S):
    add(m.group(1), m.group(2))
f49 = re.search(r'- \*\*FS-49\*\* \(rank 27\): append "(.*?)" \*\*Placement', sect(P3, '#### R4.F', '#### R4.S'), re.S)
if f49: add('plans/STUB-distance-two-gadget.md', f49.group(1))
else: errors.append('FS-49 line')
f67 = re.search(r'Append to FS-67\'s row in `plans/FRONTIER-STUBS.md`:\n"(.*?)"\n', P3, re.S)
if f67: add('plans/STUB-tight-product-colourings.md', f67.group(1))
else: errors.append('FS-67 line')
add('plans/STUB-five-colours-47.md', "**J29's reframe (2026-09-25; `plans/FS84-five-colours-47.md`, its stages from 2026-10-01):** the survivors' `Θ₄` cell analysis can only colour a survivor (G71, row 96); a refusal needs a finite graph or a four-class averaged certificate; `χ(ℚ(√47)²) = 5` answers Soifer 55.1 and Moorhouse's ℚ(√47) question.")
add('plans/STUB-window-frequency-certificate.md', "**J29 (2026-09-25; `plans/FS84-five-colours-47.md`):** ℚ(√47) is a target beside ℚ(√167) — its fractional cap `121/28 > 4`.")
# provisional bearings for the grokkings minted at these closes (WORKFLOW 9)
BEAR = {
 'plans/STUB-four-colours-167.md': "G77 (a character colouring here needs eight colours given CLG, row 101 — look for colourings no character gives) and G76 (the window format at five, row 110)",
 'plans/STUB-adelic-window-colouring.md': "G77 (the one-place, windowless case is a character colouring: existence only, row 100) and G76's five-colour mixing sentence (row 110)",
 'plans/STUB-five-colours-47.md': "G77 (no character four-colouring at any `L = 5` field, CLG-g's (g1))",
 'plans/STUB-four-colour-inheritance.md': "G78 (rank one is countable ⟹ finite; frozen walls are invisible to Kempe arguments, row 108) and G77 (characters cannot break inheritance where CLG classifies, row 100)",
 'plans/STUB-window-frequency-certificate.md': "G78 (in rank one the Kempe route cannot see a frozen wall — an averaged certificate is not a Kempe argument, row 108)",
 'plans/STUB-kempe-classes.md': "G78 (Kempe moves only relabel at frozen tails; FW rules out every Kempe-move invariant in rank one, row 108)",
 'plans/STUB-tight-product-colourings.md': "G76's mixing sentence (a factor leaves a product colouring when it mixes, not when its ratio is small, row 109)",
 'plans/STUB-certificate-at-43.md': "G76's mixing sentence and row 110 (43 is the one finite place the window count at five still needs)",
}
for p, b in BEAR.items():
    banners.setdefault(p, []).append(f"**Provisional bearings, updated at the 2026-09-25 crunch's close (M1–M3):** {b}.")
expect = {'plans/STUB-band-rigidity-six.md', 'plans/STUB-three-colours-residue-degree-three.md', 'plans/STUB-layer-method-five-colours.md',
  'plans/STUB-four-colours-167.md', 'plans/STUB-adelic-window-colouring.md', 'plans/STUB-five-colours-47.md', 'plans/STUB-three-colour-criterion-kernel.md',
  'plans/STUB-unit-vector-ring-kernel.md', 'plans/STUB-biquadratic-table.md', 'plans/STUB-three-colour-classification.md', 'plans/STUB-plane-bridge.md',
  'plans/STUB-chain-theorem.md', 'plans/STUB-de-grey-chain-kernel.md', 'plans/STUB-field-level-criteria.md', 'plans/STUB-four-colour-inheritance.md',
  'plans/STUB-distance-two-gadget.md', 'plans/STUB-certificate-at-43.md', 'plans/STUB-tight-product-colourings.md', 'plans/STUB-window-frequency-certificate.md',
  'plans/STUB-kempe-classes.md'}
if set(banners) != expect: errors.append(f'banner set differs: {sorted(set(banners) ^ expect)}')
counts = {'M1': len(re.findall(r'^\| FS-\d+ `plans/STUB', sect(P1, '#### 4.5', '#### 4.6'), re.M))}
if counts['M1'] != 11: errors.append(f'M1 banners {counts}')
if '--plant' in sys.argv: banners['plans/STUB-no-such-stub.md'] = ['x']
out = {}
for path, paras in banners.items():
    f = ROOT / path
    if not f.is_file(): errors.append(f'missing {path}'); continue
    t = f.read_text(); first, rest = t.split('\n', 1)
    if not first.startswith('# '): errors.append(f'{path}: no title'); continue
    for p in paras:
        if 'next' in re.sub(r'`[^`]*`', '', p) and re.search(r'\brows? next', p): errors.append(f'{path}: placeholder left')
    out[path] = first + '\n\n' + '\n\n'.join(paras) + '\n' + rest
# the five new stubs: their numbers
NEW = {'plans/STUB-character-classification.md': ('FS-M1a', 'FS-92'), 'plans/STUB-pyjama-gluing.md': ('FS-M1b', 'FS-93'),
       'plans/STUB-one-prime-minimal-sets.md': ('FS-M1c', 'FS-94'), 'plans/STUB-rank-one-walls.md': ('FS-(new)', 'FS-95'),
       'plans/STUB-windows-five-nonmixing.md': ('FS-(new)', 'FS-96')}
for path, (old, new) in NEW.items():
    t = out.get(path) or (ROOT / path).read_text()
    if old not in t: errors.append(f'{path}: {old} absent'); continue
    t = re.sub(r'until then (this stub is )?"' + re.escape(old) + r'"', f'numbered {new} there', t)
    t = re.sub(r'The FS number is assigned by the\s+front-page job\.', f'Numbered {new} by the front-page job (J24).', t)
    t = t.replace(old, new)
    if path == 'plans/STUB-rank-one-walls.md':
        t = t.replace('G77 (drafted at M3\'s close:', 'G78 (minted at M3\'s close:')
        if 'G77' in t: errors.append('rank-one-walls: G77 left')
    for o2, n2 in (('FS-M1a', 'FS-92'), ('FS-M1b', 'FS-93'), ('FS-M1c', 'FS-94')): t = t.replace(o2, n2)
    t = renum(t) if path.endswith(('walls.md', 'nonmixing.md')) else t
    out[path] = t
if errors:
    print('ERRORS:'); [print(' ', x) for x in errors]; sys.exit(1)
print(f'{len(out)} stub files; banners: {sum(len(v) for v in banners.values())} paragraphs')
if not DRY:
    for path, t in out.items(): (ROOT / path).write_text(t)
