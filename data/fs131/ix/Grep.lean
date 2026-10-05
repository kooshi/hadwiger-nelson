import Mathlib
-- FS131-IX1 stage 2: Mathlib at the pin, by the crossing lemma's shape. Each line either elaborates (found) or errors (not found).
open Complex Set Metric Topology
#check @IsCoveringMap.existsUnique_continuousMap_lifts
#check @Complex.isCoveringMap_exp
#check @IsCoveringMap.liftPath
#check @IsCoveringMap.liftHomotopy
#check @IsCoveringMap.monodromy
#check @Complex.arg_mul_cos_add_sin_mul_I
#check @Complex.arg_exp_mul_I
#check @Disjoint.exists_thickenings
#check @Disjoint.exists_cthickenings
#check @IsOpen.isConnected_iff_isPathConnected
#check @IsPathConnected.joinedIn
#check @JoinedIn.somePath
#check @JoinedIn.somePath_mem
#check @Path.extend
#check @Path.extend_extends
#check @Complex.continuousAt_clog
#check @Complex.mem_slitPlane_iff
#check @Complex.exp_eq_exp_iff_exists_int
#check @Complex.log_im
#check @Metric.isCompact_of_isClosed_isBounded
#check @IsPreconnected.thickening
#check @Metric.thickening
#check @isPreconnected_of_forall
#check @Circle.exp
#check @AddCircle
-- not-found probes (each expected to error)
#check @JordanCurve
#check @Janiszewski
#check @brouwer_fixed_point
#check @Complex.windingNumber
#check @poincare_miranda
