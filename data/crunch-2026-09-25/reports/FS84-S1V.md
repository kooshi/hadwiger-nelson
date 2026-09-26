JOB FS84-S1V — DONE   harness≈n/a (own≈150k)
RESULT: V1 TRUE (ρ_per(ℚ(√47)) ≤ 0.2499972548 < 1/4, binding at 31, margin 2.7452·10⁻⁶ checked by two exact routes; needs row 75's certificates at 11 and 19, [Zhang2012], weak approximation, prime inversion; not [AmbrusEtAl2023]); "which prime attains the supremum" GAP (11 or 31, undecided; the supremum lies in [28/121, 0.2499972548]); V2 TRUE, and amenability is load-bearing (explicit F₂ counterexample); V3 (i) TRUE, (ii) GAP for unit-distance lattices (TRUE for abstract abelian Cayley graphs), (iii) TRUE; S1e (non-blind) TRUE once "Γ four-colourable" is added to (i)
RECORD: plans/FS84-S1V-verification.md   COMMITS: 3bb6b771 (stage 1), 2cbffe39 (stage 2), and this report's commit
INVENTORY: 5 lines follow
result — V1 blind second derivation, AmbrusEtAl-free; a sharper Lemma P (new characters |λ| ≤ 2p^⌈m/2⌉, ramified places too); 31's margin certified by an exact Sturm count on an integer polynomial — plans/FS84-S1V-verification.md §V1; tools/fs84_s1v_ratio_check.py (plants fire)
result — amenability is load-bearing in S1b-i: an F₂-graph, 6-colourable, whose 6-colourings map equivariantly onto ∂F₂ (closes the deriver's §2.4 open item) — record §V2
correction owed — plan §5.2 a4 says "The sup is attained at 31"; it should say the bound binds at 31 and the supremum is attained at 11 or 31, undecided. S1e (i) needs "Γ four-colourable" added — record §2.1 D2, §2.3
correction owed — the brief's V3 does not quote plan §M.1: it is the planner's own text, and its compactness half paraphrases plan §G's R96 line ("finitely generated" became "saturated") — record §2.0
prediction scored — P-S1a (two AmbrusEtAl-free derivations, 0.85): met — record §2.1 D1
SPAWN: none
HELD FOR THE OWNER: decision — whether to look for a four-colourable unit-distance lattice with Θ₄ = ∅. Finding one would turn V3 (ii)'s GAP into TRUE; the route is a field with χ ≤ 4 and Θ₄(R_F) = ∅, then compactness. Default if nothing is done: not pursued
