from src.factura import calcular_subtotal, calcular_total


def test_subtotal_simple():
    lineas = [{"cantidad": 2, "precio": 100}]
    assert calcular_subtotal(lineas) == 200


def test_total_con_iva():
    lineas = [{"cantidad": 1, "precio": 100}]
    assert calcular_total(lineas) == 116.0
