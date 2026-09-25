import re

repo = "/home/kooshi/source/lean-dir"

def load(path):
    with open(f"{repo}/{path}", encoding="utf-8") as f:
        return f.readlines()

def next_num(lines):
    nums = []
    for l in lines:
        m = re.match(r"^\|\s*(\d+)\s*\|", l)
        if m:
            nums.append(int(m.group(1)))
    return (max(nums) + 1) if nums else 1

def append_rows(path, rows, header=None):
    try:
        lines = load(path)
    except FileNotFoundError:
        lines = []
        if header:
            lines = header

    n = next_num(lines)
    new_lines = []
    for kind, text, source in rows:
        new_lines.append(f"| {n} | {kind} | {text} | {source} | open |\n")
        n += 1
    lines = lines + new_lines
    with open(f"{repo}/{path}", "w", encoding="utf-8") as f:
        f.writelines(lines)
    return len(new_lines)

# ---------- M1 (FS91) rows: from J03 (36) + J03a (8) ----------
J03_RECORD = "plans/FS91-character-local-global.md"
j03_rows = [
("result", "J03-1 peeling lemma (X=−X, X+Y⊆B_β, x∉B_β ⟹ Y⊆B_β with margin; n-fold by induction) [hand, one mind]", f"{J03_RECORD} §S CLG-b, §M.2"),
("result", "J03-2 SIX-a trace-set reduction V_c = {t : t²−4c non-square or 0} [hand, one mind]", f"{J03_RECORD} §PA.1, §S"),
("result", "J03-3 at q=23 no band 6- or 7-character, band 8 at c∈{11,20,21}, matching row 69's ceiling [hand, one mind; fenced from J08/J11]", f"{J03_RECORD} §P.basis"),
("result", "J03-4 archimedean places (real and complex) have local κ=0 [hand, one mind]", f"{J03_RECORD} §M.1"),
("slip", "J03's brief quotes the advisor non-verbatim twice (Q2 \"survives its blind verifier\" for \"holds\"; Q5 \"never as 'try orders until one works'\" not in POROS-2026-09-25-crunch-plan line 130)", f"{J03_RECORD} §Q"),
("slip", "LEDGER § B read by structure and bearing entries only (budget), not line by line", f"{J03_RECORD} §Q"),
("prior-art debt", "Johnson 2000 status report (Zbl 0974.05029) poses the question (Benda–Perles (1)); Johnson 2011 survey; Johnson 1991 \"Product colorings\"; none held", f"{J03_RECORD} §PA.3"),
("prior-art debt", "DeVos–Ebrahimi–Ghebleh 2007 (χ_c(ℝ²) ≥ 4), Kang–Maharaj 2010 (p-adic distance-graph colourings), Liu 2008 survey — not held", f"{J03_RECORD} §PA.2"),
("prior-art debt", "8 zbMATH queries unanswered (502/timeouts) incl. circular χ of abelian Cayley graphs, view obstruction", f"{J03_RECORD} §PA.2"),
("stub to mint or re-aim", "FS-91 row: opened as the character local–global theorem; band rigidity answered at k≤9 (J01), every k pending J03a", f"{J03_RECORD} \"Proposed edits\""),
("bears", "G1: wall-standing fields trivial at k≥4; content is wall-broken fields", f"{J03_RECORD} §G.1"),
("bears", "G7: type-M relation supplies 1/3 for FS-82", f"{J03_RECORD} §G.1 (S0)"),
("bears", "G21: J08's list states its generator image and runs row 69's known positive", f"{J03_RECORD} §G.1"),
("bears", "G30: derivation-only; inhabitants per theorem; discipline ladder for §PA", f"{J03_RECORD} §G.1"),
("bears", "G35: dyadic trichotomy is CLG's dyadic case", f"{J03_RECORD} §G.1"),
("bears", "G38: Fischer Ex. 4 as J08's free consistency control", f"{J03_RECORD} §G.1"),
("bears", "G41: Fischer 1994 ℤ/4 on K is J07's dyadic control (level 3)", f"{J03_RECORD} §G.1"),
("bears", "G43: targets = usable planes + U_Q; no integrality gap for characters", f"{J03_RECORD} §G.1"),
("bears", "G44: per-target question is a Weil-bounded character sum", f"{J03_RECORD} §G.1"),
("bears", "G46: named disciplines (circular colouring/κ, tori, character sums)", f"{J03_RECORD} §G.1"),
("bears", "G48: CLG is the conjecture for character colourings", f"{J03_RECORD} §G.1"),
("bears", "G49, G50: §PA in discipline words; Zhu2011 avoided; Johnson debts", f"{J03_RECORD} §G.1"),
("bears", "G51: seventh-run staffing with fixed lists and lemma-statement fallback", f"{J03_RECORD} §G.1"),
("bears", "G54: Hoffman/certificates refuse band 6-characters at q≥59 for free", f"{J03_RECORD} §G.1"),
("bears", "G55: R_F = ring integral at stable primes; torsion factors locally", f"{J03_RECORD} §G.1"),
("bears", "G56: a band 6-character at 23/43 = first exactly six-chromatic plane; P-W6", f"{J03_RECORD} §G.1"),
("bears", "G58: every band-character colouring is antipodal (controls)", f"{J03_RECORD} §G.1"),
("bears", "G59: fractional wall applies to characters; thresholds", f"{J03_RECORD} §G.1"),
("bears", "G61: FS-82 via S0, consumed as hypothesis", f"{J03_RECORD} §G.1"),
("bears", "G63: number fields first; finitely generated F is FS-39's gap", f"{J03_RECORD} §G.1"),
("bears", "G64: \"six hides only in non-character colourings\"; J08 decides characters at 167", f"{J03_RECORD} §G.1"),
("bears", "G66: level collapse as a lemma (p > k/2); all-levels L", f"{J03_RECORD} §G.1"),
("bears", "G67, G72: close-form of any new grokking; §IQ", f"{J03_RECORD} §G.1"),
("bears", "G71: scope lines, characters only", f"{J03_RECORD} §G.1"),
("bears", "G74: layer gluing; J01 decided its reading at 1/6–1/9", f"{J03_RECORD} §G.1"),
("bears", "G76: the frame; primes counted first; J12's one-prime half", f"{J03_RECORD} §G.1"),
]

