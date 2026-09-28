# FS112-X stage 4: plans/FS112-unit-arc-half.md §R-close 4.3 (BIBLIOGRAPHY.md), 4.4 (CLOSED-QUESTIONS.md), 4.6 (GROKKING-INSTANCES.md, the rest
# after stage 3's §G21), 4.7 (the protocol), 4.8's two corrections (plans/FS110-derivation.md, added to the touch list by inventory item 65).
# Every replacement asserted exactly once. Deviations from the drafts' letter are named in the record, stage 4.
import pathlib, re, sys
sys.path.insert(0, '/home/kooshi/source/lean-dir/data/fs112/fs112-x')
from drafts_extract import section, bullets
R = pathlib.Path('/home/kooshi/source/lean-dir')
def q(b):
    m = re.search(r':\*? "', b); return b[m.end(): b.rindex('"')]
def rep(t, old, new, name):
    assert t.count(old) == 1, (name, t.count(old)); return t.replace(old, new)
def pick(sec, start):
    bs = [b for b in bullets(section(sec)) if b.startswith(start)]; assert len(bs) == 1, (sec, start, len(bs)); return q(bs[0])

# ---- 4.6 GROKKING-INSTANCES (G21 done at stage 3)
p = R/'plans/GROKKING-INSTANCES.md'; t = p.read_text()
H = "`plans/FS112-unit-arc-half.md` §R-close"
g51, g72, g79 = pick('4.6', '*§G51:*'), pick('4.6', '*§G72:*'), pick('4.6', '*§G79:*')
slot, quote, fence = pick('4.6', '*§ Building'), pick('4.6', '*"Quote statements'), pick('4.6', '*Fence rule:*')
blk51 = (f"*FS112-X, FS-112's close (FS112-C, {H} 4.6):*\n\n{g51}\n\n"
         f"*FS112-X at FS-112's close — the rule \"quote statements verbatim in briefs\" (FS112-C, {H} 4.6):*\n\n{quote}\n\n"
         f"*FS112-X, FS-112's close, under the fence rule (FS112-C, {H} 4.6):*\n\n{fence}\n\n")
t = rep(t, "## G54 — Tight or slack", blk51 + "## G54 — Tight or slack", 'G51')
t = rep(t, "## G79 — A wall arrives as a counterexample's invariant",
        f"*FS112-X, FS-112's close (FS112-C, {H} 3.3):*\n\n{g72}\n\n## G79 — A wall arrives as a counterexample's invariant", 'G72')
t = rep(t, "## `CLAUDE.md` § Delegation — one level deep",
        f"*FS112-X, FS-112's close (FS112-C, {H} 3.3):*\n\n{g79}\n\n## `CLAUDE.md` § Delegation — one level deep", 'G79')
t = rep(t, "## `CLAUDE.md` § The standard of evidence above rung B",
        "## `CLAUDE.md` § Building — RAM is the discriminator (`scripts/slot.py`)\n\n"
        f"*FS112-X, FS-112's close (FS112-C2, {H} 4.6):*\n\n{slot}\n\n## `CLAUDE.md` § The standard of evidence above rung B", 'slot')
p.write_text(t)

# ---- 4.3 BIBLIOGRAPHY
p = R/'BIBLIOGRAPHY.md'; t = p.read_text(); L = t.split('\n')
def row(key):
    i = [k for k, l in enumerate(L) if l.startswith(f'| **[{key}]**')]; assert len(i) == 1, key; return i[0]
bs = bullets(section('4.3'))
pm21 = q([b for b in bs if b.startswith('`[Polymath2021]`')][0])
i = row('Polymath2021'); assert L[i].endswith(' |'); L[i] = L[i][:-2] + '; ' + pm21 + ' |'
# [AxenovichEtAl2014]: reading column add; role column add (the role's "Nothing of ours rests on it" and the reading's "§3–§4 not read" made current)
ax = [b for b in bs if b.startswith('`[AxenovichEtAl2014]`')][0]
ax_read = ax[ax.index('→ add "') + 7: ax.index('"; role column')]
ax_role = ax[ax.index('role column, add: "') + 19: ax.rindex('"')]
i = row('AxenovichEtAl2014')
L[i] = rep(L[i], "**read: §1–§2 including the proof of Theorem 2.3, by the FS-58 prior-art sweep (2026-09-17); §3–§4 not read**",
           "**read: §1–§2 including the proof of Theorem 2.3, by the FS-58 prior-art sweep (2026-09-17)" + ax_read + "; §3 and the rest of §4 not read**", 'ax read')
