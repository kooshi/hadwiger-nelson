"""FS132-F1 stage 5: re-point atlas quotations (addresses and quote strings only) to the current words of the same fact."""
import sys
sys.path.insert(0, 'data/fs132/f1')
p = 'tools/viz_proof_atlas_facts.py'
s = open(p, encoding='utf-8').read()
log = []
def sub(old, new, count=1, label=''):
    global s
    n = s.count(old)
    assert n == count, f'{label}: expected {count} got {n} for {old[:70]!r}'
    s = s.replace(old, new)
    log.append(f'{label}: {n} replaced: {old[:90]!r} -> {new[:110]!r}')

# the range statement (A7, A6, A5 nodes and the six "half" edges)
sub('"χ(ℝ²) ∈ {5, 6, 7}"', '"χ(ℝ²) ∈ {6, 7}"', 2, 'range quote, CLAUDE.md § Where the problem stands')
# LB7 node, R128->LB7, M7->LB7
sub('"gives χ_m⁰(ℝ²) = 7, hence χ(ℝ²) = 7 given MR"', '"gives χ(ℝ²) = 7"', 3, 'LB7 and its two edges, CLAUDE.md § The aim link 5')
sub('"No — Voronov\'s contradiction survives a free colour of vanishing density — gives χ_m⁰(ℝ²) = 7"',
    '"No — Voronov\'s contradiction survives a free colour of vanishing density — gives χ(ℝ²) = 7"', 1, 'M7 node, link 5')
# UB6, UB5 nodes (same old string twice)
old_ub = '"Yes — such a sequence, with six or five colours — gives χ(ℝ²) ≤ 6, or = 5, with no MR"'
i6 = s.index('N("UB6"'); i5 = s.index('N("UB5"')
seg6 = s[i6:i5]; seg5 = s[i5:s.index('\n\n', i5)]
assert seg6.count(old_ub) == 1 and seg5.count(old_ub) == 1
s = s[:i6] + seg6.replace(old_ub, '"Yes — such a sequence with six colours — gives χ(ℝ²) = 6"') + s[i5:]
i5 = s.index('N("UB5"'); end5 = s.index('\n\n', i5)
s = s[:i5] + s[i5:end5].replace(old_ub, '"At five the answer is in: the holes stay of density bounded below"') + s[end5:]
log.append('UB6 node quote -> link 5 "Yes — such a sequence with six colours — gives χ(ℝ²) = 6"; UB5 node quote -> link 5 "At five the answer is in: the holes stay of density bounded below"')
# R130 node and edge
sub('"Given MR (row 128): χ(ℝ²) = χ_m⁰(ℝ²)"',
    '"With no hypothesis ([OAIMath2026] Thm 1.3; χ_m⁰ ≤ χ kernel-checked there and audited here, EXT-OAI1): χ(ℝ²) = χ_m⁰(ℝ²)"', 2, 'R130 node and edge, LEDGER.md row 130')
# MAPS6 (pre-existing failure on main: row 132's wording changed at FS131-E1)
sub('"maps need six modulo Townsend\'s simplification (c), which [Woodall1973]\'s steps 2, 3, 5 fill (in outline)"',
    '"maps need six for arc maps (segments and circular arcs), by [Woodall1973]\'s steps 1–6, step 6 repaired by Townsend\'s lemma"', 1, 'MAPS6 node (fails on main too), LEDGER.md row 132')
sub('"maps need six modulo Townsend\'s simplification (c)"', '"maps need six for arc maps (segments and circular arcs)"', 1, 'MAPS6->FS44 edge (fails on main too), row 132')
# FS120 node
sub('"the pinch at a junction, and the cover route at five: can a pinch in a measurable fall colouring of the plane be removed locally"',
    '"the pinch at a junction: can a pinch in a measurable fall colouring of the plane be removed locally"', 1, 'FS120 node, stub title line (M18)')
