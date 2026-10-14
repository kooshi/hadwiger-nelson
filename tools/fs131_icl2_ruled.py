#!/usr/bin/env python3
"""FS131-ICL2: each ruled statement change is exactly what was ruled (after FS131-ICL1's `tools/fs131_icl1_ruled.py`).

DROP (item 726's word: an unread instance binder dropped by `omit … in`): strip from BEFORE's stored type the instance
binder of the class named, and require the result to equal AFTER's stored type character for character.
ADD (the coordinator's two rulings: item 847 ruling 2 for `finite_quot`, the message of 2026-10-14 for
`rowsEdgeNull_levelRows`): strip from AFTER's stored type the binder named, and require the result to equal BEFORE's.
--plant: for every entry, strip nothing (and for one DROP entry, strip from the wrong dump) and require every entry to
report DIFFERS.

Usage: fs131_icl2_ruled.py BEFORE AFTER [--plant]
"""
import sys

C = "HadwigerNelson.Rigidity.Counting."
DROP = {
    C + "isIndepSet_levelTarget_iff": " : NumberField",
    C + "neg_mem_normOneQ": " : NumberField",
    C + "ratioLe_normOneQ": " : NumberField",
    C + "exists_unitRing_of_normOneL": " : NumberField",
    C + "Delta_ratCast": " : NumberField",
    C + "Delta_circle_mem_closure": " : NumberField",
    C + "pow_mem_normOneL": " : NumberField",
    C + "mul_mem_normOneL": " : NumberField",
}
ADD = {
    C + "finite_quot": " : NumberField",
    # an unused explicit binder prints as an arrow: `(HadwigerNelson.SpectralChain.TCA F) -> (<the rest>)`
    C + "rowsEdgeNull_levelRows": "ARROW:(HadwigerNelson.SpectralChain.TCA F) -> (",
}


def types(path):
    out, cur = {}, None
    for line in open(path, encoding="utf-8"):
        if line.startswith("@@ "):
            cur = line.split()[2]
        elif line.startswith("TYPE ") and cur:
            out[cur] = line.rstrip("\n").split(" ", 2)[2]
    return out


def strip(t, key):
    # the binder holding `key`, bracket to matching bracket, and the space after it
    if key.startswith("ARROW:"):
        pat = key[len("ARROW:"):]
        i = t.find(pat)
        if i < 0:
            return None
        j = i + len(pat) - 1          # the `(` that opens the rest
        depth, k = 0, j
        while k < len(t):
            depth += t[k] == "("
            depth -= t[k] == ")"
            if depth == 0:
                break
            k += 1
        head, inner = t[:i], t[j + 1:k]
        # `∀ binders, (A) -> (∀ more, B)` without the arrow is `∀ binders more, B`: the printer merges the binders
        if head.endswith(", ") and inner.startswith("forall "):
            return head[:-2] + " " + inner[len("forall "):] + t[k + 1:]
        return head + inner + t[k + 1:]
    i = t.find(key)
    if i < 0:
        return None
    if key.startswith("("):
        j, open_, close = i, "(", ")"
    else:
        j = t.rfind("[", 0, i)
        open_, close = "[", "]"
    depth, k = 0, j
    while k < len(t):
        depth += t[k] == open_
        depth -= t[k] == close
        if depth == 0:
            break
        k += 1
    return t[:j] + t[k + 2:]


def main(argv):
    b, a = types(argv[0]), types(argv[1])
    plant = "--plant" in argv
    results = []
    for n, key in DROP.items():
        t = b[n] if not plant else b[n]
        t2 = t if plant else strip(t, key)
        same = t2 is not None and t2 == a[n]
        results.append(same)
        print(("EXACT    " if same else "DIFFERS  ") + f"DROP {n}: {key.strip()}")
    for n, key in ADD.items():
        t2 = a[n] if plant else strip(a[n], key)
        same = t2 is not None and t2 == b[n]
        results.append(same)
        print(("EXACT    " if same else "DIFFERS  ") + f"ADD  {n}: {key.replace('ARROW:', '').strip()}")
    if plant:
        fired = sum(1 for r in results if not r)
        print(f"plant: {fired} of {len(results)} entries report DIFFERS")
        return 0 if fired == len(results) else 1
    ok = all(results)
    print("RESULT: " + ("PASS" if ok else "FAIL") + f" ({sum(results)} of {len(results)} exact)")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
