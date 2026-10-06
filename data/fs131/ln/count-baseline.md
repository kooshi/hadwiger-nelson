<!-- made by tools/fs131_ln_count.py from data/fs131/ln/lint-baseline.out; do not edit by hand -->
The driver's own line: 3 findings in 9643 declarations (plus 8414 automatically generated ones) with 14 linters.

| linter | findings | in FS-131's modules | in post-M2 modules | in older modules |
|---|---:|---:|---:|---:|
| `checkType` | 0 | 0 | 0 | 0 |
| `defsWithUnderscore` | 0 | 0 | 0 | 0 |
| `deprecatedNoSince` | 0 | 0 | 0 | 0 |
| `docBlame` | 0 | 0 | 0 | 0 |
| `impossibleInstance` | 0 | 0 | 0 | 0 |
| `nonClassInstance` | 0 | 0 | 0 | 0 |
| `simpComm` | 0 | 0 | 0 | 0 |
| `simpNF` | 0 | 0 | 0 | 0 |
| `structureInType` | 0 | 0 | 0 | 0 |
| `subsetDotNotationLinter` | 0 | 0 | 0 | 0 |
| `synTaut` | 0 | 0 | 0 | 0 |
| `tacticDocs` | 0 | 0 | 0 | 0 |
| `unusedArguments` | 3 | 3 | 0 | 0 |
| `unusedHavesSuffices` | 0 | 0 | 0 | 0 |
| **all** | **3** | **3** | **0** | **0** |

Modules: 52 FS-131, 8 post-M2, 1706 older; 3 have at least one finding.

| # | module | class | findings | by linter |
|---:|---|---|---:|---|
| 1 | `Proofs.HadwigerNelson.Arith.Dyadic` | fs131 | 1 | unusedArguments 1 |
| 2 | `Proofs.HadwigerNelson.Arith.FalconerField` | fs131 | 1 | unusedArguments 1 |
| 3 | `Proofs.HadwigerNelson.Arith.PlaceHom` | fs131 | 1 | unusedArguments 1 |

### `unusedArguments` — 3 findings; three quoted in full (first, middle, last by module and line)

The linter's own description: UNUSED ARGUMENTS.

```
/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Arith/Dyadic.lean:36:1: error: @HadwigerNelson.Arith.DyadicSqrt3Conclusion 1 unused argument:
  argument 5: [NumberField L]
```
```
/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Arith/FalconerField.lean:179:1: error: HadwigerNelson.Arith.falconerFan_five_placeHom 1 unused argument:
  argument 2: [NumberField ↥F]
```
```
/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Arith/PlaceHom.lean:219:1: error: HadwigerNelson.Arith.placeHom_step 1 unused argument:
  argument 2: [NumberField ↥F]
```