# FS104 node (src, quote, grade pair)
sub('(FS-104).", PF(3),\n  "is χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6 (row 130)?", (PF(3), "is χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6 (row 130)?"),',
    '(FS-104).", STUB("STUB-cp-plane-six.md"),\n  "Answered YES by citation, 2026-10-07: χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6", (STUB("STUB-cp-plane-six.md"), "Answered YES by citation, 2026-10-07: χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6"),', 1, 'FS104 node, stub banner (the ranked top-three row it quoted left CLAUDE.md)')
sub('E("R128", "LB6", "rests", PF(3), "a YES gives χ(ℝ²) ≥ 6 given MR (row 128)", bus=True)',
    'E("R128", "LB6", "rests", STUB("STUB-cp-plane-six.md"), "Answered YES by citation, 2026-10-07: χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6", bus=True)', 1, 'R128->LB6 edge, FS-104 banner')
sub('E("FS104", "LB6", "rests", PF(3), "a YES gives χ(ℝ²) ≥ 6 given MR (row 128)", label="its YES, given MR")',
    'E("FS104", "LB6", "rests", STUB("STUB-cp-plane-six.md"), "Answered YES by citation, 2026-10-07: χ_CP(ℝ²) = χ_m⁰(ℝ²) ≥ 6", label="its YES, given MR")', 1, 'FS104->LB6 edge, FS-104 banner')
sub('E("FS104", "FS44", "context", PF(3), "a NO (a CP five-colouring) gives χ(ℝ²) = 5 with no MR", label="its NO is this")',
    'E("FS104", "FS44", "context", STUB("STUB-fifth-colour-structure.md"), "a CP five-colouring of the plane does not exist", label="its NO is this")', 1, 'FS104->FS44 edge, FS-44 banner')
# FS80: moved from rank 14 to rank 19
sub('FSR(14)', 'FSR(19)', 3, 'FS80 rows: FRONTIER-STUBS ranked item 14 -> 19')
# FS44: its ranked row left the table; banner at the stub
sub('"lim µ₅(ε) = 1. Decisive if it lands: χ(ℝ²) = 5 with no MR (FS-44).", FSR(13),\n  "the shape of a CP five-colouring of the plane — FS-104\'s mirror",',
    '"lim µ₅(ε) = 1. Decisive if it lands: χ(ℝ²) = 5 with no MR (FS-44).", STUB("STUB-fifth-colour-structure.md"),\n  "a CP five-colouring of the plane does not exist",', 1, 'FS44 node, stub banner')
sub('words=(FSR(13), "the conjecture\'s bold form predicts no (G48)"))', 'words=({"file": "plans/RERANK-2026-09-27.md"}, "the conjecture\'s bold form predicts no (G48)"))', 1, 'FS44 words, the same words in the 2026-09-27 re-rank note (the ranked row left the table)')
sub('E("FS44", "UB5", "rests", FSR(13), "a CP five-colouring of the plane gives χ(ℝ²) = 5 with no MR (link 2; row 130)")',
    'E("FS44", "UB5", "rests", STUB("STUB-fifth-colour-structure.md"), "a CP five-colouring of the plane does not exist")', 1, 'FS44->UB5 edge, FS-44 banner')
# BOWTIE edge: FS-115 moved from item 19 to item 16
sub('{"file": "plans/FRONTIER-STUBS.md", "row": "19"}', '{"file": "plans/FRONTIER-STUBS.md", "row": "16"}', 1, 'BOWTIE->TSMYES edge, FS-115 item 19 -> 16')
# belief note
sub('quote="Believing the answer is seven is not evidence for seven; the value-skipping that motivates the belief is itself compatible with five (G64)."',
    'quote="Believing the answer is seven is not evidence for seven; the value-skipping that motivated the belief was compatible with five until [OAIMath2026]"', 1, 'note belief, CLAUDE.md § The local–global conjecture')
open(p, 'w', encoding='utf-8').write(s)
open('data/fs132/f1/stage5-repoint-log.txt', 'w').write('\n'.join(log) + '\n')
print('\n'.join(log))
