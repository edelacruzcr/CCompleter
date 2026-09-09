#!/usr/bin/env bash

# ==============================================================================
# Instalador automático de Snippets para C en VS Code / VSCodium
# ==============================================================================

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}======================================================${NC}"
echo -e "${BLUE}   🚀 Biblioteca Completa de Snippets C para VS Code  ${NC}"
echo -e "${BLUE}======================================================${NC}"

# Definir posibles rutas donde se guardan los snippets según OS y editor
TARGET_DIRS=()

if [[ "$OSTYPE" == "darwin"* ]]; then
    TARGET_DIRS+=("$HOME/Library/Application Support/Code/User/snippets")
    TARGET_DIRS+=("$HOME/Library/Application Support/VSCodium/User/snippets")
    TARGET_DIRS+=("$HOME/Library/Application Support/Code - Insiders/User/snippets")
else
    TARGET_DIRS+=("$HOME/.config/Code/User/snippets")
    TARGET_DIRS+=("$HOME/.config/VSCodium/User/snippets")
    TARGET_DIRS+=("$HOME/.config/Code - Insiders/User/snippets")
    TARGET_DIRS+=("$HOME/.vscode-server/data/User/snippets")
fi

if [ -n "$APPDATA" ]; then
    TARGET_DIRS+=("$APPDATA/Code/User/snippets")
    TARGET_DIRS+=("$APPDATA/VSCodium/User/snippets")
fi

# URL cruda por defecto si se ejecuta mediante curl/wget en remoto
RAW_URL="https://raw.githubusercontent.com/edelacruzcr/CCompleter/main/c.json"

INSTALLED_COUNT=0

for DIR in "${TARGET_DIRS[@]}"; do
    PARENT_DIR=$(dirname "$DIR")
    if [ -d "$PARENT_DIR" ] || [ -d "$DIR" ]; then
        mkdir -p "$DIR"
        echo -e "${YELLOW}📂 Instalando en:${NC} $DIR"
        
        if [ -f "./c.json" ]; then
            cp "./c.json" "$DIR/c.json"
        else
            curl -fsSL "$RAW_URL" -o "$DIR/c.json"
        fi
        
        echo -e "${GREEN}✓ Instalado exitosamente en: $DIR/c.json${NC}"
        INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
    fi
done

if [ $INSTALLED_COUNT -eq 0 ]; then
    FALLBACK_DIR="$HOME/.config/Code/User/snippets"
    mkdir -p "$FALLBACK_DIR"
    if [ -f "./c.json" ]; then
        cp "./c.json" "$FALLBACK_DIR/c.json"
    else
        curl -fsSL "$RAW_URL" -o "$FALLBACK_DIR/c.json"
    fi
    echo -e "${GREEN}✓ Instalado en directorio por defecto: $FALLBACK_DIR/c.json${NC}"
fi

echo -e "\n${GREEN}🎉 ¡Instalación finalizada con éxito!${NC}"
echo -e "Abre cualquier archivo .c en VS Code y prueba escribiendo ${BLUE}main${NC} o ${BLUE}inc_todos${NC}.\n"
