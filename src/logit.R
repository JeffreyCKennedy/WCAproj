# Used this reference:
# https://stats.idre.ucla.edu/r/dae/ordinal-logistic-regression/

str(responses$F14b_CarSucc)
str(responses$Age_f)

scales_logistic <- c("F14b_CarSucc", "F14b_CarSucc_f", "Age", "Seniority", "Educ", "TotSal", 
                     "TotDeps", "Marital", "Age_f", "Seniority_f", "Educ_f", 
                     "TotSal_f", "Marital_f", "D3_CareerSE")
responses_logistic <- responses %>% 
    dplyr::select(one_of(scales_logistic)) %>% 
    filter(!is.na(F14b_CarSucc_f)) %>% 
    filter(!is.na(Marital)) %>% 
    filter(!is.na(Educ)) %>% 
    filter(!is.na(Seniority)) %>% 
    filter(!is.na(TotSal)) %>% 
    filter(!is.na(TotDeps)) %>% 
    filter(Seniority <= 6) %>%  # 7 = other & 8 = no managerial resp
    filter(Age < 6) %>%  # 6 = 65 and over
    filter(Marital < 3) %>%  # 3 = other
    filter(Educ < 7) %>%  # 7 = other
    filter(TotDeps <= 3)  # only 4 cases > 3
    


sapply(responses_logistic,function(x) sum(is.na(x)))

m <- polr(F14b_CarSucc_f ~ Age + Seniority + Educ + TotSal + TotDeps + Marital,
          data = responses_logistic, na.action = "na.omit", Hess = TRUE)
# Add in an interaction term for Age and Seniority:
m2 <- polr(F14b_CarSucc_f ~ Age * Seniority + Educ + TotSal + TotDeps + Marital,
          data = responses_logistic, na.action = "na.omit", Hess = TRUE)
# Include interaction only, not main effects
m3 <- polr(F14b_CarSucc_f ~ Age : Seniority + Educ + TotSal + TotDeps + Marital,
           data = responses_logistic, na.action = "na.omit", Hess = TRUE)
# Model m, but with CareerSE included:
m4 <- polr(F14b_CarSucc_f ~ Age + Seniority + D3_CareerSE + Educ + TotSal + TotDeps + Marital,
          data = responses_logistic, na.action = "na.omit", Hess = TRUE)

summary(m, digits = 3)
(ci <- confint(m))

summary(m2, digits = 3) # With interaction and main effects, nothing is significant.
(ci <- confint(m2))

summary(m3, digits = 3) # Without main effects, Educ & interaction are significant.
(ci <- confint(m3))

summary(m4, digits = 3) # Without main effects, Educ & interaction are significant.
(ci <- confint(m4))

anova(m3, m)
anova(m2, m)


# The coefficients from the model can be somewhat difficult to interpret because
# they are scaled in terms of logs. Another way to interpret logistic regression
# models is to convert the coefficients into odds ratios. To get the OR and
# confidence intervals, we just exponentiate the estimates and confidence
# intervals.

# odds ratios
exp(coef(m))
## OR and CI
exp(cbind(OR = coef(m), ci))
# These coefficients are called proportional odds ratios and we would interpret
# these pretty much as we would odds ratios from a binary logistic regression

# For Age, we would say that for a one unit increase in age, i.e., going from 1
# (15-24 yrs) to 2 (25-34 yrs), the odds of “ahead of schedule” applying versus
# “on schedule” or “behind schedule” applying combined are 0.587 smaller, given
# that all of the other variables in the model are held constant. Likewise, the
# odds “ahead” or “on” applying versus “behind” applying is 0.587 times smaller,
# given that all of the other variables in the model are held constant. In
# contrast, for a one unit increase in salary (e.g., from 2 ($30,001-$50,000) to
# 3 ($50,001-$80,000), the odds of "ahead" applying versus "on" or "behind"
# combined applying are 1.21 times greater.

# One of the assumptions underlying ordinal logistic (and ordinal probit)
# regression is that the relationship between each pair of outcome groups is the
# same. In other words, ordinal logistic regression assumes that the
# coefficients that describe the relationship between, say, the lowest versus
# all higher categories of the response variable are the same as those that
# describe the relationship between the next lowest category and all higher
# categories, etc. This is called the proportional odds assumption or the
# parallel regression assumption.One of the assumptions underlying ordinal
# logistic (and ordinal probit) regression is that the relationship between each
# pair of outcome groups is the same. In other words, ordinal logistic
# regression assumes that the coefficients that describe the relationship
# between, say, the lowest versus all higher categories of the response variable
# are the same as those that describe the relationship between the next lowest
# category and all higher categories, etc. This is called the proportional odds
# assumption or the parallel regression assumption.

# [Tests have problems; webpage cites Harrell (2001) who suggests using
# graphical method to evaluate. The values displayed in this graph are
# essentially (linear) predictions from a logit model, used to model the
# probability that y is greater than or equal to a given value (for each level
# of y), using one predictor (x) variable at a time. In order create this graph,
# you will need the Hmisc library.

