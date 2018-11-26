
proc import datafile="Z:\Desktop\2018FALL\stat506\Cigar.csv" 
out=mydata dbms=csv replace; 
getnames=yes; 
run;

data Cigar; set mydata;
price_adj = (price/cpi)*100;
income_adj = (ndi/cpi)*100;
run;

proc reg data=Cigar; 
 model sales = price_adj pop pop16 income_adj;
 run;
quit;

proc glm data=Cigar;
 class year state; 
 model sales = price_adj pop pop16 income_adj year state/ solution; run;
quit;
