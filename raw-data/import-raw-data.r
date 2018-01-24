# JCK: Only need to run this file if the original data (csv files) change.
# This file reads in data, combines the two csv files, etc, then saves
# resulting dataframe in 'data'. From then on, when running load.project(),
# the responses.Rdata is automatically loaded, ready for further analysis.

library(ProjectTemplate); load.project(list(munging=FALSE, data_loading = FALSE))

folder <- file.path("raw-data")
datafile1 <- "20170628_Womens_Careers_and_Aspirations.csv"
datafile2 <- "20170628_Womens_Careers_and_Aspirations_2.csv"

# read_CSV in readr is better than R's built-in read.csv function; see Peng
# msdr.pdf p. 14.

# Nice info here on using the RStudio <Import Dataset> gui 
# for bringing in the csv file - creates syntax reflecting
# choices made. 
# https://support.rstudio.com/hc/en-us/articles/218611977-Importing-Data-with-RStudio

# Set up vector of variable names for use in the read_csv function.
varNames <- c("ResponseID", "ResponseSet", "Name", "ExtDataRef", "Email", 
              "IP_Add", "Status", "StartDate", "EndDate", "Finished", NA, 
              NA, NA, "Token", NA, "Marital", "Age", "WkHours", "JobStatus", 
              "JobStatTXT", "Deps0_5", "Deps5_10", "Deps11_18", "Deps19_30", 
              "DepsOther", NA, "JobTitle", "Seniority", "SeniorityTXT", 
              "Ethnic", "EthnicTXT", "Tenure", "Overseas", "Educ", "EducTXT", 
              "TotSal", "DirReps", "NinOrg", "OccGp", "Sector", "SectorTXT", 
              "NZRegion", "AKRegion", NA, "C1_1_ImpJob", "C1_2_ImpFam", 
              "C1_3_ImpLife", "C2_1_WLB", "C2_2_WLB", "C2_3_WLB", "C2_4_WLB", 
              "C2_5_WLB", "C3_Aspire", "C3_AspireTXT", "C4_AspChange", 
              "C4_AspChangeTXT", "C5_1_CarAdv", "C5_2_CarAdv", "C5_3_CarAdv", 
              "C5_4_CarAdv", "C5_5_CarAdv", "C5_6_CarAdv", "C5_7_CarAdv", 
              "C5_8_CarAdv", "C5_1_CarAdvTXT", "C6_PrimCareResp", 
              "C6_PrimCareRespTXT", "C7_PrimRespHHold", "C7_PrimRespHHoldTXT", 
              NA, "D1_1_Barrier", "D1_2_Barrier", "D1_5_Barrier", 
              "D1_6_Barrier", "D1_7_Barrier", "D1_7_BarrierTXT", "D1_8_Barrier",
              "D2_1_Conf", "D2_2_SE", "D2_3_PubSpk", "D2_4_IntPers", "D2_5_IQ", 
              "D2_6_PersEffic", "D2_7_PersEffect", "D2_8_Tech", "D3_1_Decn", 
              "D3_2_Grow", "D3_3_Probs", "D3_4_Chall", NA, "E1_1_CultFit", 
              "E1_2_CultFit", "E1_3_CultFit", "E1_4_CultFit", "E1_5_CultFit", 
              "E1_6_CultFit", "E1_7_CultFit", "E2_1_Network", "E2_2_Network", 
              "E3_1_Mentor", "E3_2_Mentor", "E3_3_Mentor", "E3_4_Mentor", 
              "E4_1_CarMgt", "E4_2_CarMgt", "E4_3_CarMgt", "E5_1_DevAsst", 
              "E5_2_DevAsst", "E5_3_DevAsst", "E5_4_DevAsst", "E5_5_DevAsst", 
              "E5_6_DevAsst", "E5_7_DevAsst", "E6_1_GeogMob", "E6_2_GeogMob", 
              "E6_3_GeogMob", "E6_4_GeogMob", "E6_5_GeogMob", "E6_6_GeogMob", 
              "E6_7_GeogMob", "E6_8_GeogMob", "E6_8_GeogMobTXT", "E7_Barriers", 
              NA, "F1_1_TrackRcd", "F2_1_OwnCareer", "F2_2_OwnCareer", 
              "F2_3_OwnCareer", "F2_4_OwnCareer", "F3_1_Relships", 
              "F3_2_Relships", "F3_3_Relships", "F3_4_Relships", "F4_1_Mentor", 
              "F4_2_Mentor", "F4_3_Mentor", "F4_4_Mentor", "F4_5_Mentor", 
              "F4_6_Mentor", "F4_7_Mentor", "F4_8_Mentor", "F5_1_DevAss", 
              "F5_2_DevAss", "F5_3_DevAss", "F5_4_DevAss", "F6_1_ProcJust", 
              "F6_2_ProcJust", "F6_3_ProcJust", "F6_4_ProcJust", 
              "F6_5_ProcJust", "F7_1_DistJust", "F7_2_DistJust", 
              "F7_3_DistJust", "F7_4_DistJust", "F7_5_DistJust", "F8_1_Empower",
              "F8_2_Empower", "F8_3_Empower", "F8_4_Empower", "F9_1_DevAss", 
              "F9_2_DevAss", "F9_3_DevAss", "F10_1_Turnover", "F10_2_Turnover", 
              "F10_3_Turnover", "F10_4_Turnover", "F11_1_JobSat", 
              "F11_2_JobSat", "F11_3_JobSat", "F11_4_JobSat", "F11_5_JobSat", 
              "F12_1_CareerSat", "F12_2_CareerSat", "F12_3_CareerSat", 
              "F12_4_CareerSat", "F12_5_CareerSat", "F13_1_LifeSat", 
              "F13_2_LifeSat", "F13_3_LifeSat", "F13_4_LifeSat", 
              "F13_5_LifeSat", NA, "F14a_1_CarSucc", "F14a_2_CarSucc", 
              "F14a_3_CarSucc", "F14b_CarSucc", "F14b_CarSuccTXT", NA, 
              "G1_AspST", "G2_AspLT", "G3_AspFactors", NA, NA, "H1_1_OrgFacil",
              "H1_2_OrgFacil", "H1_3_OrgFacil", "H1_4_OrgFacil", 
              "H1_5_OrgFacil", "H1_6_OrgFacil", "H1_7_OrgFacil", 
              "H1_8_OrgFacil", "H1_8_OrgFacilTXT", "H2_OrgDoMore", 
              "H3_OrgDoMoreTXT", "H4_1_Career_cfMen", "H4_2_Career_cfWom", 
              "H5_Recomm", "H6_RecommTXT", "H7_IncOrgPerf", "H8_IncOrgPerfTXT", 
              "H9_AddAnything", "H10_ParticInIv", "H11_GetCopy", "H12_Email", 
              NA, "Lat", "Long", "LocAcc", NA)

