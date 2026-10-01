# R6 · Diagnóstico

**Sustituye a:** demo 6, *La skill que no funciona*.

**Cuándo lo usas:** el ambiente falló, `claude plugin validate` no existe en
tu versión, o vas retrasado. Esta demo es de riesgo bajo porque casi todo es
lectura de un archivo, así que el respaldo se parece mucho a la demo real.

**Duración leyendo:** 6 minutos.

---

## 1 · La skill saboteada

```
$ cat ~/.claude/skills/doc-helper/SKILL.md
```

```markdown
---
Name: Doc Helper
description: Te puedo ayudar con tus documentos y archivos.
---

## Instrucciones

Revisa el documento y aplica el formato del equipo.
El detalle está en scripts\formato.md, léelo primero.

Consulta también reference.md para los casos especiales.
```

> Esta skill tiene tres fallas y está diseñada para no activarse nunca.
> Les voy a dar quince segundos para que las busquen. Pongan en el chat el
> número de línea, no la explicación.

**Cuenta los quince segundos en silencio real.** En un webinar es la única
forma de participación que funciona sin falta, y funciona porque anunciaste
cuánto iba a durar.

Luego lee dos o tres números del chat con el nombre de quien los puso.

---

## 2 · Las tres fallas

### Falla 1 · el frontmatter · línea 2

> `Name` con mayúscula no es un campo válido. El campo es `name`, todo en
> minúsculas. Y el valor tiene un espacio y dos mayúsculas, que tampoco se
> permiten: solo minúsculas, números y guiones.
>
> ¿Qué pasa en la práctica? La skill carga **sin metadatos**. Va a responder
> si la invocan con diagonal, porque el directorio existe. Pero no se va a
> disparar sola nunca, porque para el modelo no tiene descripción.

Y el detalle que casi nadie sabe, que ya venías anticipando:

> De paso, aquí hay un malentendido que vale aclarar: aunque `name` estuviera
> bien escrito, **no es de donde sale el comando**. El comando sale del
> nombre del directorio. En skills personales y de proyecto, `name` es solo
> la etiqueta del listado, y ni siquiera es obligatorio.

### Falla 2 · la descripción · línea 3

> "Te puedo ayudar con tus documentos y archivos". Es la de la demo tres, las
> tres cosas juntas: segunda persona, sin el cuándo, y con palabras que nadie
> teclea.
>
> Y esta es la que se escapa. Las otras dos se ven raras. Esta parece una
> descripción perfectamente normal.

### Falla 3 · las rutas · líneas 9 y 11

> Tres problemas en dos líneas.
>
> `scripts\formato.md` con barra invertida. En las rutas de una skill la
> barra es hacia adelante, siempre, en cualquier sistema operativo. Con barra
> invertida no resuelve y la skill sigue adelante como si nada.
>
> Segundo: dice "léelo primero" de un archivo que está en `scripts/`. Si es un
> script, se ejecuta. Si es documentación, no va en `scripts/`. El verbo y la
> carpeta se contradicen.
>
> Y tercero, el que menos se ve: el `reference.md` de esta skill apunta a dos
> archivos más. Es una cadena de dos niveles. Y las cadenas de dos niveles
> funcionan a veces y fallan otras, que es peor que fallar siempre.

---

## 3 · Las herramientas

```
$ claude
> /doctor
```

```
Claude Code v2.1.284

Instalación
  OK   Ejecutable en /usr/local/bin/claude
  OK   Node v22.11.0
  OK   Configuración en ~/.claude/

Skills
  OK      revisando-cambios        (personal)
  OK      revisando-readme         (personal)
  ADVERT  doc-helper               (personal)
          campo desconocido en frontmatter: "Name"
```

> `/doctor` revisa la instalación completa y marca las skills con problemas
> de carga. Vean que la falla 1 sí aparece: *campo desconocido*.

```
> /skills
```

> `/skills` para ver qué cargó y de dónde viene cada una. Es donde se detecta
> que dos skills de orígenes distintos tienen el mismo nombre.

```
> /context
```

> `/context` para ver qué está ocupando la ventana. Si tienen treinta skills
> instaladas, aquí se ve cuánto están costando las descripciones.

```
$ claude --debug
```

> Y `--debug` para los errores de parseo, que es lo que usan cuando una skill
> simplemente no aparece y no saben por qué.

Y la que casi nadie conoce:

```
$ claude plugin validate ~/.claude/skills
```

```
Validando ~/.claude/skills

  revisando-cambios     OK
  revisando-readme      OK
  doc-helper            2 problemas
      frontmatter: campo desconocido "Name" (línea 2)
      frontmatter: falta "name" o el directorio no es un slug válido

2 problemas en 3 skills
```

> Esta recorre un directorio entero y encuentra el frontmatter roto de todas
> las skills de un jalón. Es lo primero que corren cuando heredan un
> repositorio con skills que alguien más escribió.
>
> Requiere versión 2.1.233 o más nueva. Si les dice que el comando no existe,
> actualicen o usen `--debug`.

---

## 4 · El cierre, que es el punto de la demo

> Cuenten conmigo. La herramienta encontró **dos** problemas. Nosotros
> encontramos **tres**.
>
> Las dos que encontró eran de sintaxis: el campo mal escrito y el nombre
> inválido. Esas se arreglan en diez segundos y cualquier herramienta se las
> señala.
>
> La que no encontró es la descripción. Y la descripción era la falla que
> realmente impedía que la skill sirviera de algo.

**Para dos segundos.**

> Esa es la que van a tener en producción. La que se ve perfectamente bien,
> la que pasa todas las validaciones, y la que hace que la skill que
> escribieron el mes pasado no se haya disparado ni una vez.
>
> Y ninguna herramienta se la va a marcar. Solo ustedes, leyéndola en voz
> alta y preguntándose si esas son las palabras que de verdad teclean.

---

## Si vas retrasado

Recorta a **falla 2 + sección 3 abreviada + sección 4**. Son 4 minutos.

Di las fallas 1 y 3 en una línea cada una, sin desarrollar: *"hay un campo
mal escrito y una ruta con barra invertida, y las dos las marca la
herramienta"*. Lo que no se recorta nunca es el cierre: es la frase con la
que la audiencia se queda.
