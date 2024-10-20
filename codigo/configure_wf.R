# configure_wf for RSeqHAB
# Gonzalo Claros
# 2024-10-10

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# NO TOCAR: ARRANQUE LIMPIO ####
#
rm(list=ls())    # Borra las variables de la RAM
gc()             # garbage collection; libera la RAM disponible
graphics.off()   # cierra todos los gráficos abiertos
# ////////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# DALE UN NOMBRE AL PROYECTO ####
#
# Será el nombre que aparecerá en el título del informe final
#
# Example:
#   PROJECT_NAME <- "Un análisis del cáncer de mama del ratón"

PROJECT_NAME <- "Cáncer de mama en los ratones"
# //////////////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# RUTA A LA CARPETA QUE CONTIENE EL CÓDIGO ####
#
# Tendrás que poner la ruta (path) a la carpeta "RNAseqHAB" en tu ordenador
# No olvides acabarla con una "/"
# 
# Example:
#   SOURCE_DIR <- "~/usr/local/mycodingfiles/"

SOURCE_DIR <- "~/Documents/MisScriptsR/HAB-RNAseq/"
# //////////////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# ¿SE VAN A ACTUALIZAR LOS PAQUETES? ####
#
# TRUE: se actualizarán ni no falta ningún paquete
# FALSE: no se actualizarán, solo se instalan los necesarios

PKG_UPDATE <- FALSE
# /////////////////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# ¿QUIERES OBTENER EL INFORME COMPLETO? ####
#
# TRUE: se ejecutarán todos los Rmd para obtener el HTML final
# FALSE: solo se ejecutarán los Rmd más relevantes

VERBOSE_MODE <- TRUE
# //////////////////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# PATH TO DATA-CONTAINING DIRECTORY ####
#
# Tendrás que poner la ruta (path) a la carpeta de tu ordenador
# donde estés los datos que vas a analizar
# No olvides acabarla con una "/"
#
# Example:
#   DATA_DIR <- "~/Documents/My_MA_data/this_experiment/"

DATA_DIR <- "~/prueba/Rseq_Mouse/"
# //////////////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# LOAD YOUR EXPRESSION DATA AND EXPERIMENT ####
#
# Files containing expression data must be in csv or tsv format
# If you define 1 file, it is a table containing all experimental counts
# If you define several files to read, they must be used to mount
#    the experimental data table
#

# define every expresion count table
DATA_FILES <- c("GSM1545538_purep53.txt",
               "GSM1545539_JMS8-2.txt",
               "GSM1545542_JMS8-5.txt",
               "GSM1545535_10_6_5_11.txt", 
               "GSM1545541_JMS8-4.txt",
               "GSM1545545_JMS9-P8c.txt",
               "GSM1545536_9_6_5_11.txt", 
			         "GSM1545540_JMS8-3.txt", 
			         "GSM1545544_JMS9-P7c.txt")

# define the removable initial part of each file 'name'
CHARS_TO_REMOVE <- 11 # the 11 first chars of all file names will be removed.

# define columns to read from each file
# in Mouse case, col1 contains the ID, col3 contains counts
COLUMNS_TO_READ <- c(1,3)

# if you have the expression table, use
# DATA_FILES <- "mouseBreast_raw_counts2.tsv"
# this list is required in such a case
OTHER_DATA <- list(IDs = "GeneCode", firstCol = 1, lastCol = 6)
# ///////////////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# DEFINE LOS FACTORES (CONDICIONES) EXPERIMENTALES ####
#
# define EVERY experimental condition to analyse. CTRL and TREAT are necessary

CTRL <- "Basal"
TREAT <- "LP"
TREAT2 <- "ML"
# ///////////////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# ASIGNA LAS CONDICIONES A LAS MUESTRAS (COLUMNAS) ####
#
# Define un vector con el factor que corresponde a cada columna de la tabla
#
#  Example: 
# EXP_CONDITIONS <- c(CTRL, CTRL, CTRL, TREAT, TREAT, TREAT, TREAT2, TREAT2, TREAT2)

# vector of factors corresponding to each file or column in DATA_FILES
EXP_CONDITIONS <-  c(rep(CTRL, 3), rep(TREAT, 3), rep(TREAT2,  3))
# ///////////////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# DEFINE LOS CONTRASTES A ANALIZAR ####
#
# Define las parejas de condiciones experimentales que se analizarán automáticamente
# Habrás de crear una variable por cada contraste y luego comprobar que las has 
# aañadido todas a la lista de contrastes
#
C1 <- c(TREAT, CTRL)
C2 <- c(TREAT2, TREAT)
C3 <- c(TREAT2, CTRL)

# Now, convert these contrasts in list with list(). Do not forget any one!
CONTRASTS <- list(C1, C2, C3)
# ///////////////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# THRESHOLD FOR MINIMUM CPM PER GENE ####
#
# You must specify the CPM (counts per million) threshold for a 
# minimal count value for a gene in each treatment. Margin: 0.5-10
# See more about this value in Law et al 2016 and Chen et al 2016.
#
# Example:
# MIN_CPM <- 1

MIN_CPM <- 0.5
# ///////////////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# THRESHOLD FOR FOLD-CHANGE ###
#
# You must specify the fold-change threshold (in absolute value) for a 
# spot signal to be considered as differentially expressed
# Using treat(), the FC should be low (2 is high)
#
# Example:
#   FC <- 2

FC <- 1.5
# /////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%%%
# THRESHOLD FOR P-VALUE ####
#
# You must specify the P-value threshold for a spot signal to be considered as
# significative. When FDR is used, P < 0.1 (FDR < 10%) can be appropriate
#
# Example:
#   P <- 0.01

P <- 0.05
# //////////////////////////





# %%%%%%%%%%%%%%%%%%%%%%%%%%%
# END CONFIGURATION FILE ####
# %%%%%%%%%%%%%%%%%%%%%%%%%%%

# %%%%%%%%%%%%%%%%%%%%%%%%%%
# %%%%%%%%%%%%%%%%%%%%%%%%%%
# DO NOT TOUCH THE FOLLOWING
# %%%%%%%%%%%%%%%%%%%%%%%%%%
# %%%%%%%%%%%%%%%%%%%%%%%%%%

# Determine interactivity to know if 'execute_RNAseqHAB.R' has to be sourced
INTERACTIVE_SESSION <- interactive()
if (INTERACTIVE_SESSION) {
	message("Ejecución interactiva: se cargará 'execute_wf.R'")
	fileToSource <- paste0(SOURCE_DIR, "execute_wf.R")
	# load the main executable R file
    source(fileToSource)
} else {
	message("La ejecución no continuará si no ejecutaste el flujo de trabajo como:\n")
	message("    Rscript execute_wf.R configure_wf.R\n")
}
