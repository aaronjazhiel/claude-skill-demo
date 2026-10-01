# Criterios de revisión del taller

Son reglas didácticas del equipo ficticio; no son un estándar universal.

## Contrato
Revisar descripción de operaciones, parámetros, cuerpos, respuestas y esquemas.
Señalar inconsistencias, indicando la ubicación exacta.

## Autenticación
Revisar componentes de seguridad y su aplicación global o por operación.
La seguridad global se hereda salvo sobrescritura por operación. `security: []`
puede representar acceso anónimo intencional: solicitar contexto, no inventar riesgos.
Ausencia de documentación no implica exposición real del servicio.

## Listas y errores
Para consultas de listas, revisar paginación y límites documentados.
Revisar errores relevantes según el caso; no exigir todos los códigos a toda API.
Para creación, evaluar 201 según la semántica, sin afirmar que 200 es siempre inválido.

## Integración del equipo
Preguntar por registro en API Gateway y MuleSoft si aplica a este proyecto.
Un contrato OpenAPI por sí solo no prueba que dichos registros existan.
No incluir secretos ni credenciales en el reporte.

## Clasificación
- Información faltante: no se puede verificar desde el contrato.
- Inconsistencia: conflicto observable en la especificación.
- Mejora: recomendación contextual, no incumplimiento confirmado.
Usar prioridades Alta, Media o Baja justificadas por impacto.
