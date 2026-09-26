P="/home/kooshi/source/lean-dir/CLAUDE.md"
L=open(P).read().split("\n")
assert L[136].startswith("*Last updated: 2026-09-26") and L[137].startswith("its hand-over to 2026-10-01")
L[136:138]=["*Last updated: 2026-09-26 — **the 2026-09-25 crunch closed** (queue `plans/CRUNCH-2026-09-25-queue.md` §8: its jobs, its expectations scored,",
"its hand-over to 2026-10-01); FS-100's stages 1–2 ran and FS-97 was absorbed into it (the stub). Before it, 2026-09-25, **row 88's question** (rows 111–113, item 24; G79 minted) — **Paid (theorem); row 88 not landed** (`plans/FS86-row88-rigidity.md` §R-close) — and **FS-67** (rows 114–115, item 28) — **Paid (theorem and no-go)** (`plans/FS67-tight-products.md` §R-close); before them the crunch's three milestones (rows 98–110, items 25–27; G77, G78 minted): **FS-91 (M1)** — **Paid (theorem)**, O1 at a prior of 0.30 (`plans/FS91-character-local-global.md` §R-close); **M2**, the kernel lane (§ What the kernel holds) — **Paid (kernel)** (`plans/M2-kernel-lane.md` §R-close); **M3** — FS-76 in rank one **not landed**, FS-64 at five colours over ℚ(√167) **landed in part** (`plans/M3-exotic-colourings.md` §R-close). **No finite-witness search runs until 2026-10-01** (Kooshi; § Toolchain). Earlier closes: `plans/FRONTIER-STUBS.md`'s closed list, and git.*"]
i=[k for k,l in enumerate(L) if l.startswith("**Open milestones, in order.**")]
assert len(i)==1
L[i[0]]=("**Open milestones, in order.** **One is open: FS-84** (ℚ(√47): five colours; `plans/FS84-five-colours-47.md`) — S1, its derivation, and S1V, its blind verification, are done (`plans/FS84-S1-derivation.md`, `plans/FS84-S1V-verification.md`); its next stages run from 2026-10-01. "
 "**Next:** Kooshi's choice, with a next-step advisor; the finite-witness-free week runs to 2026-10-01 (§ Toolchain). **M63** stands at phases H2–H3 closed (rows 64–65); **M62** stays paused behind it. "
 "**Closed most recently** (verdicts and §R-close addresses in the Last-updated line; every earlier close, its record and banner in `plans/FRONTIER-STUBS.md`'s closed list): row 88's question (`plans/R88-derivation.md`; FS-97, FS-98, FS-99 minted); FS-67 as a milestone (`plans/FS67-derivation.md`; the stub re-aimed); "
 "the 2026-09-25 crunch's M1–M3 (index `plans/CRUNCH-2026-09-25-INDEX.md`) — M1 = FS-91 (rows 98–102, G77; `plans/FS91-derivation.md`; banners on `plans/STUB-band-rigidity-six.md`, on FS-82's `plans/STUB-three-colours-residue-degree-three.md`, closed with it, and on FS-83's `plans/STUB-layer-method-five-colours.md`, answered for falsifiers), "
 "M2 = the kernel lane, FS-45, FS-39, FS-87 and FS-47 (rows 103–107; the kernel register `plans/M2-derivation.md`), M3 = FS-76 in rank one and FS-64 at five colours (rows 108–110, G78; `plans/M3-derivation.md`); "
 "FS-89, rational band rigidity, 2026-09-25 (rows 95–97, G76; `plans/FS89-rational-band-rigidity.md` §R-close; `plans/FS89-derivation.md`; banner on `plans/STUB-isometric-measure-rigidity.md`).")
t="\n".join(L)
old=("**Gate:** the field-level statement needs only that a number field with a conjugation-fixed prime\n"
     "  supplies the valuation subring with residue field of size N(𝔭); closing it promotes G35 and G43")
assert t.count(old)==1
t=t.replace(old,"**Gate:** the field-level statement is row 57's gap (a conjugation-fixed prime\n  supplying the valuation subring); closing it promotes G35 and G43")
open(P,"w").write(t)
