# Análisis Funcional de Genes

Este trabajo es parte de mi proceso de aprendizaje en la asignatura de **Herramientas y Algoritmos en Bioinformática**. En este análisis, me basaré en el código de mi profesor **Moya García Aurelio**, cuyo perfil en GitHub es [amoyag](https://github.com/amoyag).

## TAREA

Cargue un script de Python o un Jupyter Notebook que incluya una implementación detallada de un análisis funcional de los genes **COX4I2**, **ND1** y **ATP6**. El análisis utiliza bibliotecas de Python para evaluar los procesos biológicos asociados con estos genes. Asegúrese de que su código esté bien documentado y describa claramente los métodos y las bases de datos utilizados para obtener información funcional, conforme a la rúbrica de evaluación.

## Introducción al Análisis Funcional en Bioinformática

El análisis funcional es fundamental para comprender las funciones biológicas de los genes y sus productos. Este trabajo emplea varias bibliotecas de Python, que se detallarán a continuación:

### Librerías Utilizadas

1. **Biopython**: Utilizada para realizar tareas de bioinformática, incluyendo la manipulación de secuencias biológicas y el acceso a bases de datos biológicas.
   
2. **GOATOOLS**: Permite realizar análisis de enriquecimiento funcional utilizando términos de ontología genética (Gene Ontology, GO), ayudando a identificar procesos biológicos significativos asociados con los genes de interés.
   
3. **Enrichr**: Una herramienta en línea para el análisis de enriquecimiento que permite evaluar listas de genes en múltiples bibliotecas de conjuntos de genes.
   
4. **STRINGdb**: Proporciona información sobre interacciones entre proteínas, lo que permite explorar redes funcionales y asociaciones entre los genes analizados.

## Ejecución del Código

Para ejecutar el análisis, asegúrese de tener instaladas las bibliotecas necesarias. Puede instalar las dependencias requeridas utilizando pip:
