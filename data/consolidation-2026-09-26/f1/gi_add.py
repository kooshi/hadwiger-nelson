#!/usr/bin/env python3
"""F1 stage 3 batch 4: write the incidental restorations into plans/GROKKING-INSTANCES.md (remainders from f1/excise.py)."""
T = '/tmp/claude-1000/'
rd = lambda f: '⟦ ' + open(T + f).read().strip() + ' ⟧'
gi = open('plans/GROKKING-INSTANCES.md').read()
def HDR(src, commit, date, after=None):
    if after:
        after = '…' + ' '.join(after.lstrip('…').split()[-6:])
    tail = (', after “' + after + '”') if after else ''
    return f"*F1, from {src}, cut in `{commit}` ({date}){tail}:*\n\n"
B = lambda t: '⟦ ' + t + ' ⟧'
def OLD(src):
    return f"*F1: {src} as at `c5e55f12^`.*\n\n"
a = "and this file as one corpus. Later instances of these rules belong here, under their source.*"
assert gi.count(a) == 1
gi = gi.replace(a, a + "\n\n*Job F1 (2026-09-26, the audit of `CLAUDE.md`'s git history) added the text earlier compression passes had cut from\n`CLAUDE.md` without a home — incident stories and later instances, each verbatim and headed by the commit that cut it; the reasons,\nconditions and killing tests among them went back into `CLAUDE.md` (`data/consolidation-2026-09-26/F1-record.md`). A passage headed\n“as at `c5e55f12^`” is that source as it stood before the narrative cut of 2026-09-10 (“current state only — 564,620 → 83,841\ncharacters”), line wraps joined; “[…]” marks words `CLAUDE.md`, `LEDGER.md` or an earlier passage here already hold, so nothing is\ntold twice.*")
def add_to_section(gi, head, text):
    i = gi.index(head); j = gi.find('\n## ', i + len(head))
    if j < 0: j = len(gi)
    return gi[:j].rstrip('\n') + '\n\n' + text.strip('\n') + '\n' + gi[j:]
def new_section_before(gi, before_head, text):
    i = gi.index(before_head); return gi[:i] + text.strip('\n') + '\n\n' + gi[i:]
contended = "; **contended times inflate 2–3×** — the ladder read 983 s at the first refusing radius, the quiet minimum of three 463 s — so a number that enters a decision is re-asked alone"
m3 = '*M3, from G21, after “…enters a decision is re-asked alone”:*'
assert gi.count(m3) == 1
gi = gi.replace(m3, "*F1 (the owner's item 1: an instance whose rule stands in § Two machines and in “carry what it MEASURES”), from G21, after “…a high-order isolated point reads UNDECIDED, never NONEMPTY”:*\n\n" + contended + "\n\n" + m3)
gi = add_to_section(gi, '## G21 — ', OLD('G21') + rd('f1_gi_g21.txt'))
gi = new_section_before(gi, '## G49 — ', "## G30 — Measurement generates; derivation kills\n\n" + OLD('G30') + rd('f1_gi_g30.txt'))
g46 = ("## G46 — Recognize the classical theory first\n\n"
       + HDR('G46', '34464cba', '2026-09-13', '…the implementation is the one that cannot round off.')
       + B("Its discoverer declined the credit for depth and named this instead, which is why it is written as a habit rather than as an achievement.") + "\n\n"
       + OLD('G46') + rd('f1_gi_g46.txt'))
gi = new_section_before(gi, '## G49 — ', g46)
c142 = "**Row 88's close:** C14.2 (c) is `[BardestaniMallahiKarai2017]` §3.2 in window form — held since FS-58 and named there, never carried to the lemma;"
gi = add_to_section(gi, '## G49 — ', "*F1 (the owner's item 1: a second instance of the *Do*'s held-paper clause), from G49, after “…More instances: `plans/GROKKING-INSTANCES.md` §G49.”:*\n\n" + c142 + "\n\n" + OLD('G49') + rd('f1_gi_g49.txt'))
g63 = (HDR('G63 (an instance of G50)', '0f4cf93a', '2026-09-25, J24 stage 3', '…proved by writing a unit vector over `F[x]` without common factor and setting `x = 0`.')
       + B("The paper had been in our bibliography, its row naming the theorem, for two weeks (G50)."))
gi = add_to_section(gi, '## G50 — ', OLD('G50') + rd('f1_gi_g50.txt') + "\n\n" + g63)
g51 = ("## G51 — A competitor and an advisor beat one mind\n\n" + OLD('G51') + rd('f1_gi_g51.txt') + "\n\n"
       + HDR('G51', 'fc2775f2', '2026-09-13', '…will arrive later at full price.')
       + B("Its author declined the credit and named the sequencing: having been wrong twice that evening on the same kind of step made the third one cheap to see."))
g58 = ("## G58 — The antipodal conjecture\n\n"
       + HDR('G58', 'd0df4f82', "2026-09-21, “trim ahead of FS-66's close”", '…the effort belongs on those half-size instances rather than on a full cube-and-conquer.')
       + B("**Attempted 2026-09-16 at 23 (k = 7, 8) and 43 (k = 8) as a decision, and it returned NOTHING — every refusal was free and every informative row undecided.** The `(2,2,2,2)` rows fall to the fixed-colour argument in 0 s, the identity rows fall in 0 s to a single edge (some `z` is adjacent to `−z`, so `c(z) = c(−z)` is immediate), and the rows with a τ fixing several colours — the only ones that could carry a colouring — were undecided at 3,000,000 conflicts after 170–483 s. A test whose informative outcome was never shown to be reachable, which is this file's own rule broken by its author within the hour."))
