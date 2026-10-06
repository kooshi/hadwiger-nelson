import Proofs.HadwigerNelson.Plane.ValidMap.BaseWalk
-- FS131-I5q: the elaborated statements of `bv_l3` and `l3_base`, printed in full; run before the move and after it, and compared by `diff`
-- (the text check `tools/fs131_i5_bvl3_move.py` cannot see a statement that reads differently in its new context; this can)
set_option pp.fullNames true
set_option pp.explicit true
set_option pp.universes true
#check @HadwigerNelson.Plane.ArcMap.bv_l3
#check @HadwigerNelson.Plane.ArcMap.BaseCtx.l3_base
