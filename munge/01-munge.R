# Data manipulations
# Highlight and run command below to load project without munging.
# This is useful when debugging data manipulation code.
# rm(list = ls()); library(ProjectTemplate); load.project(list(munging=FALSE)) 

# It is often useful to create sets of variable names
# By convention, the list that stores these variable sets is called 'v'
# v <- names()


# Consider reverse coded items - for calculating reliability
# the keys parameter can be used (psych package). If some
# of the items will be analysed on their own, may need to recode
# and flag them in some way.

# names(df)  # lists all the variable names with column numbers, so can reference by number.


# Bring in the csv showing all scales and items ---------------------------

ScalesItems <- read_csv(here("data/ScalesItems.csv"))
# View(ScalesItems)

# Data Cleaning -----------------------------------------------------------


# Select out all vars beginning with X (headings etc).
# Select out D1_7, C5_8, E6_8, H1_8 (No info, relates to 'other' text comment)
# Select out H12_Email (email address)
# Prob others can be dropped - ResponseSet etc.

responses <- responses %>% 
     select(-starts_with("X")) %>% 
     select(-ends_with("D1_7_Barrier")) %>% 
     select(-ends_with("C5_8_CarAdv")) %>% 
     select(-ends_with("E6_8_GeogMob")) %>% 
     select(-ends_with("H1_8_OrgFacil")) %>% 
	 select(-H12_Email) %>%
     filter(ResponseID != "R_3GvvOBTj4XHfyeM") %>% 
     filter(ResponseID != "R_RKpGHXWPmVQx3Sp") %>% 
     filter(ResponseID != "R_2sbE1CxaFo6uCCG") %>% 
     mutate(TotDeps = Deps0_5 + Deps5_10 + Deps11_18 + Deps19_30 + 
                       DepsOther) %>% 
    mutate(MinsTaken = (interval(StartDate, EndDate)) / dminutes(1))



