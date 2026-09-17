const C = require('./core.js');
function run(gen){ let r; while(!(r=gen.next()).done); return r.value; }
function full(r, N, target, mode, oddSeed){
  const F=C.makeField(r); let t=Date.now();
  const U=run(C.unitVectors(F,N,3e7)); const tW=Date.now()-t; t=Date.now();
  let seeds=[new Int32Array(2*F.n)], oc='';
  if (oddSeed){ const res=run(C.cayleyOddCycle(F,N,U.W,300000)); oc=` cayley-odd: ${res.found? 'len '+res.length : 'none r<='+res.radius}, ${res.points} pts, ${Date.now()-t}ms;`; if(res.found) seeds=res.verts; t=Date.now(); }
  const G=run(C.grow(F,N,U.W,seeds,target,mode)); const tG=Date.now()-t; t=Date.now();
  const {E,proposals}=C.edgesOf(F,N,G.pts,G.np); const tE=Date.now()-t; t=Date.now();
  const adj=C.adjacency(G.np,E); const T=C.triangles(adj); const S=C.spindles(F,G.pts,G.np,adj,T); const tS=Date.now()-t; t=Date.now();
  const cyc=C.shortestOddCycle(adj); const tO=Date.now()-t;
  // verify generator edges are unit and count edges not along W
  const m=2*F.n; const Wset=new Set(U.W.map(v=>v.join(','))); let extra=0;
  for(let e=0;e<E.length;e+=2){ const d=[]; for(let q=0;q<m;q++) d.push(G.pts[E[e+1]*m+q]-G.pts[E[e]*m+q]); if(!Wset.has(d.join(','))) extra++; }
  console.log(JSON.stringify(r),'N='+N,mode,'|W|='+U.W.length,`pts=${G.np} edges=${E.length/2} (not in W: ${extra}) prop=${proposals} tri=${T.length/3} spindles=${S.length} odd=${cyc?cyc.length:'bipartite'};${oc} t: W ${tW} grow ${tG} edges ${tE} shapes ${tS} odd ${tO} ms`);
  return {F,U,G};
}
const {F,U}=full([167],420,1000,'closure',true);
console.log(' sample W:', U.W.slice(0,3).map(v=>'('+C.fmt(F,420,v,0)+', '+C.fmt(F,420,v,F.n)+')').join('  '));
full([167],420,1000,'closure',false);
full([167],84,1000,'closure',true);
full([],5,1000,'closure',false); full([3],2,1000,'closure',false); full([3],2,1000,'ball',false);
const k=full([3,11],12,1000,'closure',false);
console.log(' sample W:', k.U.W.slice(0,4).map(v=>'('+C.fmt(k.F,12,v,0)+', '+C.fmt(k.F,12,v,k.F.n)+')').join('  '));
full([3,11],12,1000,'ball',false);
full([3,5,11],8,1000,'closure',false); full([3,7,11],12,1000,'closure',false); full([3,5,7,11],8,1000,'closure',false);
full([2,3],6,1000,'closure',false); full([2351],1176,1000,'closure',true); full([3,11,247],16,1000,'closure',false);
full([3,11],12,3000,'closure',false);
