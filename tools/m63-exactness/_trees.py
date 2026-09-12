#!/usr/bin/env python3
"""Load `tools/` modules as they stood at a given commit, beside the ones on disk now.

WHY THIS EXISTS. The two scripts in this directory compare the code before and after the
exactness migration of 2026-09-12 (commit d0a68ea and its parent 8b59db6). They are the checker
for a claim -- "every number is unchanged" -- that the rest of that work rests on, and a checker
that only ran in someone's /tmp is not a checker. So the baseline is reconstructed from git on
every run rather than assumed to be lying around.

    BASELINE = 071ec4a, the last commit before the migration.

HAZARD THIS AVOIDS. `typem_exact.py` does `import typem`, so a reconstructed baseline
`typem_exact` would happily bind to TODAY's `typem` if that one reached `sys.modules` first and
the comparison would quietly be of one tree against itself. `baseline_pair` therefore puts the
baseline modules in one directory, places it first on `sys.path`, and imports them plainly, so
the pair is internally consistent; today's copy is loaded under a DIFFERENT module name and can
never claim `typem`. Load order is not decoration here -- it is the whole correctness argument.
"""
from __future__ import annotations
import importlib.util, subprocess, sys, tempfile
from pathlib import Path

BASELINE = "071ec4a"


def repo_root() -> Path:
    out = subprocess.run(["git", "rev-parse", "--show-toplevel"],
                         capture_output=True, text=True, check=True)
    return Path(out.stdout.strip())


def materialise(rev: str, names, into: Path | None = None) -> Path:
    """Write `tools/<name>` as of `rev` into a directory, and return it."""
    root = repo_root()
    into = into or Path(tempfile.mkdtemp(prefix=f"m63-{rev}-"))
    into.mkdir(parents=True, exist_ok=True)
    for n in names:
        blob = subprocess.run(["git", "show", f"{rev}:tools/{n}"],
                              cwd=root, capture_output=True, check=True)
        (into / n).write_bytes(blob.stdout)
    return into


def baseline_pair(rev: str = BASELINE):
    """(typem, typem_exact) as of `rev`, imported as a consistent pair under their real names."""
    d = materialise(rev, ["typem.py", "typem_exact.py"])
    sys.path.insert(0, str(d))
    import typem as base_typem                        # binds to `d` because it is first on the path
    import typem_exact as base_exact
    assert Path(base_typem.__file__).parent == d, (
        f"baseline typem came from {base_typem.__file__}, not the reconstructed tree -- the "
        f"comparison would be of one tree against itself")
    return base_typem, base_exact


def load_as(name: str, path: Path):
    """Import a single module file under an explicit name, so it cannot shadow the baseline."""
    spec = importlib.util.spec_from_file_location(name, path)
    m = importlib.util.module_from_spec(spec)
    sys.modules[name] = m
    spec.loader.exec_module(m)
    return m


def today(name: str = "typem_today", rev: str | None = None):
    """Today's `typem`: the live working tree by default, or a commit if `rev` is given."""
    src = (materialise(rev, ["typem.py"]) / "typem.py") if rev else (repo_root() / "tools" / "typem.py")
    return load_as(name, src), src
