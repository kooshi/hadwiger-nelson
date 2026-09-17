const C=require('./core.js');
// the presets are read from the page template itself, so this check cannot drift from what the page shows
const tmpl=require('fs').readFileSync(__dirname+'/page.tmpl.html','utf8');
const P=new Function('return '+tmpl.slice(tmpl.indexOf('const FIELDS = [')+'const FIELDS = '.length, tmpl.indexOf('];', tmpl.indexOf('const FIELDS = ['))+1))();
function run(g){let r;while(!(r=g.next()).done);return r.value;}
for(const p of P){ const F=C.makeField(p.r);
  for(const N of [p.N, ...p.sugg.filter(x=>x!==p.N)]){
    const t=Date.now(); const U=run(C.unitVectors(F,N,2e7)); const tw=Date.now()-t;
    const t2=Date.now(); const G=run(C.grow(F,N,U.W,[new Int32Array(2*F.n)],1000,'ball')); const {E}=C.edgesOf(F,N,G.pts,G.np);
    const adj=C.adjacency(G.np,E), T=C.triangles(adj), S=C.spindles(F,G.pts,G.np,adj,T), cyc=C.shortestOddCycle(adj);
    console.log((N===p.N?'*':' ')+JSON.stringify(p.r).padEnd(14),'N='+String(N).padEnd(5),'|W|='+String(U.W.length).padEnd(4),U.complete?'ok  ':'STOP',`search ${tw}ms, draw ${Date.now()-t2}ms; E=${E.length/2} tri=${T.length/3} spin=${S.length} odd=${cyc?cyc.length:'-'}`);
  }
}
