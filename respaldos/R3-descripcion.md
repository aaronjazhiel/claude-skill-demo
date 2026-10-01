# R3 · La descripción

**Sustituye a:** demo 3, *La descripción, A/B en vivo*.

**Cuándo lo usas:** dos escenarios muy distintos, y cada uno tiene su
variante abajo.

| Escenario | Variante |
|---|---|
| **Decidido antes de transmitir.** En el ensayo la versión mala se disparó dos o tres veces de tres. El A/B en vivo no es confiable | **Variante A · narrada** |
| **Falla en transmisión.** El ambiente se cayó a media demo | **Variante B · capturada** |

La variante A es una decisión de diseño, no un plan B. Si el ensayo dice que
el azar no está de tu lado, **úsala sin culpa**: enseña lo mismo y no
depende de nada.

---
---

# VARIANTE A · Narrada

**Duración:** 10 minutos, igual que la demo en vivo. Sin esperas de modelo,
así que da tiempo de ir más despacio.

Esta variante convierte el A/B en un ejercicio de lectura con la audiencia.
Funciona mejor de lo que parece, porque los hace **buscar el error** en vez
de verte encontrarlo.

## Paso 1 · Muestra las dos, juntas (2 min)

Comparte la pantalla con las dos descripciones, una arriba de la otra:

```yaml
# Versión 1
description: Te puedo ayudar con tus documentos y archivos.
```

```yaml
# Versión 2
description: Revisa un README y señala las secciones que faltan.
  Úsala cuando el usuario mencione README, documentación del proyecto,
  o pregunte si su documentación está completa.
```

> Estas dos descripciones son del mismo archivo. El cuerpo es idéntico, byte
> por byte. Una funciona y la otra no se dispara nunca.
>
> Les voy a dar treinta segundos. Escriban en el chat cuántas diferencias
> encuentran. No cuáles: cuántas.

**Cuenta los treinta segundos de verdad.** En un webinar, el silencio
anunciado es la única forma de participación que funciona de manera
confiable.

## Paso 2 · Las respuestas del chat, aprovechadas (2 min)

Lee dos o tres números del chat en voz alta, con el nombre de quien lo puso.
Eso hace más por la participación del resto del webinar que cualquier
pregunta abierta.

> Vi tres, vi dos, vi cuatro. Son tres, y la tercera es la que casi nadie
> ve.

## Paso 3 · Las tres, de una en una (4 min)

**Uno · la persona gramatical**

> "Te puedo ayudar" está escrito como si Claude le hablara al usuario. Pero
> esta línea no se la muestra a nadie: se inyecta en la indicación del
> sistema, donde Claude lee sobre sí mismo en tercera persona.
>
> Es como si en un directorio telefónico, en lugar de "Dentista", una entrada
> dijera "puedo arreglarte los dientes". Técnicamente dice lo mismo. Pero
> nadie lo encuentra buscando en un directorio.

**Dos · el cuándo, que falta entero**

> La fórmula completa son dos mitades: qué hace, más cuándo usarla. La
> versión 1 no tiene la segunda. Y sin la segunda, Claude sabe que la skill
> existe pero no tiene con qué decidir si esta conversación es el momento.
>
> La mitad que casi todos omiten es exactamente la que decide si la skill
> se dispara.

**Tres · las palabras** — *detente aquí más que en las otras dos*

> Esta es la sutil. "Documentos y archivos" no es lo que ustedes escriben
> nunca. Ustedes escriben "revisa mi README". Y el mecanismo de
> descubrimiento es, en la práctica, coincidencia entre lo que ustedes
> teclean y lo que dice la descripción.
>
> Si la descripción está en el idioma del manual y ustedes escriben en el
> idioma del martes, no se encuentran.

## Paso 4 · La prueba, capturada (1 min)

Muestra el bloque de la variante B, sección "las dos corridas". Con el
diagnóstico ya explicado, la captura confirma en vez de demostrar, y eso
basta.

## Paso 5 · La conclusión (1 min)

