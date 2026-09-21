# Owner's recheck of the certificate at 19 (2026-09-21)

```
step 7/7: 4 * U_num = 31004696835443752890281460805026848 < 361 * scale = 36100000000000000000000000000000000
CERTIFIED: every phi in [0,1]^361 with q(phi) >= 0 has sum(phi) <= U = 77.511742… (exactly U_num/scale of the file, sha256 055f031d1e69…); 4*U = 310.046968… < 361, so BY THE HAND-PROVED LINKS L1, L2, L6 (data/fs66/b1/SOUNDNESS.md) no UD(Z/19^k, 2), k >= 1, is 4-colourable. Standard-library checker, NOT the Lean kernel.
exit=0
```

Frozen checker sha256 prefix: 735b926798ffac14 (unchanged since Phase 2A). The 76-point level-one set at 19 verified pairwise non-adjacent by the owner's own code from the definition (as the 14- and 28-point sets were). floor(U) = 77, so alpha(UD(F_19,2)) is 76 or 77 (standing bracket before this milestone: [76, 80]); 27,436 <= alpha(UD(Z/361,2)) <= 27,981.
