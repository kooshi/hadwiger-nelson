#!/usr/bin/env python3
"""Hold each lane's verbatim identity to its skill.

Every mind in the pipeline loads one file whose body is its identity -- a core skill copied verbatim from
`.claude/skills/<name>/SKILL.md` -- followed by that lane's lean-dir workflow, which starts at a heading of the form
`# <who> in lean-dir — the workflow`. Agent files and output styles cannot import other files with `@` (probed
2026-09-28: an `@` line in either reaches the model as text, unexpanded), so the identity is a copy, and this script is
what keeps the copy honest.

    python3 scripts/identities.py check        # every identity block byte-identical to its skill; non-zero exit on drift
    python3 scripts/identities.py sync         # re-copy each skill's body over the identity block; the workflow is kept
    python3 scripts/identities.py --self-test  # plant a one-character drift and a missing heading; both must fail

Run `sync` then `check` after the skills are re-imported from agent-forge; run `check` at every close.
"""
import re
import shutil
import sys
import tempfile
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
TARGETS = [  # (the file a mind loads, the skill whose body is its identity)
    (".claude/output-styles/keryx.md", "keryx"),
    (".claude/agents/poros.md", "poros"),
    (".claude/agents/ephodos.md", "ephodos"),
    (".claude/agents/ephodos-verifier.md", "ephodos"),
    (".claude/agents/debruijn.md", "debruijn"),
    (".claude/agents/debruijn-implementer.md", "debruijn"),
]
MARKER = re.compile(r"^# .+ in lean-dir — the workflow$", re.M)


def split_front(text: str, where: str) -> tuple[str, str]:
    """(the frontmatter with both `---` lines, the body)."""
    if not text.startswith("---\n"):
        raise ValueError(f"{where}: no frontmatter")
    end = text.index("\n---\n", 4) + len("\n---\n")
    return text[:end], text[end:]


def skill_body(root: Path, name: str) -> str:
    path = root / ".claude/skills" / name / "SKILL.md"
    return split_front(path.read_text(encoding="utf-8"), str(path))[1].strip("\n")


def parse(root: Path, rel: str) -> tuple[str, str, str]:
    """(frontmatter, identity block, workflow from its heading on)."""
    front, body = split_front((root / rel).read_text(encoding="utf-8"), rel)
    m = MARKER.search(body)
    if not m:
        raise ValueError(f"{rel}: no '# … in lean-dir — the workflow' heading after the identity")
    return front, body[: m.start()].strip("\n"), body[m.start():]


def check(root: Path) -> int:
    failures = 0
    for rel, name in TARGETS:
        try:
            _, identity, workflow = parse(root, rel)
            want = skill_body(root, name)
        except (OSError, ValueError) as e:
            print(f"FAIL  {e}")
            failures += 1
            continue
        if identity != want:
            a, b = identity.split("\n"), want.split("\n")
            i = next((k for k in range(min(len(a), len(b))) if a[k] != b[k]), min(len(a), len(b)))
            print(f"FAIL  {rel}: the identity differs from .claude/skills/{name}/SKILL.md at its line {i + 1}: "
                  f"{(a[i] if i < len(a) else '<end>')[:80]!r} against {(b[i] if i < len(b) else '<end>')[:80]!r}")
            failures += 1
        else:
            print(f"ok    {rel}: identity = {name} ({len(want.encode()):,} bytes), workflow {len(workflow.encode()):,} bytes")
    print("IDENTITIES: " + ("FAIL" if failures else "PASS"))
    return 1 if failures else 0


def sync(root: Path) -> int:
    for rel, name in TARGETS:
        front, _, workflow = parse(root, rel)
        (root / rel).write_text(front + skill_body(root, name) + "\n\n" + workflow, encoding="utf-8")
        print(f"synced {rel} <- .claude/skills/{name}/SKILL.md")
    return check(root)


def self_test() -> int:
    """Plant faults in a copy of the tree; each must fail, and the faithful copy must pass."""
    with tempfile.TemporaryDirectory() as tmp:
        root = Path(tmp)
        for rel, name in TARGETS:
            for src in (REPO / rel, REPO / ".claude/skills" / name / "SKILL.md"):
                dst = root / src.relative_to(REPO)
                dst.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy(src, dst)
        results = [("faithful copy passes", check(root) == 0)]
        rel0, _ = TARGETS[2]
        text = (root / rel0).read_text(encoding="utf-8")
        cut = text.index("carried versus conveyed") if "carried versus conveyed" in text else len(text) // 3
        (root / rel0).write_text(text[:cut] + "X" + text[cut + 1:], encoding="utf-8")
        results.append(("a one-character drift in the identity fails", check(root) == 1))
        (root / rel0).write_text(text, encoding="utf-8")
        rel1, _ = TARGETS[0]
        t1 = (root / rel1).read_text(encoding="utf-8")
        (root / rel1).write_text(MARKER.sub("## the workflow", t1), encoding="utf-8")
        results.append(("a missing workflow heading fails", check(root) == 1))
    for what, ok in results:
        print(f"{'PASS' if ok else 'FAIL'}  self-test: {what}")
    ok = all(ok for _, ok in results)
    print("SELF-TEST " + ("PASSED" if ok else "FAILED"))
    return 0 if ok else 1


if __name__ == "__main__":
    arg = sys.argv[1] if len(sys.argv) > 1 else "check"
    if arg == "check":
        sys.exit(check(REPO))
    if arg == "sync":
        sys.exit(sync(REPO))
    if arg == "--self-test":
        sys.exit(self_test())
    print(__doc__)
    sys.exit(2)
