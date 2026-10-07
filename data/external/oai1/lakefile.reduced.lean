import Lake

open System Lake DSL

-- EXT-OAI1 working copy: the release's lakefile.lean (kept beside this file as lakefile.lean.release)
-- reduced to what the cone of OAI.Geometry.PlaneColoring.Five imports from outside: Mathlib alone,
-- at the release's revision.  Same package name, same toolchain file, same leanOptions.  The 29 other
-- direct requirements, their patches and the run_cmd / post_update hooks are dropped: no module of the
-- cone imports them (data/external/oai1/cone-five.txt in lean-dir).

package OAI where
  version := v!"0.1.0"
  fixedToolchain := true
  leanOptions := #[⟨`autoImplicit, false⟩]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "d13f23b723b8a846827a245b89c10fc7d3f11612"

@[default_target] lean_lib OAI

lean_lib ComparatorChallenges where globs := #[`ComparatorChallenges.+]

lean_lib Audit where globs := #[`Audit.+]
