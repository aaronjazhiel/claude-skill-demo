# Datos para el reporte Word

El script requiere un JSON UTF-8 con este esquema:

```json
{
  "titulo": "Revisión de API de clientes",
  "contrato": "ejemplos/api-incompleta.json",
  "resumen": "Texto del análisis",
  "hallazgos": [
    {"prioridad": "Media", "tipo": "Información faltante",
     "hallazgo": "No se documenta paginación",
     "evidencia": "GET /clientes no declara parámetros",
     "recomendacion": "Confirmar y documentar límites y paginación"}
  ],
  "preguntas": ["¿La consulta tiene un límite de resultados?" ]
}
```

`hallazgos` y `preguntas` pueden estar vacíos. No rellenar con hallazgos ficticios.
Las cinco claves de cada hallazgo son obligatorias y deben contener texto.
Usar párrafos breves. El generador rechaza datos inválidos y no sobrescribe
un archivo existente; para reemplazarlo debes pasar `--sobrescribir`.
El encabezado, estilos y tamaño de página se heredan de la plantilla Word.
El logo es una marca ficticia de demostración, reemplazable por la del equipo.
