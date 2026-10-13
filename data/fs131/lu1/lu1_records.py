#!/usr/bin/env python3
"""FS131-LU1: the landing's records in the gate's saved axioms log — every declaration a person typed in the three
modules of the residue upper half (`Arith/UpperHalf`, `Arith/QuadraticPrime`, `Instances/UpperHalfValues`) has exactly
one record, under CLEAN, on exactly the standard three axioms; and the landing files nothing on a declared outside
theorem, so over the whole log the records under IMPORTED are the twenty-six the last landing left (8 + 6 + 12).

After `data/fs131/lc1/records.py` (FS131-LC1's; not edited), which is loaded BY PATH under the name `lc1_records` — this
file is named otherwise so that no import by name can pick one for the other, and the loaded module's path is asserted —
and from which come the filing of the twenty-six imported records (`FILED`), the set of declared imports (`IMPORTS`),
the standard three (`STD`) and the reader of the audit's log (`l1.l10b.records`).  It lives under `data/fs131/lu1/`
because the job's brief names that directory and not `tools/`.

Two lists are read:
  DECLS       the output of `data/fs131/lu1/decls.lean` — every constant of the three modules as the kernel holds it
              (`LU1DECL <kind> <written|aux> <GEN|-> <module> <name>`); a declaration the landing brings is a
              `written`, non-`GEN` line of kind THM, DEF or IND: what a person typed, not what the elaborator made.
              (Private helpers have internal names and are not listed: `data/fs131/iv1/axioms-footer.txt` has theirs.)
  AXIOMS_LOG  the full output of `scripts/axioms.sh` (its saved receipt), every record with the banner it is under.

What the landing CLAIMS is written here, once: COUNTS (30 + 13 + 9 = 52 declarations, 49 theorems and 3 definitions)
and HEADLINES (the theorems the front page will name).  What the library SHIPS is the log.  The checks:

  MISSING / DOUBLED      every declaration the landing brings has exactly one record
  NOT-CLEAN-SECTION      … printed under CLEAN
  FOREIGN                … on a subset of the standard three (`sorryAx`, a native auxiliary, an outside theorem: refused)
  NOT-EXACTLY-THREE      … and in fact on exactly the three, as the implementers' prints say of all fifty-two
  HEADLINE               each headline is a theorem the landing brings, under CLEAN, on exactly the three
  MODULES / COUNTS       the dump lists exactly the three modules, with 30, 13 and 9 declarations
  IMPORTED-SET           over the WHOLE log, the records under IMPORTED are exactly the twenty-six filed before
  IMPORT-RECORD          … each on the standard three and exactly its one import
  IMPORT-LEAK            over the whole log, no record outside an import's filed set carries that import
  TWO-IMPORTS            over the whole log, no record carries two declared imports
  SORRY                  over the whole log, no record carries `sorryAx`

Usage: lu1_records.py DECLS AXIOMS_LOG
       lu1_records.py DECLS AXIOMS_LOG --plant
           in memory, fifteen faults, one at a time, each required to be refused by the check it was written for; the
           unplanted lists must pass first (the partner).  Exit 0 from --plant means every plant fired; 1 otherwise.
       lu1_records.py DECLS --unfiled AXIOMS_LEAN
           before the audit runs: the declarations the landing brings that `scripts/Axioms.lean` holds no
           `#print axioms` line for (one name per line), and those it holds more than one line for.  Exit 1 if any.
       lu1_records.py DECLS AXIOMS_LOG --lines
           the record's "Theorems this phase proved, final" lines: every declaration with its banner and its axioms.
Exit 0 when every check holds; 1 otherwise (each failure printed); 2 when a list could not be read at all.
"""
import collections
import importlib.util
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT / "tools"))
_p = ROOT / "data" / "fs131" / "lc1" / "records.py"
_spec = importlib.util.spec_from_file_location("lc1_records", _p)
c = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(c)
assert Path(c.__file__).resolve() == _p.resolve(), c.__file__