# Recode weird values in items - editing changes to Qualtrics survey
# means that some scales had gaps (e.g., 1-4, 6 instead of 1-5)
responses$C2_1_WLB <- car::recode(responses$C2_1_WLB,"13=1 ; 14=2 ; 15=3 ; 16=4 ; 17=5; else=NA")
responses$C2_2_WLB <- car::recode(responses$C2_2_WLB,"13=1 ; 14=2 ; 15=3 ; 16=4 ; 17=5; else=NA")
responses$C2_3_WLB <- car::recode(responses$C2_3_WLB,"13=1 ; 14=2 ; 15=3 ; 16=4 ; 17=5; else=NA")
responses$C2_4_WLB <- car::recode(responses$C2_4_WLB,"13=1 ; 14=2 ; 15=3 ; 16=4 ; 17=5; else=NA")
responses$C2_5_WLB <- car::recode(responses$C2_5_WLB,"13=1 ; 14=2 ; 15=3 ; 16=4 ; 17=5; else=NA")
responses$C3_Aspire <- car::recode(responses$C3_Aspire,"1=1 ; 2=2 ; 3=3 ; 4=4 ; 5=5 ; 6=6 ;
                                   8=7 ; 9=8 ; 7=9 ; 10=10 ; else=NA")
responses$C6_PrimCareResp <- car::recode(responses$C6_PrimCareResp, "1=1 ; 8=2 ; 9=3 ;10=4 ; 11=5 ; 12=6 ;
                                   13=7 ; 14=8 ; else=NA")
responses$D1_1_Barrier <- car::recode(responses$D1_1_Barrier,"13=1 ; 18=2 ; 14=3 ; 15=4 ; 16=5; else=NA")
responses$D1_2_Barrier <- car::recode(responses$D1_2_Barrier,"13=1 ; 18=2 ; 14=3 ; 15=4 ; 16=5; else=NA")
responses$D1_5_Barrier <- car::recode(responses$D1_5_Barrier,"13=1 ; 18=2 ; 14=3 ; 15=4 ; 16=5; else=NA")
responses$D1_6_Barrier <- car::recode(responses$D1_6_Barrier,"13=1 ; 18=2 ; 14=3 ; 15=4 ; 16=5; else=NA")
responses$D1_8_Barrier <- car::recode(responses$D1_8_Barrier,"13=1 ; 18=2 ; 14=3 ; 15=4 ; 16=5; else=NA")
responses$E4_1_CarMgt <- car::recode(responses$E4_1_CarMgt,"1=1 ; 2=2 ; 3=3 ; 4=4 ; 6=5; else=NA")
responses$E4_2_CarMgt <- car::recode(responses$E4_2_CarMgt,"1=1 ; 2=2 ; 3=3 ; 4=4 ; 6=5; else=NA")
responses$E4_3_CarMgt <- car::recode(responses$E4_3_CarMgt,"1=1 ; 2=2 ; 3=3 ; 4=4 ; 6=5; else=NA")
responses$F14a_1_CarSucc <- car::recode(responses$F14a_1_CarSucc,"1=1 ; 3=2 ; 4=3 ; 5=4 ; 6=5; 7=6; 8=7; else=NA")
responses$F14a_2_CarSucc <- car::recode(responses$F14a_2_CarSucc,"1=1 ; 3=2 ; 4=3 ; 5=4 ; 6=5; 7=6; 8=7; else=NA")
responses$F14a_3_CarSucc <- car::recode(responses$F14a_3_CarSucc,"1=1 ; 3=2 ; 4=3 ; 5=4 ; 6=5; 7=6; 8=7; else=NA")
# C5 asks if people willing to do certain things to advance their career (yes, maybe, no, don't know).
# 8th item is 'other'; The more of the first 7 items endorsed as yes (or maybe), the more ambitious
# the person is to advance. Recode so that 'yes' becomes '2', 'maybe' is '1', and no & don't know are 0.
responses$C5_1_CarAdv <- car::recode(responses$C5_1_CarAdv,"1=2 ; 2=1 ; 3=0 ; 4=0 ; else=NA")
responses$C5_2_CarAdv <- car::recode(responses$C5_2_CarAdv,"1=2 ; 2=1 ; 3=0 ; 4=0 ; else=NA")
responses$C5_3_CarAdv <- car::recode(responses$C5_3_CarAdv,"1=2 ; 2=1 ; 3=0 ; 4=0 ; else=NA")
responses$C5_4_CarAdv <- car::recode(responses$C5_4_CarAdv,"1=2 ; 2=1 ; 3=0 ; 4=0 ; else=NA")
responses$C5_5_CarAdv <- car::recode(responses$C5_5_CarAdv,"1=2 ; 2=1 ; 3=0 ; 4=0 ; else=NA")
responses$C5_6_CarAdv <- car::recode(responses$C5_6_CarAdv,"1=2 ; 2=1 ; 3=0 ; 4=0 ; else=NA")
responses$C5_7_CarAdv <- car::recode(responses$C5_7_CarAdv,"1=2 ; 2=1 ; 3=0 ; 4=0 ; else=NA")


# Recode reverse scored variables -----------------------------------------

# Note: need to do this here, after the above recoding has been carried out.
# In future, consider naming original variable with suffix r, and dropping
# the r for the recoded variable. Makes it easier to use 'ends_with' to select
# subsets of variables.

responses <- responses %>% 
    mutate(C2_1_WLBr = 6 - C2_1_WLB) %>% 
    mutate(C2_3_WLBr = 6 - C2_3_WLB) %>% 
    mutate(C2_4_WLBr = 6 - C2_4_WLB) %>% 
    mutate(C2_5_WLBr = 6 - C2_5_WLB) %>% 
    mutate(F6_2_ProcJustr = 6 - F6_2_ProcJust) %>% 
    mutate(F6_3_ProcJustr = 6 - F6_3_ProcJust) %>% 
    mutate(F11_3_JobSatr = 6 - F11_3_JobSat) %>% 
    mutate(F11_5_JobSatr = 6 - F11_5_JobSat)

#### Create count of missing responses in numeric vars ###
numericvars <- responses[sapply(responses,is.numeric)]
# Sum number of missing responses in each row.
Missing <- apply(numericvars, 1, function(x) sum(is.na(x)))
responses <- bind_cols(responses, as.data.frame(Missing))
# Note - bind_cols binds on position, not a key variable, but should be safe here.


