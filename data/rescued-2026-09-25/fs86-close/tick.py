import re
p='plans/FS86-close-inventory.md'
s=open(p,encoding='utf-8').read()
A,B,C,D,E,F='e2fe40df','de8bb61c','f2fd1cff','aa977ec6','e086c98f','(this commit)'
held=f"done: restored at hand-back; its theorems filed in `plans/FS86-derivation.md` at {A}"
st={1:"settled",2:f"done: § Toolchain's ban line kept current to 2026-10-01 ({B}); route 4 carried to FS-90 (d) ({D})",3:f"done: the verdict ruled with it ({C}, §R-close.5)",
4:f"done at {C} (§R-close.4: no yes, no no; P-nogo not met by its letter)",
5:f"done in part: T721's passage read in the held Soifer 2024 text at the close ({D}, FS86-CL3); `[Soi46]`, `[deGrey2026]`, `[Haugstrup2026]` still not held — carried, Kooshi's call",
6:"carried, open: nothing about row 82 is claimed new until the Johnson papers are read",7:f"settled; used as the fact-audit base ({B})",8:"settled",
9:f"done: the owner error logged in §R-close.6 ({C})",10:f"done: FS-67 re-aimed ({D}); G49's instance ({B}); row 88",
11:f"done: two derivations (Poros (plan), B1 blind); row 88, FS86-V2, V3, LP ({A})",
12:f"done in part: FS86-LP filed, the ramified-base bound in row 88 ({A}); G54's inert-tower sentence **declined** for CLAUDE.md's byte budget — the fact's home is row 88",
13:f"done: row 89, FS86-VK, two derivations, B1's prior-art check ({A})",14:f"done: FS86-A1–A4 filed ({A})",15:f"settled (logged); §R-close.6 ({C})",
16:f"done at {A}: the stub's correction line; H5's record annotated",
17:f"done: prior-art position and G49 ({B}); row 88; FS38-D2-A's and FS85-R3a's prior-art lines {F}. G54's grade line **declined** (bytes; the attribution is in the prior-art position)",
18:"carried: not held; obtaining it is Kooshi's call (`[Soifer2019]`)",19:f"done at {D} (FS-67, FS-83, FS-76, the FS-86 stub's banner and outcomes)",20:"settled",
21:f"done: the advisor's record moved in at a1dbbc2d; E1 in §R-close.6 ({C})",22:f"done: FS86-V4 ({A})",23:"moot: the killing test passed; no fallback was staffed",
24:"done: records in `plans/`",25:f"done: row 93, FS86-B2-T0–T3, B3-T1 ({A})",
26:f"done: FS38-L1, D3 and D2-B annotated, row 67 corrected ({A}); G54 rewritten with a demotion record ({B})",27:"settled (logged)",
28:f"done: row 88, FS86-V2, V3 ({A})",29:f"done: G54's margin labelled with its normalisation ({B})",30:f"done: FS86-B3-T1 ({A}); scored in §R-close.4 ({C})",
31:"settled",32:f"done: rows 88–89 ({A})",33:f"done: the plan's §0 annotated with D2, D3, D4, D6, D8 ({A}); the stub's 19 note; G54's 31 margin ({B}); `[Speyer2018]` exists (item 53)",
34:f"done: B1's entries filed ({A}); G21 instances ({B}); Speyer's conflict carried to FS-88's stub {F}",35:"done (staffing)",39:f"done: the protocol's work-in-stages rule ({E}); §R-close.6 ({C})",
44:f"done: restored; the owner error in §R-close.6 ({C}) and the protocol ({E})",46:f"done: Theorem A's grade, D₀'s `h ≠ 0`, the K sentence and W's `μ₁` filed ({A}); the slip in G21 ({B})",
47:f"done: row 90, FS86-dB-A ({A}); P-K-fires scored ({C})",48:f"done (logged; the protocol's sixth run, {E})",50:f"done (logged; {E})",
52:f"done: row 85's and G75's attribution ({A}, {B})",53:f"done: bibliography rows (item 53's commit); Kari–Szabados's citation settled ({E})",54:f"done (logged; {E})",59:f"done (logged; {E})",
63:f"done: HD1-cert filed ({A}); its certificate is FS-90 (a) ({D}); Theorem C's downgrade propagated (rows 94, {A})",65:"settled (R9)",
66:f"done: `[Kuhlmann2016]` (item 66's commit); VD-7 and H* filed ({A})",67:f"done: G21's instance, \"quote statements verbatim\" ({B}); the protocol ({E})",
68:f"done: the verdict ruled explicitly ({C}, §R-close.5); the advisor's first checks (a)–(h) worked in this close",69:"settled",70:"settled"}
for n in [36,37,38,40,41,42,43,45,49,51,55,56,57,58,60,61,62,64]: st.setdefault(n,held)
lines=s.split('\n'); cnt=0
for i,l in enumerate(lines):
    m=re.match(r'^\| (\d+) \|',l)
    if m and int(m.group(1)) in st:
        n=int(m.group(1)); cells=l.rstrip().rstrip('|').rstrip().split(' | ')
        cells[-1]=cells[-1]+'; **close:** '+st[n] if cells[-1] not in ('settled',) else 'settled; **close:** '+st[n]
        lines[i]=' | '.join(cells)+' |'; cnt+=1
s='\n'.join(lines)
extra=("| 71 | owner-brief slip (the close brief) | **The close planner's brief attributed the unreachable `ζ ↦ ζ⁵` plant to verifier W; it was B1's** (item 28). Corrected in G21's instance and §R-close.6. | the close planner | settled (logged) |\n"
"| 72 | result (the close planner, one mind) | **FS86-CL3: given Heule's T721 (read in the held Soifer 2024 ch. 54 text: 721 vertices in ℚ(√2,√3)², a distance-2 pair monochromatic in every four-colouring) and C13, ℚ(√2,√3)'s plane is four-colour rigid** — S2's member with triangles is rigid; no competition record connected T721 to C13. Row 93, FS-90 (b) becomes T721's audit. | the close | done at aa977ec6 |\n"
"| 73 | correction (the close planner, from D's retraction note) | **FS86-CL2: B1's Lemma R fails at a stable dyadic place ramified in `F(i)/F`** (ℚ(√5), ℚ(√17)); every FS-86 use unaffected. | the close | done at e2fe40df (scope corrected in B1's record, row 88, FS-47's stub) |\n"
"| 74 | result (the close planner, one mind) | **FS86-CL1: over ℚ(√47) and ℚ(√167) no measurable window four-colouring over finitely many places (odd split places) exists** — the brief's type-(A) question, answered at exact scope; nothing at five colours (the real place's `m₁ ≥ 0.229 > 1/5`). | the brief | done at e2fe40df (row 92; FS-59, FS-83, FS-84, FS-64 re-aimed at aa977ec6) |\n")
s=s.replace("\n## Held items, restored at hand-back",'\n'+extra+"\n## Held items, restored at hand-back",1)
s=s.replace("*Opened 2026-09-25, when FS-86 was chosen","*Ticked at the close (2026-09-25) by the close planner, its only writer from then on: every row's status ends with \"**close:**\" and the commit that did it. Opened 2026-09-25, when FS-86 was chosen",1)
open(p,'w',encoding='utf-8').write(s)
print(cnt)
