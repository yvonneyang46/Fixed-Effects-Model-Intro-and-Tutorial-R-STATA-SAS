## Group Project
## Stats 506, Fall 2018
## Updated: November 20th, 2018

# libraries: ------------------------------------------------------------------
library(plm)
library(car)
library(lfe)

# data: -----------------------------------------------------------------------
data(Cigar)

# Adjust the price, and disposable income with cpi to 
# get the dollar value in 1983
Cigar = mutate(Cigar, 
price_adj = (price/cpi)*100,
income_adj = (ndi/cpi)*100)

# Run ordinary linear regression without fixed effect
ols = lm(sales ~ price_adj + pop + pop16 + income_adj, data = Cigar)
summary(ols)

# Fixed effects using Least squares dummy variable model
ols_fixed = lm(sales ~ price_adj + 
                 pop + pop16 + income_adj +
                 factor(year) + factor(state), data = Cigar)
summary(ols_fixed)

# Using lfe package to generate dummies variables for *state* and *year* and fit
# a model 
felm_fixed = felm(sales ~ price_adj + 
                  pop + pop16 + income_adj |
                  factor(year) + factor(state), data = Cigar)
summary(felm_fixed)

# Use plm package to generate dummie variables for *state* and *year* and fit
# a model
plm_md = plm(sales ~ price_adj + pop + pop16 + income_adj, 
             data = Cigar,
          index = c("year", "state"), model = "within", effect = "twoways")
summary(plm_md)


