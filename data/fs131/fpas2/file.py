#!/usr/bin/env python3
"""File FS131-PAS2's § 3.2 drafts (row 129's prior-art correction, item 1076) verbatim.
Every slot is found exactly once, whitespace-insensitive, before anything is written; all or nothing.
Usage: file.py [--plant]   (--plant changes one character of the first slot and must exit 1)"""
import re,sys
ROOT="/home/kooshi/source/lean-dir/"
E=[]  # (file, old, new)  — a replacement
E.append(("README.md",
"It proves the first clause of Dúcz and Varga's Conjecture 1 (2026), and answers the question Matolcsi, Ruzsa, Varga and Zsámboki (2025, §2) call open, whether $\\chi_f(\\mathbb{R}^2) = 1/m_1(\\mathbb{R}^2)$; Johnson had posed it earlier (1996; 2000).",
"Its first part, $f(n)/n \\to m_1(\\mathbb{R}^2)$, is the first clause of Dúcz and Varga's Conjecture 1 (2026); Li and Su proved it first in print (arXiv:2610.15424, posted 11 October 2026, with a Lean proof), and this library's proof, derived on 7 October and kernel-checked on 14 October, was found independently of theirs. The fractional part answers the question Matolcsi, Ruzsa, Varga and Zsámboki (2025, §2) call open, whether $\\chi_f(\\mathbb{R}^2) = 1/m_1(\\mathbb{R}^2)$; Johnson had posed it earlier (1996; 2000)."))
E.append(("README.md",
"For the plane: not found in print (`LEDGER.md` row 129).",
"For the plane, $f(n)/n \\to m_1(\\mathbb{R}^2)$ and $\\alpha_1(\\mathbb{R}^2) = m_1(\\mathbb{R}^2)$ are Li and Su's (arXiv:2610.15424, 2026), by the same rigidity theorem of OpenAI's. The algebraic-plane form and the fractional equalities are not stated there; for them, prior art not found in print (`LEDGER.md` row 129)."))
E.append(("RESULTS.md",
"For the plane: prior art not found in print. `[Davies2026]`",
"For the plane: `α₁(ℝ²) = m₁(ℝ²)`, as `f(n)/n → m₁(ℝ²)`, is `[LiSu2026]`'s Theorem 1.1 (posted 11 October 2026, with a Lean proof over the same `[OAIMath2026]` Thm 2.3), published before this project's kernel proof (14 October; derivation 7 October) and found independently of it. `α₁(𝒜²) = m₁(ℝ²)` and the fractional equalities are not stated there (a reading, one mind, FS131-PAS2): prior art not found in print. `[Davies2026]`"))
E.append(("RESULTS.md",
"In the plane, `f(n)/n → m₁(ℝ²)` is the first clause of `[DuczVarga2026]`'s Conjecture 1, and",
"`f(n)/n → m₁(ℝ²)` is the first clause of `[DuczVarga2026]`'s Conjecture 1, as `[LiSu2026]` says; and"))
E.append(("CLAUDE.md",
"with no hypothesis, row 129's plane clause (FS-133) answers the first clause of `[DuczVarga2026]`'s Conjecture 1 and `[MatolcsiEtAl2025]` §2's equality question — formalized: in the kernel since FS133-LD1, on the standard three axioms, through `[OAIMath2026]`'s rigidity step, ported; for the plane, prior art not found in print (row 129; `plans/FS131-ER1-davies-reading.md` § Stage 7) — `[Davies2026]` Thm 1.1 proves the same equality in dimensions four and up —; the kernel proof is this project's.",
"with no hypothesis, row 129's plane clause (FS-133) answers `[MatolcsiEtAl2025]` §2's equality question — formalized: in the kernel since FS133-LD1, on the standard three axioms, through `[OAIMath2026]`'s rigidity step, ported; for the fractional equality, prior art not found in print (row 129); its first part, `f(n)/n → m₁(ℝ²)` (`[DuczVarga2026]`'s Conjecture 1, first clause), is `[LiSu2026]`'s, published first (11 October 2026) and found independently — `[Davies2026]` Thm 1.1 proves the same equality in dimensions four and up —; the kernel proof is this project's."))
E.append(("CLOSED-QUESTIONS.md",
"the second clause (`m₁ = δ_Croft`) is open.",
"the second clause (`m₁ = δ_Croft`) is open. **The first clause is in print:** `[LiSu2026]` Theorem 1.1, *\"lim f (n)/n = m1 . Moreover f (n) ≥ m1 n for every n ≥ 1.\"* (arXiv:2610.15424, posted 11 October 2026, with a Lean proof over `[OAIMath2026]` Thm 2.3), published before FS-133's kernel proof (14 October; its derivation is dated 7 October) and found independently of it; this project learned of it on 17 October (FS131-PAS2). The fractional equality and Johnson's questions are not stated there (a reading, one mind)."))
E.append(("CLOSED-QUESTIONS.md",
"Not closed until FS-133's Lean module passes the gate.",
"Kernel-checked since FS133-LD1 (2026-10-14)."))
E.append(("LEDGER.md",
"the equalities not found (F §3.6, five queries; a gate under descriptive-combinatorics names owed; FS-133's gate (fifteen arXiv queries, two web searches, 2026-10-07; zbMATH down): not found; the descriptive-combinatorics neighbours named, unread (`plans/FS133-one-class-transfer.md` § PA.4));",
"the plane's clause `α₁(ℝ²) = m₁(ℝ²)`, as `f(n)/n → m₁(ℝ²)`, is `[LiSu2026]` Theorem 1.1 (arXiv:2610.15424, PDF dated 10 October 2026, posted 11 October, Lean-formalized over `[OAIMath2026]` Thm 2.3), published first; FS-133's derivation (7 October) and kernel proof (14 October) were made without knowledge of it, found 17 October by FS131-PAS2 (zbMATH `ab:\"independence ratio\" & ab:\"plane\"`) — FS-133's own gate of 7 October (fifteen arXiv queries, two web searches, zbMATH down) predates it. `α₁(𝒜²) = m₁(ℝ²)` and the fractional equalities `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)` are not stated there (a reading, one mind); `χ_f,0(ℝ²) = 1/m₁(ℝ²)` follows from it with `[MatolcsiEtAl2025]` Thm 2, and the step to `χ_f(ℝ²)` is C133-CHIF (an inference, one mind) — for these, not found in print; the descriptive-combinatorics neighbours named, unread (`plans/FS133-one-class-transfer.md` § PA.4);"))
E.append(("plans/KERNEL-HOLDS.md",
"(`[DuczVarga2026]` Conjecture 1, first clause;",
"(`[DuczVarga2026]` Conjecture 1, first clause; first proved in print by `[LiSu2026]`;"))
E.append(("BIBLIOGRAPHY.md",
"| **[Schinzel1969]** |",
None))  # anchor: insert the § A row after this row's line
E.append(("BIBLIOGRAPHY.md",
"| `supplementary/mrvz-2311.10069-fcn4/` (10 files, with `SHA256SUMS`) | `[MatolcsiEtAl2025]` |",
None))  # anchor: insert the § B row after this row's line
ROWA="| **[LiSu2026]** | S. Li, Y. Su, *Every n points in the plane contain (m1 + o(1)) n points with no unit distance*, arXiv:2610.15424v1 [math.CO] (11 October 2026; the PDF dated 10 October 2026), 6 pp.; Lean development `github.com/daizisheng/erdos-1070`, release v1.0 | **Row 129's plane clause in print, first:** Theorem 1.1, *\"lim f (n)/n = m1 . Moreover f (n) ≥ m1 n for every n ≥ 1.\"*, the first clause of `[DuczVarga2026]` Conjecture 1 (Erdős Problem #1070), by a single-label version of `[OAIMath2026]` § 4's transfer over its Thm 2.3, formalized in Lean 4 on the standard three axioms (§ 6). Found independently of FS-133 (derived 7 October, kernel 14 October); found here 17 October (FS131-PAS2). Not stated there: `α₁(𝒜²) = m₁`, any fractional chromatic number (a reading, one mind) | `library/pdf/arXiv-2610.15424-li-su-every-n-points-no-unit-distance-m1.pdf` | **read in full** (FS131-PAS2, 2026-10-17); its Lean repository not cloned |"
ROWB="| `pdf/arXiv-2610.15424-li-su-every-n-points-no-unit-distance-m1.pdf` | `[LiSu2026]` | read in full |"
INS={9:ROWA,10:ROWB}
def pat(s): return re.compile(r"\s+".join(re.escape(t) for t in s.split()))
plant="--plant" in sys.argv
if plant: E[0]=(E[0][0],E[0][1].replace("Dúcz","Dúcx",1),E[0][2])
texts={}
for f,_,_ in E: texts.setdefault(f,open(ROOT+f).read())
spans=[]
for i,(f,old,new) in enumerate(E):
    m=list(pat(old).finditer(texts[f]))
    print(f"slot {i+1} {f}: {len(m)} match(es)")
    if len(m)!=1: print("FAIL: not exactly once"); sys.exit(1)
    spans.append(m[0])
for i in sorted(range(len(E)),key=lambda i:(E[i][0],-spans[i].start())):
    f,old,new=E[i]; s=texts[f]; m=pat(old).search(s)
    if new is not None: s=s[:m.start()]+new+s[m.end():]
    else:
        e=s.index("\n",m.end()); s=s[:e+1]+INS[i]+"\n"+s[e+1:]
    texts[f]=s
for f,s in texts.items(): open(ROOT+f,"w").write(s)
print("filed", len(E), "items")
