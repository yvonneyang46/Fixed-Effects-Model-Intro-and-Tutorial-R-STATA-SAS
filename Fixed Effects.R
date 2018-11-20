## Group Project
## Stats 506, Fall 2018
## Updated: November 20th, 2018

# libraries: ------------------------------------------------------------------
library(plm)
library(car)

# data: -----------------------------------------------------------------------
data(Cigar)

ols = lm(sales ~ price, data = Cigar)
summary(ols)

# Fixed effects using Least squares dummy variable model
ols_fixed = lm(sales ~ price + factor(state) + factor(year) - 1, data = Cigar)
summary(ols_fixed)

yhat = ols_fixed$fitted.values
scatterplot(yhat ~ Cigar$price|Cigar$state, boxplots=FALSE, 
            xlab="price", ylab="yhat", smooth=FALSE)

abline(lm(Cigar$sales~Cigar$price),lwd=3, col="red")

# Use plm package to generate dummie variables for *state* and *year* and fit
# a model
plm_md = plm(sales ~ price - 1, data = Cigar,
          index = c("state","year"), model = "within")
summary(plm)
fixef(plm)

