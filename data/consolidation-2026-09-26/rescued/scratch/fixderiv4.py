import re, sys
path = "/home/kooshi/source/lean-dir/plans/FS100-derivation.md"
t = open(path, encoding="utf-8").read()
P = "the plan's §R-close (stage 5, wave 3)"
NONE = "none recorded at the close."

def rep(old, new):
    global t
    n = t.count(old)
    assert n == 1, (n, old[:80])
    t = t.replace(old, new)

def entry_line(eid):
    i = t.index(f"\n**{eid} — ") + 1
    j = t.index("\n", i)
    return i, j

def insert_before_kernel(eid, text):
    global t
    i, j = entry_line(eid)
    line = t[i:j]
    k = line.index(" *Kernel:*")
    assert line.count(" *Kernel:*") == 1, eid
    line = line[:k] + " " + text + line[k:]
    t = t[:i] + line + t[j:]

# headers
rep("[hand, one mind, blind] — three minds, two routes]**", "(hand, one mind, blind) — three minds, two routes]**")
rep("**FS100-X22 — the type-(B) fields ℚ(√59), ℚ(√83), ℚ(√131) given MR, and SEL-k (X22D; X22V blind).**",
    "**FS100-X22 — the type-(B) fields ℚ(√59), ℚ(√83), ℚ(√131) given MR, and SEL-k (X22D; X22V blind). [hand; the claims two blind, TR-ROT's form and X22V-T4 one mind]**")

adds = {
 "FS100-Q0": f"*Proof verdict:* {P} 1.1, row Q-0. *Prior art:* {NONE}",
 "FS100-FAM": f"*Proof verdict:* {P} 1.1, rows A-1, A-2.",
 "FS100-K0b": f"*Proof verdict:* {P} 1.1, row A-3. *Prior art:* {NONE}",
 "FS100-167": f"*Proof verdict:* {P} 1.1, row A-4. *Prior art:* X24R: not found in print (`plans/FS100-X24R-prior-art.md` §2.1).",
 "FS100-B12": f"*Proof verdict:* {P} 1.1, rows B-1, B-2; 1.6. *Prior art:* {NONE}",
 "FS100-B3": f"*Proof verdict:* {P} 1.1, row B-3; 1.6. *Rests on it:* FS-59's stub line ({P} 4.6).",
 "FS100-CLS": f"*Proof verdict:* {P} 1.1, row CLS; 1d (X26B).",
 "FS100-COR": f"*Proof:* X23D §3.3; X23V §2.4; {P} 1.3 (the headline audited link by link). *Proof verdict:* {P} 1.1, row COR; 1.3; 1d.",
 "FS100-CTL": f"*Proof:* X23D §2.2; X23V §2.1. *Proof verdict:* {P} 1.1, row CTL. *Rests on it:* {NONE} *Prior art:* {NONE}",
 "FS100-D1": f"*Proof:* X23D §4.2; X23V §2.6. *Proof verdict:* {P} 1.1, row D-1. *Rests on it:* {NONE} *Prior art:* {NONE}",
 "FS100-DLP": f"*Proof verdict:* {P} 1.1, row CLS; 1d (X26B-L1). *Rests on it:* FS100-CLS (its dyadic level bound, {P} 1.1, row CLS). *Prior art:* {NONE}",
 "FS100-EXC": f"*Proof:* X23D stage 5 item 1; X23V §2.3; X26B §2.4 (X26B-EXC). *Proof verdict:* {P} 1.3; 1d. *Prior art:* {NONE}",
 "FS100-G27": f"*Proof:* X23D §2.1; X23V §4.2 (X23V-H). *Proof verdict:* {P} 1d (X26B-T1). *Rests on it:* FS100-CLS (its Hoffman table). *Prior art:* {NONE}",
 "FS100-GF": f"*Proof verdict:* {P} 1.1, row CLS. *Rests on it:* FS100-DLP's scope note (the first field where it is needed). *Prior art:* {NONE}",
 "FS100-Q35": f"*Proof:* X23D §4.1; X23V §2.5. *Proof verdict:* {P} 1.1, row Q35. *Prior art:* {NONE}",
 "FS100-SPC": f"*Proof verdict:* {P} 1.1, row SPC; 1c; 1d. *Prior art:* {NONE}",
 "FS100-TCA": f"*Proof verdict:* {P} 1.1, row A-1; 1c (X25B). *Prior art:* {NONE}",
 "FS100-CX": f"*Proof:* X23D §3.2 step 3′; X23V §2.3 (X23V-CX); X26B §3.2 (X26B-L3). *Proof verdict:* {P} 1c; 1d. *Prior art:* {NONE}",
 "FS100-X22": f"*Proof verdict:* {P} 1b. *Rests on it:* FS-98's stub line (TR-ROT beside T-B1, {P} 4.6). *Prior art:* the clopen correspondence for the non-abelian `R ⋊ U` needs its citation checked at that generality (`[BergelsonMoragues2021]`; row 124's draft, {P} 4.1); otherwise {NONE}",
}
for eid, text in adds.items():
    insert_before_kernel(eid, text)

