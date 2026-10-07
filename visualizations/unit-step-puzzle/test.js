const fs=require("fs");const html=fs.readFileSync(process.argv[2],"utf8");
const core=html.split("/*CORE*/")[1].split("/*END*/")[0];
eval(core+";globalThis.T={steps,neighbours,clashes,stripes23,encode,decode};");
let ok=true;const say=(n,c)=>{console.log((c?"ok   ":"FAIL ")+n);if(!c)ok=false;};
for(const q of [3,7,11,19,23]) say("q="+q+": each cell clashes with q+1 = "+(q+1), T.steps(q).length===q+1 && T.neighbours(q).every(l=>l.length===q+1 && new Set(l).size===q+1));
const nb=T.neighbours(23), s=T.stripes23();
say("the stripes at 23 use 8 colours and have no clash", new Set(s).size===8 && T.clashes(s,nb).pairs===0 && s.every(c=>c>=0));
// planted fault: one cell recoloured to a neighbour's colour must clash
const f=Int8Array.from(s); f[0]=f[nb[0][0]]; say("a planted clash is counted", T.clashes(f,nb).pairs>=1);
// symmetry of the relation: j in nb[i] iff i in nb[j]
say("the clash relation is symmetric", nb.every((l,i)=>l.every(j=>nb[j].includes(i))));
// Latin colouring at q=3 solves level 1
const n3=T.neighbours(3), c3=Int8Array.from({length:9},(_,i)=>((i%3)+Math.floor(i/3))%3); say("x+y mod 3 solves the 3×3 level", T.clashes(c3,n3).pairs===0);
say("a code round-trips", T.encode(T.decode(T.encode(s),529,8))===T.encode(s) && T.decode("012",9,3)===null && T.decode("9".repeat(9),9,3)===null);
process.exit(ok?0:1);
