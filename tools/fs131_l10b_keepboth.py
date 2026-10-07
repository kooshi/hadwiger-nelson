#!/usr/bin/env python3
"""FS131-L10B: resolve the conflict hunks of a join by the three-way rule, and check any merged file against it.

The rule, line by line (blank lines apart): a line stands in the merged file exactly

    ours + theirs - base        (never below zero)

times, the three counts being its multiplicities at the two tips and at their merge base. That is what a
three-way merge of disjoint changes gives: a line both sides hold once and the base held once stays once;
a line one side added is there once; a line one side deleted or rewrote is gone, and its rewriting is there.
It is stricter than "every line of both sides is present": a row one side rewrote must not come back
through the other side's unchanged copy.

  tools/fs131_l10b_keepboth.py resolve [--theirs-first] <file>
      <file> holds diff3-style hunks (`<<<<<<<`, `|||||||`, `=======`, `>>>>>>>`; make the merge with
      `git -c merge.conflictStyle=diff3 merge …`). Each hunk is resolved by key: a line beginning `| ` is
      keyed by its first table cell (a row of ARCHITECTURE.md), any other line by its whole text. Theirs'
      lines are walked in order: a key the base holds is given ours' line when theirs left the base's line
      alone, theirs' line when ours left it alone, and the hunk is REFUSED when both changed it; a key the
      base lacks is theirs' addition and is kept. Ours' additions (keys neither the base nor theirs holds)
      follow, after a blank line when the hunk has no base (adjacent blocks) — or come first, with
      --theirs-first reversed: ours' walk first is the default order "ours, theirs"; with --theirs-first
      theirs' additions stand before ours'. A base line one side deleted and the other left alone is dropped.

  tools/fs131_l10b_keepboth.py check <file> <ours-ref> <theirs-ref> <base-ref> <path-in-git>
      No conflict marker; every line's multiplicity is the rule's (LOST when below, EXTRA when above);
      for a file with `#print axioms` lines, their number is ours + theirs - base and no name is printed
      twice (TWICE). Exit 0 iff all hold. A path absent at a ref is read as empty there.

  tools/fs131_l10b_keepboth.py --self-test <file> <ours-ref> <theirs-ref> <base-ref> <path-in-git>
      `check` on the file, then on plants written to scratch copies, each of which must fail with its own
      word: a line only theirs holds dropped (LOST); a line only theirs holds doubled (EXTRA, and TWICE
      when it is a record); a marker left in (MARKER); when ours rewrote a base line, the base's
      line put back beside the rewriting (EXTRA: the stale row a plain keep-both would have kept); and,
      in a file of records, a record of theirs doubled (TWICE) and one dropped (COUNT).
"""
import collections
import subprocess
import sys
import tempfile


def show(ref, path):
    r = subprocess.run(["git", "show", f"{ref}:{path}"], capture_output=True, text=True)
    return r.stdout if r.returncode == 0 else ""


def key(ln):
    if ln.startswith("| "):
        return "ROW " + ln.split("|")[1].strip()
    return ln


def resolve_hunk(O, B, T, theirs_first):
    """One hunk's merged lines, or None when both sides changed one key."""
    ko = {key(l): l for l in O if l.strip()}
    kb = {key(l): l for l in B if l.strip()}
    kt = {key(l): l for l in T if l.strip()}
    walk_first, walk_second = (T, O) if theirs_first or B else (O, T)
    # with a base in the hunk the skeleton is theirs' order (theirs' additions sit between base rows);
    # with no base the two sides are adjacent blocks and the order is the flag's
    kf = kt if walk_first is T else ko
    ks = ko if walk_first is T else kt
    out = []
    for l in walk_first:
        if not l.strip():
            out.append(l)
            continue
        k = key(l)
        if k in kb:
            if k not in ks:                      # the other side deleted the base's line
                if l == kb[k]:
                    continue
                return None
            if l == kb[k]:
                out.append(ks[k])                # this side left it alone: the other side's line
            elif ks[k] == kb[k] or ks[k] == l:
                out.append(l)                    # the other side left it alone (or agrees)
            else:
                return None
        else:
            out.append(l)                        # this side's addition
            if k in ks and ks[k] != l:
                return None                      # both added one key, differently
    extra = [l for l in walk_second if l.strip() and key(l) not in kb and key(l) not in kf]
    if extra:
        if not B:
            out.append("")
        out.extend(extra)
    # a base line this walk never met (deleted by the first side): the second side must have left it alone
    for k, l in kb.items():
        if k not in kf and k in ks and ks[k] != l:
            return None
    return out


def resolve(path, theirs_first=False):
    out, state, n = [], None, 0
    O, B, T = [], [], []
    for ln in open(path, encoding="utf-8").read().split("\n"):
        if ln.startswith("<<<<<<< "):
            assert state is None, "nested hunk"
            state, n = "ours", n + 1
            O, B, T = [], [], []
        elif ln.startswith("||||||| ") and state == "ours":
            state = "base"
        elif ln == "=======" and state in ("ours", "base"):
            if state == "ours":
                sys.exit("refused: a hunk with no base section (make the merge with merge.conflictStyle=diff3)")
            state = "theirs"
        elif ln.startswith(">>>>>>> ") and state == "theirs":
            state = None
            merged = resolve_hunk(O, B, T, theirs_first)
            if merged is None:
                sys.exit(f"REFUSED: hunk {n} of {path}: both sides changed one line or row; resolve it by hand")
            out.extend(merged)
        elif state == "ours":
            O.append(ln)
        elif state == "base":
            B.append(ln)
        elif state == "theirs":
            T.append(ln)
        else:
            out.append(ln)
    if state is not None:
        sys.exit("refused: an unterminated hunk")
    if n == 0:
        sys.exit("refused: no conflict hunk in the file")
    open(path, "w", encoding="utf-8").write("\n".join(out))
    print(f"resolved {n} hunk(s) in {path}" + (" (theirs first)" if theirs_first else ""))


