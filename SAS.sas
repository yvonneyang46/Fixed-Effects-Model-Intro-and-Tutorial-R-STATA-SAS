
proc import datafile="C:\project\cigar.csv" 
out=mydata dbms=csv replace; 
getnames=yes; 
run;

data cigar; set mydata;
price_adj = (price/cpi)*100;
income_adj = (ndi/cpi)*100;
run;

proc reg data=cigar; 
 model sales = price_adj pop pop16 ndi;
 run;
quit;

proc glm;
 class state year;
 model sales = price_adj pop pop16 ndi/ solution; run;
quit;
