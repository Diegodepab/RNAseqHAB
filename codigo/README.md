# Análisis de Expresión Diferencial con el Script Modular RNASeqHAB

Este documento describe el análisis de expresión diferencial utilizando el script modular **RNASeqHAB**. A continuación se detallan las principales etapas y conceptos del proceso:

## Carga de Datos

El análisis comienza con la carga de los datos experimentales, que incluyen diferentes tipos de réplicas. Las réplicas son fundamentales para garantizar la reproducibilidad y precisión en los resultados.

## Definición de Factores

Se define un conjunto de **factores** que representan las **condiciones experimentales** bajo estudio. Estos factores permiten organizar y clasificar los datos, preparando el terreno para el análisis de expresión diferencial.

## Configuración y Ejecución de RNASeqHAB

Una vez definidos los factores, se procede a la **configuración y ejecución** del script RNASeqHAB. Este script modular es utilizado para realizar el análisis completo del RNA-Seq, desde la filtración de datos hasta la cuantificación de la expresión diferencial.

## Análisis del Informe

El informe generado incluye varias fases críticas:

- **Filtración de datos**: Se eliminan lecturas o genes con baja calidad o baja expresión.
- **Normalización**: Los datos son ajustados para permitir comparaciones precisas entre condiciones.
- **Expresión diferencial**: Identificación de genes que muestran diferencias significativas en sus niveles de expresión entre las condiciones experimentales.

## Representaciones Gráficas

El informe también incluye diversas **representaciones gráficas**, tales como gráficos de dispersión y diagramas de calor, que facilitan la interpretación visual de los resultados del análisis de expresión diferencial.

---

Este trabajo fue dado gracias a la tutela de **M. Gonzalo Claros**, cuyo perfil académico está disponible en [Google Scholar](https://scholar.google.es/citations?user=WtvKUvMAAAAJ), principal autor del código, aquí solo se usa el código para un dataset especifíco y se debe contabilizar los cambios
