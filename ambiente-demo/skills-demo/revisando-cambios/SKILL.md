---
description: Revisa los cambios sin commitear y señala lo riesgoso antes de
  subirlos. Úsala cuando el usuario pregunte qué cambió, pida revisar su diff,
  quiera un mensaje de commit o pregunte si su cambio está listo para subir.
allowed-tools: Read Grep
---

## Cambios actuales

!`git diff HEAD`

## Instrucciones

Resume en dos o tres viñetas qué cambió, en términos de intención y no de
líneas. "Se agregó soporte de cupones", no "se modificaron 14 líneas".

Después lista los riesgos que encuentres. Busca específicamente:

- Manejo de errores ausente en operaciones que pueden fallar
- Valores hardcodeados que deberían ser configuración o constantes
- Datos de negocio embebidos en el código
- Pruebas que quedaron desactualizadas respecto al código que tocaste

Ordena los riesgos por severidad. Si no encuentras ninguno, dilo en una
línea; no inventes hallazgos para llenar la sección.

<!-- Grado de libertad: ALTA. El criterio de revisión es el valor. -->