l1 = c.l1
STD = c.STD
FILED = c.FILED            # {import: the records filed on it}, 8 + 6 + 12 after FS131-LC1
ALL_FILED = c.ALL_FILED
IMPORTS = c.IMPORTS
assert sum(len(v) for v in FILED.values()) == 26 and len(ALL_FILED) == 26, "the last landing left twenty-six"
HN = "HadwigerNelson."
U, Q = HN + "UpperHalf.", HN + "QuadraticPrime."
M = "Proofs.HadwigerNelson."
COUNTS = {M + "Arith.UpperHalf": 30, M + "Arith.QuadraticPrime": 13, M + "Instances.UpperHalfValues": 9}
KINDS = ("THM", "DEF", "IND")
KIND_COUNTS = {"THM": 49, "DEF": 3, "IND": 0}
# the theorems the front page and the ledger rows will name
HEADLINES = [U + n for n in (
    "nonempty_hom_unitQuadrance nonempty_hom_finitePlane chromaticNumber_planeOver_le_unitQuadrance "
    "chromaticNumber_planeOver_le_finitePlane colorable_planeOver_of_finitePlane exists_hom_levelTarget "
    "nonempty_hom_levelTarget_one chromaticNumber_planeOver_le_levelTarget chromaticNumber_planeOver_le_localBound "
    "chromaticNumber_eq_localBound_of_chain two_mem_of_conj_trivial colorable_two_planeOver_of_ramified "
    "exists_stablePrime_of_valuationSubring inv_natCast_mem_unitRingOver_iff_forall_stablePrime "
    "colorable_planeOver_fieldOfRadicands chromaticNumber_planeOver_eleven chromaticNumber_planeOver_sqrt167_le_eight "
    "chromaticNumber_planeOver_sqrt47_le_five_of_prime numberField_bot two_le_chromaticNumber_planeOver "
    "exists_stablePrime_rat chromaticNumber_planeOver_rat").split()] + [Q + n for n in (
        "numberField_fieldOfRadicands exists_ringHom_zmod_of_padic exists_maximal_card_of_padic exists_padicInt_sq_eq "
        "nonempty_ringHom_padic exists_maximal_card_eq exists_maximal_card_eq_sqrt "
        "nonempty_ringHom_zmod_of_ramified_sqrt exists_maximal_card_eq_of_ramified").split()]


def decls(path):
    """{name: (kind, module)} for the declarations the landing brings, the modules the dump lists, the constants."""
    out, mods, total = {}, set(), 0
    for ln in open(path, encoding="utf-8"):
        p = ln.split()
        if ln.startswith("LU1MODULE ") and len(p) >= 2:
            mods.add(p[1])
        if ln.startswith("LU1DECL ") and len(p) >= 6:
            total += 1
            kind, written, gen, mod, name = p[1], p[2], p[3], p[4], p[5]
            if written == "written" and gen == "-" and kind in KINDS:
                out[name] = (kind, mod)
    return out, mods, total


