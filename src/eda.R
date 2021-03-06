# library('ProjectTemplate')
# load.project()
# 

View(ScalesItems)

splom.scales <- responses %>% 
    select(one_of(c("E4_CarMgt", "E5_DevAsst", "F2_MngCar", "F5_DevAss", 
                    "F6_ProcJust", "F7_DistJust", "F12_CareerSat")))

pairs.panels(splom.scales)
corPlot(splom.scales, numbers = TRUE)

my_7_alpha <- round(as.data.frame(scores_7$alpha[,-1]), digits = 3)
sjt.df(my_7_alpha, 
       describe = FALSE, 
       title = "Alpha for 7-point Scales", 
       altr.row.col=TRUE,
       hide.progress = TRUE)
sjt.df(round(as.data.frame(scores_7$n.items[-1]), digits = 2), 
       describe = FALSE, 
       title = "Number of items in 7-point Scales", 
       altr.row.col=TRUE,
       hide.progress = TRUE)


# Use sjPlot to produce tables of frequencies -----------------------------

sjp.frq(responses$Age_f, title = "Age", type = "bar", show.na = TRUE)
sjp.frq(responses$Seniority_f, title = "Seniority", type = "bar", show.na = TRUE)
sjp.frq(responses$Educ_f, title = "Educ", type = "bar", show.na = TRUE)
sjp.frq(responses$TotSal_f, title = "Total Salary", type = "bar", show.na = TRUE)
sjp.frq(responses$WkHours_f, title = "WorkHours", type = "bar", show.na = TRUE)
sjp.frq(responses$TotDeps, title = "N of Dependents", type = "bar", show.na = TRUE)

# Can also use skimr to produce one-line summaries of non-factor versions:
skim(responses, Age, Seniority, Educ, TotSal, WkHours, TotDeps)


# Generate df with only numeric vars for Nazim (PLS) ----------------------

# WCA_Numeric <- responses[sapply(responses,is.numeric)]
# write.csv(WCA_Numeric, file = "WCA_Numeric.csv")

# Scale Reliabilities -----------------------------------------------------

sink(file.path("output", "Scale psychometrics.txt")) # Send output to txt file
cat("Cronbach alpha for 7-point scales:\n")
round(scores_7$alpha[,-1], digits = 2) # [-1] removes ID 
cat("\n\nNumber of items in 7-point scales:\n")
scores_7$n.items[-1]
# scores_7$corrected
cat("\n\nCronbach alpha for 5-point scales:\n")
round(scores_5$alpha[,-1], digits = 2)
cat("\n\nNumber of items in 5-point scales:\n")
scores_5$n.items[-1]
# scores_5$corrected
sink()

# Item Descriptives -------------------------------------------------------

options("max.print" = 2000) # So can print all item summaries later
item.summaries5 <- responses %>% select(one_of(itemsused_5)[-1]) %>% describe()
item.summaries7 <- responses %>% select(one_of(itemsused_7)[-1]) %>% describe()
# first variable is ID, so [-1] drops this out. 
sink(file.path("output", "Item Descriptives.txt"))
     cat("Descriptives for 5-point scale items:\n")
     cat("NOTE: Total N for sample is :", max(responses$ID), "\n")
     print(item.summaries5)
     cat("Descriptives for 7-point scale items:\n")
     print(item.summaries7)
     sink()


# Correlations ------------------------------------------------------------

# num.responses <- responses[ , purrr::map_lgl(responses, is.numeric)]
# names(num.responses)
# correlations <- corr.test(num.responses, use = "pairwise", method = "pearson")
# corr.test(responses$F10_Turnover, responses$F12_CareerSat, use = "pairwise", method = "pearson")

corr.vars <- responses %>% select(one_of(c("F10_Turnover","F12_CareerSat")))
corr.test(corr.vars, use = "pairwise", method = "pearson")
    
