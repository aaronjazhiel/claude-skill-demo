# R4 · El destilador

**Sustituye a:** demo 4, *El destilador*.

**Cuándo lo usas:** el ambiente falló, o vas tan retrasado que doce minutos
no caben. Es la demo que **nunca se recorta del todo**: si tienes cinco
minutos, usa las secciones 2 y 4 de este respaldo y sáltate el resto.

**Cómo entras:**

> Esta es la parte que quiero que se lleven completa, así que la vamos a leer
> con calma en lugar de esperar al modelo.

**Duración leyendo:** 8 minutos. En emergencia se comprime a 5.

---

## 1 · La conversación que voy a destilar

```
$ claude
> mira el diff de este repo y redáctame el mensaje de commit.
> Usamos commits convencionales: tipo entre paréntesis el alcance,
> resumen en imperativo y menos de 72 caracteres. El cuerpo explica
> por qué, no qué.
```

```
feat(factura): agregar descuentos por código de cupón

Las campañas de marketing necesitaban aplicar descuentos sin que un
desarrollador tocara el precio de cada línea. Se agrega aplicar_cupon,
que traduce un código a un porcentaje y reutiliza aplicar_descuento
para no duplicar la aritmética.

El diccionario de códigos queda en el módulo por ahora; mover a
configuración cuando haya más de una campaña activa.
```

> Funcionó bien. Pero fíjense en todo lo que **yo** tuve que escribir para
> que funcionara: la convención, el formato del tipo y el alcance, el límite
> de setenta y dos caracteres, y que el cuerpo explica el por qué.
>
> Eso es contexto que puse a mano. Y que voy a tener que volver a poner
> mañana, y el jueves, y la semana que entra.

---

## 2 · El prompt destilador

> Aquí está el momento que importa. En lugar de copiarme ese prompt a un
> archivo de notas, le voy a pedir que lo convierta en una skill. Y no se lo
> pido en general: le doy un procedimiento.

```
Destila esta conversación en un SKILL.md de Claude Code.

Nombre en gerundio. Descripción en tercera persona con la fórmula
[qué hace] + "Úsala cuando..." usando las palabras que yo usé de verdad
en esta conversación, no lenguaje de manual. En el cuerpo pon solo el
contexto que tuve que darte y que no sabías; quita todo lo que ya sabías.
Menos de 60 líneas. Termina con un comentario del grado de libertad.

Dame el archivo y el mkdir. Nada más.
```

Lee las tres instrucciones en voz alta, señalándolas:

> Tres cosas específicas. Que use **mis** palabras, no las del manual, porque
> es lo que decide si se dispara. Que **quite** lo que ya sabía, porque eso
> solo ocuparía contexto sin aportar nada. Y que me diga qué tan frágil es la
> tarea.

---

## 3 · Lo que generó

```
mkdir -p ~/.claude/skills/redactando-commits
```

```markdown
---
description: Redacta el mensaje de commit a partir de los cambios sin
  commitear, siguiendo la convención de commits convencionales del equipo.
  Úsala cuando el usuario pida un mensaje de commit, pregunte cómo describir
  su cambio, o mencione commits convencionales.
allowed-tools: Read Grep
---

## Cambios actuales

!`git diff HEAD`

## Convención del equipo

Formato del encabezado:

    tipo(alcance): resumen en imperativo

- Tipos: feat, fix, refactor, docs, test, chore
- El alcance es el módulo tocado, en minúsculas
- El resumen va en imperativo y **menos de 72 caracteres** contando el tipo
- Sin punto final

El cuerpo explica **por qué**, nunca qué. Lo que cambió ya está en el diff.
Si el cambio deja algo pendiente a propósito, dilo en el último párrafo.

## Instrucciones

1. Deduce el tipo y el alcance del diff. Si el diff toca varios módulos,
   usa el que concentra el cambio, no una lista.
2. Redacta el encabezado y **cuenta los caracteres**.
3. Escribe el cuerpo en uno o dos párrafos. Si el cambio es trivial, no
   escribas cuerpo.
4. Entrega el mensaje en un bloque, listo para copiar. Sin explicación
   alrededor.

No hagas el commit. No agregues archivos al índice.

<!-- Grado de libertad: MEDIA. La convención es fija, la redacción es libre. -->
```

