const C = require('./core.js');
function run(gen){ let r; while(!(r=gen.next()).done); return r.value; }
const cases = [[[],5],[[2],6],[[3],2],[[3],12],[[5],15],[[7],8],[[11],6],[[23],12],[[47],24],[[167],84],[[167],420],[[167],2184],[[1055],108],[[2351],1176],[[4703],2352],
 [[2,3],12],[[3,11],6],[[3,11],12],[[3,11],24],[[3,11,35],12],[[3,11,14],12],[[3,5,11],12],[[3,11,23],12],[[3,11,247],48],[[3,7,11],12],[[3,7,11],24],[[3,11,13],12],[[3,5,7,11],8],[[3,5,7,11],12]];
for (const [r,N] of cases){
  const F=C.makeField(r); const t=Date.now(); const res=run(C.unitVectors(F,N,3e7));
  console.log(JSON.stringify(r), 'N='+N, '|W|='+res.W.length, res.complete?'complete':'STOPPED', 'nodes='+res.nodes, (Date.now()-t)+'ms');
}