# X28D entries (owner's ruling): statements and grades verbatim from plans/FS100-X28D-derivation.md's table
x = open("/home/kooshi/source/lean-dir/plans/FS100-X28D-derivation.md", encoding="utf-8").read()
rows = {}
for line in x.splitlines():
    m = re.match(r"^\| (X28D-[A-Z0-9]+) \| (.*) \| (.*?) \| (.*?) \|$", line)
    if m: rows[m.group(1)] = (m.group(2), m.group(3), m.group(4))
assert set(rows) == {"X28D-P","X28D-S","X28D-CP1","X28D-CP2","X28D-CP3","X28D-ODD","X28D-CUBE"}, rows.keys()
X = "`plans/FS100-X28D-derivation.md`"
VER = "one mind (X28D); not reconciled at the close — X28D reported after X29C (`data/crunch-2026-09-26-x2x3/reports/X28D.md`)."
REST = {"X28D-CP2": "FS100-COR's scope note (the complex-place case is inhabited, so FS100-CX is load-bearing there; X28D §3.3 item 1)."}
PA = {"X28D-S": "standard local algebraic number theory; no gate run.", "X28D-CUBE": "standard local algebraic number theory; no gate run."}
block = ["", "*Filed by the front-page editor X30F under the owner's ruling (07:1x): statements and grades verbatim from X28D's \"Theorems this phase proved\" table; X28D ran after the close planner X29C, one mind.*", ""]
for k in ["X28D-P","X28D-S","X28D-CP1","X28D-CP2","X28D-CP3","X28D-ODD","X28D-CUBE"]:
    st, gr, addr = rows[k]
    assert "]" not in gr and "[" not in gr
    block.append(f"**FS100-{k} — {st}. [{gr}]** *Proof:* {X} {addr}. *Proof verdict:* {VER} *Rests on it:* {REST.get(k, NONE)} *Prior art:* {PA.get(k, NONE)} *Kernel:* no decision recorded at the close (the owner's).")
    block.append("")
anchor = "\n## §G. Stated and not proved"
assert t.count(anchor) == 1
t = t.replace(anchor, "\n".join(block) + anchor, 1)

# owner's note 3: one sentence in FS100-COR's scope
rep("the one caveat is MR's complex-place case, derived in general by both MR routes and never exercised on an instance; EL2021 Thm 1.2 external]**",
    "the one caveat is MR's complex-place case, derived in general by both MR routes and never exercised on an instance; EL2021 Thm 1.2 external]** *Scope (X28D):* the complex-place case is inhabited and not reducible to totally real fields by monotonicity — ℚ(√23, ∛2) has `L = 5` while its totally real subfields have `L ≤ 4` (FS100-X28D-CP2) — so FS100-CX is load-bearing there.")
open(path, "w", encoding="utf-8").write(t)
print("ok")