L[i] = rep(L[i], "**Nothing of ours rests on it; it blocks a novelty claim.**",
           "**Row 136 rests on it: " + ax_role + ". Otherwise it blocks a novelty claim.**", 'ax role')
# [Polymath16threads]
pt = [b for b in bs if b.startswith('`[Polymath16threads]`')][0]
pt_read = pt[pt.index('verbatim: "') + 11: pt.index('"; role column')]
pt_role1 = pt[pt.index('role column, add its list: "') + 28: pt.index('"; and: "')]
pt_role2 = pt[pt.index('"; and: "') + 9: pt.rindex('"')]
i = row('Polymath16threads'); cols = L[i].split(' | '); assert len(cols) == 5
cols[2] = cols[2] + ' **FS-112:** ' + pt_role1 + '; ' + pt_role2 + '.'
assert cols[4].endswith(' |'); cols[4] = cols[4][:-2] + '; ' + pt_read + ' |'
L[i] = ' | '.join(cols)
# [Coulson2004]
i = row('Coulson2004')
L[i] = rep(L[i], "**Coulson read in full** (FS106-SB, 2026-09-27; figures not viewed)",
           "**Coulson read in full** (FS106-SB, 2026-09-27); figures viewed (FS112-PA, 2026-09-27): polygonal only, no curved boundary", 'coulson')
# [Soifer2024]
so = q([b for b in bs if b.startswith('`[Soifer2024]`')][0])
i = row('Soifer2024'); L[i] = rep(L[i], "; the rest not read** |", "; " + so + "; the rest not read** |", 'soifer')
t = '\n'.join(L)
# the FS-110 gate block: Kruskal, Ágoston
t = rep(t, "(the zbMATH API record, `data/fs110/fs110-p/boundaries.json`) | **Listing only** (FS110-P §PA); not held |",
        "(the zbMATH API record, `data/fs110/fs110-p/boundaries.json`) | **Abstract read** (FS112-P, the Semantic Scholar record): two- and three-colourings of bounded regions; silent on six-maps; not held |", 'kruskal')
t = rep(t, "| P. Ágoston, a 2025 paper in Discrete Comput. Geom. named by FS110-P's gate **[title unverified]** | **Named only** (FS110-P §PA); not held |",
        "| P. Ágoston, *A Lower Bound on the Number of Colours Needed to Nicely Colour a Sphere*, Discrete Comput. Geom. (2025), doi 10.1007/s00454-025-00736-3 (title and authors from OpenAlex, FS112-P) | **Abstract read** (FS112-P): nice colourings of large spheres need at least eight; silent on unit arcs; not held |", 'agoston')
# the new block (C's rows, verbatim), after the FS-110 table
nb = [b for b in bs if b.startswith('**A new block')][0]
assert 'etd.auburn.edu/bitstream/10415/1844/1/Anna_Boronska.pdf' in nb and '**[Oostema2020]**' in nb
rows_new = [
 "| **[Oostema2020]** P. Oostema, R. Martins, M. J. H. Heule, *Coloring Unit-Distance Strips using SAT*, EPiC Series in Computing 73 (2020) 373–389, doi 10.29007/btmj | **Abstract read** (FS112-P, OpenAlex): strips tiled by squares and hexagons, found by SAT; no unit arcs; not held |",
 "| A. Boronska, *The Chromatic Number of the Euclidean Plane*, thesis, Auburn University (2009), `etd.auburn.edu/bitstream/10415/1844/1/Anna_Boronska.pdf` | **Title only** (FS112-P; a citing work of `[Coulson2004]`) |",
 "| B. Hockertz, *Exclusion zones in infinite graphs*, manuscript (dropbox link, `[Polymath16threads]` thread 6, 10 June 2018) | **Unheld, unread**: the promised formalisation of HOCK |",
 "| T. Sirgedas and others, the Google group `hadwiger-nelson-problem` (2019–2021) | **Unheld, unread**: de Grey, `[16.317]`: Sirgedas 'got very close' to proving that the plane cannot be six-tiled with a non-Siamese tiling — FS-114's first prior-art debt |",
 "| the Polymath16 wiki's tile-rule page (de Grey, `[08.67]`) and the dropbox draft `stripdisk.pdf` (`[16.326]`) | **Unheld** |"]
