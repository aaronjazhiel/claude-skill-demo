#!/bin/bash
echo "Limpiando resultados y entorno virtual..."
rm -rf .venv
rm -f resultados/*.json resultados/*.docx
echo "Listo ✅"
