# Ocho demos sobre el mismo caso

La carpeta incluye la versión final. Para crearla en vivo, prepara una carpeta
independiente con solo los contratos y tus recursos. Conserva el paquete como respaldo.
No ejecutes la versión final antes de la primera tarea manual: alteraría la comparación.

## 1. La tarea manual
En la carpeta de práctica sin skill, abre Claude y pega:

> Revisa este contrato. Evalúa autenticación, paginación, esquemas y errores.
> No inventes controles que no estén documentados. Entrega resumen, hallazgos
> con evidencia y preguntas pendientes. Contrato: api-incompleta.json.

Señala qué instrucciones necesitas repetir cada vez.

## 2. Crear la skill
En esa misma conversación:

> Convierte el procedimiento acordado en una skill revisar-api para Claude Code.
> Crea .claude/skills/revisar-api/SKILL.md con nombre, descripción específica,
> procedimiento, reglas sobre evidencia y formato de salida. Usa rutas relativas.
> No agregues scripts todavía.

Lee lo generado antes de continuar. El paquete incluye una versión final de referencia.

## 3. Entender la estructura
Muestra la diferencia entre description y cuerpo. Explica cuándo usar la skill,
qué pasos ordena y cómo verificar el resultado. No presentes la activación como garantizada.

## 4. Probar la reutilización
Abre una nueva sesión desde el proyecto:

> /revisar-api Revisa api-mejorada.json.

Comprueba seguridad global, paginación y esquema incompleto de items.
Luego prueba una petición natural: «Revisa la documentación de esta API».
Si no se activa automáticamente, analiza description; no asumas una única causa.

## 5. Agregar recursos
Copia references/, templates/ y assets/ desde el paquete a la skill de práctica.
Pide actualizar SKILL.md para consultar lineamientos y utilizar la plantilla.
Muestra el encabezado Word. Explica que el logo de muestra se reemplaza por el real.

## 6. Agregar código
Copia scripts/generar_reporte.py y configura el entorno virtual.
Pide a Claude generar un JSON conforme a references/formato-reporte.md y ejecutar
el script. El modelo analiza; el script aplica formato. Abre el Word y revisa el encabezado.
Usa reporte-muestra.json como respaldo si hace falta, avisando que es precargado.

## 7. Compartir con el equipo
En una copia de práctica o repositorio nuevo:

```bash
git init
git add .claude/skills/revisar-api requirements.txt .gitignore
git diff --cached --stat
git commit -m "Agrega skill de revision de API"
```

Git puede solicitar configurar nombre y correo. Usa los datos del participante.
Si ya existe un repositorio, omite git init. Para publicar, utiliza el remoto autorizado
del equipo y un pull request; no inventes URL ni credenciales.
El compañero necesita actualizar su copia, abrir Claude Code desde el proyecto
y disponer de las dependencias documentadas.

## 8. Comprobar y mejorar
Compara el resultado con estos criterios:
- Evidencia específica en cada hallazgo.
- No afirmar que la API carece de seguridad solo por documentación faltante.
- Reconocer autenticación global y paginación del contrato mejorado.
- Mantener las secciones, logo y encabezado del reporte.
- Comprobar ejecución real y revisar todas las páginas del Word.

Modifica una regla, inicia otra sesión y repite con un contrato distinto.
Pide a otro participante probar la skill con su propio caso.

## Qué no demuestra la demo
No prueba seguridad en producción, registro en MuleSoft ni implementación real.
No ejecuta despliegues ni modifica servicios externos.
