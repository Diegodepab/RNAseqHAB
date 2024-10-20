# functions_wf
# Gonzalo Claros
# 2023-11-03


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# DETERMINING THE COMPUTER ####

GetComputer <- function(thisPlatform) {
    # determine computer for graphical functions
    if (grepl("linux", thisPlatform)) {
      comput <- "Linux"
    } else if (grepl("pc", thisPlatform)) { 
      comput <- "Windows"
    } else if (grepl("w64", thisPlatform)) { 
      comput <- "Windows64"
    } else if (grepl("apple", thisPlatform)) {
      comput <- "Mac" 
    } else {
      comput <- "Other" 
    }
    # .Platform and R.version are defined by the system
    return(paste0(comput, " - ", .Platform$OS.type))
}
# /////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# WORKING DIRECTORY DEFINITION ####

CreateDir <- function(adir = DATA_DIR,
					 aname = SOFT_NAME,
					 aversion = VERSION_CODE,
					 adate = HOY) {
	name.wd <- paste0(adir, aname, aversion, "_results_", adate, "/")
	
	if (file.exists(name.wd)){  # ¿existe el directorio ya?
		msg <- paste0("Directory '", name.wd, "' already existed")
	} else if (dir.create(name.wd)) {  # ¿he reado el directorio con éxito?
		msg <- paste0("Directory '", name.wd, "' created")
	} else {
		# no se puede crear el directorio, msg de error y abortar
		msg <- paste0(msg, "   Directory ", name.wd ," cannot be created in")
		msg <- paste0(msg, "   ", adir, "\n")
		stop(msg, call.=FALSE)
	}	
	message(msg)
	return(name.wd)
}
# /////////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%
# LOAD EXPRESSION DATA ####

LoadExpressionData <- function (files = DATA_FILES,
								dataDir = DATA_DIR,
								theFactors = EXP_FACTORS,
								colsToRead = COLUMNS_TO_READ,
								delims = OTHER_DATA,
								chars2rm = CHARS_TO_REMOVE) {
	if (length(files) == 1) {
		# only one file defined, therefore, is a complete counts table
		countsTable <- read.delim(paste0(dataDir, files), 
		                          row.names = delims$IDs, 
		                          quote = "")[, delims$firstCol:delims$lastCol]
		msg <- "a **single data table**"
		print(head(countsTable))
		counts_obj <- DGEList(counts = countsTable, 
		                      group = theFactors) 
	} else {
		# several files defined to construct the counts table
		counts_obj <- readDGE(files, 
		                      path = dataDir, 
		                      columns = colsToRead)
		# añadir información de los factores para la expresión diferencial
		msg <- "**several data files**"
		# completion of DGEList object with factors
		counts_obj$samples$group <- theFactors

		# recortar los nombres de las muestras de ratón para quitar 
		# el código de GEO y dejar solo el nombre de la muestra
		sample_names <- colnames(counts_obj)
		writeLines("*** Current sample names: ")
		print(sample_names)
		new_names <- substring(sample_names, chars2rm + 1, nchar(sample_names))
		colnames(counts_obj) <- new_names
		writeLines("have been simplified to: ")
		print(new_names)
	}

	# Complete DGElist object
	message("Counts from ", msg, " were read. The corresponding DGEList object was created")
	print(head(counts_obj$samples))
	
	return(counts_obj)
}
# //////////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%
# SAVE DATA IN TSV FORMAT ####

SaveTSV <- function(theDataTable, 
                    dataText,
                    adir = WD,
                    adate = HOY) {
	# create the file name to save in working directory
    fileName <- paste0(adir, dataText, adate, ".tsv" )

    # use col.names = NA to have an empty ID for row.names
    write.table(theDataTable, 
                file = fileName, 
                sep = "\t", 
                quote = FALSE,
                col.names = NA,
                row.names = TRUE)
    
    return(fileName)
}
# /////////////////////////////////////
          
          
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%
# CUSTOMISED PCA PLOT ####

PlotMyPCA <- function(datatable, 
                      titleText, 
                      thisScale = TRUE,  # raw data must set this to FALSE due to zeros or constant  values 
                      factorColors = EXP_COLORS) {
	pca <- prcomp(t(datatable), scale = thisScale, center = TRUE)
	pc_comp <- summary(pca)$importance
	pc1_contrib <- round(pc_comp[3, 1] * 100) 
	pc2_contrib <- round((pc_comp[3, 2] - pc_comp[3, 1]) * 100)

	plot(pca$x[, 1], pca$x[, 2], 
	     pch = ".", 
	     xlab = paste0(colnames(pc_comp)[1], " (", pc1_contrib, " %)"), 
	     ylab = paste0(colnames(pc_comp)[2], " (", pc2_contrib, " %)"),
	     main = titleText)
	text(pca$x[, 1], pca$x[, 2], 
	     col = factorColors, 
	     labels = colnames(datatable))
	     
	return(pc_comp)
}
# https://cran.r-project.org/web/packages/ggfortify/vignettes/plot_pca.html
# https://towardsdatascience.com/principal-component-analysis-pca-101-using-r-361f4c53a9ff
# https://www.geeksforgeeks.org/how-to-make-pca-plot-with-r/
# ////////////////////////////////

  

# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# PLOT GENE DENSITY DISTRIBUTION ####

PlotGeneDensity <- function(obj, 
                            thecutoff, 
                            atext, 
                            thenames = COL_NAMES) {
	nsamples <- ncol(obj)
	col <- brewer.pal(nsamples, "Paired")
    plot(density(obj[, 1]), 
      col = col[1], 
      lwd = 2, 
      # ylim = c(0, 0.26), # podría parametrizarse este máximo de 0.26
      las = 2, 
      main = atext, 
      xlab = "Log-cpm")
    abline(v = 0, lty = 3) # dotted line in CPM = 1
    abline(v = thecutoff, lty = 2) # dashed line for most filtered off genes
    for (i in 2:nsamples) {
       den <- density(obj[, i])
       lines(den$x, den$y, col = col[i], lwd = 2)
    }
    legend("topright", thenames, text.col = col, bty = "n")

}
# //////////////////////////////////


# %%%%%%%%%%%%%%%%%%%%%%%%%%%%
# CUSTOMISED VOLCANO PLOT ####

PlotMyVolcano <- function(x, y, 
                          theCols, titleText, 
                          Xlegend, Ylegend, 
                          lfc = logFC, 
                          pval = P) {
	plot(x, y, 
	     col = theCols, 
	     cex = 0.1,
	     main = titleText,
	     xlab = Xlegend,
	     ylab = Ylegend)
	abline(v = lfc, col = "cyan")
	abline(v = -lfc, col = "cyan")
	abline(h = -log10(pval), col = "red")
	text(x = 0, y = -log10(pval), "P-value", pos = 3, col = "red", cex = 0.5)
}
# ////////////////////////////////
