#!/usr/bin/env python3
"""brief_gate.py — the Keryx gate: a brief checked before it leaves.

Conventions checked (see SKILL.md <the_brief>; example-brief.md beside this file passes, example-dirty.md fails by
design, one planted defect per failure):

  quotation  a blockquote — consecutive lines starting with ">" — whose last line is "> — source: <path>" (the word
             "source" in any case). After the path, "§ <heading>" or "row <id>" is an address: the quoted text must
             occur verbatim inside that heading's section (up to the next heading of its level; a heading matches when
             its text, as written or with leading numbers aside, starts with the anchor and the anchor ends a word) or
             inside the table row whose first cell is <id>.
             Anything else after the path is kept for the reader and ignored. Runs of whitespace and blockquote markers
             are ignored. An elision is written "…" or "[…]", and the pieces between elisions must occur in order —
             except in the statements section, where a statement is quoted whole. Every blockquote in a brief is a
             quotation: one with no source line fails, and so do a source that does not resolve, is a directory, or is
             a path the brief's own fence closes (a blind mind must be able to read back what it was sent).
  brief      a line "brief: <id>" at column 0, then indented "field: value" lines, a value continuing on further
             indented lines. The fields:
               identity:        the identity the recipient loads, and the skills it loads fresh
               role:            what it is
               launch:          when it launches: "now", or after which hand-back or commit
               mission:         "§ <heading>" — why the job exists
               statements:      "§ <heading>" holding at least one quotation, or "none — <reason>"
               acceptance:      "§ <heading>" — what done looks like, stated before the work
               yours:           "§ <heading>" — the decisions that are the recipient's
               fences:          "§ <heading>", or "none — <reason>" — never none for a role that names blind, a verifier,
                                a second mind or derivation, a competitor, or independence
               channel:         how the recipient reaches you mid-flight, and where its report goes
               standing rules:  a file that exists (its first backticked token, else its first word) with a paragraph
                                that names spawning agents, forbids it, and gives a reason — a word such as because,
                                reason, why, since, so that, or a clause after a colon or a dash
               record:          the recipient's record; it must be one of the touches, or under one, or match one
               touches:         the paths the recipient may write
               budget:          the size, as guidance, and the hand-back line
             Every "§ <heading>" must name a heading in the brief with text under it. A fence section must name at
             least one path. Every path the brief names outside its quotations must exist, except those the recipient
             will create (record, touches, channel) and those in the fence section. A backticked token counts as a
             path when it has a file extension, ends in "/", starts with "~/", or its first segment exists.

What the gate proves, and only this: each quotation is verbatim in its source, at its address when it names one; a
statement is quoted whole; no quotation's source is fenced; the fields are present; the sections they name exist and are
not empty; the backticked paths outside quotations exist; a role that names a second mind has a fence section that names
paths; the standing rules have a paragraph that names, forbids, and gives a reason. It warns, and does not fail, when a
fence names no git history, no shared scratch, or no session transcripts — the three channels a harness most often
leaves open — and when a fenced brief says "prove" or "confirm", which can hand the recipient the verdict.

What it cannot see: a paraphrase in prose beside the quotation; a path written without backticks; a channel that names no
real way to reach you; a verdict given in other words; whether the quotation is the statement that should have been sent;
whether the why is the real one; whether the fence names every channel the recipient can reach.

Subcommands: quotes | brief | all          (all = brief, then quotes, on every file)
Paths resolve from --root (default: the current directory), then from the brief's own directory.
Exit status is non-zero when a check fails. Standard library only.
"""
import fnmatch
import os
import re
import sys

FIELDS = ["identity", "role", "launch", "mission", "statements", "acceptance", "yours", "fences", "channel",
          "standing rules", "record", "touches", "budget"]
SECTION_FIELDS = ["mission", "statements", "acceptance", "yours", "fences"]
MAY_BE_NONE = {"statements", "fences"}
NEW_PATH_FIELDS = ["record", "touches", "channel"]
SOURCE = re.compile(r"^\s*(?:—|--)\s*source:\s*`?([^`\s]+)`?(.*)$", re.I)
ELISION = re.compile(r"\s*(?:\[…\]|\[\.\.\.\]|…)\s*")
TICKED = re.compile(r"`([^`\s]+)`")
EXT = re.compile(r"\.[A-Za-z][A-Za-z0-9]{0,5}$")
SECOND_MIND = re.compile(r"\bblind\b|verif|second (?:mind|derivation)|competitor|independen", re.I)
SPAWN = re.compile(r"spawn|subagent|child agent|children|fork|delegat|agents? of (?:your|its) own|starts? another agent",
                   re.I)
