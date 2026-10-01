#!/usr/bin/env bash
# Verifica secciones obligatorias en el README del proyecto.
set -uo pipefail

README=""
for f in README.md readme.md README.MD; do
  [ -f "$f" ] && README="$f" && break
done

if [ -z "$README" ]; then
  echo "SIN_README: no se encontró README.md en el directorio actual"
  exit 0
fi

echo "ARCHIVO: $README"
echo "LINEAS: $(wc -l < "$README" | tr -d ' ')"
echo ""
echo "SECCIONES ENCONTRADAS:"
grep -E '^#{1,3} ' "$README" || echo "  (ninguna)"
echo ""
echo "VERIFICACION:"

for seccion in "Requisitos|Requirements" "Instalaci|Install" "Uso|Usage|Ejemplo" \
               "Configuraci|Configuration" "Desarrollo|Development" "Licencia|License"; do
  etiqueta="${seccion%%|*}"
  if grep -qiE "^#{1,3} .*($seccion)" "$README"; then
    echo "  OK      $etiqueta"
  else
    echo "  FALTA   $etiqueta"
  fi
done
