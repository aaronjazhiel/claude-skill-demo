# Skill, agente, MCP y hook

| Elemento | Función | Ejemplo del taller |
|---|---|---|
| Skill | Instrucciones y recursos para un procedimiento reutilizable | Revisar una API y producir el reporte con la plantilla |
| Agente | Usa un modelo, instrucciones y herramientas para realizar una tarea | Claude analiza el contrato y decide qué herramientas utilizar |
| Subagente | Agente especializado con contexto separado para una tarea delegada | Revisor que analiza el contrato y devuelve hallazgos al agente principal |
| MCP | Protocolo para conectar herramientas y recursos externos | Consultar contratos o tickets a través de un servidor MCP configurado |
| Hook | Acción ligada a eventos del ciclo de Claude Code | Ejecutar una comprobación después de una edición |

Un script incluido en una skill no es automáticamente un hook.
Un comando puede ser ejecutado al seguir una skill o por un hook configurado.
Un servidor MCP aporta herramientas, pero necesita permisos y credenciales válidos.
Los hooks pueden usar comandos y también otros tipos de manejadores; el evento
configurado decide cuándo se invocan. Un hook con LLM puede tener resultados variables.

Este paquete implementa la skill y su script, no instala un MCP, un subagente ni hooks.

Fuentes oficiales:
- https://code.claude.com/docs/en/skills
- https://code.claude.com/docs/en/sub-agents
- https://code.claude.com/docs/en/mcp
- https://code.claude.com/docs/en/hooks