def check(wave, mods, recs):
    by = collections.defaultdict(list)
    for n, ax, sec in recs:
        by[n].append((ax, sec))
    bad, tally = [], collections.Counter()
    for n in sorted(wave):
        got = by.get(n, [])
        if len(got) != 1:
            bad.append(f"{'MISSING' if not got else 'DOUBLED'} {n} ({len(got)} records; {wave[n][0]}, module {wave[n][1]})")
            continue
        ax, sec = got[0]
        if sec != "CLEAN":
            bad.append(f"NOT-CLEAN-SECTION {n}: printed under {sec or 'no banner'}")
        if ax - STD:
            bad.append(f"FOREIGN {n}: {sorted(ax - STD)}")
            continue
        if ax != STD:
            bad.append(f"NOT-EXACTLY-THREE {n}: [{', '.join(sorted(ax))}]")
        tally["exactly the three" if ax == STD else ("none" if not ax else "fewer: [" + ", ".join(sorted(ax)) + "]")] += 1
    for n in HEADLINES:
        got = by.get(n, [])
        if n not in wave or wave[n][0] != "THM":
            bad.append(f"HEADLINE {n}: not a theorem the landing brings")
        elif len(got) != 1 or got[0][0] != STD or got[0][1] != "CLEAN":
            bad.append(f"HEADLINE {n}: " + ("no single record" if len(got) != 1 else
                                            f"under {got[0][1]}, axioms {sorted(got[0][0])} — not exactly the three under CLEAN"))
    if mods != set(COUNTS):
        bad.append(f"MODULES: the dump lists {len(mods)} module(s); extra {sorted(mods - set(COUNTS))}, missing {sorted(set(COUNTS) - mods)}")
    per = collections.Counter(m for _, m in wave.values())
    kinds = collections.Counter(k for k, _ in wave.values())
    for m, k in COUNTS.items():
        if per[m] != k:
            bad.append(f"COUNTS {m}: {per[m]} declarations, the record says {k}")
    for k, v in KIND_COUNTS.items():
        if kinds[k] != v:
            bad.append(f"COUNTS kind {k}: {kinds[k]}, the record says {v}")
    # the whole log
    under = sorted(n for n, ax, sec in recs if sec == "IMPORTED")
    if under != sorted(ALL_FILED):
        bad.append(f"IMPORTED-SET: {len(under)} record(s) under IMPORTED; extra {sorted(set(under) - ALL_FILED)}, "
                   f"missing {sorted(ALL_FILED - set(under))}")
    for n, ax, sec in recs:
        carried = ax & IMPORTS
        if len(carried) > 1:
            bad.append(f"TWO-IMPORTS {n}: carries {sorted(l1.SHORT[a] for a in carried)}, under {sec}")
        for imp in carried:
            if n not in FILED[imp]:
                bad.append(f"IMPORT-LEAK {n}: carries {l1.SHORT[imp]} and is not filed on it, under {sec}")
        if "sorryAx" in ax:
            bad.append(f"SORRY {n}: carries sorryAx, under {sec}")
    for imp in sorted(IMPORTS):
        for n in sorted(FILED[imp]):
            got = by.get(n, [])
            if len(got) != 1 or got[0][1] != "IMPORTED" or got[0][0] != STD | {imp}:
                bad.append(f"IMPORT-RECORD {n}: filed on {l1.SHORT[imp]}; "
                           f"{'no single record' if len(got) != 1 else f'under {got[0][1]}, axioms {sorted(got[0][0])}'}")
    return bad, tally


