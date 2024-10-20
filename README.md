# Análisis de Expresión Diferencial - Proyecto PRJNA156363

Este repositorio contiene el análisis de expresión diferencial utilizando datos de 6 librerías de genes de *Arabidopsis thaliana* del proyecto [PRJNA156363](https://www.ebi.ac.uk/ena/browser/view/PRJNA156363?show=reads). Los datos fueron preprocesados y mapeados previamente con *Kallisto*. El objetivo de este análisis es realizar la cuantificación de la expresión diferencial a partir de los recuentos obtenidos.

## Datos de Entrada

Se han obtenido los 6 ficheros con los recuentos de las 6 librerías de genes de *Arabidopsis* que servirán como entrada para esta tarea. Los ficheros de recuento fueron generados a partir de las siguientes librerías:

| Librería                         | Condición |
|----------------------------------|-----------|
| SRR392118.fastq.sample.fastq     | Ler       |
| SRR392119.fastq.sample.fastq     | Ler       |
| SRR392120.fastq.sample.fastq     | Ler       |
| SRR392121.fastq.sample.fastq     | Ler       |
| SRR392122.fastq.sample.fastq     | C24       |
| SRR392123.fastq.sample.fastq     | C24       |

## Instrucciones

1. **Modificar el fichero de configuración**: Actualiza el fichero de configuración para leer los ficheros de salida de *Kallisto* obtenidos en la tarea 3.2.
   
2. **Definir condiciones experimentales**: Las muestras corresponden a réplicas biológicas, y se definen las siguientes condiciones experimentales:
   - *Ler*: SRR392118, SRR392119, SRR392120, SRR392121
   - *C24*: SRR392122, SRR392123

3. **Análisis de Expresión Diferencial**: Utiliza el mejor método visto en clase para realizar el análisis de expresión diferencial. Asegúrate de eliminar el código innecesario del script **RNAseqHAB** que no sea relevante para esta tarea.

4. **Subir los archivos**: 
   - Comprime y sube un archivo que contenga:
     - Todos los ficheros de código R y Rmd necesarios para ejecutar el análisis.
     - El HTML resultante con los resultados obtenidos.
     - El HTML con el balance de cambios.

## Balance de Cambios

En el HTML con el balance de cambios, responde a las siguientes preguntas:

- ¿Hay alguna librería que te haga sospechar que no es lo que se espera o que podría dar resultados poco fiables?
- ¿Has modificado el valor por defecto de `MIN_CPM` porque las librerías tienen pocas lecturas? ¿Por qué?
- ¿El número de genes obtenido en la expresión diferencial es lo esperable en función de lo obtenido de las gráficas PCA o MDS?

---

Este trabajo fue realizado con **M. Gonzalo Claros** de guía. [Perfil en Google Scholar](https://scholar.google.es/citations?user=WtvKUvMAAAAJ).