for r in rows_new:  # each row's cells checked against C's bullet text (whitespace-normalised)
    for cell in [c.strip() for c in r.strip('|').split(' | ')]:
        core = cell.replace('**[Oostema2020]** ', '')
        assert ' '.join(core.split()) in ' '.join(nb.split()) or core.startswith('**'), core[:60]
blockhead = ("**FS-112's prior-art gate (2026-09-27; `plans/FS112-unit-arc-half.md` §PA; `plans/FS112-PA-reading.md` Stage 8).** Named and not held. "
             "`[Oostema2020]`'s title, authors, DOI, volume and first page checked against FS112-P's OpenAlex record "
             "(`data/fs112/fs112-p/axenovich_citing.json`) at the front page (FS112-X); that record's last page reads 355, a defect of the record, "
             "so 389 is unchecked. Ágoston's row above was checked the same way (`data/fs112/fs112-p/thomassen_citing.json`).\n\n| work | status |\n|---|---|\n")
anchor = "**The consolidation run's reference-list mining (2026-09-27, job LP;"
t = rep(t, anchor, blockhead + '\n'.join(rows_new) + '\n\n' + anchor, 'newblock')
p.write_text(t)

# ---- 4.4 CLOSED-QUESTIONS
p = R/'CLOSED-QUESTIONS.md'; t = p.read_text()
cb = bullets(section('4.4'))
cq1 = [b for b in cb if b.startswith('§2.8')][0]; cq1 = cq1[cq1.index(': insert "') + 10: cq1.rindex('"')]
cq2 = [b for b in cb if b.startswith('§3')][0]; cq2 = cq2[cq2.index(': insert "') + 10: cq2.rindex('"')]
t = rep(t, "row 134's \"Not claimed\"); boundaries other than segments and circular arcs. **Prior art that",
        "row 134's \"Not claimed\"); boundaries other than segments and circular arcs. " + cq1 + " **Prior art that", 'cq 2.8')
t = rep(t, "outside that class (the paper's tiles are bounded by closed curves, p. 191) FS-112 is silent.",
        "outside that class (the paper's tiles are bounded by closed curves, p. 191) FS-112 is silent. " + cq2, 'cq 3')
p.write_text(t)

# ---- 4.7 the protocol
p = R/'plans/PROTOCOL-competitor-and-advisor.md'; t = p.read_text()
pr = bullets(section('4.7'))
r12 = q([b for b in pr if b.startswith('*§1 rule 12')][0])
r13 = q([b for b in pr if b.startswith('*§1, a new rule 13')][0])
r14 = q([b for b in pr if b.startswith('*§1, a new rule 14')][0])
run = q([b for b in pr if b.startswith('*§3, the eleventh run')][0])
end12 = "before its own hand-back; a side's last word to an advisor goes through the owner."
t = rep(t, end12 + "\n\n## 2.", end12 + " " + r12 + "\n13. " + r13 + "\n14. " + r14 + "\n\n## 2.", 'rules')
head, rest = run.split(" **The rounds' objects:** ")
objs, tail = rest.split(" **The run:** ")
assert tail == "4.6's G51 text."
objs = objs[0].upper() + objs[1:]
eleventh = head + "\n- **The rounds' objects.** " + objs + "\n- **The run** (FS112-C, §R-close 4.6): " + g51 + "\n\n"
t = rep(t, "**The next use** (G51's *Do*):", eleventh + "**The next use** (G51's *Do*):", 'run')
p.write_text(t)

# ---- 4.8 plans/FS110-derivation.md
p = R/'plans/FS110-derivation.md'; t = p.read_text()
t = rep(t, "general form: a four-colour vertex needs an arc of `Γ` of `ω(y)` or `ω(σ_v^{±1}y)` through a change point of every orbit of its ring.",
        "general form (read as FS112-NB4P at FS-112's close): a four-colour vertex needs an arc of `Γ` of `ω(σ_v^{±1}y)` with a change point of every orbit of its ring in its closure, or an orbit point in the closure of an arc of `ω(v)`.", 'nb4')
t = rep(t, "which is why R2 ends paths only at V-in vertices. *Rests on it:* FS110-CE6;",
        "which is why R2 ends paths only at V-in vertices. Its step 'at an M-in point the strip's majority side is outside' is not needed — the in-vote count carries it, unit arcs included (FS112-N3-ANTI; FS-112's close). *Rests on it:* FS110-CE6;", 'ce5')
p.write_text(t)
print('ok')
