#!/usr/bin/env python3
"""FS131-IRU2: write tools/fs131_iru2_statements.py from tools/fs131_ifr2_statements.py (docstring, sides, ruled set, plants)."""
import pathlib
R = pathlib.Path('/home/kooshi/source/lean-dir/.claude/worktrees/il5')
s = (R/'tools/fs131_ifr2_statements.py').read_text()
i0 = s.index('"""'); i1 = s.index('"""', i0 + 3) + 3
doc_new = '''"""FS131-IRU2 — the merge of `main` into `fs131-kru1` changed no stored statement or definition of either line, from the
kernel's side. A copy of FS131-IFR2's comparator (`tools/fs131_ifr2_statements.py`): the sides, the ruled publicizations and
the plants replaced; the comparison itself unchanged.

Reads three prints of FS131-ICO2's dumper (format: `## MODULE <m> constants=<n>`, then per constant
`@@ <KIND> <name> [INTERNAL | PRIVATE <user name>] [PROPTYPE]`, `TYPE <hash> <raw>`, and for a definition `VALUE <hash> <raw>`
and, when its type is not a proposition, `DATA <hash> <raw>` — the value with every proof subterm erased):
  IRU1   — FS131-IRU1's gated build 3 (gate `ddb765bac`; `data/fs131/iru1/statements-after-build3.txt.gz`; six modules);
  MAIN   — `main`'s gated build (FS131-IFR2's, of `b8cef1f36`; `data/fs131/ifr2/statements-merged.txt.gz`; 27 modules);
  MERGED — the merged build being gated (`data/fs131/iru2/lean/StatementDump.lean`; the union, 33 modules).

The two sides cover disjoint module sets. For each side S and every constant c of S that is not INTERNAL:
  SAME        MERGED's same module holds c with the same kind, the same flags, the same stored type (text), and for a
              definition the same DATA when S printed one, else the same VALUE;
  PUBLICIZED  c is S's private `_private.<m>.0.<n>`, the OTHER side ruled `n` public (RULED_PUBLIC below), and MERGED holds
              `n` public in the same module with the same kind and the same stored type up to the hygienic hash an instance
              binder's name carries (FS131-ICS1's finding). Idle here: the one ruled set (FS131-IRU1's three lemmas of
              `Rigidity/AdmissiblePrime`, item 1044) is in a module only IRU1's print covers, where they are already public;
  CHANGED     anything else that differs                                                                  -> FAIL;
  MISSING     absent from MERGED                                                                          -> FAIL.
MERGED's constants (not INTERNAL) of a covered module that no side holds under their name, and that are not a PUBLICIZED
form, are ADDED -> FAIL unless GENERATED (`f.congr_simp`, `f.eq_n`, `f.eq_def`: reserved names Lean writes on demand):
a merge adds no declaration. A constant both sides hold with different text is reported CONFLICT -> FAIL. Modules MERGED
holds and no side covers are counted, not compared. INTERNAL constants are counted per module, never compared.
Also reported: for every definition whose DATA (or VALUE) agrees, whether its full VALUE also agrees (VALUE-MOVED is
information: a proof term inside a definition, never a statement).

--plant runs the comparison six more times on MERGED changed in memory and requires each fault reported by name, and
nothing else new: one character of a public stored type in `Rigidity/UnitRingEq` (recompiled by the merge); one public
constant of `Rigidity/UsablePrime` dropped; one unlisted public constant added to `Instances/UnitRingModels`; one character
of a public stored type in `Collapse/Density/Headline`; one public constant of `Rigidity/FourColourPlaces` dropped;
FS131-IRU1's publicization of `exists_integral_primitive` undone (MERGED holding it private).
Usage: fs131_iru2_statements.py IRU1 MAIN MERGED [--plant]   exit 0 iff the comparison is clean (and, with --plant, every
plant fired)
"""'''
s = s[:i0] + doc_new + s[i1:]
r0 = s.index('RULED_PUBLIC = {'); r1 = s.index('}\n', r0) + 2
s = s[:r0] + '''RULED_PUBLIC = {
    "HadwigerNelson.Rigidity.exists_integral_primitive": "IRU1",   # inventory item 1044
    "HadwigerNelson.Rigidity.exists_dvd_of_dvd_exponent": "IRU1",  # inventory item 1044
    "HadwigerNelson.Rigidity.nonempty_residueHom": "IRU1",         # inventory item 1044
}
''' + s[r1:]
assert s.count('CR = "Proofs.HadwigerNelson.Rigidity.ClassRatio"\n') == 1
s = s.replace('CR = "Proofs.HadwigerNelson.Rigidity.ClassRatio"\n', 'AP = "Proofs.HadwigerNelson.Rigidity.AdmissiblePrime"\n')
p0 = s.index('def plants(sides, merged):'); p1 = s.index('    ok = True', p0)
s = s[:p0] + '''def plants(sides, merged):
    out = []
    P = "Proofs.HadwigerNelson."
    URE, USP, URM = P + "Rigidity.UnitRingEq", P + "Rigidity.UsablePrime", P + "Instances.UnitRingModels"
    DEN, FCP = P + "Collapse.Density.Headline", P + "Rigidity.FourColourPlaces"

    def flip(t):
        i = t.index("Real") if "Real" in t else 0
        return t[:i] + ("X" if t[i] != "X" else "Y") + t[i + 1:]

    m1 = copy.deepcopy(merged); n1 = first_public(m1, URE); m1[URE][n1]["TYPE"] = flip(m1[URE][n1]["TYPE"])
    out.append(("ring type changed", m1, f"CHANGED {URE} {n1}"))
    m2 = copy.deepcopy(merged); n2 = first_public(m2, USP); del m2[USP][n2]
    out.append(("ring constant dropped", m2, f"MISSING {USP} {n2}"))
    m3 = copy.deepcopy(merged); n3 = first_public(m3, URM)
    m3[URM]["HadwigerNelson.UnitRingModels.planted_extra"] = dict(m3[URM][n3])
    out.append(("unlisted public added", m3, f"ADDED {URM} HadwigerNelson.UnitRingModels.planted_extra"))
    m4 = copy.deepcopy(merged); n4 = first_public(m4, DEN); m4[DEN][n4]["TYPE"] = flip(m4[DEN][n4]["TYPE"])
    out.append(("density type changed", m4, f"CHANGED {DEN} {n4}"))
    m5 = copy.deepcopy(merged); n5 = first_public(m5, FCP); del m5[FCP][n5]
    out.append(("five-colour constant dropped", m5, f"MISSING {FCP} {n5}"))
    m6 = copy.deepcopy(merged); un = "HadwigerNelson.Rigidity.exists_integral_primitive"
    c = m6[AP].pop(un); c = dict(c); c["private"] = True; c["user"] = un; c["flags"] = f"PRIVATE {un} PROPTYPE"
    m6[AP][f"_private.{AP}.0.{un}"] = c
    out.append(("IRU1's publicization undone", m6, f"MISSING {AP} {un} (vs IRU1)"))
''' + s[p1:]
assert s.count('sides = {"IFR1": read(args[0]), "ICS1": read(args[1])}') == 1
s = s.replace('sides = {"IFR1": read(args[0]), "ICS1": read(args[1])}', 'sides = {"IRU1": read(args[0]), "MAIN": read(args[1])}')
(R/'tools/fs131_iru2_statements.py').write_text(s)
print('written')
