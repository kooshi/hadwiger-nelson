const C = require('./core.js');
function run(g){let r;while(!(r=g.next()).done);return r.value;}
const F = C.makeField([167]);
for (let N = 1; N <= 140; N++) {
  const U = run(C.unitVectors(F, N, 1e8));
  if (U.W.length <= 12) continue;                        // axis only or axis + Pythagorean: bipartite
  const r = run(C.cayleyOddCycle(F, N, U.W, 400000));
  console.log(`N=${N} |W|=${U.W.length}`, r.found ? `odd girth ${r.length}` : `no odd cycle of length ≤ ${2*r.radius-1} (${r.points} points)`);
}