FORBID = re.compile(r"\b(?:no|not|never|don't|do not|may not|must not|cannot|forbid\w*)\b", re.I)
REASON = re.compile(r"\bbecause\b|\breason\b|\bwhy\b|\bso that\b|\bsince\b|:\s+\S|\s—\s", re.I)
VERDICT_WORDS = re.compile(r"\b(?:prove|confirm)\b(?!\s+or\s+(?:refute|disprove))", re.I)
CHANNELS = [("git history", re.compile(r"git log|git show|commit (?:subject|bod|histor)|git histor", re.I)),
            ("shared scratch", re.compile(r"scratch", re.I)),
            ("session transcripts", re.compile(r"transcript", re.I))]

FAIL, WARN = [], []


def fail(f, msg):
    FAIL.append(f"FAIL  {f}: {msg}")


def warn(f, msg):
    WARN.append(f"warn  {f}: {msg}")


def norm(s):
    s = re.sub(r"(?m)^[ \t]*>[ \t]?", "", s)
    return re.sub(r"\s+", " ", s).strip()


def resolve(p, base, root):
    p = os.path.expanduser(p)
    for c in (os.path.join(root, p), os.path.join(base, p)):
        if os.path.exists(c):
            return c
    return None


def is_path(tok, base, root):
    """A backticked token is a path when it has an extension, ends in "/", starts with "~/", or its first segment exists."""
    if any(c in tok for c in "<>") or tok.startswith("http"):
        return False
    if tok.startswith("~/") or tok.endswith("/"):
        return True
    if "/" in tok or "." in tok:
        if EXT.search(tok.rstrip("*")) and not re.match(r"^[\d./]+$", tok):
            return True
    return "/" in tok and resolve(tok.split("/")[0], base, root) is not None


def quotations(text):
    """Yield (line number, quoted text, source line or None, character offset) for every blockquote."""
    lines = text.split("\n")
    offs, off = [], 0
    for l in lines:
        offs.append(off)
        off += len(l) + 1
    i = 0
    while i < len(lines):
        if lines[i].lstrip().startswith(">"):
            start, body = i, []
            while i < len(lines) and lines[i].lstrip().startswith(">"):
                body.append(re.sub(r"^\s*>\s?", "", lines[i]))
                i += 1
            src = None
            if body and SOURCE.match(body[-1]):
                src = body.pop()
            yield start + 1, "\n".join(body), src, offs[start], offs[i - 1] + len(lines[i - 1]) + 1
        else:
            i += 1


def starts(h, a):
    """h begins with a, and a ends at a word boundary: "3" matches "3. The gap", never "30"."""
    return h.startswith(a) and (len(h) == len(a) or not h[len(a)].isalnum())


def heading_name(h):
    return re.sub(r"^[\d.]+\s+", "", h.strip()).strip().lower()


def sections(text):
    """[(heading name, level, body start, body end, raw heading)] for every markdown heading."""
    heads = [(m.start(), len(m.group(1)), heading_name(m.group(2)), m.end(), m.group(2).strip().lower())
             for m in re.finditer(r"(?m)^(#{1,6})\s+(.+?)\s*$", text)]
    out = []
    for j, (s, lvl, name, e, raw) in enumerate(heads):
        end = next((h[0] for h in heads[j + 1:] if h[1] <= lvl), len(text))
        out.append((name, lvl, e, end, raw))
    return out


def section_body(text, name):
    for n, _, a, b, _ in sections(text):
        if n == name:
            return text[a:b], a, b
    return None, 0, 0


def diverges(piece, hay):
    """Where piece leaves hay: the longest word-prefix found, what the brief has next, and what the source has next."""
    words = piece.split(" ")
    k = 0
    while k < len(words) and " ".join(words[:k + 1]) in hay:
        k += 1
    if k == 0:
        return None
    at = hay.find(" ".join(words[:k])) + len(" ".join(words[:k]))
    return " ".join(words[max(0, k - 4):k]), " ".join(words[k:k + 4]), " ".join(hay[at:].split(" ")[1:5])


def find_in_order(pieces, hay):
    pos = 0
    for piece in pieces:
        at = hay.find(piece, pos)
        if at < 0:
            return piece, pos
        pos = at + len(piece)
    return None, pos


