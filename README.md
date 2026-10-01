# Claude Skills — Webinar Práctico

Repositorio de demostración para el webinar **"Skills con Claude Code"**.  
Aquí encontrarás todo lo necesario para seguir las demos en vivo y construir tus propias skills.

---

## ¿Qué son las Skills de Claude Code?

Una skill es simplemente **un archivo de texto en una carpeta**. Nada más.

Cuando le haces una pregunta a Claude, él lee las descripciones de tus skills y decide si alguna aplica. Si aplica, la usa automáticamente — sin que escribas ningún comando especial.

```
~/.claude/skills/
└── revisando-cambios/
    └── SKILL.md
```

El archivo tiene dos partes:

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

---

## ¿Por qué son útiles las Skills?

- **Eliminas la repetición** — no vuelves a explicarle lo mismo a Claude cada semana
- **El criterio vive en un archivo** — no en la cabeza de una sola persona
- **Se versionan con el código** — quien clona el repo hereda el criterio sin que nadie le explique nada
- **Son portables** — un archivo de texto que funciona en cualquier máquina
- **Se comparten en equipo** — una skill en `.claude/skills/` del repositorio aplica para todos
- **No tienen costo hasta que se usan** — 50 skills instaladas solo ocupan 50 descripciones de dos líneas

---

## Ventajas frente a CLAUDE.md

| | CLAUDE.md | Skill |
|---|---|---|
| Cuándo se carga | En **todas** las conversaciones | Solo cuando aplica |
| Para qué sirve | Lo que hace falta siempre | Lo que hace falta a veces |
| Costo | Permanente en todas las sesiones | Solo al invocarse |

> Regla simple: ¿hace falta en cada conversación? → `CLAUDE.md`. ¿Solo en algunas? → Skill.

---

## Requisitos

- **Claude Code** v2.1.233 o más nueva
- **git** disponible en la terminal
- **python3** disponible en la terminal
- Sesión de Claude Code autenticada

Verifica tu versión:

```bash
claude --version
```

Si necesitas actualizar:

```bash
claude update
```

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

Verás que la línea `!`git diff HEAD`` es lo que hace que Claude lea el diff solo — se ejecuta automáticamente cuando la skill entra.

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
