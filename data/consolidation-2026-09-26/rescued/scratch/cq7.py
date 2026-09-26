p="/home/kooshi/source/lean-dir/CLOSED-QUESTIONS.md"
t=open(p,encoding="utf-8").read()
def rep(old,new):
    global t
    n=t.count(old); assert n==1,(n,old[:80]); t=t.replace(old,new)
# §1.7
old17="**Status:** `ℚ(√11)`'s lower bound kernel-checked;"
rep(old17, "**The value, and its prior-art gate** (FS-100 stage 5, 2026-09-26; `LEDGER.md` rows 121, 123). *\"Prior-art gate for the value (X24R, 2026-09-26, `plans/FS100-X24R-prior-art.md` §2.1): "
 "no printed value of `χ(ℚ(√47)²)` and no printed five-colour lower bound for any real field without √3 were found in zbMATH (author "
 "listings of Moorhouse, Soifer, Exoo, Ismailescu, Fischer, Johnson, Madore, Manturov, Zaks, Chilakamarri, Chow, Jungreis–Reid; abstract "
 "searches), arXiv, the Polymath16 threads (held text and the live eighteenth thread to 2026-09-24) or `[Soifer2024]` chs. 11 and 55; "
 "`[Johnson2000]` and `[Johnson2006]` remain unread.\"* Our value: `χ(ℚ(√47)²) = 5` (row 121), and `= 5` at ℚ(√143), ℚ(√311), ℚ(√335), every "
 "real quadratic `ℚ(√d)` with `L = 5` (row 123); `≥ 5` at ℚ(√167). By `[Moorhouse2010slides]`'s own criterion (*\"If `d ≢ 47, 59 or 83 mod 84`, "
 "then `χ(K²) ≤ 4`\"*) these are the fields his slides left open, less the type-(B) ones (row 124). The section's rule stands: nothing recorded as "
 "closed until the two Johnson papers are read.\n\n"+old17)
# §3, Exoo–Ismailescu's smallest subfield
rep("(`LEDGER.md` row 84; FS-84 carries it).\n- **A triangle-free 5-chromatic",
    "(`LEDGER.md` row 84; FS-84 carries it). **At FS-100 stage 5** (`LEDGER.md` rows 121, 123; [hand]; prior-art gate X24R, "
    "`plans/FS100-X24R-prior-art.md` §3.4, verbatim): *\"a quadratic field needing five would be of the least degree possible (ℚ's plane is "
    "two-chromatic), so 'smallest' would be answered by degree; whether ℚ(√47) is the smallest *quadratic* one is a separate question "
    "(every squarefree `d < 47` has `χ(ℚ(√d)²) ≤ 4` by `[Moorhouse2010slides]`: 'If `d ≢ 47, 59 or 83 mod 84`, then `χ(K²) ≤ 4`').\"* With "
    "`χ(ℚ(√47)²) = 5` (row 121), ℚ(√47) is the first real quadratic field needing five.\n- **A triangle-free 5-chromatic")
# §3, Soifer 55.1
rep("four-colours ℚ(√47)'s plane; the yes side is untouched. **Still open.**",
    "four-colours ℚ(√47)'s plane; the yes side is untouched. **Still open.** **At FS-100 stage 5** (`LEDGER.md` rows 121, 123; [hand]): "
    "`χ(ℚ(√47)²) = 5`, so a finite triangle-free five-chromatic unit-distance graph over ℚ(√47) exists, none exhibited. On the gate (X24R, "
    "`plans/FS100-X24R-prior-art.md` §3.4, verbatim): *\"if the value lands, the answer is to 55.1's **existence** question only — 55.1 reads "
    "'Construct a triangle-free 5-chromatic unit-distance graph', and a field-level value gives a finite graph by de Bruijn–Erdős, not a "
    "construction. Nothing in print (to 2026-09-24) has a planar triangle-free five-chromatic unit-distance graph; the only five-chromatic "
    "triangle-free one is in ℝ³ (de Grey, Geombinatorics 2026, Zbl 1581.05080).\"* ℚ(√143), ℚ(√311), ℚ(√335) give further triangle-free "
    "instances (no √3); ℚ(√3,√5)'s does not (it has √3). So 55.1's existence half is answered, non-constructively; 55.1 as posed (construct one) "
    "and 55.2 stay open (FS-84's re-aim).")
# §2.6
rep("answered at `χ ≤ 3` and at `L(F) ≤ 4` over every real number field, and for character colourings at every `k`;",
    "answered at `χ ≤ 3`, at `L(F) ≤ 4` over every real number field, and at `L(F) = 5` given MR (row 123), and for character colourings at every `k`;")
rep("**Not answered:** `χ(F²)` from `L(F) = 5` up — the conjecture's",
    "**Not answered:** `χ(F²)` from `L(F) = 6` up (the lower bound stops at five) — the conjecture's")
open(p,"w",encoding="utf-8").write(t); print("ok")
