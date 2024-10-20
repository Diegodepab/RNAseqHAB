# libraries_wf
# Gonzalo Claros
# 2023-09-29

# obtén los paquetes que ya tienes instalados
# más detalles en https://www.r-bloggers.com/an-efficient-way-to-install-and-load-r-packages/
ya_instalado <- rownames(installed.packages())
# ya_instalado <- as.vector(installed.packages()[ , "Package"])

# %%%%%%%%%%%%%%%%%%%%%%
# Librerías de CRAN ####
# %%%%%%%%%%%%%%%%%%%%%%

## Define las librerías en vectores ####
writeLines("\n*** Comprobando las librerías de CRAN que hay que actualizar ***")
# define los paquetes que necesitas
libs_general <- c("ggplot2", "tidyverse", "ggpubr", "scales", "reshape2")
libs_diagramas_Venn <- c("ggvenn", "gplots", "VennDiagram", "grid", "futile.logger")
libs_Rmd <- c("knitr", "knitcitations", "rmarkdown", "markdown", "bibtex", "DT")
libs_anova <- "statmod"
libs_correlation <- c("igraph", "psych", "corrplot")

requeridoCRAN <- c(libs_general, 
                   libs_diagramas_Venn, 
                   libs_Rmd, 
                   libs_anova,
                   libs_correlation)
# elimina variables innecesarias
rm(libs_general, libs_diagramas_Venn, libs_Rmd, libs_anova, libs_correlation)

## Comprueba si hay que instalar librerías ausentes ####
# las librerías ausentes NO ESTARÁN en 'ya_instalado'
nuevos_CRAN <- requeridoCRAN[!(requeridoCRAN %in% ya_instalado)]

## Instala y actualiza librerías de CRAN ####
# instala los nuevos, siempre que el vector 'nuevos_CRAN' contenga algo
if (length(nuevos_CRAN)) {
  # instala los paquetes que no están
  install.packages(nuevos_CRAN, dependencies = TRUE)
  writeLines(paste("Following", length(nuevos_CRAN), "CRAN libraries were installed at\n    ", R.home()))
  writeLines(nuevos_CRAN, sep = ", ")
} else if (PKG_UPDATE) {
	update.packages(ask = FALSE, checkBuilt = TRUE)
} else {
	message("Everything is updated")
}

# Si no funciona el servidor de CRAN, descomenta la línea siguiente y elige uno nuevo;
# chooseCRANmirror()
# te sugiero el de USA, IN, que tiene las versiones más actualizadas

## Carga los paquetes ####
sapply(requeridoCRAN, require, character.only = TRUE)
# to remove the output when loading a package, since it is rarely useful
# lapply(requeridoCRAN, library, character.only = TRUE) %>% invisible() 

# borrar variables que no se volverán a usar
rm(requeridoCRAN, nuevos_CRAN)



# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Instalación o actualización de Bioconductor ####
# %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# https://www.bioconductor.org/install/

writeLines("\n*** Comprobando las librerías de Bioconductor ***")

## Comprueba si está BiocManager ####
# Comprueba si hay que instalar BiocManager antes de instalar BioConductor
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

# si no funcionara el servidor de descargas de Bioconductor, 
# cámbialo descomentando la línea siguiente
# chooseBioCmirror()

## Instalación o actualización de BiocManager ####
if (PKG_UPDATE) {
	BiocManager::install(ask = FALSE)  # instala lo básico
}

# Versión instalada:
VERSION_BIOC <- BiocManager::version()
 
## Vector con los paquetes necesarios ####
requerido_BioC <- c("edgeR", 
                    "limma", 
                    "gplots",
                    "RColorBrewer")

## Comprobar si faltan librerías ####
# ¿Qué falta por instalar? Lo que no esté en 'ya_instalado'
nuevos_BioC <- requerido_BioC[!(requerido_BioC %in% ya_instalado)]

## Instala y actualiza Bioconductor ####
# instala los nuevos, siempre que el vector 'nuevos_BioC' contenga algo
if (length(nuevos_BioC)) {
    # instala los paquetes que no están
    BiocManager::install(nuevos_BioC, ask = FALSE)
    writeLines(paste(sep = "", "Se INSTALARON ", length(nuevos_BioC), " librerías de BioConductor ", VERSION_BIOC))
    writeLines(nuevos_BioC, sep = ", ")
} else {
	message(paste(sep="", "BioConductor ", VERSION_BIOC, " ya estaba actualizado"))
}

## Carga las liberías ####
sapply(requerido_BioC, require, character.only = TRUE)

# eliminar variables innecesarias
rm(ya_instalado,
   requerido_BioC,
   nuevos_BioC)


message("Librarías actualizadas y cargadas\n")