def count(text):
    return collections.Counter(l for l in text.split("\n") if l.strip())


def check_text(text, ours, theirs, base):
    faults = []
    lines = text.split("\n")
    for ln in lines:
        if ln.startswith(("<<<<<<< ", ">>>>>>> ", "||||||| ")) or ln == "=======":
            faults.append(f"MARKER {ln[:40]!r}")
    have, co, ct, cb = count(text), count(ours), count(theirs), count(base)
    for l in set(have) | set(co) | set(ct):
        if l.startswith(("<<<<<<< ", ">>>>>>> ", "||||||| ")) or l == "=======":
            continue
        want = max(0, co[l] + ct[l] - cb[l])
        if have[l] < want:
            faults.append(f"LOST {l[:100]!r} (rule {want} = ours {co[l]} + theirs {ct[l]} - base {cb[l]}; have {have[l]})")
        elif have[l] > want:
            faults.append(f"EXTRA {l[:100]!r} (rule {want} = ours {co[l]} + theirs {ct[l]} - base {cb[l]}; have {have[l]})")
    pr = lambda t: [l.split()[2] for l in t.split("\n") if l.startswith("#print axioms ")]
    nums = None
    if pr(text) or pr(ours) or pr(theirs):
        nums = (len(pr(text)), len(pr(ours)), len(pr(theirs)), len(pr(base)))
        if nums[0] != nums[1] + nums[2] - nums[3]:
            faults.append(f"COUNT #print axioms: have {nums[0]}, expected ours {nums[1]} + theirs {nums[2]} - base {nums[3]}")
        for nm, k in collections.Counter(pr(text)).items():
            if k > 1:
                faults.append(f"TWICE {nm} ({k})")
    return sorted(faults), nums, sum(have.values())


def check(path, ours_ref, theirs_ref, base_ref, gitpath, label="check"):
    text = open(path, encoding="utf-8").read()
    faults, nums, n = check_text(text, show(ours_ref, gitpath), show(theirs_ref, gitpath), show(base_ref, gitpath))
    extra = "" if nums is None else f"; #print axioms lines {nums[0]} = ours {nums[1]} + theirs {nums[2]} - base {nums[3]}"
    print(f"{label}: {gitpath}: {n} non-blank lines{extra}; faults {len(faults)}")
    for f in faults[:12]:
        print("  " + f)
    return faults


def main(argv):
    if len(argv) >= 2 and argv[0] == "resolve":
        resolve(argv[-1], theirs_first="--theirs-first" in argv)
        return 0
    if len(argv) == 6 and argv[0] == "check":
        faults = check(*argv[1:])
        print("three-way: PASS" if not faults else "three-way: FAIL")
        return 1 if faults else 0
    if len(argv) == 6 and argv[0] == "--self-test":
        path, o, t, b, gp = argv[1:]
        ok = not check(path, o, t, b, gp, label="faithful")
        text = open(path, encoding="utf-8").read()
        co, ct, cb = count(show(o, gp)), count(show(t, gp)), count(show(b, gp))
        theirs_only = [l for l in show(t, gp).split("\n") if l.strip() and co[l] == 0 and cb[l] == 0 and ct[l] == 1]
        ours_rewrote = [l for l in show(b, gp).split("\n") if l.strip() and cb[l] == 1 and co[l] == 0 and ct[l] == 1]
        if not theirs_only:
            print("self-test: no line that theirs alone holds — the plants cannot be planted")
            return 1
        victim = theirs_only[0]
        plants = [
            ("LOST", "a line of theirs dropped", text.replace(victim + "\n", "", 1)),
            ("EXTRA", "a line of theirs doubled", text.replace(victim + "\n", victim + "\n" + victim + "\n", 1)),
            ("MARKER", "a marker left in", text.replace(victim + "\n", "=======\n" + victim + "\n", 1)),
        ]
        if ours_rewrote:
            plants.append(("EXTRA", "the base's line put back beside ours' rewriting",
                           text.replace(victim + "\n", victim + "\n" + ours_rewrote[0] + "\n", 1)))
        else:
            print("  (no base line that ours alone rewrote in this file: the stale-row plant is not applicable here)")
        recs = [l for l in theirs_only if l.startswith("#print axioms ")]
        if recs:
            plants.append(("TWICE", "a record of theirs doubled", text.replace(recs[0] + "\n", recs[0] + "\n" + recs[0] + "\n", 1)))
            plants.append(("COUNT", "a record of theirs dropped", text.replace(recs[0] + "\n", "", 1)))
        for word, what, planted in plants:
            if planted == text:
                print(f"  plant ({what}): COULD NOT BE PLANTED")
                ok = False
                continue
            with tempfile.NamedTemporaryFile("w", suffix=".txt", delete=False, encoding="utf-8") as f:
                f.write(planted)
            faults = check(f.name, o, t, b, gp, label=f"plant ({what})")
            fired = any(x.startswith(word) for x in faults)
            print(f"  -> {'fired' if fired else 'DID NOT FIRE'} ({word})")
            ok = ok and fired
        print("self-test: PASS" if ok else "self-test: FAIL")
        return 0 if ok else 1
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
