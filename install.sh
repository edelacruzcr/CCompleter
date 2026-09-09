#!/usr/bin/env bash

# Instalador automático de Snippets para C en VS Code / VSCodium / Antigravity IDE

set -e

# Configuración de snippets recomendada para autocompletado óptimo
SETTINGS_PATCH='{
  "editor.acceptSuggestionOnEnter": "on",
  "editor.tabCompletion": "on",
  "editor.snippetSuggestions": "top",
  "editor.quickSuggestions": {
    "other": true,
    "comments": false,
    "strings": true
  }
}'

# URL del snippet en GitHub
RAW_URL="https://raw.githubusercontent.com/edelacruzcr/CCompleter/main/c.json"

# ---------------------------------------------------------------------------
# Directorios de snippets por editor/OS
# ---------------------------------------------------------------------------
TARGET_DIRS=()

if [[ "$OSTYPE" == "darwin"* ]]; then
    TARGET_DIRS+=(
        "$HOME/Library/Application Support/Code/User/snippets"
        "$HOME/Library/Application Support/VSCodium/User/snippets"
        "$HOME/Library/Application Support/Code - Insiders/User/snippets"
        "$HOME/Library/Application Support/Antigravity IDE/User/snippets"
    )
else
    TARGET_DIRS+=(
        "$HOME/.config/Code/User/snippets"
        "$HOME/.config/VSCodium/User/snippets"
        "$HOME/.config/Code - Insiders/User/snippets"
        "$HOME/.config/Antigravity IDE/User/snippets"
        "$HOME/.vscode-server/data/User/snippets"
    )
fi

if [ -n "$APPDATA" ]; then
    TARGET_DIRS+=(
        "$APPDATA/Code/User/snippets"
        "$APPDATA/VSCodium/User/snippets"
        "$APPDATA/Antigravity IDE/User/snippets"
    )
fi

# ---------------------------------------------------------------------------
# Función: aplicar parche de settings.json al editor dado su directorio User/
# ---------------------------------------------------------------------------
aplicar_settings() {
    local SETTINGS_FILE="$1"
    if [ ! -f "$SETTINGS_FILE" ]; then
        # Crear settings.json mínimo si no existe
        echo "$SETTINGS_PATCH" > "$SETTINGS_FILE"
        echo "  -> settings.json creado con configuración de snippets."
        return
    fi

    # Verificar si ya tiene tabCompletion configurado
    if grep -q '"editor.tabCompletion"' "$SETTINGS_FILE"; then
        echo "  -> settings.json ya tiene configuración de snippets."
        return
    fi

    # Usar python3 para fusionar JSON de forma segura
    if command -v python3 &>/dev/null; then
        python3 - "$SETTINGS_FILE" "$SETTINGS_PATCH" <<'PYEOF'
import sys, json

settings_file = sys.argv[1]
patch_str = sys.argv[2]

with open(settings_file, "r") as f:
    try:
        settings = json.load(f)
    except json.JSONDecodeError:
        settings = {}

patch = json.loads(patch_str)
settings.update(patch)

with open(settings_file, "w") as f:
    json.dump(settings, f, indent=4, ensure_ascii=False)
    f.write("\n")

print("  -> settings.json actualizado para habilitar Tab/Enter en snippets.")
PYEOF
    else
        echo "  -> (python3 no disponible, actualiza settings.json manualmente)"
    fi
}

# ---------------------------------------------------------------------------
# Instalar snippets
# ---------------------------------------------------------------------------
INSTALLED_COUNT=0

for DIR in "${TARGET_DIRS[@]}"; do
    PARENT_DIR=$(dirname "$DIR")
    if [ -d "$PARENT_DIR" ] || [ -d "$DIR" ]; then
        mkdir -p "$DIR"
        echo "Instalando snippets en: $DIR"

        if [ -f "./c.json" ]; then
            cp "./c.json" "$DIR/c.json"
        else
            curl -fsSL "$RAW_URL" -o "$DIR/c.json"
        fi

        echo "  -> c.json instalado correctamente."

        # Aplicar configuración de settings.json del editor correspondiente
        SETTINGS_FILE="$PARENT_DIR/settings.json"
        aplicar_settings "$SETTINGS_FILE"

        INSTALLED_COUNT=$((INSTALLED_COUNT + 1))
    fi
done

# ---------------------------------------------------------------------------
# Fallback: instalar en VS Code por defecto si no se detectó ningún editor
# ---------------------------------------------------------------------------
if [ $INSTALLED_COUNT -eq 0 ]; then
    FALLBACK_DIR="$HOME/.config/Code/User/snippets"
    mkdir -p "$FALLBACK_DIR"
    if [ -f "./c.json" ]; then
        cp "./c.json" "$FALLBACK_DIR/c.json"
    else
        curl -fsSL "$RAW_URL" -o "$FALLBACK_DIR/c.json"
    fi
    echo "Instalado en directorio por defecto: $FALLBACK_DIR/c.json"
    aplicar_settings "$HOME/.config/Code/User/settings.json"
fi

echo ""
echo "Instalacion finalizada con exito."
echo "Abre un archivo .c en VS Code o Antigravity IDE y escribe:"
echo "  'main'      -> estructura main basica"
echo "  'inc_todos' -> incluir headers comunes"
echo "  'for'       -> bucle for"
echo "Acepta con Tab o Enter."
echo ""