> Mismo archivo, mismo cuerpo, mismo todo, excepto una línea.
>
> Si se llevan una sola cosa de este webinar, que sea esta: cuando una skill
> no se dispara, el problema casi nunca está en el cuerpo. Está en la
> descripción. Van a perder horas revisando el cuerpo. No está ahí.

## Por qué esta variante a veces gana

Dila si alguien pregunta por qué no lo corriste en vivo:

> Lo corrí ayer tres veces y me dio dos resultados distintos. Eso también es
> información útil: el descubrimiento es probabilístico. Una descripción mala
> no falla el cien por ciento de las veces, falla lo suficiente para que no
> puedan confiar en ella.

Esa frase es mejor contenido que la demo en vivo. Si la variante A te tocó,
tienes una ventaja.

---
---

# VARIANTE B · Capturada

**Duración:** 6 minutos. La usas cuando el ambiente se cayó a media demo y
ya venías con el guion en vivo.

**Cómo entras:**

> Dejo esto y les muestro la corrida de ayer, que para el punto que quiero
> hacer sirve igual.

## Las dos corridas

### Corrida 1 · con la descripción mala

```
$ claude
> revisa mi README y dime qué le falta
```

```
No tengo el contenido de tu README. ¿Puedes compartirlo, o me dices en qué
ruta está para leerlo?
```

> La skill está instalada. El archivo existe. El cuerpo dice exactamente
> "revisa el README y dime qué secciones le faltan". Y no se activó: ni
> siquiera supo que podía leer el archivo por su cuenta.

Enseña que la skill sí estaba ahí, para cerrar la duda obvia:

```
$ claude
> /skills
```

```
Skills disponibles:

  revisando-cambios   Revisa los cambios sin commitear y señala lo
                      riesgoso antes de subirlos. Úsala cuando...
  revisando-readme    Revisa que un README tenga las secciones que el
                      equipo exige y señala lo que falta. Úsala cuando...
  ayudante-docs       Te puedo ayudar con tus documentos y archivos.
```

> Ahí está, en la lista, cargada. Y no sirvió.

### Corrida 2 · con la descripción corregida

Misma pregunta, mismo cuerpo, descripción nueva:

```
$ claude
> revisa mi README y dime qué le falta
```

```
Revisé README.md contra las secciones que el equipo exige. Tiene 9 líneas
y dos encabezados.

FALTA
· Requisitos — no dice qué versión de Python necesita ni qué dependencias
· Instalación — no hay ningún comando de instalación
· Configuración — el ejemplo de uso recibe un archivo JSON que no está
  documentado en ninguna parte
· Licencia — no hay ninguna

MEJORABLE
· Uso existe, pero el comando apunta a datos/ejemplo.json, que no está en
  el repositorio. Copiar ese comando falla.
· La descripción de una línea no dice qué formato de entrada acepta.

Lo primero que arreglaría es Instalación: sin ella, quien clona el
repositorio no puede pasar del primer paso.
```

> Se disparó, leyó el archivo sin que se lo pidiera, corrió su verificación
> y me dijo hasta que el ejemplo del README está roto.
>
> Mismo cuerpo. Una línea de diferencia.

## Las tres diferencias

Aquí usa los pasos 3 y 5 de la variante A tal cual. El diagnóstico es el
mismo; lo único que cambia es que llegas a él después de la evidencia en vez
de antes.

---
---

# Los dos archivos, para tenerlos a mano

Si el ambiente se recupera y quieres retomar en vivo, estos son los archivos
exactos. Directorio: `~/.claude/skills/ayudante-docs/`.

**Antes:**

```markdown
---
description: Te puedo ayudar con tus documentos y archivos.
---

## Instrucciones

Revisa el README y dime qué secciones le faltan.
```

**Después:**

```markdown
---
description: Revisa un README y señala las secciones que faltan. Úsala
  cuando el usuario mencione README, documentación del proyecto, o pregunte
  si su documentación está completa.
---

## Instrucciones

Revisa el README y dime qué secciones le faltan.
```

El cuerpo no cambió. Esa es la demostración.
