# Demo progresiva de Skills en Claude Code

Caso: revisar un contrato OpenAPI y entregar un reporte Word con encabezado y logo.
Incluye una skill final y ocho pasos de demostración. La marca API LAB es ficticia.

## Preparación en Mac

Descomprime el ZIP, abre Terminal y entra a la carpeta `ejemplo-skills-api`.
Necesitas Claude Code instalado y autenticado, Python 3 y Git para la demo 7.

```bash
python3 -m venv .venv
source .venv/bin/activate
python3 -m pip install -r requirements.txt
claude
```

La skill ya está en `.claude/skills/revisar-api/`. Abre Claude desde la raíz
para que la descubra. No necesitas copiarla a una carpeta personal.

## Prueba rápida en Claude Code

```text
/revisar-api Revisa ejemplos/api-incompleta.json y genera un reporte Word.
Guarda el análisis en resultados/reporte.json y el Word en resultados/reporte.docx.
Usa el Python .venv/bin/python de este proyecto.
```

Después abre una sesión nueva y repite con `ejemplos/api-mejorada.json`, usando
otros nombres de salida. Debe reconocer la seguridad global y la paginación;
el esquema de cada pedido sigue siendo incompleto.

## Probar solo el generador, sin Claude

```bash
python3 .claude/skills/revisar-api/scripts/generar_reporte.py --datos ejemplos/reporte-muestra.json --salida resultados/prueba.docx
open resultados/prueba.docx
```

El JSON de muestra es un respaldo didáctico. Este comando verifica generación
Word; no demuestra que Claude haya revisado un contrato.

## Contenido
- `GUIA-DEMO.md`: ocho pasos y prompts para el instructor, sin tiempos.
- `.claude/skills/revisar-api/`: skill completa, referencias, plantilla, logo y script.
- `ejemplos/`: dos contratos y datos de muestra para probar el generador.
- `resultados/`: ubicación para las salidas del participante.
- `revisar-api-para-web.zip`: solo la skill, para subirla en Customize > Skills.

## Web y Cowork
Sube `revisar-api-para-web.zip` si tu cuenta permite cargar skills. Adjunta también
el contrato de ejemplo. Pide usar revisar-api. El entorno debe disponer de Python
con python-docx; las rutas del Mac y el comando `open` no aplican en la nube.
El comando `${CLAUDE_SKILL_DIR}` pertenece a Claude Code: en otros entornos Claude
debe localizar la carpeta real y ejecutar el script con su ruta.

## Compartir mediante Git
La carpeta `.claude/skills/` debe estar incluida en el repositorio del proyecto.
Revisa cambios por pull request y documenta dependencias en requirements.txt.
No subas credenciales, entornos virtuales ni reportes con datos confidenciales.
Consulta GUIA-DEMO.md para los comandos de la demostración.

## Alcance de la comprobación
El script y los documentos de muestra se verificaron en el entorno de preparación.
La activación y respuesta del modelo deben ensayarse en tu instalación de Claude Code.

Documentación: https://code.claude.com/docs/en/skills
