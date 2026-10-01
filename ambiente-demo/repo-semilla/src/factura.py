"""Cálculo de totales de factura."""

IVA = 0.16


def calcular_subtotal(lineas):
    """Suma cantidad * precio de cada línea."""
    return sum(l["cantidad"] * l["precio"] for l in lineas)


def aplicar_descuento(subtotal, porcentaje):
    """Aplica un descuento porcentual al subtotal."""
    return subtotal * (1 - porcentaje / 100)


def calcular_total(lineas, descuento=0):
    """Calcula el total de la factura con IVA."""
    subtotal = calcular_subtotal(lineas)
    con_descuento = aplicar_descuento(subtotal, descuento)
    return round(con_descuento * (1 + IVA), 2)