def plants(wave, mods, recs):
    """[(label, the failure line's prefix, planted wave, planted mods, planted records)] — one alteration each."""
    plain = [n for n in sorted(wave) if n not in HEADLINES]
    c_drop, c_dbl, c_sorry, c_kb, c_imp, c_pur, c_nat, c_two = plain[:8]
    eleven = U + "chromaticNumber_planeOver_eleven"
    bound = U + "chromaticNumber_planeOver_le_localBound"
    rat = U + "chromaticNumber_planeOver_rat"
    old = sorted(FILED[l1.T])[0]
    ghost = U + "zz_lu1_planted_theorem_with_no_record"

    def alter(target, f):
        out = []
        for n, ax, sec in recs:
            out += f(n, ax, sec) if n == target else [(n, ax, sec)]
        return out
    w2 = dict(wave)
    w2[ghost] = ("THM", M + "Arith.UpperHalf")
    w3 = {n: v for n, v in wave.items() if n != c_drop}
    return [
        (f"a record dropped ({c_drop})", "MISSING " + c_drop, wave, mods, alter(c_drop, lambda n, ax, sec: [])),
        (f"a record doubled ({c_dbl})", "DOUBLED " + c_dbl, wave, mods, alter(c_dbl, lambda n, ax, sec: [(n, ax, sec)] * 2)),
        (f"sorryAx under a landing record ({c_sorry})", "SORRY " + c_sorry, wave, mods,
         alter(c_sorry, lambda n, ax, sec: [(n, ax | {"sorryAx"}, sec)])),
        (f"a landing record resting on Weil's bound ({c_kb})", "IMPORT-LEAK " + c_kb, wave, mods,
         alter(c_kb, lambda n, ax, sec: [(n, ax | {l1.KB}, sec)])),
        (f"a landing record FILED under IMPORTED, on the three and the transfer ({c_imp})",
         "NOT-CLEAN-SECTION " + c_imp, wave, mods, alter(c_imp, lambda n, ax, sec: [(n, ax | {l1.T}, "IMPORTED")])),
        (f"a landing record printed under PURCHASED ({c_pur})", "NOT-CLEAN-SECTION " + c_pur, wave, mods,
         alter(c_pur, lambda n, ax, sec: [(n, ax, "PURCHASED")])),
        (f"a native auxiliary under a landing record ({c_nat})", "FOREIGN " + c_nat, wave, mods,
         alter(c_nat, lambda n, ax, sec: [(n, ax | {n + "._native.native_decide.ax_1_1"}, sec)])),
        (f"a landing record on two axioms only ({c_two})", "NOT-EXACTLY-THREE " + c_two, wave, mods,
         alter(c_two, lambda n, ax, sec: [(n, ax - {"Quot.sound"}, sec)])),
        (f"THE VALUE THAT NEEDS NO IMPORT resting on the five-colour theorem: chi(Q(sqrt 11)^2) = 4 ({eleven})",
         "HEADLINE " + eleven, wave, mods, alter(eleven, lambda n, ax, sec: [(n, ax | {l1.H}, sec)])),
        (f"the upper half printed under IMPORTED ({bound})", "HEADLINE " + bound, wave, mods,
         alter(bound, lambda n, ax, sec: [(n, ax, "IMPORTED")])),
        (f"chi(Q^2) = 2 with no record ({rat})", "HEADLINE " + rat, wave, mods, alter(rat, lambda n, ax, sec: [])),
        (f"a theorem of the landing with no record ({ghost})", "MISSING " + ghost, w2, mods, recs),
        (f"an earlier record on the transfer stripped of it ({old})", "IMPORT-RECORD " + old, wave, mods,
         alter(old, lambda n, ax, sec: [(n, ax - {l1.T}, sec)])),
        ("a module absent from the dump (Arith.QuadraticPrime)", "MODULES", wave, mods - {M + "Arith.QuadraticPrime"}, recs),
        (f"a declaration absent from the kernel's list ({c_drop})", "COUNTS", w3, mods, recs),
    ]


def unfiled(decl_path, axioms_lean):
    wave, mods, total = decls(decl_path)
    if not wave:
        print(f"UNREADABLE: {decl_path} lists no declaration")
        return 2
    lines = collections.Counter(m.group(1) for m in re.finditer(r"^#print axioms (\S+)\s*$", open(axioms_lean, encoding="utf-8").read(), re.M))
    missing = [n for n in sorted(wave) if lines[n] == 0]
    doubled = [n for n in sorted(wave) if lines[n] > 1]
    for n in missing:
        print(f"UNFILED {wave[n][0]} {wave[n][1].replace(M, '')} {n}")
    for n in doubled:
        print(f"DOUBLED {lines[n]} {n}")
    print(f"declarations the landing brings: {len(wave)} (of {total} constants in {len(mods)} modules); "
          f"with one line: {len(wave) - len(missing) - len(doubled)}; unfiled: {len(missing)}; doubled: {len(doubled)}; "
          f"`#print axioms` lines in the script: {sum(lines.values())}, names twice: {sum(1 for v in lines.values() if v > 1)}")
    return 1 if missing or doubled else 0


