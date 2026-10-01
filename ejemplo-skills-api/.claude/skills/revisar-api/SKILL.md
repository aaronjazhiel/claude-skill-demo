---
name: revisar-api
description: Revisa contratos OpenAPI, identifica información faltante y genera un reporte Word con el formato del equipo. Úsala cuando el usuario pida revisar una API, evaluar su documentación o generar un reporte de revisión de API.
---

# Revisar una API y generar un reporte

1. Identifica el contrato solicitado. Si no hay uno, pide su ubicación.
2. Lee el contrato y `references/lineamientos-api.md`, relativos a esta carpeta.
3. Examina operaciones, seguridad efectiva (global y por operación), parámetros,
   respuestas, esquemas y paginación. Distingue evidencia de hipótesis.
4. Entrega un resumen, hallazgos sustentados y preguntas pendientes.
   Una ausencia en la especificación no demuestra una ausencia en producción.
5. Si el usuario solicita Word, lee `references/formato-reporte.md` y crea
   un JSON con la estructura definida allí, basado en tu análisis.
6. Localiza esta carpeta de skill. En Claude Code puedes usar
   `${CLAUDE_SKILL_DIR}`; en otro entorno usa la ruta real de la carpeta.
   Ejecuta el script con rutas explícitas al JSON y al archivo de salida:

   ```bash
   python3 "${CLAUDE_SKILL_DIR}/scripts/generar_reporte.py" --datos "<reporte.json>" --salida "<reporte.docx>"
   ```

   Sustituye los marcadores antes de ejecutar. Usa el Python del entorno
   que tenga python-docx instalado. Si falta, informa la dependencia y usa
   un entorno virtual disponible; no instales paquetes globalmente.
7. Comprueba el archivo y el encabezado. Si puedes renderizarlo, revisa
   todas sus páginas. Si no puedes, indica que falta la revisión visual.

## Reglas
- No inventes implementaciones, pruebas, despliegues ni controles operativos.
- No cambies el contrato ni registres servicios externos sin petición explícita.
- Incluye evidencia concreta con la ruta y operación correspondientes.
- Usa `templates/reporte.docx`; su encabezado contiene el logo ficticio.
- El script aplica formato; no analiza OpenAPI ni decide los hallazgos.
- No uses un reporte de muestra como si fuera el análisis del contrato actual.
