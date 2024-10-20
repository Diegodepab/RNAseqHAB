#!/usr/bin/env Rscript
#
# execute_wf
# Gonzalo Claros
# 2023-11-08
#
# Main file, invoked after source(configure_RNAseqHAB.R)
# Alternative usage from terminal: Rscript execute_RNAseqHAB.R aConfigFile.R 

T00 <- proc.time() # Initial time for elaspsed time

# %%%%%%%%%%%%%%%%%%%%%%%%%
# RETRIEVE ARGS if ANY ####
# %%%%%%%%%%%%%%%%%%%%%%%%%

## user ID in the computer ####
YO <- system("whoami", intern = TRUE)  # or Sys.info()[7]

# Default error messages
errMsg <- "RNAseqHAB must be launched as 'Rscript execute_wf.R aConfigFile.R'\n       or as 'source(configure_wf.R)'\n"

## by default, okMsg refers to sourcing the configuration file ####
okMsg <- "RNAseqHAB sourced as interactive from 'configure_wf.R'"

## retrieve inputs to the script when given ####
ARGS <- commandArgs(trailingOnly = TRUE) # Test if there is one input argument
if (length(ARGS) >= 1) { 
  # non interactive session with one argument that should be a config file
  message("ARGS ≥ 1: the argument will be treated as configuration file\n")
  # redefinition of okMsg for terminal execution
  okMsg <- paste0("RNAseqHAB was launched from terminal using ", ARGS[1], " as configuration file")
  # load the corresponding configuration parameters
  source(ARGS[1])
} else if (!(interactive())) {
  warning("No argument (configuration file) supplied\n")
  stop(errMsg, call.=FALSE)
} else if (!("MIN_CPM" %in% ls())) {
  stop(errMsg, call.=FALSE)
} else {
  message("The script may be reading VARIABLES from RAM instead of configuration file")
}

if (interactive()) {
	message("Estás en MODO INTERACTIVO")
} else {
	message("Ejecución desde la terminal")
}


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# SOME PARAMETER VERIFICATION ####
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

## verificación del directorio definido en DATA_DIR ####
if (!file.exists(DATA_DIR)) {
  msg <- paste0(" ** No existe el directorio ", DATA_DIR, 
                " indicado en la variable DATA_DIR para el usuario ", YO, " **\n")
  # salir del programa para arreglar el error
  stop(msg, call. = FALSE)
}

## checking other configuration values ####
theVar <- vector()
msg <- " Change it in configure_wf.R"
if (MIN_CPM < 0) theVar <- c(theVar, "MIN_CPM")
if (FC < 0) theVar <- c(theVar, "FC")
if (P < 0) theVar <- c(theVar, "P")
if (length(theVar) > 0) stop("\n   ", toString(theVar), " must be > 0.", msg)

if (P > 0.5) stop("\n   P-value ", P, " is too high.", msg)

# remove needless variable
rm(theVar)


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%
# LOAD LIBRARIES/PACKAGES ####
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%

fileToSource <- paste0(SOURCE_DIR, "libraries_wf.R")
source(fileToSource)


# %%%%%%%%%%%%%%%%%%%
# LOAD FUNCTIONS ####
# %%%%%%%%%%%%%%%%%%%

fileToSource <- paste0(SOURCE_DIR, "functions_wf.R")
source(fileToSource)

# remove useless variable
rm(fileToSource)


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# DECLARE USER-INDEPENDENT VARIABLES ####
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

## change this when you produce a main change ####
SOFT_NAME <- "RNAseqHAB"
VERSION_CODE <- "231108"

## información sobre la versión de R ####
VERSION_R <- R.Version()

## get computer type ####
COMPUTER <- GetComputer(VERSION_R$platform)
COMP_DETAILS <- system("uname -snmr", intern = TRUE)

## constante para personalizar el directorio de trabajo ####
HOY <- format(Sys.time(), "%F_%H.%M.%S")

## create working directory to save results ####
WD <- CreateDir(DATA_DIR, SOFT_NAME, VERSION_CODE)

## convert EXP_CONDITIONS into factors ####
EXP_FACTORS <-  factor(EXP_CONDITIONS)
COND_FREQ <- table(EXP_CONDITIONS)

## convert CONTRASTS list into the required vector of contrasts ####
i <- 1
allContrasts <- c()
# for (i in 1:length(CONTRASTS)) {
#   contrast_coef <- COND_FREQ[[CONTRASTS[[i]][2]]] / COND_FREQ[[CONTRASTS[[i]][1]]]
# 	allContrasts <- c(allContrasts, paste0(contrast_coef, 
# 	                                       "*", 
# 	                                       CONTRASTS[[i]][1], 
# 	                                       "-", 
# 	                                       CONTRASTS[[i]][2])
# 	                  )
# }
for (i in 1:length(CONTRASTS)) {
  allContrasts <- c(allContrasts, 
                    paste0(CONTRASTS[[i]][1], 
                           "-",
                           CONTRASTS[[i]][2])
  )
}

## set the log2 of fold-change ####
logFC <- log2(FC)


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# MAIN EXECUTION USING MARKDOWN ####
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

## Establece el directorio de trabajo ####
setwd(WD)
# setwd(paste0(getwd(), SOFT_NAME, VERSION_CODE))

## Lanza el informe con rmarkdown ####
cat("\n", "*** Creating markdown report ***", "\n")

# the Rmd file must be located with code
# loadRmd <- paste0(SOURCE_DIR, "Report_empty.Rmd")
loadRmd <- paste0(SOURCE_DIR, "Report_wf.Rmd")
# the resulting HTML should be be saved with the results, not with code
render(loadRmd, output_dir = WD, quiet = TRUE)

# %%%%%%%%%%%%%%%%%%
# END MAIN CODE ####
# %%%%%%%%%%%%%%%%%%

message(paste(SOFT_NAME, VERSION_CODE, "report successfully fihished."))
cat("\n", "*** Report and results saved in the new folder ***", "\n")
message(WD)

message("\nReal time taken by the current run: ", round(T_total[[3]]/60, digits = 3), " min")
print(T_total)





# future gene annotation using biomart:
# http://monashbioinformaticsplatform.github.io/RNAseq-DE-analysis-with-R/RNAseq_DE_analysis_with_R.html
# from RNA-seq mapped to genome:
# http://master.bioconductor.org/packages/release/workflows/html/rnaseqGene.html
# https://bioinformatics-core-shared-training.github.io/RNAseq-R/align-and-count.nb.html
