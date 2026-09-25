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

def append_rows(path, rows):
    lines = load(path)
    n = next_num(lines)
    new_lines = []
    for kind, text, source in rows:
        new_lines.append(f"| {n} | {kind} | {text} | {source} | open |\n")
        n += 1
    lines = lines + new_lines
    with open(f"{repo}/{path}", "w", encoding="utf-8") as f:
        f.writelines(lines)
    return len(new_lines)

m1_owner_rows = [
("owner ruling", "J01-7 now has two blind readings (J01, J03a) and is consumed as verified at every k, with A(R_F) = Hom_ℚ(F(i), ℝ) mod 1; J01's parity route R2 stays a named hypothesis (one reader)", "owner, 2026-09-25"),
("owner ruling", "J02's S1–S3 consumed as verified (two independent derivations, J02 and J09); J09's J2 and J4 are one mind, a second reading owed before any ledger row rests on them alone", "owner, 2026-09-25"),
("correction owed", "FS89-derivation \"Notation\": over R_F, A must be Hom_ℚ(F(i), ℝ) mod 1; FS89-CL2 is false as written (ℚ(√3), k = 4, J03a-9); whether FS89-CL3, CL4, CL5 survive under the corrected A is a named deliverable of J07", "J03a report; owner"),
("held", "row 95 and Frontier item 25 are not widened to every k until the \"archimedean\" wording over R_F is fixed", "J03a report"),
("agent token counts", "J03 harness 500k (own 320k); J03a harness 324k (own 135k); J09 harness 417k (own 255k)", "task notifications"),
]
n1 = append_rows("plans/FS91-close-inventory.md", m1_owner_rows)

m2_owner_rows = [
("owner ruling", "J17V declined (J17's recommendation); J17K queued after J16 (B0 + B1 + Lemma NP via Polynomial.abc), J17K's brief being written", "owner, 2026-09-25"),
("agent token count", "J17 harness 366k (own 150k)", "task notification"),
]
n2 = append_rows("plans/M2-close-inventory.md", m2_owner_rows)

m3_owner_rows = [
("owner ruling", "J20/J22 keep their verified-input lists (FS86-dB-H, Zhang Thm 1.8), as FS-89's verifiers had", "owner, 2026-09-25"),
("agent token count", "J06 harness 484k", "task notification"),
]
n3 = append_rows("plans/M3-close-inventory.md", m3_owner_rows)

print("M1 owner rows added:", n1)
print("M2 owner rows added:", n2)
print("M3 owner rows added:", n3)
