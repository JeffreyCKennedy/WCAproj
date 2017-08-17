Need to test following instructions - might need to run munging when starting a new
session. Check vars with names(responses). After munging, should be 237 vars
ending with "TotSal_f".

To run the analysis:
If there have been no changes to the original csv data files, then:
1.	Double click <WCAproj.Rproj> to open RStudio with correct working directory.
2.	Launch ProjectTemplate with munging off:
		library(ProjectTemplate)
		load.project(list(munging=FALSE))
3.	This will load packages, load the data etc. Now ready to run analyses.

If there have been changes to the original csv data files, then:
1.	Double click <WCAproj.Rproj> to open RStudio with correct working directory.
2.	Run \raw-data\import-raw-data.r. This will import the csv files, name variables, and save as a dataframe in 'data'.
3.	Launch ProjectTemplate:
		library(ProjectTemplate)
		load.project()
4.	This will load packages, and run the munging files (cleaning data, creating scale scores, etc). Now ready to run analyses.


raw-data folder contains the original csv files, and an R script "\raw-data\import-raw-data.r". Running this script will read in the csv files and assign the appropriate variable names. It then saves the resulting dataframe as "./data/responses.Rdata".

The R scripts in the munge folder run the following actions:
01-munge.R	Cleans data (e.g., dropping out invalid cases), recodes variables, creates a count of missing values etc.
02-munge.R	Counts missing values in items which are used to create scales. Some commented out script to plot missing values, select cases based on how much time people took to answer, etc.
03-munge.R	Creates scale scores, converts categorical responses to factors.

The R scripts in src folder do the actual analysis.
eda.R	Calculates scale psychometrics and item descriptives and outputs to text files in output folder. Also using this for CFA.
