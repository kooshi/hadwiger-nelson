#!/usr/bin/env python3
"""FS132-I4: read Print.out (the output of Print.lean) and decide.

A TARGET passes when
  * it is printed (AXIOMS and FRONTIER lines; no MISSING line);
  * its axioms are a subset of the standard three and `sorryAx` — no outside theorem, no native axiom, nothing else;
  * `sorryAx` is among them exactly when its frontier is non-empty;
  * every declaration of its frontier is declared by a module of ANOTHER lot. Through stage 5 those were
    Plane.SixRing.Chart, .Shift and .Tips; since Amendment 2 every module under the targets is proved (the chart's and
    the tips' by this job, the shift's by FS132-I3), so the set is EMPTY: a target on `sorryAx` fails, whatever the
    module of the `sorry`.
The three CONTROLS must each show what they exist to show; the DONE line must give the counts of targets.txt.
Exit 1 on any failure.  --self-test plants each fault in a copy of the output and requires exit 1 for each.
"""
import re, sys, pathlib
here = pathlib.Path(__file__).parent
STD = {'propext', 'Classical.choice', 'Quot.sound'}
ALLOWED = set()      # stage 5: {…SixRing.Chart, …SixRing.Shift, …SixRing.Tips}; empty since Amendment 2 (see above)

def lst(s):
    s = s.strip()
    assert s.startswith('[') and s.endswith(']'), s
    s = s[1:-1].strip()
    return [x.strip() for x in s.split(',') if x.strip()] if s else []

def parse(text):
    # messages may wrap: join the lines of one message
    text = re.sub(r'\n\s+', ' ', text)
    ax, fr, missing, done = {}, {}, [], None
    for line in text.splitlines():
        m = re.search(r'(TARGET|CONTROL) AXIOMS (\S+) (\S+) \| (\[.*\])\s*$', line)
        if m: ax[(m.group(1), m.group(3))] = (m.group(2), lst(m.group(4))); continue
        m = re.search(r'(TARGET|CONTROL) FRONTIER (\S+) (\S+) \| (\d+) \| (\[.*\])\s*$', line)
        if m: fr[(m.group(1), m.group(3))] = (int(m.group(4)), lst(m.group(5))); continue
        m = re.search(r'(TARGET|CONTROL) MISSING (\S+) (\S+)', line)
        if m: missing.append(m.group(3)); continue
        m = re.search(r'DONE (\d+) targets (\d+) controls', line)
        if m: done = (int(m.group(1)), int(m.group(2)))
    return ax, fr, missing, done

def decide(text, quiet=False):
    rows = [l.split() for l in (here/'targets.txt').read_text().splitlines() if l.strip() and not l.startswith('#')]
    ax, fr, missing, done = parse(text)
    bad, clean, onsorry = [], [], []
    def say(*a):
        if not quiet: print(*a)
    for kind, short in rows:
        n = 'HadwigerNelson.SixRing.' + short
        key = ('TARGET', n)
        if n in missing or key not in ax or key not in fr:
            bad.append(f'{short}: not printed'); continue
        axs, (cnt, holders) = set(ax[key][1]), fr[key]
        extra = axs - STD - {'sorryAx'}
        if extra: bad.append(f'{short}: axioms beyond the standard three and sorryAx: {sorted(extra)}')
        if ('sorryAx' in axs) != (cnt > 0): bad.append(f'{short}: sorryAx in axioms = {"sorryAx" in axs}, frontier size {cnt}')
        if cnt != len(holders): bad.append(f'{short}: frontier count {cnt} against {len(holders)} listed')
        foreign = [h for h in holders if h.split('@')[1] not in ALLOWED]
        if foreign: bad.append(f'{short}: sorry in a module that is not another lot\'s: {foreign}')
        (onsorry if 'sorryAx' in axs else clean).append((kind, short, sorted(h.split('@')[0].replace('HadwigerNelson.SixRing.', '') for h in holders)))
    # controls
    c1 = ax.get(('CONTROL', 'HadwigerNelson.Outside.OAI158.not_colorable_five'))
    if not c1 or 'HadwigerNelson.Outside.OAI158.no_proper_five_coloring' not in c1[1]:
        bad.append('control 1: the first outside theorem is not seen under not_colorable_five')
    c2 = ax.get(('CONTROL', 'HadwigerNelson.Outside.OAI158.chromaticNumber_plane_eq_chiM0'))
    if not c2 or 'HadwigerNelson.Outside.OAI158.proper_to_borel_weak' not in c2[1]:
        bad.append('control 2: the second outside theorem is not seen under chromaticNumber_plane_eq_chiM0')
    c3a, c3f = ax.get(('CONTROL', 'i4_control_user')), fr.get(('CONTROL', 'i4_control_user'))
    if not c3a or 'sorryAx' not in c3a[1] or not c3f or c3f[1] != ['i4_control_planted@«(this file)»']:
        bad.append(f'control 3: the planted sorry is not seen (axioms {c3a}, frontier {c3f})')
    if done != (len(rows), 3): bad.append(f'the DONE line reads {done}, targets.txt has {len(rows)}')
    say(f'targets={len(rows)} clean={len(clean)} on-sorry={len(onsorry)} failures={len(bad)}')
    say('CLEAN (exactly a subset of [propext, Classical.choice, Quot.sound]):')
    for kind, s, _ in clean: say(f'  {kind:7s} {s}')
    say('ON SORRY (each is a failure since Amendment 2):')
    for kind, s, h in onsorry: say(f'  {kind:7s} {s}  <-  {", ".join(h)}')
    for b in bad: say('FAIL', b)
    return 1 if bad else 0

