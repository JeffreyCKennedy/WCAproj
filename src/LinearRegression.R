# Regression play


# Perceived Barriers to Advancement (Block e) -----------------------------

# Remove NA values (for vars used in regression) from dataset so that all
# regressions are on same M Use all.vars(model formula) to get a list of all
# vars to use in select.
vars1 <- all.vars(F10_Turnover ~ E1_CultFit + E2_Network + E3_Mentor + 
                E4_CarMgt + E5_DevAsst + E6_GeoMob)
vars2 <- all.vars(F10_Turnover ~ F2_MngCar + F3_Relships + F4_Mentor + 
                      F5_DevAss + F6_ProcJust + F7_DistJust + F8_Empower + 
                      F9_DevAss)

remove.na.vars <- c("ResponseID", vars1, vars2, "F12_CareerSat")

responses.nonmissing <- responses %>% select(one_of(remove.na.vars)) %>% 
    na.omit()


demog.vars <- responses %>% select(one_of("ResponseID", "Marital_f", "Ethnic_f", "JobStatus_f",
                                          "Seniority_f", "Age_f", "Educ_f", "TotSal_f",
                                          "WkHours_f", "TotDeps"))
# Add demog.vars back to dataframe, only where they match a case with no 
# missing values on the regression variables.
responses.used.in.lm <- inner_join(demog.vars, responses.nonmissing, by="ResponseID")

fit1 <- lm(formula= F10_Turnover ~ E1_CultFit + E2_Network + E3_Mentor + 
               E4_CarMgt + E5_DevAsst + E6_GeoMob, data=responses.used.in.lm)


fit2 <- lm(formula=F10_Turnover ~ F2_MngCar + F3_Relships + F4_Mentor + 
               F5_DevAss + F6_ProcJust + F7_DistJust + F8_Empower + 
               F9_DevAss, data=responses.used.in.lm)


fit3 <- lm(formula= F12_CareerSat ~ E1_CultFit + E2_Network + E3_Mentor + 
               E4_CarMgt + E5_DevAsst + E6_GeoMob, data=responses.used.in.lm)

fit4 <- lm(formula=F12_CareerSat ~ F2_MngCar + F3_Relships + F4_Mentor + 
               F5_DevAss + F6_ProcJust + F7_DistJust + F8_Empower + 
               F9_DevAss, data=responses.used.in.lm)


sink(file.path("output", "Regression Summaries.txt"))
cat("Multiple linear regression model - Turnover on Career Barriers:\n\n")
summary(fit1)
cat("N of observations: ", nobs(fit1))
cat("\n\nMultiple linear regression model - Turnover on Career Facilitators:\n\n")
summary(fit2)
cat("N of observations: ", nobs(fit2))
cat("\n\nMultiple linear regression model - Career Sat on Career Barriers:\n\n")
summary(fit3)
cat("N of observations: ", nobs(fit3))
cat("\n\nMultiple linear regression model - Career Sat on Career Facilitators:\n\n")
summary(fit4)
cat("N of observations: ", nobs(fit4))
sink()

sink(file.path("output", "Demographics for Sample used in Regression.txt"))
cat("Marital Status:\n")
table(responses.used.in.lm$Marital_f)
cat("\nEthnicity:\n")
table(responses.used.in.lm$Ethnic_f)
cat("\nJob Status:\n")
table(responses.used.in.lm$JobStatus_f)
cat("\nSeniority:\n")
table(responses.used.in.lm$Seniority_f)
cat("\nAge:\n")
table(responses.used.in.lm$Age_f)
cat("\nEcuation:\n")
table(responses.used.in.lm$Educ_f)
cat("\nTotal Salary:\n")
table(responses.used.in.lm$TotSal_f)
cat("\nWeekly Working Hours:\n")
table(responses.used.in.lm$WkHours_f)
cat("\nTotal Dependants:\n")
table(responses.used.in.lm$TotDeps)
sink()


                                   
