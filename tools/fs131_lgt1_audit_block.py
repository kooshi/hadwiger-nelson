#!/usr/bin/env python3
"""FS131-LGT1 — the audit's blocks for the five-colour chain's landing, generated from the kernel's print of every
record of the 148 modules the landing brings or changes (`data/fs131/lgt1/lean/AxiomsAll.lean` →
`data/fs131/lgt1/axioms-all.txt`), less the records `scripts/Axioms.lean` already holds.

Every PUBLIC theorem or definition is classed as `scripts/axioms.sh` classes it (LEAN.md § Trust ledger):
  CLEAN     a subset of the standard three;
  IMPORTED  the standard three and declared outside theorems, at least one — placed under the `declareImport` of the
            first of IMPORTS it names (positive_entropy_rigidity before kloosterman_bound);
  OPEN      `sorryAx` among its axioms — the generator STOPS (the gate takes no sorry);
  BAD       any other axiom — the generator STOPS.
A record `scripts/Axioms.lean` already prints is not emitted again; its section there (IMPORTED, CLEAN, PURCHASED) must
agree with its class here, or the generator STOPS (`MISFILED`).

Cross-check against the lines' own drafts (every `#print axioms <name>` line, and every `HadwigerNelson.<name>` in the
link's § 4.3 prose): each drafted name is printed here (public) or reported `DRAFTED-ABSENT` with the reason the caller
must give; each record emitted that no draft names is listed `UNDRAFTED` (counted, not a failure).

Writes three files: <out>.imported-pe.lean, <out>.imported-kb.lean, <out>.clean.lean, and prints the counts.
Usage: fs131_lgt1_audit_block.py <axioms-all.txt> <scripts/Axioms.lean> <out-prefix> [--plant]
--plant (in memory): an unknown axiom in one record, a sorryAx in another, and one CLEAN record already in
scripts/Axioms.lean moved to the PURCHASED section; requires all three reported and exit 1.
"""
import re
import sys
from collections import defaultdict

STANDARD = {"propext", "Classical.choice", "Quot.sound"}
PE = "HadwigerNelson.Rigidity.positive_entropy_rigidity"
KB = "HadwigerNelson.StandingFive.kloosterman_bound"
NP5 = "HadwigerNelson.Outside.OAI158.no_proper_five_coloring"
IMPORTS = [PE, KB, NP5]

ROOT = "/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wq1/"
DRAFTS = [  # (label, path, mode): 'print' reads `#print axioms` lines; 'names' reads every HadwigerNelson.<name>
    ("chain (FS131-LCH1's draft)", "data/fs131/lch1/draft-axioms-block.lean", "print"),
    ("link (FS131-IKL1 § 4.3)", "plans/FS131-IKL1-implementation.md", ("### 4.3 The audit's block", "### 4.4")),
    ("p = 3: FS131-IKC1", "plans/FS131-IKC1-implementation.md",
     ("### The audit's block (for the landing; `scripts/Axioms.lean`)", "## Stage 7")),
    ("p = 3: FS131-IKC2", "plans/FS131-IKC2-implementation.md",
     ("### `scripts/Axioms.lean`, CLEAN (for the landing)", "### `data/fs131/claims-NF2.md`")),
    ("p = 11, 19: FS131-IKC3", "plans/FS131-IKC3-implementation.md", "print"),
    ("p = 19: FS131-IKC4", "data/fs131/ikc4/axioms-block.txt", "print"),
    ("dyadic: FS131-ICM4", "data/fs131/icm4/axioms-block-draft.txt", "print"),
]


def line_of(mod):
    m = mod.replace("Proofs.HadwigerNelson.", "")
    if m.startswith("Arith.FibreCert"):
        return "p19"
    if m in ("Arith.CircleCos", "Arith.BinaryField", "Arith.DyadicCerts"):
        return "dyadic"
    if m in ("Arith.FibreShareIneq", "Rigidity.CertLink", "Rigidity.CertLinkModels"):
        return "link"
    if m in ("Arith.ThreeFourColours", "Arith.UpperHalf", "Instances.SqrtFortySeven", "Plane.OneClass.InvariantLaw"):
        return "main"
    return "chain"


LINE_TITLE = {
    "chain": "the chain's modules (`Rigidity/*` but the link's two, `Outside/OAI015*`, `Plane/WindowDensity`, "
             "`Plane/MOneBound`, `Instances/SqrtFortySevenFive`, `Instances/SqrtClassValues`; FS131-KN3 … FS131-IJN1, "
             "joined by FS131-LCH1)",
    "dyadic": "M13's dyadic line (`Arith/CircleCos`, `Arith/BinaryField`, `Arith/DyadicCerts`; FS131-ICM3, FS131-ICM4)",
    "p19": "the bound at p = 11 and p = 19 (`Arith/FibreCert*`, 81 modules; FS131-IKC1 … FS131-IKC4)",
    "link": "the certificate link (`Arith/FibreShareIneq`, `Rigidity/CertLink`, `Rigidity/CertLinkModels`; FS131-IKL1, "
            "its drafts applied by FS131-LCH1)",
    "main": "main's four modules the join changed (`Arith/ThreeFourColours`, `Arith/UpperHalf`, "
            "`Instances/SqrtFortySeven`, `Plane/OneClass/InvariantLaw`)",
}
ORDER = ["chain", "link", "dyadic", "p19", "main"]


def read_records(path):
    recs = []
    for ln in open(path, encoding="utf-8"):
        m = re.match(r"AXIOMS (\S+) (public|private) (\S+) : \[(.*)\]$", ln.rstrip("\n"))
        if m and m.group(1) != "PLANT":
            ax = {a.strip() for a in m.group(4).split(",") if a.strip()}
            recs.append([m.group(1), m.group(2), m.group(3), ax])
    return recs


