# Regression play


# Perceived Barriers to Advancement (Block e) -----------------------------

fit1 <- lm(formula= F10_Turnover ~ E1_CultFit + E2_Network + E3_Mentor + 
               E4_CarMgt + E5_DevAsst + E6_GeoMob, data=responses)


fit2 <- lm(formula=F10_Turnover ~ F2_MngCar + F3_Relships + F4_Mentor + 
               F5_DevAss + F6_ProcJust + F7_DistJust + F8_Empower + 
               F9_DevAss, data=responses)


fit3 <- lm(formula= F12_CareerSat ~ E1_CultFit + E2_Network + E3_Mentor + 
               E4_CarMgt + E5_DevAsst + E6_GeoMob, data=responses)

fit4 <- lm(formula=F12_CareerSat ~ F2_MngCar + F3_Relships + F4_Mentor + 
               F5_DevAss + F6_ProcJust + F7_DistJust + F8_Empower + 
               F9_DevAss, data=responses)


sink(file.path("output", "Regression Summaries.txt"))
cat("Multiple linear regression model - Turnover on Career Barriers:\n\n")
summary(fit1)
cat("Multiple linear regression model - Turnover on Career Facilitators:\n\n")
summary(fit2)
cat("Multiple linear regression model - Career Sat on Career Barriers:\n\n")
summary(fit3)
cat("Multiple linear regression model - Career Sat on Career Facilitators:\n\n")
summary(fit4)
sink()