---
description: Revisa que un README tenga las secciones que el equipo exige y
  señala lo que falta. Úsala cuando el usuario mencione README, documentación
  del proyecto, o pregunte si su documentación está completa.
allowed-tools: Read Grep Bash(bash ${CLAUDE_SKILL_DIR}/scripts/verificar.sh *)
---

## Instrucciones

1. Ejecuta la verificación automática:

       bash ${CLAUDE_SKILL_DIR}/scripts/verificar.sh

2. El script reporta qué secciones obligatorias faltan. Para cada una,
   revisa el README real y evalúa si existe con otro nombre antes de
   reportarla como faltante.

3. Redacta un reporte con dos partes: **Falta** y **Mejorable**.

4. Para el detalle de qué debe contener cada sección, consulta
   ${CLAUDE_SKILL_DIR}/reference.md

No reescribas el README salvo que el usuario lo pida.

<!-- Grado de libertad: MEDIA. Checklist fijo, juicio de calidad libre. -->