def check_quotes(f, text, root, whole_region=None):
    base = os.path.dirname(os.path.abspath(f))
    n = 0
    for line, body, src, off, _ in quotations(text):
        if src is None:
            fail(f, f"line {line}: a quotation with no source line — write \"> — source: <path>\" under it")
            continue
        m = SOURCE.match(src)
        path, rest = m.group(1), m.group(2)
        real = resolve(path, base, root)
        if not real:
            fail(f, f"line {line}: source {path} does not exist")
            continue
        if os.path.isdir(real):
            fail(f, f"line {line}: source {path} is a directory, not a file")
            continue
        n += 1
        pieces = [p for p in ELISION.split(norm(body)) if p]
        if whole_region and whole_region[0] <= off < whole_region[1] and len(pieces) > 1:
            fail(f, f"line {line}: a statement is quoted whole — no elision inside the statements section")
            continue
        src_text = open(real, encoding="utf-8", errors="replace").read()
        hay_all = norm(src_text)
        scope, where = hay_all, None
        sec = re.search(r"§\s*([^;,()]+)", rest)
        row = re.search(r"\brow\s+([A-Za-z0-9_.-]+)", rest)
        if sec:
            raw_anchor = sec.group(1).strip().lower()
            anchor = heading_name(raw_anchor)
            hit = [(a, b) for nm, _, a, b, raw in sections(src_text)
                   if starts(raw, raw_anchor) or (anchor and starts(nm, anchor))]
            if not hit:
                fail(f, f"line {line}: source {path} has no heading § {sec.group(1).strip()}")
                continue
            scope, where = norm(src_text[hit[0][0]:hit[0][1]]), f"§ {sec.group(1).strip()}"
        elif row:
            rid = row.group(1)
            rows = [l for l in src_text.split("\n")
                    if l.lstrip().startswith("|") and l.strip().strip("|").split("|")[0].strip(" *`") == rid]
            if not rows:
                fail(f, f"line {line}: source {path} has no table row {rid}")
                continue
            scope, where = norm(rows[0]), f"row {rid}"
        missing, pos = find_in_order(pieces, scope)
        if missing is None:
            continue
        if where and find_in_order(pieces, hay_all)[0] is None:
            fail(f, f"line {line}: in {path}, but not under {where} — the address is a claim too")
            continue
        d = diverges(missing, scope[pos:])
        if scope.find(missing) >= 0:
            what = f"\"{missing[:60]}\" is in the source, but before the text the quotation puts ahead of it"
        elif d:
            what = f"agrees up to \"…{d[0]}\", where the brief has \"{d[1]} …\" and the source \"{d[2]} …\""
        else:
            what = f"\"{missing[:60]}\" is not in the source"
        fail(f, f"line {line}: not verbatim in {path}{' ' + where if where else ''} — {what}")
    return n


def header(text):
    """(id, fields, (start, end) character span of the block), or (None, {}, (0, 0))."""
    lines = text.split("\n")
    for i, l in enumerate(lines):
        m = re.match(r"^brief:\s*(\S+)\s*$", l)
        if not m:
            continue
        fields, key, end = {}, None, len(lines)
        for j in range(i + 1, len(lines)):
            l2 = lines[j]
            if not l2.strip() or not l2[0].isspace():
                end = j
                break
            fm = re.match(r"^\s{2,}([a-z][a-z ]*?):\s*(.*)$", l2)
            if fm and fm.group(1) in FIELDS:
                key = fm.group(1)
                fields[key] = fm.group(2).strip()
            elif key:
                fields[key] += " " + l2.strip()
        span = (sum(len(x) + 1 for x in lines[:i]), sum(len(x) + 1 for x in lines[:end]))
        return m.group(1), fields, span
    return None, {}, (0, 0)


def tokens(v):
    return [t.strip("`") for t in re.split(r"[,\s]+", v) if t.strip("`")]


def fenced(path, fence_paths):
    p = path.lstrip("./")
    for fp in fence_paths:
        q = fp.lstrip("./")
        if p == q or (q.endswith("/") and p.startswith(q)) or fnmatch.fnmatch(p, q):
            return True
    return False