g64 = ("## G64 — Six may be a value no field attains\n\n"
       + HDR('G64', 'd0df4f82', '2026-09-21', '…whether the skipping is specific to the plane stays untested.')
       + B("A fresh instance of this file's own rule: the probe's design confirmed that a six was reachable *in principle* and never that it was reachable *at the sizes the budget could decide*."))
gi = new_section_before(gi, '## G72 — ', g51 + "\n\n" + g58 + "\n\n" + g64)
soe = ("## `CLAUDE.md` § The standard of evidence above rung B\n\n"
       + HDR('the reviewer-bundle bullet', '34464cba', '2026-09-13', '…what must someone who trusts none of this actually check?')
       + B("Its discoverer declined the credit for insight and named the question instead, which is the version that reproduces."))
twm = ("## `CLAUDE.md` § Toolchain — Two machines\n\n"
       + HDR('§ Two machines', 'fc2775f2', '2026-09-13', '…`nproc` says **32** and that is the *thread* count.')
       + B("**Corrected 2026-09-12**, where this file had said \"32 cores\": an agent sizing a job from it reasoned that 32 concurrent solvers on 16 cores must be contending, killed a running job and relaunched at half width. Restoring 32-way was right — observed throughput **12.6 cubes/min** against the ~8/min sixteen workers give — but **the two figures first reported here (32-way 120.6 s against 16-way 122.8 s, \"statistically identical\") are STRUCK**: they compared a mixed cube population against a pure one. Restricted to one difficulty class, the same data reads 32-way **105.1 s** (n=43), 16-way **126.6 s** (n=32), 32-way again **129.2 s** (n=117) — **two runs at the SAME width differing by as much as the width effect being claimed.** […] The agent had just been credited with instancing *\"a number carries what it measures\"* and then broke it again **at the first opportunity, inside the act of correcting the first break** — comparing \"the numbers from before\" against \"the numbers from after\" without checking that the two cube ranges had the same difficulty mix. What caught it was **not vigilance about populations**: it was **the cost model failing an arithmetic check** — 32 workers at ~125 s should yield 15 cubes/min, far more than it was seeing, which forced the look.") + "\n\n*(Text as at `34464cba^`; `fc2775f2` shortened it and `6852a2ae` (2026-09-15) cut the rest.)*")
srch = "## `CLAUDE.md` § Searching\n\n" + OLD('§ Toolchain’s search paragraph (today § Searching)') + rd('f1_gi_search.txt')
gate = "## `CLAUDE.md` § The gate — the vacuity check\n\n" + OLD('§ The gate’s vacuity bullet') + rd('f1_gi_gate.txt')
mgf = ("## `CLAUDE.md` § Make the gate fail, and watch it fail\n\n"
       + HDR('“To compare POLICIES, replay them …”', 'fc2775f2', '2026-09-13', '…Re-running would have compared two populations and one policy at once.')
       + B("The replay also showed the adaptive policy slightly worse than the best fixed one until the accept rate falls, which a second run would have hidden in noise.") + "\n\n"
       + HDR('“A positive control proves an instrument …”', 'fc2775f2', '2026-09-13', '…the image was a measure-zero slice (24 × 24 against 144²) and the answer lived outside it.')
       + B("Third instance in one milestone of a decisive zero from a generator that could not represent its target, every one with its positive control passing."))
gi = gi.rstrip('\n') + '\n\n' + soe + '\n\n' + twm + '\n\n' + srch + '\n\n' + gate + '\n\n' + mgf + '\n'
import re
def excise(gi):
    others = open('CLAUDE.md').read() + '\n' + open('LEDGER.md').read() + '\n'
    full = others + gi
    toks = [(m.start(), m.end(), m.group()) for m in re.finditer(r'\S+', full)]
    inreg = []; reg = False; words = []
    for st, en, w in toks:
        if w == '⟦': reg = True; continue
        if w == '⟧': reg = False; continue
        words.append((st, en, w, reg and st >= len(others)))
    W = [w for _, _, w, _ in words]; n = 10
    from collections import defaultdict
    occ = defaultdict(list)
    for i in range(len(W) - n + 1): occ[tuple(W[i:i + n])].append(i)
    mark = [False] * len(W)
    for k, lst in occ.items():
        if len(lst) > 1:
            outside = [i for i in lst if not all(words[j][3] for j in range(i, i + n))]
            victims = lst if outside else lst[1:]
            for i in victims:
                for j in range(i, i + n):
                    if words[j][3]: mark[j] = True
    out = []; pos = 0; i = 0
    while i < len(words):
        if mark[i]:
            j = i
            while j < len(words) and mark[j]: j += 1
            out.append(full[pos:words[i][0]]); out.append('[…]'); pos = words[j - 1][1]; i = j
        else:
            i += 1
    out.append(full[pos:])
    res = ''.join(out)[len(others):]
    res = res.replace('⟦ ', '').replace(' ⟧', '').replace('⟦', '').replace('⟧', '')
    res = re.sub(r'\[…\](\s*\[…\])+', '[…]', res)
    return res
gi = excise(gi)
open('plans/GROKKING-INSTANCES.md', 'w').write(gi); print(len(gi.encode()))
