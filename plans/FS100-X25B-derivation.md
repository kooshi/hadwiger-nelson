# X25B — a blind second derivation of R88-TCA's class form (TCA-cls) and FS100-T1

*Job X25B of the ×2×3 crunch (2026-09-26), Coxeter (Opus 5.5), brief `data/crunch-2026-09-26-x2x3/briefs/X25B-tca-class-blind-derivation.md`
with `STANDING-RULES.md`. Working files `data/fs100/x25b/`. Stop 12:50 UTC.*

## Theorems this phase proved

*(filled at stage 3)*

## Stage 1 — SAVED

**Quotation check** (11:44 UTC), each by `grep -cF` of the brief's quotation against its source, count 1 each:
- TCA-cls: the brief's text is a verbatim substring of `plans/R88-derivation.md` line 161 (R88-TCA's bold statement). OK.
- T1: the brief's text is a verbatim substring of `LEDGER.md` row 117 (line 155). OK. The same claim as `plans/FS100-derivation.md` line 116
  (FS100-T1's bold statement, open by the brief), worded "(T-C(A)'s class, R88-TCA's class form)" in the middle; no difference of content.

**Fence log.**
1. **Touch (06:40):** reading R88-TCA's statement, I printed `plans/R88-derivation.md` lines 150–175 with `sed`, which showed the bodies under
   R88-TC-tab, R88-TCA and the first line of R88-J28V-6's body — fenced. What I saw of R88-TCA's body: "every factor of `G_S` has ratio
   `< 1/4` (11 and 19 by FS-66, the tail by Hoffman …, the ramified 47 by Lemma P, the real places `m₁`, split places 0), so four classes
   cannot cover: `1 ≤ 4 max(α(Y′), r_X) < 1` (J28D) or `1 ≤ 4(r + η(n))` (J28V)". This is a route sketch, not a proof; it is also, at the
   same level of detail, the open text of `LEDGER.md` rows 112–113. **So my route to "four classes cannot cover" is not blind to the prior
   derivations' outline**; what stays blind is every step of how the count is justified (the product step, the passage from finite levels
   to the measure, the archimedean factor). The owner should weigh this.
2. Afterwards only bold statement lines of `plans/R88-derivation.md` (by `grep '^\*\*R88'`) and its header notation block (lines 1–30,
   above any statement) were read. `plans/FS100-derivation.md`: bold statements of T1 and K0 only.

**C0 probabilities, sealed before any derivation (06:44):**
- TCA-cls at `S = ∅`, as a mathematical statement: **0.80 TRUE**; that I reach TRUE in this window with every step derived: 0.45 (the
  product step over a continuous archimedean factor is where I expect a GAP).
- TCA-cls for finite `S`: **0.75 TRUE**.
- T1: **0.85 TRUE** (risk: a stable place I forget — ramified places above `p | d`, the dyadic cases — or a ratio at 23 or 31 that is
  level-one only).

## Would-have-searched-here log

*(one line per move)*
