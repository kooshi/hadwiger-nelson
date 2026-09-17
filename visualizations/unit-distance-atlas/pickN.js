const C = require('./core.js');
function run(gen){ let r; while(!(r=gen.next()).done); return r.value; }
const fields = [[],[2],[3],[5],[7],[11],[23],[47],[167],[1055],[2351],[4703],[2,3],[3,11],[3,11,35],[3,11,14],[3,11,70],[3,5,11],[3,11,23],[3,11,247],[3,7,11],[3,11,13],[3,5,7,11]];
for (const r of fields) {
  const F = C.makeField(r); const rows=[];
  for (let N = 1; N <= (F.k<=1? 2400: 60); N++) {
    if (F.k<=1 && N>60 && ![84,108,168,420,1176,2352,2184].includes(N)) continue;
    const t=Date.now(); const res = run(C.unitVectors(F, N, 2.5e6)); const ms=Date.now()-t;
    if (!res.complete) continue;
    let used = 0; for (const v of res.W) for (let S=0;S<F.n;S++) if (v[S]||v[F.n+S]) used |= S; // bitwise OR of supports (as masks)
    // coverage: OR of all S used spans generators?
    let cov=0; for (const v of res.W) for (let S=1;S<F.n;S++) if (v[S]||v[F.n+S]) cov |= S;
    rows.push({N, W:res.W.length, cov, full: cov===F.n-1, ms});
  }
  const full = rows.filter(x=>x.full);
  const best = full.slice(0,6).map(x=>`N=${x.N}:|W|=${x.W},${x.ms}ms`).join('  ');
  console.log(JSON.stringify(r), 'k='+F.k, 'gens='+F.gens, full.length? best : 'NO full coverage; best cov rows: '+rows.slice(-3).map(x=>`N=${x.N} cov=${x.cov} W=${x.W}`).join(' '));
}
