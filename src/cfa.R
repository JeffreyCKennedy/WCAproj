
# Create and run Lavaan model statementa ----------------------------------

# Drops the C2_ prefix, leaving WLB etc for cfa syntax. Keeps it simpler
cfanames <- map(names(keys.list_5[-1]), .f = ~ str_split(.x, "_")[[1]][2])
# Creates the model syntax
modelstmts <- glue('{cfanames} =~ {map(keys.list_5[-1], .f = ~ 
                   collapse(.x, sep = " + "))}')
# Next step - get fit objects for each model
fitoutput <- map(modelstmts, .f = ~ cfa(.x, data = responses))
# Put everything in a tibble
lm.output <- tibble(name = cfanames,
                    model = modelstmts,
                    fitoutput = fitoutput)

lm.output[["fitoutput"]]

lm.output <- lm.output %>% 
    mutate(chisq = map_dbl(fitoutput, ~ fitMeasures(.x, "chisq"))) %>% 
    mutate(df = map_dbl(fitoutput, ~ fitMeasures(.x, "df"))) %>% 
    mutate(cfi = map_dbl(fitoutput, ~ fitMeasures(.x, "cfi"))) %>% 
    mutate(rmsea = map_dbl(fitoutput, ~ fitMeasures(.x, "rmsea"))) %>% 
    mutate(srmr = map_dbl(fitoutput, ~ fitMeasures(.x, "srmr")))

lm.output %>% View()

# map(lm.output$fitoutput, ~ summary(.x))
# map(names(lm.output), ~ print(lm.output[[.x]]))

# CFA ---------------------------------------------------------------------

C2_WLB.model <- ' WLB =~ C2_1_WLBr + C2_2_WLB + C2_3_WLBr + C2_4_WLBr + C2_5_WLBr '
C2_WLB.fit <- cfa(C2_WLB.model, data = responses)
D1_PersCirc.model <- ' PersCirc =~ D1_1_Barrier + D1_2_Barrier + D1_5_Barrier + D1_6_Barrier + D1_8_Barrier '
D1_PersCirc.fit <- cfa(D1_PersCirc.model, data = responses)
D2_Abilities.model <- ' Abilities =~ D2_1_Conf + D2_2_SE + D2_3_PubSpk + D2_4_IntPers + D2_5_IQ + D2_6_PersEffic + D2_7_PersEffect + D2_8_Tech '
D2_Abilities.fit <- cfa(D2_Abilities.model, data = responses)
D3_CareerSE.model <- ' CareerSE =~ D3_1_Decn + D3_2_Grow +D3_3_Probs + D3_4_Chall '
D3_CareerSE.fit <- cfa(D3_CareerSE.model, data = responses)
E1_CultFit.model <- ' CultFit =~ E1_1_CultFit + E1_2_CultFit + E1_3_CultFit + E1_4_CultFit + E1_5_CultFit + E1_6_CultFit + E1_7_CultFit '
E1_CultFit.fit <- cfa(E1_CultFit.model, data = responses)
# Network not identified - only 2 variables
# E2_Network.model <- ' Network =~ E2_1_Network + E2_2_Network '
# E2_Network.fit <- cfa(E2_Network.model, data = responses)
E3_Mentor.model <- ' Mentor =~ E3_1_Mentor + E3_2_Mentor + E3_3_Mentor + E3_4_Mentor '
E3_Mentor.fit <- cfa(E3_Mentor.model, data = responses)
E4_CarMgt.model <- ' CarMgt =~ E4_1_CarMgt + E4_2_CarMgt + E4_3_CarMgt '
E4_CarMgt.fit <- cfa(E4_CarMgt.model, data = responses)
E5_DevAsst.model <- ' DevAsst =~ E5_1_DevAsst + E5_2_DevAsst + E5_3_DevAsst + E5_4_DevAsst + E5_5_DevAsst + E5_6_DevAsst + E5_7_DevAsst '
E5_DevAsst.fit <- cfa(E5_DevAsst.model, data = responses)
E6_GeoMob.model <- ' GeoMob =~ E6_1_GeogMob + E6_2_GeogMob + E6_3_GeogMob '
E6_GeoMob.fit <- cfa(E6_GeoMob.model, data = responses)
F10_Turnover.model <- ' Turnover =~ F10_1_Turnover + F10_2_Turnover + F10_3_Turnover + F10_4_Turnover '
F10_Turnover.fit <- cfa(F10_Turnover.model, data = responses)
F11_JobSat.model <- ' JobSat =~ F11_1_JobSat + F11_2_JobSat + F11_3_JobSatr + F11_4_JobSat + F11_5_JobSatr '
F11_JobSat.fit <- cfa(F11_JobSat.model, data = responses)
F12_CareerSat.model <- ' CareerSat =~ F12_1_CareerSat + F12_2_CareerSat + F12_3_CareerSat + F12_4_CareerSat + F12_5_CareerSat '
F12_CareerSat.fit <- cfa(F12_CareerSat.model, data = responses)
F13_LifeSat.model <- ' LifeSat =~ F13_1_LifeSat + F13_2_LifeSat + F13_3_LifeSat + F13_4_LifeSat + F13_5_LifeSat '
F13_LifeSat.fit <- cfa(F13_LifeSat.model, data = responses)
F2_MngCar.model <- ' MngCar =~ F2_1_OwnCareer + F2_2_OwnCareer + F2_3_OwnCareer + F2_4_OwnCareer '
F2_MngCar.fit <- cfa(F2_MngCar.model, data = responses)
F3_Relships.model <- ' Relships =~ F3_1_Relships + F3_2_Relships + F3_3_Relships + F3_4_Relships '
F3_Relships.fit <- cfa(F3_Relships.model, data = responses)
F4_Mentor.model <- ' Mentor =~ F4_1_Mentor + F4_2_Mentor + F4_3_Mentor + F4_4_Mentor + F4_5_Mentor + F4_6_Mentor + F4_7_Mentor + F4_8_Mentor '
F4_Mentor.fit <- cfa(F4_Mentor.model, data = responses)
F5_DevAss.model <- ' DevAss =~ F5_1_DevAss + F5_2_DevAss + F5_3_DevAss + F5_4_DevAss '
F5_DevAss.fit <- cfa(F5_DevAss.model, data = responses)
F6_ProcJust.model <- ' ProcJust =~ F6_1_ProcJust + F6_2_ProcJustr + F6_3_ProcJustr + F6_4_ProcJust + F6_5_ProcJust '
F6_ProcJust.fit <- cfa(F6_ProcJust.model, data = responses)
F7_DistJust.model <- ' DistJust =~ F7_1_DistJust + F7_2_DistJust + F7_3_DistJust + F7_4_DistJust + F7_5_DistJust '
F7_DistJust.fit <- cfa(F7_DistJust.model, data = responses)
F8_Empower.model <- ' Empower =~ F8_1_Empower + F8_2_Empower + F8_3_Empower + F8_4_Empower '
F8_Empower.fit <- cfa(F8_Empower.model, data = responses)
F9_DevAss.model <- ' DevAss =~ F9_1_DevAss + F9_2_DevAss + F9_3_DevAss '
F9_DevAss.fit <- cfa(F9_DevAss.model, data = responses)