J03A_RECORD = "plans/FS91-S0V2-SWm-second-reading.md"
j03a_rows = [
("result", "SW-m at every k ≥ 2, exact sweep check with three plants (J03a-1)", f"{J03A_RECORD} §2.1, tools/crunch_j03a_sweep.py"),
("result", "RS_k(S), MS_k(S) every k, |S| ≥ 2; RQ_k; Θ_k(R_F) ⊆ T_{N_k} + A(R_F) every F ⊆ ℝ (J03a-2, -3, -7, -8); second blind reading of J01-5 and J01-7, agreeing", f"{J03A_RECORD} §3.1–§3.4, §5"),
("correction owed", "FS89-derivation \"Notation\": over R_F, A must be Hom_ℚ(F(i), ℝ) mod 1; with one embedding's λ_e, FS89-CL2 and C2c are false (ℚ(√3): additive 3-colouring + Re(ē σ₂(·)), J03a-9)", f"{J03A_RECORD} §3.4, §3.7"),
("result", "k = 2 is trivial: Θ_2(R) ⊆ T_2 for every R = ℤ[U] (J03a-5)", f"{J03A_RECORD} §3.2"),
("slip", "J03a's own §3.2/§3.5 count \"0 ∉ B_k\" as a second k-reading line; J01 shows R̂_S is never minimal, so it needs no k — corrected in §5 row 5", f"{J03A_RECORD}"),
("slip", "the brief's prose says FS-89 proved five colours for every |S| ≥ 2; FS89-S1VB-14 has S ∋ 5 (harmless once C2a holds)", f"{J03A_RECORD} §1.1"),
("result", "PA-B2's case-1 step by a second route (joining + Furstenberg disjointness; hypotheses checked at sketch level, J01's Berend-chain check is the careful one) (J03a-4)", f"{J03A_RECORD} §3.2, §5 row 4"),
("prediction scored", "C0: all four verdicts as predicted, C2c's scope point confirmed by a counterexample", f"{J03A_RECORD} §5"),
]