# I've specified column types for the Deps columns. Some people used 
# leading zeroes when entering number of dependents, and by default, 
# R treats these as characters. A leading zero in one datafile and not
# the other will result in different character formats, and the 
# bind function (for combining into one df) will fail.

data1 <- read_csv(file.path(folder, datafile1), 
                  col_names = varNames,
                  col_types = cols(StartDate = col_datetime(format = "%Y-%m-%d %H:%M:%S"), 
                                   EndDate = col_datetime(format = "%Y-%m-%d %H:%M:%S"),
                                   Deps0_5 = col_integer(), Deps5_10 = col_integer(), 
                                   Deps11_18 = col_integer(), Deps19_30 = col_integer(), 
                                   DepsOther = col_integer()), 
                  skip = 2)

data2 <- read_csv(file.path(folder, datafile2), 
                  col_names = varNames,
                  col_types = cols(StartDate = col_datetime(format = "%Y-%m-%d %H:%M:%S"), 
                                   EndDate = col_datetime(format = "%Y-%m-%d %H:%M:%S"),
                                   Deps0_5 = col_integer(), Deps5_10 = col_integer(), 
                                   Deps11_18 = col_integer(), Deps19_30 = col_integer(), 
                                   DepsOther = col_integer()), 
                  skip = 2)

# spec(data1) can be used to retrieve the class spec used on import.
# Now combine the datasets (.id parameter identifies which dataset each
# case comes from).
responses <- bind_rows(data1, data2, .id = "Source")
save(responses, file = "./data/responses.Rdata")

# Used following when trying to find out which variables were 
# different classes in the two datasets. Equalitytest will have 
# FALSE for vars which differ.
#
# class1 <- sapply(data1, class)
# class2 <- sapply(data2, class)
# classasvector <- unlist(class1)
# classasvector2 <- unlist(class2)
# equalitytest <- classasvector == classasvector2

