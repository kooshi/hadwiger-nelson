
## Stage 11 — SAVED (FS131-K10c): the three merges

| merge | commit | conflicts | after it |
|---|---|---|---|
| `origin/main` (`c20b57a0`: the first pass as landed) | `dd7fc1e2` | `ARCHITECTURE.md` (main's rows for the four first-pass modules, this branch's ten kept), `scripts/Axioms.lean` (both blocks kept) | build exit 0, 469 batches, 91 modules rebuilt, **11 `sorry` leaves, all the second pass's** (`build-1-merge-main.log`); `dupnames` OK (the old pair `Plane.conj_e` is gone on `main`); the ten second-pass modules **byte-identical** to `330d2f48` (`git diff --stat` empty; `statements-1-merge-main.txt`, 0 changed); architecture PASS |
| `d4adcd40` (`fs131-w10e` ⊇ `fs131-w10d`: the two floors, proved) | `6f1fcaec` | none | `ARCHITECTURE.md`'s row for `Floor128` edited with the merge (imports `Arith/FloorPlanes`; description names the bridge — FS131-I10E's draft 3, ruling 543 (c)), architecture PASS; build exit 0, **4 leaves left** (`ProductFactor` 1, `MajorityVote` 1, `NegCircleModel` 2); `dupnames` OK; no head of the ten modules changed or removed, 53 added (`statements-2-merge-w10e.txt`) |
| `f65c2aa5` (`fs131-w10f`: the three measure-theoretic files, proved) — **the brief's Amendment 1**, read mid-job | `f145798a` | `scripts/Axioms.lean` (both blocks kept) | build exit 0, **no module with a warning: the tree holds no `sorry`** (`build-3-merge-w10f.log`); `dupnames` OK; 0 heads changed or removed (`statements-3-merge-w10f.txt`); architecture PASS |

No second-pass module failed to build against the landed statements. The statement check is `tools/fs131_k10c_statements.py`
(declaration heads at a base commit against the tree; `--self-test`: three faults fire — a hypothesis dropped, a declaration
removed, a conclusion changed — a partner passes, and a file with no declaration is an error, never a pass). **Amendment 1,
item 3**: the two `haveI` lines of `sp_if`'s spec example in `NegCircleModel` were not touched — the build does not object
(0 warnings); the lint is the landing's, and they go there if it objects.