n1 = append_rows("plans/FS91-close-inventory.md", j03_rows + j03a_rows)

# ---------- M2 rows: from J17 (4) ----------
j17_rows = [
("result", "bridge written in full by two routes; explicit counterexamples to Fischer's Remark 1; χ(ℚ(π,√(π³−π))²)=2, so his conclusion survives where his premise fails; question Q-const (χ(E²)=χ(constant field²)?) surfaced, no stub", "plans/M2-S1D-bridge.md §2, Theorems table"),
("correction owed", "FS-39 stub phase B priced \"1–2 days\" is months (split B0 ~1 day IsRealClosed instances / B1 ~1 day conditional bridge + C4 / B2 months); G63: \"pure transcendence\", the examples, Madore's credit, Q-const", "plans/M2-S1D-bridge.md §3.2, §3.4"),
("correction owed", "M2 plan §2.3: Madore ¶5.4 as the bridge was already in BIBLIOGRAPHY (FS-53, 2026-09-15), a re-finding; its lineage omits Benda–Perles, whom Fischer's introduction credits; Soifer OP 11.1 asserts the bridge without proof", "plans/M2-S1D-bridge.md §1.1 Q5–Q7"),
("prior-art debt", "[BendaPerles2000] unread (the one source that can still falsify P-J17a; zbMATH review withheld); bibliography entries proposed: GoelPatilVerma2022, Lang1953, BCR1998, Marker2002, Poizat2000, WangKosheleva1998, CohenMahboubi2012, and updates to Madore/Soifer/BendaPerles/Zapletal rows", "plans/M2-S1D-bridge.md §3.4"),
]
n2 = append_rows("plans/M2-close-inventory.md", j17_rows)

# ---------- M3 rows: from J06 (5, header said 6) ----------
J06_RECORD = "plans/M3-exotic-colourings.md"
j06_rows = [
("slip", "the J06 brief cites \"FS79 T30\" for the rank-1 walls; they are FS73-T30 (FS79-T30 is a face-flux no-go); the brief's \"Ellenberg2018's question at k = 4 on ℤ\" is inheritance, not Ellenberg's existence question (answered yes in rank 1)", f"{J06_RECORD} §Q row 2, §PA.2 row 1"),
("result", "[hand, planner, one mind] R2 ⟺ \"a countable four-colouring shift of a distance graph is finite\"; A-T1 ⟸ A-K3 (the reversal lemma) + T34's orbit step; FS-64 at five over any S ∋ ∞ contains χ_µ(ℝ²) ≤ 5; at ℚ(√167) the place above 3 is split; Hoffman at 43 is 0.21376 > 1/5, so D1-43 needs more than Hoffman", f"{J06_RECORD} \"The milestone in the theory's terms\", §M"),
("prior-art debt", "[KechrisMarks2020] now held (§4.6–4.7 read); Polymath16 fourth thread's MCNP ≥ 6 criterion; [EggletonErdosSkilton1990]'s aperiodic χ(D)-colourings unread (if one is zero-entropy it refutes R2; J18 stage 1 tries it)", f"{J06_RECORD} §PA.3"),
("prediction registered", "P-A1 proof 0.25, P-A2 counterexample 0.10, P-A3 named stall 0.55; P-D-a a five-colour window (falsifies ≥ 6) 0.02, P-D-d count with named gaps, no pullback 0.55", f"{J06_RECORD} §P"),
("stub to mint or re-aim", "FS-64: at five colours over S ∋ ∞ it contains MCNP ≥ 6 (and Kechris–Marks 4.23); FS-76: R2 in SFT words, EES 1990 as its first prior-art read", f"{J06_RECORD} §PA"),
]
header = [
"# M3 close inventory (opened by the crunch clerk from job reports; the owner's pen, WORKFLOW 5)\n",
"\n",
"## Items\n",
"\n",
"| # | kind | item | source | status |\n",
"|---|---|---|---|---|\n",
]
n3 = append_rows("plans/M3-close-inventory.md", j06_rows, header=header)

print("M1 rows added:", n1)
print("M2 rows added:", n2)
print("M3 rows added:", n3)
