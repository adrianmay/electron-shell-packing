
function radius(sh, ssh) { return (sh-1)*(sh)/2 + ssh; }
function capacity(ssh) { return 2+4*(ssh-1);}
function angle(sh, ssh, elec) { return (0.9/radius(sh,1)) * (elec - (capacity(ssh)+1)/2); }

function ptss(c) { 
  if (c<3 ) { return 1; }
  if (c<17) { return 4; }
  if (c<27) { return 3; }
  return 2;
}


BEGIN {
}

{
  name[$1]=$2;
  row[$1]=$3;
  col[$1]=$4;
  split($6,shs[$1],";");
}

END {
  print "elFills = [ "
  for (x in name) {
    printf("[-1");
    for (y=1;y<=7;y++) {
      printf(", %d", shs[x][y]);
    }
    print("], ")
  }
  print("[] ]");

  print "rows = [";
  for (x in name) printf("%d, ", row[x]);
  print "0];"
  print "cols = [";
  for (x in name) printf("%d, ", col[x]);
  print "0];"

  radPix=20;
  oriX = 20;
  oriY = 400;
  colours[1] = "red"; 
  colours[2] = "blue";
  colours[3] = "green";
  colours[4] = "orange";
  colours[5] = colours[6] = colours[7] = "gray";
  printf("var elNames = [");
  for (x in name) 
    printf("'%s', ", name[x]);
  print("'Nothing'];")
  print "</script>"
  print "<body onLoad='init()'>"
  print "<svg width='1800' height='" oriY*2 "'>"
  for (sh=1;sh<=7;sh++) {
    el=1;
    for (ssh=1;ssh<=sh;ssh++) {
      rad = radius(sh, ssh)
      cap = capacity(ssh)
      # print sh " " ssh " " rad " " cap
      for (elec=1; elec<=cap; elec++) { # printf(" %f", angle(sh, ssh, elec));
        ang = angle(sh, ssh, elec);
        x = rad * radPix * cos(ang) + oriX
        y = rad * radPix * sin(ang) + oriY
        print "<circle id='el-" sh "-" el "' r='5' stroke-width='1' stroke='" colours[ssh] "' fill='" colours[ssh] "' opacity='10%' cx='" x  "' cy='" y "'/>"
        el++;
        }
      }
    }
  # print "<circle stroke='black' fill='none' stroke-width='1' cx='" oriX "' cy='" oriY "' r='" radPix*radius(1, 1.5) "'/>"  
  for (sh=1;sh<=8;sh++) {
      print "<circle stroke='black' fill='none' stroke-width='1' cx='" oriX "' cy='" oriY "' r='" radPix*radius(sh, 0.5) "'/>"  
    }
  for (x in name) {
    if (x != 0 && name[x]!="Nothing") {
      print "<text stroke='" colours[ptss(col[x])] "' opacity='20%' id='pt-" x "' x='" 700+30*col[x] "' y='" 100+30*row[x] "'>" name[x] "</text>";
      }
    } 
  print "<text stroke='red'    opacity='100%' x='700' y='70'>s</text>";
  print "<text stroke='blue'   opacity='100%' x='730' y='70'>p</text>";
  print "<text stroke='green'  opacity='100%' x='760' y='70'>d</text>";
  print "<text stroke='orange' opacity='100%' x='790' y='70'>f</text>";
  print "<text stroke='black'  opacity='100%' x='700' y='40'>Use arrow keys</text>";
  print "</svg>"
}
