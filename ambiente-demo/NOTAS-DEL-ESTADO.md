# Qué hay sembrado en el estado de trabajo

El `git diff HEAD` del repositorio de demostración contiene, a propósito,
cuatro problemas de distinta severidad. Las demos 1 y 6 los usan.

| # | Problema | Dónde | Por qué está ahí |
|---|---|---|---|
| 1 | `cupones[codigo]` lanza `KeyError` con un código inválido | `aplicar_cupon` | Manejo de errores ausente. Es el hallazgo más visible |
| 2 | `1.16` hardcodeado en vez de usar la constante `IVA` | `calcular_total` | Valor mágico. Ya existe la constante dos líneas arriba |
| 3 | Los códigos de cupón viven en el código, no en configuración | `aplicar_cupon` | Datos de negocio hardcodeados |
| 4 | `test_total_con_iva` no cubre el parámetro `cupon` nuevo | `tests/` | Prueba desactualizada por el cambio |

**Por qué estos cuatro.** Son reconocibles por cualquier desarrollador,
en cualquier lenguaje, sin conocer el proyecto. El público del webinar es
mixto: el ejemplo tiene que funcionar para alguien de Java tanto como para
alguien de Python.

**Lo que NO hay sembrado, y es deliberado:** ningún problema que requiera
contexto del dominio. Si la audiencia tiene que entender facturación
mexicana para seguir la demo, la demo falló.

## Si Claude encuentra cosas distintas

Es normal y **no es un problema**. La demo no depende de que encuentre
exactamente estos cuatro. Lo que la demo demuestra es que la skill se
dispara sola y produce una revisión con criterio.

Si encuentra algo que tú no habías visto, dilo en voz alta: refuerza el
punto en vez de debilitarlo.