summary(C2_WLB.fit, fit.measures = TRUE, modindices = TRUE)
summary(D1_PersCirc.fit, fit.measures = TRUE, modindices = TRUE)
summary(D2_Abilities.fit, fit.measures = TRUE, modindices = TRUE)
summary(E1_CultFit.fit, fit.measures = TRUE, modindices = TRUE)
# summary(E2_Network.fit, fit.measures = TRUE, modindices = TRUE)
summary(E3_Mentor.fit, fit.measures = TRUE, modindices = TRUE)
summary(E4_CarMgt.fit, fit.measures = TRUE, modindices = TRUE)
summary(E5_DevAsst.fit, fit.measures = TRUE, modindices = TRUE)
summary(E6_GeoMob.fit, fit.measures = TRUE, modindices = TRUE)
summary(F2_MngCar.fit, fit.measures = TRUE, modindices = TRUE)
summary(F3_Relships.fit, fit.measures = TRUE, modindices = TRUE)
summary(F4_Mentor.fit, fit.measures = TRUE, modindices = TRUE)
summary(F5_DevAss.fit, fit.measures = TRUE, modindices = TRUE)
summary(F6_ProcJust.fit, fit.measures = TRUE, modindices = TRUE)
summary(F7_DistJust.fit, fit.measures = TRUE, modindices = TRUE)
summary(F8_Empower.fit, fit.measures = TRUE, modindices = TRUE)
summary(F9_DevAss.fit, fit.measures = TRUE, modindices = TRUE)
summary(F10_Turnover.fit, fit.measures = TRUE, modindices = TRUE)
summary(F11_JobSat.fit, fit.measures = TRUE, modindices = TRUE)
summary(F12_CareerSat.fit, fit.measures = TRUE, modindices = TRUE)
summary(D3_CareerSE.fit, fit.measures = TRUE, modindices = TRUE)
summary(F13_LifeSat.fit, fit.measures = TRUE, modindices = TRUE)


# Look to use sink() to run all summaries into a text file
sink(file.path("output", "CFA Summaries.txt"))
cat("CFA Fit for D3_Career Self Efficacy:\n\n")
summary(D3_CareerSE.fit, fit.measures = TRUE, modindices = TRUE)
cat("\n\n CFA Fit for F12_Career Satisfaction:\n\n")
summary(F12_CareerSat.fit, fit.measures = TRUE, modindices = TRUE)
cat("\n\n CFA Fit for F11_Job Satisfaction:\n\n")
summary(F11_JobSat.fit, fit.measures = TRUE, modindices = TRUE)
cat("\n\n CFA Fit for F13_Life Satisfaction:\n\n")
summary(F13_LifeSat.fit, fit.measures = TRUE, modindices = TRUE)
cat("\n\n CFA Fit for F10_Turnover:\n\n")
summary(F10_Turnover.fit, fit.measures = TRUE, modindices = TRUE)
sink()
