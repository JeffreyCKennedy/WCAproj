# Don't need to run this every time, but code here for future reference.


# Missing Values ----------------------------------------------------------

# dplyr::count(responses, Missing)

# Histogram showing numbers of missing values in each case

# ggplot(responses, aes(Missing)) + geom_histogram(fill = "blue", binwidth = 5) + 
        # labs(title = "N of Missing Values per Case") + 
        # labs(x = "N values Missing", y = "Frequency") +
        # ylim(c(0,700)) +
        # scale_x_continuous(breaks = seq(0, 200, by = 25))


# Short Time to Complete --------------------------------------------------

# ShortTime <- responses %>% 
        # select(ResponseID, Source, Missing, MinsTaken) %>% 
        # arrange(MinsTaken) %>% 
        # filter(MinsTaken <= 15)

# fast <- ShortTime$ResponseID
# testx <- responses %>% filter(!(ResponseID %in% fast))
# dplyr::count(testx, Missing)

# Following code selects cases that spent less than MinsTaken on the 
# questionnaire, but had fewer than 15 missing cases.
# checkout <- responses %>% filter(ResponseID %in% fast) %>%  filter(Missing < 15)
# checkout$ResponseID

# Following block explores missing values only in items comprising scales
ScaleVarNames <- c("ResponseID", "C2_1_WLB", "C2_2_WLB", 
               "C2_3_WLB", "C2_4_WLB", "C2_5_WLB", "D3_1_Decn", "D3_2_Grow", 
               "D3_3_Probs", "D3_4_Chall", "E1_1_CultFit", "E1_2_CultFit", 
               "E1_3_CultFit", "E1_4_CultFit", "E1_5_CultFit", "E1_6_CultFit", 
               "E1_7_CultFit", "E2_1_Network", "E2_2_Network", "E3_1_Mentor", 
               "E3_2_Mentor", "E3_3_Mentor", "E3_4_Mentor", "E4_1_CarMgt", 
               "E4_2_CarMgt", "E4_3_CarMgt", "E5_1_DevAsst", "E5_2_DevAsst", 
               "E5_3_DevAsst", "E5_4_DevAsst", "E5_5_DevAsst", "E5_6_DevAsst", 
               "E5_7_DevAsst", "E6_1_GeogMob", "E6_2_GeogMob", "E6_3_GeogMob", 
               "E6_4_GeogMob", "E6_5_GeogMob", "E6_6_GeogMob", "E6_7_GeogMob", 
               "F1_1_TrackRcd", "F2_1_OwnCareer", "F2_2_OwnCareer", 
               "F2_3_OwnCareer", "F2_4_OwnCareer", "F3_1_Relships", 
               "F3_2_Relships", "F3_3_Relships", "F3_4_Relships", 
               "F4_1_Mentor", "F4_2_Mentor", "F4_3_Mentor", "F4_4_Mentor", 
               "F4_5_Mentor", "F4_6_Mentor", "F4_7_Mentor", "F4_8_Mentor", 
               "F5_1_DevAss", "F5_2_DevAss", "F5_3_DevAss", "F5_4_DevAss", 
               "F6_1_ProcJust", "F6_2_ProcJust", "F6_3_ProcJust", 
               "F6_4_ProcJust", "F6_5_ProcJust", "F7_1_DistJust", 
               "F7_2_DistJust", "F7_3_DistJust", "F7_4_DistJust", 
               "F7_5_DistJust", "F8_1_Empower", "F8_2_Empower", "F8_3_Empower", 
               "F8_4_Empower", "F9_1_DevAss", "F9_2_DevAss", "F9_3_DevAss", 
               "F10_1_Turnover", "F10_2_Turnover", "F10_3_Turnover", 
               "F10_4_Turnover", "F11_1_JobSat", "F11_2_JobSat", "F11_3_JobSat", 
               "F11_4_JobSat", "F11_5_JobSat", "F12_1_CareerSat", 
               "F12_2_CareerSat", "F12_3_CareerSat", "F12_4_CareerSat", 
               "F12_5_CareerSat", "F13_1_LifeSat", "F13_2_LifeSat", 
               "F13_3_LifeSat", "F13_4_LifeSat", "F13_5_LifeSat", 
               "F14a_1_CarSucc", "F14a_2_CarSucc", "F14a_3_CarSucc", 
               "F14b_CarSucc")

ScaleVars <- responses %>% select(one_of(ScaleVarNames))
MissScalVars <- apply(ScaleVars, 1, function(x) sum(is.na(x)))
responses <- bind_cols(responses, as.data.frame(MissScalVars))
# dplyr::count(responses, MissScalVars)
# based on this analysis, looks like we should keep cases with 
# < 4 missing values (MissScalVars < 4).
# FinalVars <- responses %>% filter(MissScalVars < 4)
# But maybe should look at it on a scale by scale basis - some people may
# have left out one scale completely, others may have occasional missing
# values.

