# Análisis de Librerías de Genes de Arabidopsis - Proyecto PRJNA156363

Este repositorio contiene el código y los resultados del análisis bioinformático de 6 librerías de genes de *Arabidopsis thaliana* (proyecto [PRJNA156363](https://www.ebi.ac.uk/ena/browser/view/PRJNA156363?show=reads)). El análisis se llevó a cabo en la plataforma Galaxy e incluyó:

- **Preprocesamiento**: Utilizando *Fastp* para limpiar las lecturas de cada una de las librerías (<100,000 lecturas por librería).
- **Mapeo**: Las librerías preprocesadas fueron mapeadas de forma individual contra el transcriptoma *Arabidopsis thaliana* Col-0 TAIR 10 utilizando *Kallisto*.

## Herramientas Utilizadas

- **Galaxy**: Plataforma para la gestión y procesamiento de datos bioinformáticos.
- **Fastp**: Herramienta para el preprocesamiento y limpieza de secuencias.
- **Kallisto**: Software para cuantificación de abundancia en datos de RNA-Seq mediante pseudomapeo.

## Datos

Los datos de las librerías de genes utilizados en este análisis provienen del proyecto PRJNA156363, disponible en el [European Nucleotide Archive](https://www.ebi.ac.uk/ena/browser/view/PRJNA156363?show=reads).

## Puede acceder a la historia trabajada con galaxy en:

