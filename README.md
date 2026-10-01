# Claude Skills — Webinar Práctico

Repositorio de demostración para el webinar **"Skills con Claude Code"**.

En este webinar vas a ver cómo dejar de repetirle lo mismo a Claude cada semana. En 90 minutos, con código corriendo en vivo, vas a entender qué son las skills, cómo funcionan por dentro, y vas a construir la tuya antes de que termine la sesión.

**Lo que vas a poder hacer al terminar:**
- Entender qué es una skill y cómo se dispara sola
- Saber por qué falla una skill cuando no se activa
- Construir tu propia skill destilando una conversación que ya funcionó
- Diagnosticar problemas cuando algo no carga

---

## ¿Qué son las Skills de Claude Code?

Una skill es simplemente **un archivo de texto en una carpeta**. Nada más.

Cuando le haces una pregunta a Claude, él lee las descripciones de tus skills y decide si alguna aplica. Si aplica, la usa automáticamente — sin que escribas ningún comando especial.

```
~/.claude/skills/
└── revisando-cambios/
    └── SKILL.md
```

El archivo tiene dos partes separadas por `---`:

```markdown
---
description: Revisa los cambios sin commitear y señala lo riesgoso.
             Úsala cuando el usuario pregunte qué cambió o pida revisar su diff.
---

## Instrucciones

Aquí van las instrucciones para Claude...
```

| Parte | Cuándo está en contexto | Costo |
|---|---|---|
| **Descripción** (arriba del `---`) | **Siempre**, en todas las conversaciones | Permanente pero pequeño |
| **Cuerpo** (abajo del `---`) | **Solo** al invocarla | Nada mientras no se use |

> Con 50 skills instaladas, lo que está ocupando contexto permanentemente son 50 descripciones de dos líneas. Los 50 cuerpos están en disco, esperando.

---

## ¿Por qué son útiles las Skills?

- **Eliminas la repetición** — no vuelves a explicarle lo mismo a Claude cada semana
- **El criterio vive en un archivo** — no en la cabeza de una sola persona
- **Se versionan con el código** — quien clona el repo hereda el criterio sin que nadie le explique nada
- **Son portables** — un archivo de texto que funciona en cualquier máquina
- **Se comparten en equipo** — una skill en `.claude/skills/` del repositorio aplica para todos
- **No tienen costo hasta que se usan** — 50 skills instaladas solo ocupan 50 descripciones de dos líneas

---

## Skills vs MCP vs Hooks — cuándo usar cada uno

Estas tres herramientas conviven y se complementan. No son alternativas entre sí.

### Skill
**Qué es:** un archivo de instrucciones que le dice a Claude cómo comportarse en situaciones específicas.

**Cuándo usarla:**
- Cuando tienes un criterio o procedimiento que repites seguido
- Cuando quieres que Claude actúe diferente según el contexto sin que se lo expliques cada vez
- Cuando quieres compartir conocimiento del equipo sin que nadie lo instale manualmente

```markdown
---
description: Revisa un README y señala las secciones que faltan.
             Úsala cuando el usuario mencione README o documentación.
---
## Instrucciones
Revisa el README contra las secciones obligatorias del equipo...
```

---

### MCP (Model Context Protocol)
**Qué es:** un protocolo que conecta a Claude con herramientas y datos externos — bases de datos, APIs, sistemas de archivos remotos, servicios de terceros.

**Cuándo usarlo:**
- Cuando Claude necesita leer o escribir datos que están fuera de tu máquina
- Cuando quieres conectar Claude con una API externa (Jira, Notion, Slack, tu base de datos)
- Cuando necesitas que Claude tenga acceso a información en tiempo real

```
Claude ←→ MCP Server ←→ Base de datos / API externa
```

**La diferencia clave con Skills:**
- La skill le dice **cómo** hacer algo
- El MCP le da **acceso** a algo
- Muchas veces conviven: la skill es el procedimiento y el MCP es la puerta

---

### Hooks
**Qué es:** scripts que se ejecutan automáticamente en momentos específicos del ciclo de Claude — antes de una respuesta, después de ejecutar un comando, al guardar un archivo.

**Cuándo usarlos:**
- Cuando quieres que algo pase **siempre**, sin importar qué le pidas a Claude
- Para validaciones automáticas (correr linter antes de cada commit)
- Para logging o auditoría de lo que Claude hace
- Para notificaciones cuando Claude termina una tarea larga

```bash
# Ejemplo: hook que corre los tests después de cada cambio de código
on: post-tool-use
run: python -m pytest --tb=short
```

**La diferencia clave con Skills:**
- La skill se dispara cuando Claude decide que aplica
- El hook se dispara **siempre**, en el momento que tú defines, sin que Claude decida nada

---

### Tabla comparativa

| | Skill | MCP | Hook |
|---|---|---|---|
| **Quién decide cuándo actúa** | Claude, según la descripción | Tú, al configurarlo | Automático, por evento |
| **Para qué sirve** | Instrucciones y criterio | Acceso a datos externos | Automatización de ciclo |
| **Dónde vive** | Archivo de texto en una carpeta | Servidor separado | Configuración de Claude |
| **Cuándo usarlo** | Procedimientos que repites | Conectar con APIs o DBs | Validaciones siempre activas |
| **Ejemplo** | Revisar un diff, redactar commits | Leer tickets de Jira | Correr tests tras cada cambio |

---

## Instalación de herramientas

### 1 · Node.js (requerido para Claude Code)

**Mac:**
```bash
# Con Homebrew (recomendado)
brew install node

# O descarga el instalador desde
# https://nodejs.org — versión LTS
```

**Verifica:**
```bash
node --version   # debe ser v18 o más nueva
npm --version
```

---

### 2 · Claude Code

```bash
npm install -g @anthropic-ai/claude-code
```

**Verifica:**
```bash
claude --version
```

**Si ya lo tienes y necesitas actualizar:**
```bash
claude update
```

> Necesitas v2.1.233 o más nueva. El comando `claude plugin validate` de la demo 6 no existe en versiones anteriores.

---

### 3 · git

**Mac:**
```bash
# Con Homebrew
brew install git

# O instala Xcode Command Line Tools
xcode-select --install
```

**Verifica:**
```bash
git --version
```

---

### 4 · Python 3

**Mac:**
```bash
brew install python3
```

**Verifica:**
```bash
python3 --version   # debe ser 3.8 o más nueva
```

---

### 5 · Autenticar Claude Code

```bash
claude
```

La primera vez te pide que inicies sesión. Necesitas una cuenta de Claude con plan **Pro, Max, Team o Enterprise**.

---

## Introducción a las demos

Este webinar tiene **6 demostraciones en vivo**, todas con código corriendo en pantalla. No hay diapositivas de relleno — cada demo enseña una sola cosa y la demuestra antes de explicarla.

El hilo de las 6 demos:

```
Existe → Cómo funciona → Por qué falla → Cómo la construyes → Cómo la potencias → Cómo la diagnosticas
```

### El escenario

Eres un desarrollador. Tienes un repositorio Python con un calculador de facturas. Un martes cualquiera agregaste cupones de descuento — 12 líneas de cambio. Antes de subirlo quieres que alguien lo revise, pero no hay nadie disponible.

Ese es el punto de partida de todas las demos.

### Las 6 demos

| # | Minuto | Demo | Lo que demuestra |
|---|---|---|---|
| 1 | 0:02 | La skill en tres minutos | Una skill funcionando antes de saber qué es |
| 2 | 0:15 | Anatomía de un SKILL.md | Por qué la descripción y el cuerpo son distintos |
| 3 | 0:27 | La descripción A/B | La descripción es lo único que decide si una skill existe |
| **4** | **0:47** | **El destilador** | Cómo construyes tu propia skill mañana |
| 5 | 1:05 | Multiarchivo y script | Una skill puede ejecutar código sin pedir permiso |
| 6 | 1:12 | La skill que no funciona | Cómo diagnosticar, y que la peor falla no la marca ninguna herramienta |

> **La demo 4 es la más importante.** Es lo único del webinar que puedes usar esa misma tarde.

---

## Parte 1 · Demo con el repositorio de facturación

### Paso 1 · Clona este repositorio

```bash
git clone https://github.com/aaronjazhiel/claude-skill-demo.git
cd claude-skill-demo
```

### Paso 2 · Prepara el ambiente

```bash
bash ambiente-demo/preparar.sh
```

Esto crea `~/demo-webinar` con:
- El repositorio de demostración inicializado en git
- Un diff de 12 líneas ya aplicado (4 problemas sembrados)
- Las skills `revisando-cambios` y `revisando-readme` instaladas en `~/.claude/skills/`

### Paso 3 · Verifica que todo está listo

```bash
bash ambiente-demo/verificar.sh
```

Deberías ver todo en verde. Si algo falla, el script te dice exactamente qué resolver.

### Paso 4 · Ve al repositorio de demo

```bash
cd ~/demo-webinar
```

### Paso 5 · Mira el diff

```bash
git diff HEAD
```

Verás 12 líneas de cambios en `src/factura.py` — se agregaron cupones de descuento con 4 problemas intencionales:

| # | Problema | Dónde |
|---|---|---|
| 1 | `cupones[codigo]` lanza `KeyError` con código inválido | `aplicar_cupon` |
| 2 | `1.16` hardcodeado en vez de usar la constante `IVA` | `calcular_total` |
| 3 | Códigos de cupón en el código, no en configuración | `aplicar_cupon` |
| 4 | Prueba `test_total_con_iva` desactualizada | `tests/` |

### Paso 6 · Abre Claude y haz la pregunta

```bash
claude
```

Cuando abra, escribe exactamente esto — sin diagonales, sin mencionar skills:

```
¿qué cambié y qué debería revisar antes de subirlo?
```

La skill `revisando-cambios` se dispara sola, lee el diff automáticamente y entrega una revisión con criterio de severidad.

### Paso 7 · Mira el archivo de la skill

```bash
/exit
cat ~/.claude/skills/revisando-cambios/SKILL.md
```

Verás la línea `!`git diff HEAD`` — eso es lo que hace que Claude lea el diff solo. Se ejecuta automáticamente cuando la skill entra.

### Paso 8 · Ve las skills instaladas

```bash
claude
/skills
```

Verás los nombres y descripciones de todas tus skills. Eso es todo lo que Claude ve permanentemente — los cuerpos están en disco, esperando.

### Paso 9 · Resetea entre demos

```bash
bash ambiente-demo/resetear.sh
```

Úsalo entre cada demo para dejar el ambiente limpio.

---

## Los 3 errores más comunes sobre Skills

Estos circulan mal en tutoriales. Si los dices mal, alguien de la audiencia te corrige:

| ❌ No digas | ✅ Di |
|---|---|
| "El campo `name` define el comando" | "El **nombre del directorio** define el comando" |
| "El tope de la descripción son 1,024 caracteres" | "Son **1,536**, combinados con `when_to_use`" |
| "El cuerpo se carga solo mientras se usa" | "El cuerpo **se queda** en la conversación después de invocarla" |

---

## Comandos de diagnóstico

Úsalos cuando algo no funciona:

| Comando | Para qué |
|---|---|
| `/skills` | Ver qué skills cargaron y de dónde |
| `/doctor` | Revisar instalación y frontmatter roto |
| `/context` | Ver qué está ocupando la ventana de contexto |
| `claude --debug` | Errores de parseo cuando una skill no aparece |
| `claude plugin validate ~/.claude/skills` | Validar frontmatter de todas las skills de un jalón |

---

## Parte 2 · Skills para APIs

> 🚧 Próximamente — ejemplo de skills aplicadas a flujos de desarrollo con APIs.

---

## Frases clave del webinar

1. *"Todo eso estaba escrito en un archivo, una sola vez."*
2. *"La descripción siempre está en contexto. El cuerpo, no."*
3. *"Si no se dispara, el problema está en la descripción."*
4. *"Nadie escribe un SKILL.md bueno de memoria y a la primera."*
5. *"Los scripts se ejecutan, no se leen."*
6. *"Las descripciones malas no las marca ninguna herramienta."*

---

## Estructura del repositorio

```
claude-skill-demo/
├── ambiente-demo/
│   ├── preparar.sh          ← crea ~/demo-webinar e instala las skills
│   ├── verificar.sh         ← checklist automático
│   ├── resetear.sh          ← devuelve todo al estado inicial
│   ├── repo-semilla/        ← código base limpio
│   ├── estado-trabajo/      ← código con el diff sembrado
│   └── skills-demo/         ← las 3 skills del webinar
├── respaldos/               ← corridas capturadas por si algo falla en vivo
└── README.md
```
