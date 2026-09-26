p="/home/kooshi/source/lean-dir/plans/CRUNCH-2026-09-26-x2x3-queue.md"
t=open(p,encoding="utf-8").read()
i=t.index("### Queue rows (wave 3"); head,tail=t[:i],t[i:]
lines=tail.split("\n")
def setstatus(jid,new):
    k=[n for n,l in enumerate(lines) if l.startswith(f"| {jid} |")]
    assert len(k)==1,(jid,k)
    cells=lines[k[0]].split(" | ")
    assert cells[-1].endswith(" |") or cells[-1].endswith("|")
    last=cells[-1].rstrip(" |")
    cells[-1]=new+" |"
    lines[k[0]]=" | ".join(cells)
    return last
old={}
for jid,new in [("X29C","DONE (report `reports/X29C.md`)"),("X30F","DONE (report `reports/X30F.md`)"),("X11K2","STAGE 1R SAVED (report `reports/X11K2.md`; its gate continued by X11K3)"),
                ("X26B","DONE (report `reports/X26B.md`)"),("X27D","DONE (report `reports/X27D.md`; its verdict folds with X31C)"),("X27V","DONE (report `reports/X27V.md`; its verdict folds with X31C)")]:
    old[jid]=setstatus(jid,new)
print(old)
k=[n for n,l in enumerate(lines) if l.startswith("| X27V |")][0]
lines[k+1:k+1]=["| X28D | Opus | derivation | FS-100 s5 (w3) | the complex-place case of FS100-COR: CP-1–CP-3 (Kooshi's pointer to FS54-T2) | — | `plans/FS100-X28D-derivation.md` | — | — | — | 07:50 | none | — | DONE (report `reports/X28D.md`; folded by X30F) |",
                "| X11K3 | Opus | kernel | FS-100 s5 (w3) | gates X11K2's skeleton into `Proofs/` | — | — | — | — | — | — | — | — | run (still gating at this close; FS-101's lane) |",
                "| X31C | Opus | close-math + front-page | FS-100 s5 (w3) | the follow-on fold of X27D and X27V (TR-ROT) | X27D, X27V | — | X30F | — | — | — | none | — | wait (launches after X30F) |"]
t=head+"\n".join(lines)
old_b="§7's wave 3 was still running at this close and closes with X29C and X30F."
assert t.count(old_b)==1
t=t.replace(old_b, old_b+"\n>\n> **CLOSED (wave 3) by X30F** (2026-09-26: §7's statuses final; the front page applied from `plans/FS100-three-field-lemma.md` §R-close (stage 5,\n> wave 3), `LEDGER.md` rows 123–125). X27D and X27V's TR-ROT verdict folds with X31C; X11K3 was still gating at this close.")
open(p,"w",encoding="utf-8").write(t); print("ok")
