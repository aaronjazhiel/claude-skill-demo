#!/usr/bin/env bash
# Devuelve el ambiente al estado inicial, sin recrear el repositorio.
# Úsalo entre ensayos, o si una demo dejó el ambiente sucio.
set -uo pipefail

AQUI="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DESTINO="${1:-$HOME/demo-webinar}"
SKILLS="$HOME/.claude/skills"

verde() { printf '\033[32m✓ %s\033[0m\n' "$1"; }
rojo()  { printf '\033[31m✗ %s\033[0m\n' "$1"; }

if [ ! -d "$DESTINO/.git" ]; then
  rojo "No hay repositorio en $DESTINO. Corre preparar.sh primero."
  exit 1
fi

cd "$DESTINO" || exit 1
git reset -q --hard HEAD 2>/dev/null
git clean -qfd 2>/dev/null
cp "$AQUI/estado-trabajo/src/factura.py" "$DESTINO/src/factura.py"
verde "Repositorio devuelto al estado inicial"

# las skills que la demo 4 crea en vivo se borran
for s in resumiendo-cambios destilada-en-vivo doc-helper; do
  [ -d "$SKILLS/$s" ] && rm -rf "${SKILLS:?}/$s" && verde "Skill de demo eliminada: $s"
done

# las dos permanentes se reinstalan por si se editaron en vivo
for s in revisando-cambios revisando-readme; do
  rm -rf "${SKILLS:?}/$s"; cp -r "$AQUI/skills-demo/$s" "$SKILLS/"
done
chmod +x "$SKILLS/revisando-readme/scripts/verificar.sh" 2>/dev/null
verde "Skills restauradas"
echo ""
