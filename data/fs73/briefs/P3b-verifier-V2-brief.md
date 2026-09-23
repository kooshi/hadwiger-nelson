# Brief — independent verifier V2, FS-73: is one ℚ(√167) lattice graph 3-colourable?

You are **de Bruijn**, the engineer of `/home/kooshi/source/lean-dir`, working as an **independent verifier**. I'm the product owner,
the coordinating session. Kooshi, the human whose project this is, asked me to coordinate this milestone rather than do its
mathematics. **Read `CLAUDE.md` (especially § The standard of evidence above rung B and § The gate), `DEBRUIJN.md` and `WORKFLOW.md`
from disk first.** The disk is authoritative; any loaded copy predates this session's edits.

## The claim you are verifying, and why it matters

Another implementer reports, pending verification, that the unit-distance graph of one lattice over ℚ(√167) is **not
3-colourable**. The lattice's graph is a subgraph of the plane over ℚ(√167), so if that holds, it proves **χ(ℚ(√167)²) ≥ 4**.
- That is the target of FS-59, the project's top-ranked open stub.
- Only 3 is proven there, and Kooshi's local–global conjecture predicts at least 6.
- A claim of that size is disbelieved by default, correctly, and your job is to try to break it.

**The lattice.** It is `L21cc6506`, from FS-61, and its key is `420|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2` over d = 167.
- A point `(a, b, c, e) ∈ ℤ⁴` stands for `x = ((a + b√167)/420, (c + e√167)/420) ∈ ℚ(√167)²`.
- The lattice is the ℤ-span of the four key rows, in (a, b, c, e) coordinates.
- Its unit vectors satisfy `a² + 167b² + c² + 167e² = 420²` and `ab + ce = 0`.
- The census (`data/fs73/q167/census.jsonl`) lists 60 of them.

**The criterion** (FS-73's competition). It was proved independently by two agents and read by the owner and an advisor, but
re-derive the direction you rely on yourself.
- **Statement.** Let Λ be a finitely generated torsion-free abelian group, and S = −S ⊂ Λ finite and generating. Then `Cay(Λ, S)`
  is 3-colourable ⟺ there is θ ∈ Hom(Λ, ℝ) with θ(s) mod 1 ∈ [1/3, 2/3] for every s ∈ S.
- **The direction the claim rests on** is ⟹: a 3-colouring gives such a θ. Its proof lifts the colouring to an integer height on
  the grid ℤⁿ covering the Cayley graph (every grid square's four ±1 steps sum to 0), takes the winding on the relation lattice,
  and extracts θ from the colouring's mean slope, using a parity argument.
- **The claim is that no such θ exists here:** Θ is empty.

## Independence: what you may and may not read before your verdict is written

**Do not read these until your verdict is in your record:**
- `tools/fs73_theta_*`;
- `data/fs73/coxeter-c3/`;
- `data/fs73/c3-debruijn/`;
- `data/fs73/records/phase-P3b-q167-theta.md`;
- any file under `data/fs73/q167/` with "theta" or "cert" in its name;
- the other implementer's scratch directory.

The reason is the one `CLAUDE.md` gives. The artifact must be re-derivable by someone who trusts none of our code, and a verifier
who reads the method first re-checks the method rather than the claim. You may read `plans/FS73-C3-Coxeter.md` §3 and
`plans/FS73-C3-deBruijn.md` §2 C1 for the proof, but only **after** you've written your own proof of the ⟹ direction in your
record. After your verdict, read whatever you like, and compare.

## The work

1. **Re-derive the ⟹ direction** in your record, in your own words, and note anything the statement needs that the lattice might
   fail: torsion-freeness, generation, finiteness.
2. **Enumerate U yourself** from the key and the two equations. Confirm the count, that U = −U, and that U spans a rank-4 lattice.
   You decide whether the graph is Cay(span U, U) or Cay(key lattice, U); either is a subgraph of the plane's graph.
3. **Controls through your own code, both directions, before the claim:**
   - FS-61's `Ld65c8ee8` over d = 11 (key `30|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2`, 108 unit vectors; FS-61's solver refused it) must
     come out empty.
   - `Ld14c588b` over d = 167 (key `348|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2`, 44 unit vectors) must come out nonempty. It is known
     3-colourable, with a periodic colouring of index 1,080.
4. **Decide Θ for L21cc6506 exactly, by a method of your own.** Floats may propose; only exact rationals decide. The other
   implementer found a float MIP ill-conditioned enough to refuse the known-colourable control, so treat floats as untrusted.
   - An emptiness verdict needs a certificate checked by a short Fraction-only checker you write, with its own planted faults.
   - If you find a point θ, the claim is refuted. Check it exactly and tell me at once.
5. **The one extra question,** if budget remains: is there a short argument, hand-checkable, for why Θ is empty here? For
   instance, a structure in U that reduces the question to a few cases. Report what you see; don't force it.

## Rules

- **Checkpoint and resume anything over ~15 minutes** (`CLAUDE.md`'s protected checkpointing rule). Budget: at most about 4 CPU-hours
  and 8 GB. At the cap, report "undecided at the cap" with the price. That is a complete report.
- **Heavy-job lock** for anything over ~2 minutes or ~8 GB:
  `flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock <cmd>`.
  Another implementer is running a long job under it right now, so expect to wait. Kill by pid, verify by effect, never `pkill -f`.
- **Your code goes in `tools/fs73v2_*.py`, and your record is `data/fs73/records/verify-P3b-q167.md`.** The record holds your
  derivation, the controls, your verdict, and the heading "Theorems this phase proved". Commit by explicit path; never push, never
  amend; check every hash you report against `git log`.
- **Your scratch directory** is `…/scratchpad/fs73-verifier2/`. Don't list or read the directories beside it.
- **No subagents.** No Agent tool, forks or workflows; delegation here is one level deep (`CLAUDE.md` § Delegation). Staffing is
  Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a clean boundary,
  persist, and tell me what's left.
- **Never run `lake build`;** use `./scripts/build.sh`. You shouldn't need Lean here.
- **Reaching me:** `SendMessage` with `to: "main"`, at any time, and at once if the claim breaks.
- **Budget:** about 250k tokens.

A verifier who finds nothing wrong has done the job exactly as well as one who finds the error. What matters is that you looked
in the places an error would hide.
