# R1 · Apertura

**Sustituye a:** demo 1, *La skill en tres minutos*.

**Cuándo lo usas:** Claude Code no arranca, no responde en 60 segundos, hay
error de red o de sesión, o el repositorio de demostración no está en el
estado esperado.

**Cómo entras:** sin anunciar el cambio.

> Esto es lo mismo que corrí ayer, capturado. Lo vamos a leer juntos, que
> para lo que quiero mostrarles es incluso mejor: podemos detenernos.

**Duración leyendo:** 5 minutos, uno menos que la demo en vivo.

---

## 1 · El cambio del martes

```
$ cd ~/demo-webinar
$ git diff HEAD
```

```diff
diff --git a/src/factura.py b/src/factura.py
index efe29c4..ebde837 100644
--- a/src/factura.py
+++ b/src/factura.py
@@ -13,8 +13,16 @@ def aplicar_descuento(subtotal, porcentaje):
     return subtotal * (1 - porcentaje / 100)
 
 
-def calcular_total(lineas, descuento=0):
+def aplicar_cupon(subtotal, codigo):
+    """Aplica un cupón de descuento por código."""
+    cupones = {"BIENVENIDA": 10, "VIP": 25, "BLACKFRIDAY": 40}
+    return aplicar_descuento(subtotal, cupones[codigo])
+
+
+def calcular_total(lineas, descuento=0, cupon=None):
     """Calcula el total de la factura con IVA."""
     subtotal = calcular_subtotal(lineas)
+    if cupon:
+        subtotal = aplicar_cupon(subtotal, cupon)
     con_descuento = aplicar_descuento(subtotal, descuento)
-    return round(con_descuento * (1 + IVA), 2)
+    return round(con_descuento * 1.16, 2)
```

> Doce líneas. Agregué cupones de descuento a un calculador de facturas.
> Es el cambio de un martes cualquiera, y antes de subirlo quiero que
> alguien lo revise. No hay nadie disponible.

**No leas el código línea por línea.** Señala el bloque nuevo y sigue.

---

## 2 · La pregunta, tal como la escribí

```
$ claude
```

```
> ¿qué cambié y qué debería revisar antes de subirlo?
```

> Fíjense bien en lo que escribí. No es un comando. No hay ninguna
> diagonal. No nombré ninguna herramienta. Es la pregunta que le haría a un
> compañero de banca.

Aquí **detente**. Es el punto de la demo entera y si lo pasas rápido se
pierde.

---

## 3 · Lo que respondió

```
Revisé los cambios sin commitear en src/factura.py. Agregaste soporte de
cupones de descuento. Cuatro cosas antes de subirlo:

ALTO
· cupones[codigo] lanza KeyError con cualquier código que no exista en el
  diccionario. Un cupón vencido o mal escrito rompe el cálculo completo de
  la factura en vez de ignorarse. Usa cupones.get(codigo, 0) o valida antes.

· calcular_total ahora devuelve round(con_descuento * 1.16, 2). El 1.16
  está escrito a mano, pero el módulo ya define IVA = 0.16 arriba. Si el
  impuesto cambia, la constante se actualiza y este cálculo no. Es el tipo
  de bug que no falla en pruebas y aparece en facturación.

MEDIO
· Los tres códigos de cupón viven en el código. Cada campaña nueva va a
  necesitar un despliegue. Si son de negocio, van en configuración.

BAJO
· calcular_total cambió de firma: agregaste el parámetro cupon. La prueba
  test_total_con_iva sigue pasando porque el parámetro es opcional, pero
  no hay ninguna prueba que cubra la ruta nueva.

Los dos de severidad alta los arreglaría antes de subir. Los otros dos
pueden ir en un seguimiento.
```

**Para dos segundos en silencio.** Luego:

> No le dije qué revisar. No le di el criterio de severidad. No le pegué el
> diff: lo sacó él. Y no le dije que existiera una constante IVA arriba del
> archivo.
>
> Todo eso estaba escrito en un archivo, una sola vez, hace meses.

---

## 4 · El archivo

```
$ cat ~/.claude/skills/revisando-cambios/SKILL.md
```

```markdown
---
description: Revisa los cambios sin commitear y señala lo riesgoso antes de
  subirlos. Úsala cuando el usuario pregunte qué cambió, pida revisar su
  diff, quiera un mensaje de commit o pregunte si su cambio está listo para
  subir.
allowed-tools: Read Grep
---

## Cambios actuales

!`git diff HEAD`

## Instrucciones

1. Resume en dos o tres líneas qué cambió, en términos de comportamiento,
   no de archivos.

2. Lista los riesgos agrupados por severidad: ALTO lo que puede fallar en
   producción, MEDIO lo que va a estorbar después, BAJO lo cosmético.

3. Para cada riesgo di qué hacer, no solo que existe.

4. Si el cambio toca un cálculo, verifica que no haya números escritos a
   mano donde ya exista una constante.

No propongas reescribir el cambio completo. No comentes el estilo salvo
que rompa una convención del repositorio.

<!-- Grado de libertad: ALTA. El criterio de revisión es el valor. -->
```

> Esto es todo. Veinte líneas de texto en una carpeta. Eso es una skill.

Si tienes tiempo, señala **una sola cosa más** y es la que conecta con la
demo siguiente:

> Vean la línea del acento invertido con `git diff HEAD`. Eso es lo que hace
> que no tenga que pegarle el diff. Se ejecuta cuando la skill entra.

---

## 5 · El puente

> En los próximos noventa minutos vamos a ver qué tiene adentro ese archivo,
> por qué se disparó solo sin que yo escribiera ninguna diagonal, y cómo
> escriben ustedes el suyo.
>
> Empecemos por la parte que casi nadie entiende bien.

---

## Lo que NO haces con este respaldo

- **No intentes arrancar Claude Code otra vez a media demo.** Si falló al
  inicio, va a fallar igual dos minutos después, y el segundo intento
  fallido cuesta el doble.
- **No prometas correrlo más tarde.** Si el ambiente se recupera, córrelo en
  la demo 3 sin anunciarlo. Si no se recupera, nadie se acuerda de una
  promesa que no hiciste.
- **No enseñes las cuatro severidades del reporte una por una.** El detalle
  aquí es decorado; lo que enseña es que nadie le dijo cómo hacerlo.
