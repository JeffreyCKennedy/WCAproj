
# Create Scales -----------------------------------------------------------

# This scale is formed by summing the number of actions respondent is
# willing to take to advance career.
responses <- responses %>% 
    mutate(C5_CarAdv = rowSums(subset(responses, select=C5_1_CarAdv:C5_7_CarAdv)))

# Need to create scales for 5-pt and 7-pt scales separately or else
# recoding won't work.

responses$ID <- c(1:length(responses$ResponseID)) # Numeric ID to help with creating scales
# In future, recode vars first so that don't need to use the minus sign in front
# of the variable name. This way, can use the lists of variable names in later
# procedures without having to edit. 

keys.list_5 <- list(ID=c("ID"),
                  C2_WLB = c("C2_1_WLBr", "C2_2_WLB", "C2_3_WLBr", "C2_4_WLBr", 
                             "C2_5_WLBr"),
                  D1_PersCirc = c("D1_1_Barrier", "D1_2_Barrier", "D1_5_Barrier",
                                 "D1_6_Barrier", "D1_8_Barrier"),
                  D2_Abilities = c("D2_1_Conf", "D2_2_SE", "D2_3_PubSpk", 
                                   "D2_4_IntPers", "D2_5_IQ", "D2_6_PersEffic", 
                                   "D2_7_PersEffect", "D2_8_Tech"),
                  E1_CultFit = c("E1_1_CultFit", "E1_2_CultFit", "E1_3_CultFit",
                                 "E1_4_CultFit","E1_5_CultFit", "E1_6_CultFit",
                                 "E1_7_CultFit"),
                  E2_Network = c("E2_1_Network", "E2_2_Network"),
                  E3_Mentor = c("E3_1_Mentor", "E3_2_Mentor", "E3_3_Mentor",
                                "E3_4_Mentor"),
                  E4_CarMgt = c("E4_1_CarMgt", "E4_2_CarMgt", "E4_3_CarMgt"),
                  E5_DevAsst = c("E5_1_DevAsst", "E5_2_DevAsst", "E5_3_DevAsst",
                                 "E5_4_DevAsst", "E5_5_DevAsst", "E5_6_DevAsst",
                                 "E5_7_DevAsst"),
                  E6_GeoMob = c("E6_1_GeogMob", "E6_2_GeogMob", "E6_3_GeogMob"),
                  F2_MngCar = c("F2_1_OwnCareer", "F2_2_OwnCareer", 
                                "F2_3_OwnCareer", "F2_4_OwnCareer"),
                  F3_Relships = c("F3_1_Relships", "F3_2_Relships", 
                                  "F3_3_Relships", "F3_4_Relships"),
                  F4_Mentor = c("F4_1_Mentor", "F4_2_Mentor", "F4_3_Mentor", 
                                "F4_4_Mentor", "F4_5_Mentor", "F4_6_Mentor", 
                                "F4_7_Mentor", "F4_8_Mentor"),
                  F5_DevAss = c("F5_1_DevAss", "F5_2_DevAss", "F5_3_DevAss", 
                                "F5_4_DevAss"),
                  F6_ProcJust = c("F6_1_ProcJust", "F6_2_ProcJustr", 
                                  "F6_3_ProcJustr", "F6_4_ProcJust", 
                                  "F6_5_ProcJust"),
                  F7_DistJust = c("F7_1_DistJust", "F7_2_DistJust", "F7_3_DistJust", 
                                  "F7_4_DistJust", "F7_5_DistJust"),
                  F8_Empower = c("F8_1_Empower", "F8_2_Empower", "F8_3_Empower", 
                                 "F8_4_Empower"),
                  F9_DevAss = c("F9_1_DevAss", "F9_2_DevAss", "F9_3_DevAss"),
                  F10_Turnover = c("F10_1_Turnover", "F10_2_Turnover", 
                                   "F10_3_Turnover", "F10_4_Turnover"),
                  F11_JobSat = c("F11_1_JobSat", "F11_2_JobSat", "F11_3_JobSatr", 
                                 "F11_4_JobSat", "F11_5_JobSatr"),
                  F12_CareerSat =c("F12_1_CareerSat", "F12_2_CareerSat", 
                                   "F12_3_CareerSat", "F12_4_CareerSat", 
                                   "F12_5_CareerSat")
                  )