# The first command creates the function that estimates the values that will be
# graphed. The first line of this command tells R that sf is a function, and
# that this function takes one argument, which we label y. The sf function will
# calculate the log odds of being greater than or equal to each value of the
# target variable. For our purposes, we would like the log odds of apply being
# greater than or equal to 2, and then greater than or equal to 3. Depending on
# the number of categories in your dependent variable, and the coding of your
# variables, you may have to edit this function. Below the function is
# configured for a y variable with three levels, 1, 2, 3. If your dependent
# variable has 4 levels, labeled 1, 2, 3, 4 you would need to add
# 'Y>=4'=qlogis(mean(y >= 4)) (minus the quotation marks) inside the first set
# of parentheses. If your dependent variable were coded 0, 1, 2 instead of 1, 2,
# 3, you would need to edit the code, replacing each instance of 1 with 0, 2
# with 1, and so on. Inside the sf function we find the qlogis function, which
# transforms a probability to a logit. So, we will basically feed probabilities
# of apply being greater than 2 or 3 to qlogis, and it will return the logit
# transformations of these probabilites. Inside the qlogis function we see that
# we want the log odds of the mean of y >= 2. When we supply a y argument, such
# as apply, to function sf, y >= 2 will evaluate to a 0/1 (FALSE/TRUE) vector,
# and taking the mean of that vector will give you the proportion of or
# probability that apply >= 2.
#
# The second command below calls the function sf on several subsets of the data
# defined by the predictors. In this statement we see the summary function with
# a formula supplied as the first argument. When R sees a call to summary with a
# formula argument, it will calculate descriptive statistics for the variable on
# the left side of the formula by groups on the right side of the formula and
# will return the results in a nice table. By default, summary will calculate
# the mean of the left side variable. So, if we had used the code
# summary(as.numeric(apply) ~ pared + public + gpa) without the fun argument, we
# would get means on apply by pared, then by public, and finally by gpa broken
# up into 4 equal groups. However, we can override calculation of the mean by
# supplying our own function, namely sf to the fun= argument. The final command
# asks R to return the contents to the object s, which is a table.

sf <- function(y) {
    c('Y>=1' = qlogis(mean(y >= 1)),
      'Y>=2' = qlogis(mean(y >= 2)),
      'Y>=3' = qlogis(mean(y >= 3)))
}

(s <- with(responses_logistic, summary(as.numeric(F14b_CarSucc_f) ~ 
                                  Age + Seniority + Educ + TotSal + TotDeps + 
                                  Marital, fun=sf)))

# We can use the values in this table to help us assess whether the proportional
# odds assumption is reasonable for our model. [See webpage for more explanation].
plot(s, which=1:3, pch=1:3, xlab='logit', main=' ', xlim=c(-3, 3))

m_carsuc <- lm(F14b_CarSucc ~ Age + Seniority + Marital + 
                   Educ + TotDeps + TotSal, 
               data = responses_logistic)
summary(m_carsuc)


# Explore relationship graphically ----------------------------------------

# This is a good plot, showing distribution of behind/on/ahead of schedule by
# seniority (director to supervisor) separately for each age group.
responses_logistic %>% ggplot() +
    geom_bar(aes(x = Seniority_f, fill = F14b_CarSucc_f)) +
    facet_wrap(~ Age_f) +
    theme(axis.text.x = element_text(angle = 30, vjust = 1, hjust = 1)) +
    labs(x = "Job Seniority", y = "Frequency", fill = "Career\nSuccess") +
    labs(title = "Self-Rated Career Success vs Seniority (Grouped by Age)")

# Same as above, but with horizontal bar plots:
responses_logistic %>% ggplot() +
    geom_bar(aes(x = Seniority_f, fill = F14b_CarSucc_f)) +
    facet_wrap(~ Age_f) +
    labs(x = "Job Seniority", y = "Frequency", fill = "Career\nSuccess") +
    labs(title = "Self-Rated Career Success vs Seniority (Grouped by Age)") +
    coord_flip()

responses_logistic %>% 
    ggplot(aes(Seniority_f, F14b_CarSucc_f, colour = Age_f)) +
    geom_jitter(size = 4, height = .2, width = .2, alpha= .6)
# could include shape = as.factor(TotDeps) in aes, but doesn't show many differences.

responses_logistic %>% ggplot() +
    geom_bar(aes(x = F14b_CarSucc_f, fill = Age_f),
             position = "fill")
    
responses_logistic %>% ggplot() +
    geom_bar(aes(x = F14b_CarSucc_f, fill = Age_f),
             position = "dodge")  

responses_logistic %>% ggplot() +
    geom_bar(aes(x = F14b_CarSucc_f, fill = Age_f),
             position = "dodge") +
    facet_wrap(~ TotDeps)

responses_logistic %>% ggplot() +
    geom_bar(aes(x = F14b_CarSucc_f, fill = Age_f),
             position = "dodge") +
    facet_wrap(~ Seniority_f)

mpg %>% ggplot(mapping = aes(x=displ, y= hwy)) + 
    geom_point(mapping = aes(colour = class)) + 
    geom_smooth(
        data = filter(mpg, class == "subcompact"), se = FALSE
    )
