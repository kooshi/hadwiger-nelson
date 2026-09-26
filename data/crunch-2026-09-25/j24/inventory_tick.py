"""J24 stage 5: tick the three close inventories for what the front page discharged, and mark each milestone closed at its head.
Run: python3 data/crunch-2026-09-25/j24/inventory_tick.py [--dry]"""
import re, sys
from pathlib import Path
ROOT = Path(__file__).resolve().parents[3]
DRY = '--dry' in sys.argv
H = "872b34fa (LEDGER), 0f4cf93a (CLAUDE.md), 79c4d42b (FRONTIER-STUBS, stubs, CLOSED-QUESTIONS), 67fdcda2 (BIBLIOGRAPHY)"
GEN = f" — **front page: applied by J24** ({H}; `data/crunch-2026-09-25/j24-record.md`)"
errors = []
def tick(path, notes, head):
    f = ROOT / path; t = f.read_text(); ls = t.split('\n'); hit = set()
    for i, l in enumerate(ls):
        m = re.match(r'^\| (\d+) \|', l)
        if not m: continue
        k = int(m.group(1))
        note = notes(k, l)
        if note is None: continue
        if 'front page: applied by J24' in l or 'J24 (front page)' in l: errors.append(f'{path} {k} already ticked'); continue
        ls[i] = l.rstrip()[:-1].rstrip() + note + ' |'; hit.add(k)
    title = ls[0]
    ls[0:1] = [title, '', head]
    return '\n'.join(ls), hit
# ---- M1 (FS-91)
M1_STAGE4 = {3, 6, 8, 11, 15, 32, 61, 69, 70, 78, 79, 83, 85, 89, 105, 109, 110, 113, 117, 119, 121, 123, 130, 131, 136, 137, 144, 158, 161, 163}
M1_SPEC = {
 125: " — **J24 (front page):** done — J24a's B4–B8 and M1's keys at 67fdcda2; `tools/bib_audit.py` PASS",
 141: " — **J24 (front page):** done by J24a (stage 4: the 1985 paper its own row)",
 142: " — **J24 (front page):** done by J24a (stage 2); superseded at 0f4cf93a (M2 closed: FS-45, FS-39, FS-87, FS-47)",
 143: " — **J24 (front page):** done by J24a (§ R.4 item 15)",
 145: " — **J24 (front page):** done at 872b34fa (row 92: the certificate re-checked) and 67fdcda2 (the Ambrus row)",
 146: " — **J24 (front page):** done at 872b34fa (row 92 and the FS86-Cx-C14 § B line); FS86-derivation's C14/CL1 go to J33 (the owner's ruling)",
 147: " — **J24 (front page):** done at 67fdcda2 (one row under three keys; venue checked; read in full; the R₂ claim)",
 149: " — **J24 (front page):** done at 67fdcda2 (the Ambrus row notes the eq. (23) typo and the two ν)",
 153: " — **J24 (front page):** declined: an owner ruling, nothing to apply on the front page",
 155: " — **J24 (front page):** done by M3's close (M3-CHK23; its § B line at 872b34fa)",
}
def n1(k, l):
    if k in M1_SPEC: return M1_SPEC[k]
    if k in M1_STAGE4:
        return GEN + ("; its record corrections (4.8) stay listed for later (the owner's ruling)" if '4.8' in l else '')
    return None
HEAD1 = ("**CLOSED 2026-09-25 — FS-91 (M1).** The mathematics closed in `plans/FS91-character-local-global.md` §R-close (J23a); the front page "
         f"applied its drafts (J24: {H}). Numbers assigned there: rows N1–N5 → **98–102**; G77 kept; item 26; FS-M1a, b, c → **FS-92, FS-93, "
         "FS-94**. Every stage-4 row below carries the tick; M1 4.8's record corrections stay listed for later (the owner's ruling, 2026-09-25).")
# ---- M2
def n2(k, l):
    if 'drafts for J24' in l: return GEN
    return None
HEAD2 = ("**CLOSED 2026-09-25 — M2, the kernel lane.** The mathematics closed in `plans/M2-kernel-lane.md` §R-close (J23b); the front page "
         f"applied its drafts (J24: {H}). Rows next-a–e → **103–107**. Held outside the front page: the four derivation files' *Kernel:* fields "
         "(J33, the owner's ruling) and `scripts/vacuity-baseline.txt`'s header.")
# ---- M3
M3_SPEC = {
 63: " — **J24 (front page):** done at 872b34fa (rows 108–110)",
 69: " — **J24 (front page):** J21's record is a job record, which the front page may not edit (J24's brief); held for the owner",
 70: " — **J24 (front page):** done in its stage-5 inventory commit — the `[KechrisMarks2020]` row now says to quote the Addendum (Shitov) beside §4.6",
 71: " — **J24 (front page):** listed for Kooshi in `BIBLIOGRAPHY.md` § R.4 item 19 (67fdcda2); still open",
}
PAT3 = re.compile(r'R4\.(?:L|B|G|F|S|Bib|M)\b|R5\b|minted `plans/STUB|ledger draft|row 92|merge proposed|recognition line')
def n3(k, l):
    if k in M3_SPEC: return M3_SPEC[k]
    st = l.rstrip().rsplit(' | ', 1)[-1]
    if PAT3.search(st): return GEN
    return None
HEAD3 = ("**CLOSED 2026-09-25 — M3, colourings no character gives.** The mathematics closed in `plans/M3-exotic-colourings.md` §R-close "
         f"(J23c); the front page applied its drafts (J24: {H}). Numbers assigned there: rows next, next+1, next+2 → **108, 109, 110**; M3's "
         "drafted \"G77\" → **G78**; item 27; the new stubs → **FS-95** (rank-one walls), **FS-96** (windows at the non-mixing places). R4.C's "
         "corrected text stays in the plan's §R-close, where the plan's banners point.")
out = {}
for path, fn, head in (('plans/FS91-close-inventory.md', n1, HEAD1), ('plans/M2-close-inventory.md', n2, HEAD2), ('plans/M3-close-inventory.md', n3, HEAD3)):
    t, hit = tick(path, fn, head); out[path] = t
    print(path, 'ticked', len(hit), sorted(hit))
if len([k for k in M1_STAGE4 | set(M1_SPEC)]) != 40: errors.append('M1 set size')
if errors: print('ERRORS', errors); sys.exit(1)
if not DRY:
    for p, t in out.items(): (ROOT / p).write_text(t)