def selftest():
    text = re.sub(r'\n\s+', ' ', OUT.read_text())      # one message per line, as `parse` reads it
    assert decide(text, quiet=True) == 0, 'the unplanted output must pass before the self-test means anything'
    plants = {
      'a sorry under a target, in a module of this job': lambda t: t.replace(
            'TARGET AXIOMS leaf HadwigerNelson.SixRing.unitPair_chart_ae | [', 'TARGET AXIOMS leaf HadwigerNelson.SixRing.unitPair_chart_ae | [sorryAx, ', 1).replace(
            'TARGET FRONTIER leaf HadwigerNelson.SixRing.unitPair_chart_ae | 0 | []',
            'TARGET FRONTIER leaf HadwigerNelson.SixRing.unitPair_chart_ae | 1 | [HadwigerNelson.SixRing.x@Proofs.HadwigerNelson.Plane.SixRing.State]', 1),
      'a sorry under the headline theorem, in the chart\'s module': lambda t: t.replace(
            'TARGET AXIOMS planner HadwigerNelson.SixRing.no_outside_orbit_points | [', 'TARGET AXIOMS planner HadwigerNelson.SixRing.no_outside_orbit_points | [sorryAx, ', 1).replace(
            'TARGET FRONTIER planner HadwigerNelson.SixRing.no_outside_orbit_points | 0 | []',
            'TARGET FRONTIER planner HadwigerNelson.SixRing.no_outside_orbit_points | 1 | [HadwigerNelson.SixRing.chart_hub@Proofs.HadwigerNelson.Plane.SixRing.Chart]', 1),
      'an outside theorem under a target': lambda t: t.replace('TARGET AXIOMS leaf HadwigerNelson.SixRing.OutsideOrbit.ae_flip | [',
            'TARGET AXIOMS leaf HadwigerNelson.SixRing.OutsideOrbit.ae_flip | [HadwigerNelson.Outside.OAI158.proper_to_borel_weak, ', 1),
      'a native axiom under a target': lambda t: t.replace('TARGET AXIOMS leaf HadwigerNelson.SixRing.ae_real_of_ae_angles | [',
            'TARGET AXIOMS leaf HadwigerNelson.SixRing.ae_real_of_ae_angles | [foo._native.native_decide.ax_1_1, ', 1),
      'a target not printed': lambda t: '\n'.join(l for l in t.splitlines() if 'HadwigerNelson.SixRing.step_kill |' not in l),
      'sorryAx with an empty frontier': lambda t: t.replace('TARGET AXIOMS helper HadwigerNelson.SixRing.change_of_ae_flip | [',
            'TARGET AXIOMS helper HadwigerNelson.SixRing.change_of_ae_flip | [sorryAx, ', 1),
      'the planted control gone clean': lambda t: re.sub(r'CONTROL FRONTIER planted i4_control_user \| 1 \| \[.*?\]', 'CONTROL FRONTIER planted i4_control_user | 0 | []', t, count=1),
      'an outside control gone clean': lambda t: t.replace('HadwigerNelson.Outside.OAI158.no_proper_five_coloring, ', '', 1).replace(', HadwigerNelson.Outside.OAI158.no_proper_five_coloring', '', 1),
    }
    fails = 0
    for name, f in plants.items():
        t2 = f(text)
        changed = t2 != text
        rc = decide(t2, quiet=True) if changed else 0
        ok = changed and rc == 1
        print(f'{"refused " if ok else "NOT REFUSED"} — {name}{"" if changed else " (the plant did not change the text)"}')
        fails += (not ok)
    print(f'plants={len(plants)} refused={len(plants)-fails}')
    return 1 if fails else 0

OUT = here/'Print.out'
if __name__ == '__main__':
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    if args: OUT = pathlib.Path(args[0])      # another output file (a trial run); the default is Print.out
    sys.exit(selftest() if '--self-test' in sys.argv else decide(OUT.read_text()))
