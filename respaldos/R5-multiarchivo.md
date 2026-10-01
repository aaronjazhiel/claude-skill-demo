# R5 · Multiarchivo y script

**Sustituye a:** demo 5, *Multiarchivo y script*.

**Cuándo lo usas:** el ambiente falló, el script no corre, o vas retrasado.
Es la primera demo que se recorta cuando falta tiempo: el patrón se puede
enseñar leyendo dos líneas.

**Duración leyendo:** 5 minutos. En emergencia, las secciones 2 y 4 solas
toman 2 minutos y salvan el contenido.

---

## 1 · Las tres piezas

```
$ find ~/.claude/skills/revisando-readme
```

```
/home/erick/.claude/skills/revisando-readme
/home/erick/.claude/skills/revisando-readme/SKILL.md
/home/erick/.claude/skills/revisando-readme/reference.md
/home/erick/.claude/skills/revisando-readme/scripts
/home/erick/.claude/skills/revisando-readme/scripts/verificar.sh
```

> Tres piezas con tres destinos distintos, y la diferencia entre ellas es lo
> que hay que entender.
>
> El `SKILL.md` tiene el procedimiento y **siempre** se carga cuando la skill
> entra. El `reference.md` tiene el detalle y se carga **solo si hace falta**.
> Y el script no se carga nunca: se **ejecuta**.

---

## 2 · El patrón anti-permiso

```
$ head -6 ~/.claude/skills/revisando-readme/SKILL.md
```

```yaml
---
description: Revisa que un README tenga las secciones que el equipo exige y
  señala lo que falta. Úsala cuando el usuario mencione README, documentación
  del proyecto, o pregunte si su documentación está completa.
allowed-tools: Read Grep Bash(bash ${CLAUDE_SKILL_DIR}/scripts/verificar.sh *)
---
```

Esta es la sección que más vale del respaldo. Señala la cuarta línea y
detente en ella.

> Aquí está el truco que vale su peso en oro, y es de los que no vienen en
> ningún tutorial.
>
> La ruta del script aparece en **dos lugares**. En el cuerpo, donde le digo
> que lo ejecute. Y aquí arriba, en `allowed-tools`, con la misma variable,
> escrita idéntica.
>
> Como las dos coinciden exactamente, el script corre **sin pedirme
> permiso**. Sin este patrón, cada ejecución me interrumpe con una pregunta,
> y una skill que interrumpe es una skill que nadie usa.

Y la aclaración que evita el malentendido más frecuente:

> Ojo con una cosa: `allowed-tools` **otorga** permiso, no lo quita. No es
> una lista de restricción. Y se limpia en el mensaje siguiente, así que no
> es una puerta que dejas abierta.

---

## 3 · El cuerpo

```
$ sed -n '7,30p' ~/.claude/skills/revisando-readme/SKILL.md
```

```markdown
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
```

> Vean el paso 1 contra el paso 4. Al script le digo "ejecuta". Al
> `reference.md` le digo "consulta". Son dos verbos distintos porque son dos
> mecanismos distintos, y confundirlos es el error más común del patrón
> multiarchivo.
>
> Y vean el paso 2: el script dice qué falta, pero le pido que **verifique**
> antes de reportarlo. El script no sabe que "Cómo empezar" es la sección de
> instalación con otro nombre. El modelo sí.

---

## 4 · La corrida

```
$ claude
> ¿mi README está completo?
```

Primero lo que hizo el script, porque eso es lo que la audiencia no espera:

```
ARCHIVO: README.md
LINEAS: 9

SECCIONES ENCONTRADAS:
# facturador
## Uso

VERIFICACION:
  FALTA   Requisitos
  FALTA   Instalaci
  OK      Uso
  FALTA   Configuraci
  FALTA   Desarrollo
  FALTA   Licencia
```

Y el reporte:

```
Corrí la verificación contra README.md. Tiene 9 líneas y dos encabezados.

FALTA
· Requisitos — no dice qué versión de Python necesita ni qué dependencias.
  Según la referencia del equipo, aquí van números de versión, no
  "reciente".
· Instalación — no hay ningún comando. Quien clona el repositorio no tiene
  primer paso.
· Configuración — el ejemplo de uso recibe un archivo JSON cuyo formato no
  está documentado en ninguna parte.
· Licencia — no hay ninguna.

MEJORABLE
· Uso existe y es lo único que existe, pero el comando apunta a
  datos/ejemplo.json, que no está en el repositorio. Copiar ese comando
  falla.
· Falta decir qué formato de entrada acepta. La referencia pide al menos un
  ejemplo completo que funcione al copiarlo, y este no funciona.

Lo primero que arreglaría es Instalación, y de paso agregar el archivo de
ejemplo que el comando de Uso ya promete.

El script no pidió permiso porque la regla de allowed-tools coincide con el
comando.
```

> El script hizo la parte mecánica: contar encabezados, buscar secciones. El
> modelo hizo la parte que un script no puede: darse cuenta de que el ejemplo
> del README apunta a un archivo que no existe.
>
> Y consultó el `reference.md` en el camino: por eso dice "números de versión,
> no reciente". Eso no está en el `SKILL.md`, está en el archivo de detalle.
> Se cargó cuando hizo falta y no antes.

---

## 5 · Las tres reglas

> Tres reglas donde se equivoca todo el mundo, y las tres se ven en este
> archivo:
>
> **Las referencias van a un solo nivel.** Este `SKILL.md` apunta al
> `reference.md` y ahí se acaba. El `reference.md` no apunta a otro archivo.
> Las cadenas de dos niveles funcionan a veces y fallan otras, que es la
> peor combinación posible.
>
> **Los scripts se ejecutan, no se leen.** Un script de cien líneas que se
> lee ocupa cien líneas de contexto y no hace nada. Ejecutado, ocupa las
> quince líneas de su salida y hace el trabajo.
>
> **Las rutas usan la variable, nunca rutas absolutas.** `${CLAUDE_SKILL_DIR}`
> funciona en mi máquina, en la de ustedes y en el contenedor de su
> integración continua. `/home/erick/.claude/...` funciona solo aquí.

---

## Si vas retrasado

Recorta a **sección 2 y sección 5**. Son 2 minutos, y contienen lo único
que la audiencia no puede deducir sola: el patrón de la doble mención y las
tres reglas.

Lo que se sacrifica sin costo: la sección 1 (la estructura se entiende con
decirla), la 3 y la 4.
