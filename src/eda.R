# library('ProjectTemplate')
# load.project()
# 
# for (dataset in project.info$data)
# {
#   message(paste('Showing top 5 rows of', dataset))
#   print(head(get(dataset)))
# }



# Generate df with only numeric vars for Nazim (PLS) ----------------------

# WCA_Numeric <- responses[sapply(responses,is.numeric)]
# write.csv(WCA_Numeric, file = "WCA_Numeric.csv")

# Scale Reliabilities -----------------------------------------------------

sink(file.path("output", "Scale psychometrics.txt")) # Send output to txt file
cat("Cronbach alpha for 7-point scales:\n")
print(scores_7$alpha, digits = 3)
cat("\n\nNumber of items in 7-point scales:\n")
scores_7$n.items
# scores_7$corrected
cat("\n\nCronbach alpha for 5-point scales:\n")
print(scores_5$alpha, digits = 3)
cat("\n\nNumber of items in 5-point scales:\n")
scores_5$n.items
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

     
     
 
# CFA ---------------------------------------------------------------------
CareerSE.model <- ' CareerSE =~ D3_1_Decn + D3_2_Grow + D3_3_Probs + D3_4_Chall '
CareerSE.fit <- cfa(CareerSE.model, data = responses)
summary(CareerSE.fit, fit.measures = TRUE)



Turnover.model <- ' Turnover =~ F10_1_Turnover + F10_2_Turnover + 
                    F10_3_Turnover + F10_4_Turnover '
Turnover.fit <- cfa(Turnover.model, data = responses)
summary(Turnover.fit, fit.measures = TRUE)

# Reverse Code JobSat items:
# JobSat.model <- ' JobSat =~"F11_1_JobSat", "F11_2_JobSat", "-F11_3_JobSat", 
#                "F11_4_JobSat", "-F11_5_JobSat"),

CareerSat.model <- ' CareerSat =~ F12_1_CareerSat + F12_2_CareerSat + F12_3_CareerSat + 
                     F12_4_CareerSat + F12_5_CareerSat '
CareerSat.fit <- cfa(CareerSat.model, data = responses)
summary(CareerSat.fit, fit.measures = TRUE)

# Look to use sink() to run all summaries into a text file
sink(file.path("output", "CFA Summaries.txt"))
# cat("Descriptives for 5-point scale items:\n")
# print(item.summaries5)
# cat("Descriptives for 7-point scale items:\n")
# print(item.summaries7)
sink()