def read_audit(path):
    """name -> section of every `#print axioms` line (names written without the root namespace get it)."""
    sec, out = None, {}
    for ln in open(path, encoding="utf-8"):
        m = re.match(r'#eval IO\.println "=== (\w+) ==="', ln)
        if m:
            sec = m.group(1)
            continue
        m = re.match(r"#print axioms (\S+)\s*$", ln)
        if m:
            out[m.group(1)] = sec
    return out


def drafted(label, path, mode):
    text = open(ROOT + path, encoding="utf-8").read()
    if mode == "print":
        return set(re.findall(r"#print axioms (HadwigerNelson\.\S+)", text))
    # a section of a record: its `#print axioms` lines, every backticked HadwigerNelson.<name>, and every `…name`
    # completed with the namespace of the full name written before it in the text
    a, b = mode
    sect = text[text.index(a):text.index(b, text.index(a))]
    names = set(re.findall(r"#print axioms (HadwigerNelson\.\S+)", sect))
    last = None
    for m in re.finditer(r"`(HadwigerNelson\.[\w.']+)`|`…(\w+)`", sect):
        if m.group(1):
            last = m.group(1)
            names.add(last)
        elif last:
            names.add(last.rsplit(".", 1)[0] + "." + m.group(2))
    return names


def main():
    plant = "--plant" in sys.argv
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    recs = read_records(args[0])
    audit = read_audit(args[1])
    pre = args[2]
    if not recs:
        print("NO RECORDS — the printer or the reader is broken")
        return 2
    if plant:
        pub = [r for r in recs if r[1] == "public"]
        new = [r for r in pub if r[2] not in audit and not (r[3] - STANDARD)]
        old = [r for r in pub if r[2] in audit and audit[r[2]] == "CLEAN"]
        new[0][3] = new[0][3] | {"planted.unknownAxiom"}
        new[1][3] = new[1][3] | {"sorryAx"}
        audit[old[0][2]] = "PURCHASED"
        print(f"PLANTED: unknown axiom in {new[0][2]}; sorryAx in {new[1][2]}; {old[0][2]} filed under PURCHASED")
    by = {"CLEAN": defaultdict(list), PE: defaultdict(list), KB: defaultdict(list), NP5: defaultdict(list)}
    stops, present, npub, npriv = [], 0, 0, 0
    for mod, kind, name, ax in recs:
        if kind != "public":
            npriv += 1
            continue
        npub += 1
        extra = ax - STANDARD
        if not extra:
            cls = "CLEAN"
        elif "sorryAx" in extra:
            stops.append(f"OPEN {name} ({mod}): {sorted(ax)}")
            continue
        elif extra <= set(IMPORTS):
            cls = "IMPORTED"
        else:
            stops.append(f"BAD {name} ({mod}): {sorted(extra)}")
            continue
        if name in audit:
            present += 1
            if audit[name] != cls:
                stops.append(f"MISFILED {name}: class {cls}, filed under {audit[name]}")
            continue
        key = "CLEAN" if cls == "CLEAN" else next(i for i in IMPORTS if i in extra)
        by[key][line_of(mod)].append((mod, name, sorted(extra)))
    for s in stops:
        print(s)
    # the drafts
    emitted = {n for k in by for ln in by[k] for (_, n, _) in by[k][ln]}
    public = {r[2] for r in recs if r[1] == "public"}
    alldraft = set()
    for label, path, mode in DRAFTS:
        d = drafted(label, path, mode)
        alldraft |= d
        absent = sorted(n for n in d if n not in public)
        print(f"DRAFT {label}: {len(d)} names; {len(d & emitted)} emitted here, "
              f"{len(d & (public - emitted))} already in scripts/Axioms.lean, {len(absent)} not a public record now")
        for n in absent:
            print(f"DRAFTED-ABSENT {n}  ({label})")
    und = sorted(emitted - alldraft)
    print(f"UNDRAFTED {len(und)} (emitted, named by no draft)")
    for n in und:
        print(f"UNDRAFTED {n}")
    if stops:
        print(f"STOP: {len(stops)} record(s) the gate cannot take")
        return 1
    if plant:
        print("PLANT NOT REPORTED")
        return 0

    def write(path, key, head):
        with open(path, "w", encoding="utf-8") as f:
            for ln in ORDER:
                rows = by[key][ln]
                if not rows:
                    continue
                f.write(f"-- FS131-LGT1 ({head}): {LINE_TITLE[ln]} — {len(rows)}\n")
                for mod, name, ex in sorted(rows, key=lambda r: (r[0], r[1])):
                    f.write(f"#print axioms {name}\n")
    write(pre + ".imported-pe.lean", PE, "IMPORTED, on `Rigidity.positive_entropy_rigidity`")
    write(pre + ".imported-kb.lean", KB, "IMPORTED, on `StandingFive.kloosterman_bound`")
    write(pre + ".clean.lean", "CLEAN", "CLEAN")
    if any(by[NP5].values()):
        print("STOP: a record on no_proper_five_coloring — not expected at this landing")
        return 1
    cnt = {k: {ln: len(v) for ln, v in by[k].items()} for k in by}
    print(f"records read: public {npub}, private {npriv}; already in scripts/Axioms.lean {present}")
    for k, lab in (("CLEAN", "CLEAN"), (PE, "IMPORTED pe"), (KB, "IMPORTED kb")):
        print(f"{lab}: {sum(cnt[k].values())}  " + "  ".join(f"{ln}={cnt[k].get(ln, 0)}" for ln in ORDER))
    return 0


sys.exit(main())
