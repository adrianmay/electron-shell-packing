<script>

var an=1;

function on(sh, elec, isOn) {
  document.getElementById('el-'+sh+'-'+elec).setAttribute('opacity', isOn ? '100%' : '10%');
}

function setName(x) { document.getElementById('elName').innerHTML=elNames[x]; }

function nudge(d) {
  if (an+d<1 || an+d>118 || d==0) return;
  oldAn = an;
  an = oldAn + d;
  oldFills = elFills[oldAn];
  newFills = elFills[an];
  for (sh=1;sh<=7;sh++) {
    if (oldFills[sh] == newFills[sh]) { }
    else if (oldFills[sh] < newFills[sh]) { for (x=oldFills[sh]+1;x<=newFills[sh];x++) {on(sh, x, true)} }
    else if (newFills[sh] < oldFills[sh]) { for (x=oldFills[sh]  ;x> newFills[sh];x--) {on(sh, x, false)} }
  }
  document.getElementById("pt-"+oldAn).setAttribute("opacity", "20%");  
  document.getElementById("pt-"+an).setAttribute("opacity", "100%");  
}

function distDown(an) {
  return an<3  ? 2 :
         an<13 ? 8 :
         an<39 ? 18 :  
         32
}

function distUp(an) {
  return an<3  ? 0 :
         an<5  ? 2 :
         an<11 ? 0 :
         an<21 ? 8 :  
         an<31 ? 0 :
         an<57 ? 18 :
         an<71 ? 0 :
         32
}

document.onkeydown = function(e) {
  if      (e.key=="ArrowRight") nudge(1)
  else if (e.key=="ArrowLeft")  nudge(-1)
  else if (e.key=="ArrowDown")  nudge(distDown(an))
  else if (e.key=="ArrowUp")    nudge(-distUp (an))
}

function init() { 
  an = 1;
  on(1,1,true);
  document.getElementById("pt-"+an).setAttribute("opacity", "100%");  
  setName(1);
}


