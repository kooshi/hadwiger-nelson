import Proofs

/-!
# Axiom audit — the trust receipt

The de Bruijn criterion made a standing check: everything shipped reduces to what the
kernel verified plus what we explicitly chose to trust. Add one `#print axioms` line per
public theorem as the library grows; the milestone gate reads this output and fails on a
leftover proof-hole axiom or an unaudited custom axiom.

Run it:  `lake env lean scripts/Axioms.lean`
-/

#print axioms Proofs.two_add_two