**No lo instales todavía.** Léelo señalando tres cosas, en este orden:

> Primero, la descripción. Dice "mensaje de commit" y "commits
> convencionales", que son exactamente las palabras que yo escribí. No dice
> "gestión de control de versiones" ni "estandarización de mensajería de
> repositorio".
>
> Segundo, lo que **no** está. No me explica qué es un commit, ni qué es git,
> ni por qué conviene tener convenciones. Todo eso ya lo sabía, y meterlo
> solo costaría contexto en cada invocación.
>
> Tercero, la última línea. Me está diciendo que esta tarea es de libertad
> media: la convención no se negocia, la redacción sí. Eso es una decisión
> de diseño escrita, y en tres meses voy a agradecer que esté ahí.

---

## 4 · La prueba en sesión limpia

> Sesión nueva. Nada de la conversación anterior. Y esta vez no le explico
> nada.

```
$ claude
> dame un mensaje de commit para esto
```

```
feat(factura): aplicar descuentos por código de cupón

Marketing necesitaba lanzar campañas sin tocar el precio de cada línea.
aplicar_cupon traduce el código a un porcentaje y reutiliza
aplicar_descuento, de modo que la aritmética del descuento vive en un
solo lugar.

Los códigos quedan en el módulo a propósito: moverlos a configuración
solo se justifica cuando haya más de una campaña simultánea.
```

**Para dos segundos.**

> Nueve palabras de mi parte. No le dije la convención, no le dije el límite
> de caracteres, no le dije que el cuerpo explica el por qué. Y respetó las
> tres cosas.
>
> Eso que acaban de ver es la diferencia entre escribir un prompt y tener
> una skill.

---

## 5 · El ciclo

> A esto le llamamos el ciclo Claude A / Claude B. A es la sesión donde
> resolviste el problema y de donde destilas. B es una sesión limpia, sin
> nada de contexto, donde pruebas. Lo que observas en B regresa a A como
> corrección.
>
> Nadie escribe un SKILL.md bueno de memoria y a la primera. Yo no lo hago.
> Este ciclo es el trabajo real, y viene en el kit que se llevan, con el
> prompt completo en su versión larga.

---

## Si tienes exactamente cinco minutos

Recorta a esto y nada más:

1. **Sección 2 completa** · el prompt destilador, leído en voz alta con las
   tres instrucciones señaladas — 2 min
2. **Sección 4 completa** · la prueba en sesión limpia — 2 min
3. **Una sola frase de la sección 5:** *"Nadie escribe un SKILL.md bueno de
   memoria y a la primera; el ciclo está en el kit"* — 1 min

Lo que se sacrifica, en este orden: la sección 1 (el contexto que tuviste
que dar), la 3 (el archivo generado), y por último la 5. **La sección 2
nunca se sacrifica:** el prompt destilador es lo único de este webinar que
la audiencia puede usar esa misma tarde.

---

## El prompt corto, para pegar

Si el ambiente se recupera y quieres retomar en vivo, este es el bloque:

```
Destila esta conversación en un SKILL.md de Claude Code.

Nombre en gerundio. Descripción en tercera persona con la fórmula
[qué hace] + "Úsala cuando..." usando las palabras que yo usé de verdad
en esta conversación, no lenguaje de manual. En el cuerpo pon solo el
contexto que tuve que darte y que no sabías; quita todo lo que ya sabías.
Menos de 60 líneas. Termina con un comentario del grado de libertad.

Dame el archivo y el mkdir. Nada más.
```
