
## Import the data
proc import datafile=".\Cigar.csv" 
out=mydata dbms=csv replace; 
getnames=yes; 
run;

## Transform the varaibles
data Cigar; set mydata;
price_adj = (price/cpi)*100;
income_adj = (ndi/cpi)*100;
run;

## Fit the ordinary least square regression
proc reg data=Cigar; 
 model sales = price_adj pop pop16 income_adj;
 run;
quit;

## Fit the fixed effects model
proc glm data=Cigar;
 class year state; 
 model sales = price_adj pop pop16 income_adj year state/ solution; run;
quit;
