*----------------------------------------------------------*
* Fix-effect Model in Stata.
*
*
* Updated: Nov 25, 2018
* Author: Nam Le
*----------------------------------------------------------*
// install package reghdfe
ssc install reghdfe
// Read data and reduce to needed variables

import delimited Cigar.csv, clear

// Adjust the price, and disposable income with cpi to get the dollar value in 1983
g price_adj = (price/cpi)*100
g income_adj = (ndi/cpi)*100

// Run regression with areg
reg sales price_adj pop pop16 ndi // without fixed effect


areg sales price_adj pop pop16 ndi i.year, absorb(state) // fixed effect

xtset state year
xtreg sales price_adj pop pop16 ndi i.year, fe // fixed effect

reghdfe sales price_adj pop pop16 ndi, absorb(state year) // fixed effect
// Compute the cross products, sum of squares, and regression coefficients
