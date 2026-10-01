#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════
#  Prepara el ambiente de demostración del webinar.
#  Idempotente: puedes correrlo las veces que quieras.
#
#  USO:  bash preparar.sh [ruta-destino]
#  Por defecto crea ~/demo-webinar
# ═══════════════════════════════════════════════════════════════
set -uo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DESTINO="${1:-$HOME/demo-webinar}"
SKILLS="$HOME/.claude/skills"

azul()  { printf '\033[34m%s\033[0m\n' "$1"; }
verde() { printf '\033[32m✓ %s\033[0m\n' "$1"; }
rojo()  { printf '\033[31m✗ %s\033[0m\n' "$1"; }
gris()  { printf '\033[90m  %s\033[0m\n' "$1"; }

echo ""
azul "═══ Preparando el ambiente de demostración ═══"
echo ""

# ── 1 · repositorio ──
if [ -d "$DESTINO" ]; then
  gris "El destino ya existe. Se recrea desde cero."
  rm -rf "$DESTINO"
fi
mkdir -p "$DESTINO"
cp -r "$AQUI/repo-semilla/." "$DESTINO/"
verde "Repositorio copiado en $DESTINO"

cd "$DESTINO" || exit 1
git init -q 2>/dev/null
git config user.name  "Demo Webinar" 2>/dev/null
git config user.email "demo@ejemplo.local" 2>/dev/null
git add -A >/dev/null 2>&1
git commit -qm "feat: cálculo de totales de factura con IVA" 2>/dev/null
verde "Commit inicial creado"

# ── 2 · estado de trabajo (el diff que ven las demos) ──
cp "$AQUI/estado-trabajo/src/factura.py" "$DESTINO/src/factura.py"
LINEAS=$(git diff --numstat 2>/dev/null | awk '{s+=$1+$2} END {print s+0}')
verde "Estado de trabajo aplicado ($LINEAS líneas de diff)"

# ── 3 · skills ──
mkdir -p "$SKILLS"
for s in revisando-cambios revisando-readme; do
  rm -rf "${SKILLS:?}/$s"
  cp -r "$AQUI/skills-demo/$s" "$SKILLS/"
  verde "Skill instalada: $s"
done

# la saboteada NO se instala: se instala en vivo durante la demo 6
gris "doc-helper (saboteada) queda sin instalar — es parte de la demo 6"

chmod +x "$SKILLS/revisando-readme/scripts/verificar.sh" 2>/dev/null

echo ""
azul "═══ Listo ═══"
echo ""
gris "Abre una terminal en:  $DESTINO"
gris "Verifica con:          bash $AQUI/verificar.sh"
gris "Resetea entre ensayos: bash $AQUI/resetear.sh"
echo ""
