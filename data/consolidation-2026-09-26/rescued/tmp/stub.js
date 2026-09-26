const fs=require('fs');const s=fs.readFileSync(process.argv[2],'utf8');const code=s.match(/<script>([\s\S]*)<\/script>/)[1];
function mk(tag){const e={tag,children:[],attrs:{},style:{},classList:{_s:new Set(),add(...a){a.forEach(x=>this._s.add(x))},toggle(x,v){v?this._s.add(x):this._s.delete(x)}},
 setAttribute(k,v){this.attrs[k]=v},getAttribute(k){return this.attrs[k]},appendChild(c){this.children.push(c);return c},
 addEventListener(){},querySelectorAll(){return []},closest(){return null},getBoundingClientRect(){return {width:10,height:10,right:0,bottom:0}},
 set innerHTML(v){this._h=v;this.children=[]},get innerHTML(){return this._h||''},textContent:'',hidden:false,value:'',onclick:null,onchange:null,disabled:false,scrollIntoView(){}};return e;}
const els={};const document={getElementById(id){return els[id]||(els[id]=mk(id))},createElementNS(ns,t){return mk(t)},createElement(t){return mk(t)},createRange(){return{selectNodeContents(){}}}};
const localStorage={getItem(){return null},setItem(){}};
let nmarks=0;
new Function('document','localStorage','innerWidth','innerHeight','getSelection','navigator',code)(document,localStorage,1400,900,()=>({removeAllRanges(){},addRange(){}}),{});
const svg=els.board; let count=0; (function walk(n){count++; (n.children||[]).forEach(walk)})(svg);
console.log('svg nodes',count,'viewBox',svg.attrs.viewBox,'guide',els.gtext.textContent.slice(0,60));
console.log('panel',els.panel.innerHTML.length,'legend',els.legend.innerHTML.length);
