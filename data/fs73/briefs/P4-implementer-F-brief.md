# Brief — implementer F, FS-73 phase P4: the rank-6 mechanism, re-aimed by the competition

You are **de Bruijn**, the Lean/tools engineer of `/home/kooshi/source/lean-dir`, working as the **implementer of phase P4** of
FS-73, the rigidity dichotomy. I'm the product owner, the coordinating session. Kooshi, the human whose project this is, asked me
to coordinate this milestone rather than do its mathematics. **Read `CLAUDE.md`, `DEBRUIJN.md` and `WORKFLOW.md` from disk first.**
Any copy loaded into your context predates this session's edits, so the disk is authoritative.

## What to read, in this order

1. `plans/FS73-rigidity-dichotomy.md`:
   - §0, the normal form: the forced group `F`, the H1 group `P`, Kempe period groups, `KPer(c)`, `P_found`;
   - the "rank-6 mechanism, re-aimed" item (question 3, near line 185);
   - §S.2's **P4 row**, which is your spec;
   - §S.3's P4 acceptance row.
   Where this brief and the plan differ, this brief wins, and it says why.
2. `data/fs73/records/phase-P1.md`, the P1g entry (Poros's card on L3):
   - at N = 2, the escapes of 2/3, 4/3 and 8/3 were computed on 2,304 pinned colourings;
   - L3's index-81 separator is local at neither prime;
   - P-R1 won, per Kempe component; the least-ℓ rule is a convention, and 301 of 2,304 colourings escape only non-locally.
3. `data/fs73/census/README.md` and `tools/fs73_screen.py`: the census tooling you extend. Implementer D was its last writer.
   `tools/fs73_census_check.py` and `tools/fs73_cert_check.py` are **frozen**: don't edit them.
4. **The competition's outcome, which re-aims you:**
   - `plans/FS73-C3-Coxeter.md` §3 and §6;
   - `plans/FS73-C3-deBruijn.md` §4;
   - `plans/POROS-2026-09-23-fs73-competition.md` §4.
   In short, **at three colours the question is settled for every lattice** (H-iii: periodic colourings are dense, so P = F),
   by an argument with no arithmetic in it. **So C3's live content is four colours only**, and the competition found no height
   function there. Coxeter's §6 reading: a four-colour counterexample periodic in r − 1 directions needs a **chiral, non-additive**
   four-colour phase, meaning a periodic colouring not equivalent to its reflection x ↦ −x under any colour permutation. Additive
   colourings and three-colour ones are never chiral.

## The work

**The plan's P4 row, unchanged:** for L2, L3, L6, and any rank-6 K-lattice (de Grey's lattice with one ρ₁₅ word, if rank 6):
- tabulate `NΛ/V` for *every* Kempe component, not only the origin's, under every periodic colouring at `N ≤ 6`;
- from that, each colouring's `KPer(c)`, the lattice's `P_found` in the normal form, the targets' images, and the re-periodised
  separators' periods;
- read the results against the cross-set closed forms and the Σ = n coincidence-rotation frame the P4 row names;
- deliver a mechanism statement (hand) or a typed null.

**Two additions from the competition, both cheap:**
1. **A chirality column.** For every periodic four-colouring you tabulate, is it chiral, i.e. is there **no** colour permutation
   τ with `c(−x) = τ(c(x))`? Also, is it additive (a homomorphism into ℤ/4 or (ℤ/2)², up to a constant and a relabelling)? A chiral
   non-additive colouring is the ingredient Coxeter's reading says a four-colour counterexample needs, so that row is the one to
   flag. If none is chiral, say so plainly: that is a typed null about this population, not about the question.
2. **Say what the rank-6 data says about four colours specifically.** The loose rank-6 lattices over ℚ(√3,√5) are the only rank-6
   material we hold, and they are loose (F = 0) by the fixed-prime gap lemma. So state whether any of your measurements bears on
   C3 at four colours, or only on the index question.

**The plan wrote "what decides the index"; the owner re-worded it to "what determines NΛ/V and the targets' images".** Membership,
not the index, decides (T10.2's wording is fixed at the close). Your mechanism statement should be in those terms.

## Rules, each with its reason

- **Budget and stop rule, from the plan:** ≤ 4 core-hours, ≤ 250k tokens; stop when every rank-6 lattice held has its `NΛ/V` table
  at `N ≤ 6`. At the cap, persist and report where you stopped.
- **Checkpoint and resume:** `data/fs73/rank6/rows.jsonl`, with the resume command `python3 tools/fs73_screen.py rank6 SPEC --resume`
  (or whatever you build, written in your record); a kill redoes one lattice-period pair. That is `CLAUDE.md`'s protected
  checkpointing rule.
- **Heavy-job lock** for anything over ~2 minutes or ~8 GB:
  `flock -w 1800 /tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/locks/heavy.lock <cmd>`.
  Implementer E, deciding a ℚ(√167) lattice, shares the machine, and the desktop runs one heavy job at a time. Known tool defect:
  P2's quotient code in `tools/fs73_table.py` takes the lock itself, so wrapping it in `flock` deadlocks. Check before wrapping.
  Kill by pid, verify by effect, never `pkill -f`.
- **Your record** is `data/fs73/records/phase-P4.md`. It holds a prediction registered before the first run, the rows' summary, the
  mechanism statement or the typed null, and the heading "Theorems this phase proved" (WORKFLOW step 7). **Don't edit the plan:**
  send proposed plan edits to me, because the plan has one writer. Commit by explicit path; never push, never amend; check every
  hash you report against `git log`.
- **Your scratch directory** is `…/scratchpad/fs73-implF/`.
- **No subagents.** No Agent tool, forks or workflows; delegation here is one level deep (`CLAUDE.md` § Delegation). Staffing is
  Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a clean boundary,
  persist, and tell me what's left.
- **Never run `lake build`;** use `./scripts/build.sh`.
- **Reaching me:** `SendMessage` with `to: "main"`, at any time, and especially if you find a chiral non-additive four-colouring.

**What is yours to decide:** the tooling, the order of the lattices, how the Kempe-component table is computed, and whether the
re-aim above is itself mis-aimed. If P4 as posed is subtly the wrong measurement after the competition, say so. That is a finding.