def check_brief(f, text, root):
    base = os.path.dirname(os.path.abspath(f))
    bid, fields, (h0, h1) = header(text)
    if bid is None:
        fail(f, "no \"brief: <id>\" block")
        return None, None
    for k in FIELDS:
        if not fields.get(k):
            fail(f, f"brief {bid}: no {k}: field")
    body_of, region = {}, {}
    for k in SECTION_FIELDS:
        v = fields.get(k, "")
        if not v:
            continue
        if k in MAY_BE_NONE and re.match(r"^none\s+—\s+\S", v):
            continue
        m = re.match(r"^§\s*(.+)$", v)
        if not m:
            fail(f, f"brief {bid}: {k}: is not \"§ <heading>\"" + (" or \"none — <reason>\"" if k in MAY_BE_NONE else ""))
            continue
        b, a, e = section_body(text, heading_name(m.group(1)))
        if b is None:
            fail(f, f"brief {bid}: {k}: names § {m.group(1).strip()}, which is not a heading here")
        elif not b.strip():
            fail(f, f"brief {bid}: {k}: § {m.group(1).strip()} is empty")
        else:
            body_of[k], region[k] = b, (a, e)
    if "statements" in body_of and not any(True for _ in quotations(body_of["statements"])):
        fail(f, f"brief {bid}: statements: the section holds no quotation — quote the statements, never paraphrase them")
    if SECOND_MIND.search(fields.get("role", "")) and fields.get("fences", "").startswith("none"):
        fail(f, f"brief {bid}: the role names a second mind and fences: is none")
    fb, fence_paths = body_of.get("fences"), []
    if fb is not None:
        fence_paths = [t for t in TICKED.findall(fb) if "*" in t or is_path(t, base, root)]
        if not fence_paths:
            fail(f, f"brief {bid}: fences: § names no path — a fence is a list of paths, never \"don't look\"")
        else:
            for name, rx in CHANNELS:
                if not rx.search(fb):
                    warn(f, f"brief {bid}: the fence does not mention {name}")
        said = [w for k in ("mission", "statements", "acceptance") for w in VERDICT_WORDS.findall(body_of.get(k, ""))]
        if said:
            warn(f, f"brief {bid}: a fenced brief says \"{said[0]}\" — a brief that says prove or confirm has given the verdict")
    for line, _, src, _, _ in quotations(text):
        if src and fence_paths and fenced(SOURCE.match(src).group(1), fence_paths):
            fail(f, f"line {line}: quotes {SOURCE.match(src).group(1)}, which the fence closes — the recipient cannot "
                    f"read back what it was sent; put the statements in a file outside every fence")
    sr = fields.get("standing rules", "")
    if sr:
        t = TICKED.search(sr)
        name = t.group(1) if t else sr.split()[0]
        p = resolve(name, base, root)
        if not p or os.path.isdir(p):
            fail(f, f"brief {bid}: standing rules: {name} does not exist")
        else:
            paras = re.split(r"\n\s*\n", open(p, encoding="utf-8", errors="replace").read())
            if not any(SPAWN.search(x) and FORBID.search(x) and REASON.search(x) for x in paras):
                fail(f, f"brief {bid}: standing rules: no paragraph names spawning agents, forbids it, and gives a reason")
    rec = tokens(fields.get("record", ""))
    if rec:
        tt = tokens(fields.get("touches", ""))
        if not any(rec[0] == t or (t.endswith("/") and rec[0].startswith(t)) or fnmatch.fnmatch(rec[0], t) for t in tt):
            fail(f, f"brief {bid}: record: {rec[0]} is not among touches:, so the recipient may not write its own record")
    new = set(t for k in NEW_PATH_FIELDS for t in tokens(fields.get(k, "")))
    cut = [(h0, h1)] + [(a, b) for _, _, _, a, b in quotations(text)]
    if "fences" in region:
        cut.append(region["fences"])
    cut.sort()
    scan, pos = [], 0
    for a, b in cut:
        if a > pos:
            scan.append(text[pos:a])
        pos = max(pos, b)
    scan.append(text[pos:])
    missing = set()
    for p in TICKED.findall("".join(scan)):
        if "*" in p or p in new or p in missing or not is_path(p, base, root):
            continue
        if not resolve(p, base, root):
            missing.add(p)
            fail(f, f"brief {bid}: names {p}, which does not exist — a brief's paths are claims too")
    return bid, region.get("statements")


def statements_region(text):
    """The statements section's span, for a quotes-only run."""
    _, fields, _ = header(text)
    m = re.match(r"^§\s*(.+)$", fields.get("statements", ""))
    if not m:
        return None
    b, a, e = section_body(text, heading_name(m.group(1)))
    return (a, e) if b is not None else None


def main(argv):
    root = "."
    if "--root" in argv:
        i = argv.index("--root")
        root = argv[i + 1]
        del argv[i:i + 2]
    if len(argv) < 2 or argv[0] not in ("quotes", "brief", "all"):
        print(__doc__.split("\n\n")[0])
        print("usage: brief_gate.py quotes|brief|all [--root DIR] BRIEF.md ...")
        return 2
    cmd, files = argv[0], argv[1:]
    nq, nb = 0, 0
    for f in files:
        if not os.path.isfile(f):
            fail(f, "no such file")
            continue
        text = open(f, encoding="utf-8", errors="replace").read()
        if cmd in ("brief", "all"):
            bid, region = check_brief(f, text, root)
            nb += bid is not None
        else:
            region = statements_region(text)
        if cmd in ("quotes", "all"):
            nq += check_quotes(f, text, root, region)
    for line in FAIL + WARN:
        print(line)
    tally = []
    if cmd in ("brief", "all"):
        tally.append(f"briefs: {nb}")
    if cmd in ("quotes", "all"):
        tally.append(f"quotations checked: {nq}")
    tally += [f"failures: {len(FAIL)}", f"warnings: {len(WARN)}"]
    print("  ".join(tally))
    print("GATE: " + ("FAIL" if FAIL else "PASS"))
    return 1 if FAIL else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
