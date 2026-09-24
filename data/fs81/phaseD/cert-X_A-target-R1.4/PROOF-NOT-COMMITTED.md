# The LRAT proof for this certificate is not committed

The trimmed CaDiCaL LRAT proof (952,894 additions, gzip 140,138,203 bytes) certifies that this witness (the R = 1.4 ball of de Grey's
lattice, 30,181 points, plus the one edge {0, v}) refuses four colours under the target encoding. K2 CERTIFIED it (`K2.out`: a FORCED
PAIR, not a chromatic bound), cake_lpr reported `s VERIFIED UNSAT` (`rup-recheck.out`), and kissat refused the same formula.

- **Why it is not committed:** at 140 MB it is three times the largest proof this repository holds (43 MB); it regenerates exactly in
  about five minutes plus the trim; and it certifies a calibration bound, R*(X_A) ≤ 1.4, not a headline result. The owner's decision,
  2026-09-24 (FS-81 close inventory).
- **sha256 of the gzipped proof:** `02ff096beb1ce3f467702e2c8456da53a8112491d0792f0f42cc4255df97d449`
- **Where it is kept:** `~/fs81-phaseD-work/certs/X_A-target-R1.4.witness.lrat.gz` on the desktop's disk (not /tmp).
- **To regenerate:** `python3 tools/fs81_phaseD.py certify 'X_A|target|R1.4'` (the record's Resume section), then the trim, then
  `python3 tools/fs81_check_witness_k.py witness.json witness.lrat.gz` and `python3 tools/fs81_rup_recheck.py …`. A regenerated proof may
  differ byte for byte from this one if the solver's version changes; the check, not the hash, is what certifies.
