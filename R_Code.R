## Group Project
## Stats 506, Fall 2018
## Updated: November 20th, 2018

# libraries: ------------------------------------------------------------------
library(plm)

# data: -----------------------------------------------------------------------
data(Cigar)

# Fixed effects using Least squares dummy variable model
ols_md = lm(sales ~ price + factor(state) + factor(year) - 1, data = Cigar)
summary(ols)

# Use plm package to generate dummie variables for *state* and *year* and fit
# a model
plm_md = plm(sales ~ price - 1, data = Cigar,
          index = c("state","year"), model = "within")
summary(plm)
fixef(plm)