def lines_out(wave, mods, total, recs):
    by = {n: (ax, sec) for n, ax, sec in recs}
    order = ["propext", "Classical.choice", "Quot.sound"]
    kind = {"THM": "theorem", "DEF": "definition", "IND": "structure"}
    for m in COUNTS:
        print(f"*`{m.replace(M, '').replace('.', '/')}`*")
        for n in sorted(x for x in wave if wave[x][1] == m):
            ax, sec = by[n]
            names = [a for a in order if a in ax] + sorted(a.replace(HN, "") for a in ax if a not in order)
            print(f"- `{n.replace(HN, '')}` — {kind[wave[n][0]]}; [kernel]; under {sec}; axioms: "
                  f"{'[' + ', '.join(names) + ']' if names else 'none'}")
    print(f"({len(wave)} declarations of {total} constants in {len(mods)} modules)")
    return 0


def main(argv):
    a = [x for x in argv if not x.startswith("--")]
    if "--unfiled" in argv:
        return unfiled(a[0], a[1]) if len(a) == 2 else 2
    if len(a) != 2:
        print(__doc__)
        return 2
    wave, mods, total = decls(a[0])
    recs = l1.l10b.records(open(a[1], encoding="utf-8").read())
    if not wave or not recs:
        print(f"UNREADABLE: landing declarations {len(wave)}, records {len(recs)}")
        return 2
    if "--lines" in argv:
        return lines_out(wave, mods, total, recs)
    bad, tally = check(wave, mods, recs)
    if "--plant" in argv:
        if bad:
            print(f"PLANT NOT RUN: the unplanted lists already fail ({len(bad)}); the partner must pass first")
            for b in bad:
                print("FAIL", b)
            return 1
        ok, ps = True, plants(wave, mods, recs)
        for label, prefix, w, m, r in ps:
            pbad, _ = check(w, m, r)
            fired = [b for b in pbad if b.startswith(prefix)]
            print(f"plant: {label}: {'FIRED' if fired else 'DID NOT FIRE'} — {fired[0] if fired else pbad[:2]}")
            ok = ok and bool(fired)
        print(f"plants: {f'every one of {len(ps)} fired; the unplanted lists pass' if ok else 'FAILED'}")
        return 0 if ok else 1
    kinds = collections.Counter(k for k, _ in wave.values())
    per = collections.Counter(m for _, m in wave.values())
    permod = ", ".join(m.replace(M, "") + " " + str(per[m]) for m in COUNTS)
    print(f"landing: {total} constants in {len(mods)} modules; declarations it brings: {len(wave)} "
          f"({', '.join(f'{kinds[k]} {k}' for k in KINDS)}; {permod}); records in the log: {len(recs)}")
    for k, v in sorted(tally.items()):
        print(f"  landing records on {k}: {v}")
    print(f"  headlines under CLEAN on exactly the three: {sum(1 for n in HEADLINES if not any(b.startswith('HEADLINE ' + n) for b in bad))} of {len(HEADLINES)}")
    for imp in (l1.KB, l1.H, l1.T):
        carrying = sorted(n for n, ax, sec in recs if imp in ax)
        print(f"  whole log: records carrying {l1.SHORT[imp]}: {len(carrying)} (filed: {len(FILED[imp])}); "
              f"of the landing's: {sum(1 for n in carrying if n in wave)}")
    print(f"  whole log: records under IMPORTED {sum(1 for r in recs if r[2] == 'IMPORTED')}; carrying two imports "
          f"{sum(1 for r in recs if len(r[1] & IMPORTS) > 1)}; carrying sorryAx {sum(1 for r in recs if 'sorryAx' in r[1])}")
    for b in bad:
        print("FAIL", b)
    print("records: PASS" if not bad else f"records: FAIL ({len(bad)})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
