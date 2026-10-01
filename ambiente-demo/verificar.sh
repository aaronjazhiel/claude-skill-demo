#!/usr/bin/env bash
# Checklist técnico automatizado. Córrelo T-1 hora.
set -uo pipefail

DESTINO="${1:-$HOME/demo-webinar}"
SKILLS="$HOME/.claude/skills"
FALLOS=0

ok()   { printf '\033[32m  ✓\033[0m %s\n' "$1"; }
mal()  { printf '\033[31m  ✗\033[0m %s\n' "$1"; FALLOS=$((FALLOS+1)); }
tit()  { printf '\n\033[34m%s\033[0m\n' "$1"; }

printf '\n\033[34m═══ Verificación del ambiente de demostración ═══\033[0m\n'

tit "Claude Code"
if command -v claude >/dev/null 2>&1; then
  ok "claude está en el PATH — versión: $(claude --version 2>/dev/null | head -1)"
else
  mal "claude NO está en el PATH"
fi

tit "Repositorio de demostración"
if [ -d "$DESTINO/.git" ]; then
  ok "Repositorio existe en $DESTINO"
  cd "$DESTINO" || exit 1
  N=$(git diff --numstat 2>/dev/null | awk '{s+=$1+$2} END {print s+0}')
  if [ "$N" -gt 0 ]; then
    ok "Hay cambios sin commitear ($N líneas) — la demo 1 tiene qué mostrar"
  else
    mal "NO hay cambios sin commitear. Corre resetear.sh"
  fi
  if grep -q "aplicar_cupon" src/factura.py 2>/dev/null; then
    ok "El estado de trabajo tiene los problemas sembrados"
  else
    mal "Falta el estado de trabajo. Corre resetear.sh"
  fi
else
  mal "No hay repositorio en $DESTINO. Corre preparar.sh"
fi

tit "Skills instaladas"
for s in revisando-cambios revisando-readme; do
  if [ -f "$SKILLS/$s/SKILL.md" ]; then ok "$s"; else mal "$s NO está instalada"; fi
done
if [ -x "$SKILLS/revisando-readme/scripts/verificar.sh" ]; then
  ok "El script de revisando-readme es ejecutable"
else
  mal "El script de revisando-readme NO es ejecutable"
fi

tit "Skills que NO deben estar todavía"
for s in doc-helper resumiendo-cambios destilada-en-vivo; do
  if [ -d "$SKILLS/$s" ]; then
    mal "$s está instalada y no debería — la crea una demo en vivo"
  else
    ok "$s ausente (correcto)"
  fi
done

tit "Presentación"
printf '  \033[90m→ Verifica a mano:\033[0m\n'
printf '  \033[90m  · Terminal a 18 pt o más, tema claro\033[0m\n'
printf '  \033[90m  · Notificaciones silenciadas\033[0m\n'
printf '  \033[90m  · Segunda pantalla con el guion de demostraciones abierto\033[0m\n'
printf '  \033[90m  · Los seis respaldos abiertos en pestañas del navegador\033[0m\n'

echo ""
if [ "$FALLOS" -eq 0 ]; then
  printf '\033[32m═══ Ambiente listo. Todas las comprobaciones pasaron. ═══\033[0m\n\n' 
  exit 0
else
  printf '\033[31m═══ %s comprobación(es) fallaron. Resuélvelas antes de transmitir. ═══\033[0m\n\n' "$FALLOS"
  exit 1
fi