# In future, use unlist() to create the itemsused_5 object unlist(keys.list_5, use.names = FALSE)
				  
itemsused_5 <- unlist(keys.list_5, use.names = FALSE)
				  
subset_responses_5 <- responses %>% dplyr::select(one_of(itemsused_5))
scores_5 <- scoreItems(keys.list_5, subset_responses_5, impute="none", min=1, max=5, digits = 2)
# add the new scale scores to responses using dplyr::left_join, matching by ID.
responses <- dplyr::left_join(responses, as.data.frame(scores_5$scores), by = "ID")

keys.list_7 <- list(ID=c("ID"), 
                    D3_CareerSE = c("D3_1_Decn", "D3_2_Grow", "D3_3_Probs", "D3_4_Chall"),
                    F13_LifeSat = c("F13_1_LifeSat", "F13_2_LifeSat", "F13_3_LifeSat", 
                                    "F13_4_LifeSat", "F13_5_LifeSat"),
                    F14a_CarSucc = c("F14a_1_CarSucc", "F14a_2_CarSucc", "F14a_3_CarSucc"))
itemsused_7 <- c("ID", "D3_1_Decn", "D3_2_Grow", "D3_3_Probs", "D3_4_Chall",
                 "F13_1_LifeSat", "F13_2_LifeSat", "F13_3_LifeSat", "F13_4_LifeSat", 
                 "F13_5_LifeSat", "F14a_1_CarSucc", "F14a_2_CarSucc", "F14a_3_CarSucc")
subset_responses_7 <- responses %>% dplyr::select(one_of(itemsused_7))
scores_7 <- scoreItems(keys.list_7, subset_responses_7, impute="none", min=1, max=7, digits = 2)
# add the new scale scores to responses using dplyr::left_join, matching by ID.
responses <- dplyr::left_join(responses, as.data.frame(scores_7$scores), by = "ID")


# Create factor variables from ethnic, marital, etc -----------------------


responses$Marital_f <- as.factor(responses$Marital)
levels(responses$Marital_f) <- c("Married", "Single", "Other")

responses$Ethnic_f <- as.factor(responses$Ethnic)
levels(responses$Ethnic_f) <- c("NZ European", "Maori", "Asian", "Pacific", 
                                "ME.LA.A", "Other")

responses$JobStatus_f <- as.factor(responses$JobStatus)
levels(responses$JobStatus_f) <- c("Permanent", "Temp.Contract", "Self-employed", 
                                   "Other")

responses$Seniority_f <- as.factor(responses$Seniority)
levels(responses$Seniority_f) <- c("Director", "ExecMgt", "SnrMgt", "MidMgt", 
                                   "1stLvlMgt", "Super", "Other", "None")

responses$Age_f <- as.factor(responses$Age)
levels(responses$Age_f) <- c("15-24", "25-34", "35-44", "45-54", "55-64", "65+")



responses$Educ_f <- as.factor(responses$Educ)
levels(responses$Educ_f) <- c("PhD", "Masters", "PG Dip", "Bachelor", "Dip/Cert",
                              "High School", "Other")

responses$C6_PrimCareResp_f <- as.factor(responses$C6_PrimCareResp)
levels(responses$C6_PrimCareResp_f) <- c("Spouse", "Other Family", "Paid Care", 
                                         "Friends", "Other", "It Depends", "Equal Share", "Me")

responses$C7_PrimRespHHold_f <- as.factor(responses$C7_PrimRespHHold)
# Note: noone answered '4' so leave out 'Friends' level
levels(responses$C7_PrimRespHHold_f) <- c("Spouse", "Other Family", "Paid Care", 
                                          "Friends", "Other", "It Depends", 
                                          "Equal Share", "Me")

responses$TotSal_f <- as.factor(responses$TotSal)
levels(responses$TotSal_f) <- c("Under $30k", "$30k-$50k", "$50k-$80k", 
                                "$80k-$100k", "$100k-$250k", "$250k-$500k", 
                                "Over $500k")

responses$WkHours_f <- as.factor(responses$WkHours)
levels(responses$WkHours_f) <- c("< 20 hrs", "20-29", "30-39", "40-49", "50-59", "60+")

