-- FS131-LEB: why the module's namespaces are not `HadwigerNelson.Topology` (measured at v4.32.0, no imports).
-- Run: lake env lean data/fs131/leb/NamespaceShadow.lean   Expected output (data/fs131/leb/namespace-shadow.out):
--   `#check bar`: error, unknown identifier -- inside `HN.*`, `open Topology` opens `HN.Topology` and NOT the root `Topology`
--   `#check onlyHere`: HN.Topology.onlyHere  -- the nested namespace is what got opened
--   `#check closedSquare`: HN.Plane.closedSquare -- the current namespace's own declaration still wins
namespace Topology
def bar : Nat := 0
end Topology
namespace HN.Topology
def onlyHere : Nat := 1
end HN.Topology
namespace HN.Plane
open Topology
#check bar
#check onlyHere
def closedSquare : Nat := 2
end HN.Plane
namespace HN.Plane
#check closedSquare
end HN.Plane
