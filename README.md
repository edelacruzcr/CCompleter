# CCompleter - Biblioteca Completa de Snippets para C (VS Code / VSCodium)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https.mit-license.org)
[![VS Code](https://img.shields.io/badge/VS%20Code-Snippets-blue.svg)](https://code.visualstudio.com/)
[![Lenguaje](https://img.shields.io/badge/Lenguaje-C%2FC%2B%2B-00599C.svg)](https://en.cppreference.com/)

Una colección exhaustiva, moderna y optimizada de **snippets de código para el Lenguaje C** que cubre todas las áreas del lenguaje: desde `includes` hasta manejo de memoria dinámica, punteros, estructuras, manejo de archivos y funciones matemáticas.

---

## Instalación Rápida en 1 Solo Comando (Global)

Puedes instalar todos estos snippets en tu VS Code / VSCodium automáticamente ejecutando un único comando en la terminal.

### Linux / macOS / WSL:

```bash
curl -fsSL https://raw.githubusercontent.com/edelacruzcr/CCompleter/main/install.sh | bash
```

### Windows (PowerShell):

```powershell
iwr -useb https://raw.githubusercontent.com/edelacruzcr/CCompleter/main/install.ps1 | iex
```

---

## Instalación Manual

Si prefieres agregarlos manualmente a VS Code:

1. Presiona `Ctrl + Shift + P` (o `Cmd + Shift + P` en Mac).
2. Selecciona **Snippets: Configure User Snippets** (*Configurar fragmentos de código de usuario*).
3. Elige `c.json` (o crea un nuevo archivo de snippets globales `c-complete.code-snippets`).
4. Copia y pega el contenido del archivo [`c.json`](./c.json).
5. Guarda el archivo (`Ctrl + S`).

---

## Categorías y Prefijos Destacados

### Includes y Estructura Base
| Prefijo | Descripción |
|---|---|
| `main` | Estructura básica de `main(void)` |
| `mainargs` | Estructura de `main(int argc, char *argv[])` |
| `inc_todos` | Incluye `stdio.h`, `stdlib.h`, `string.h`, `stdbool.h`, `math.h` de una vez |
| `inc_stdio`, `inc_stdlib`, `inc_string`, etc. | Inclusión de headers individuales |

### Variables y Tipos de Datos
| Prefijo | Descripción |
|---|---|
| `vint`, `vfloat`, `vdouble`, `vchar`, `vbool` | Declaración de variables básicas |
| `vstring` | Array de caracteres / String (`char nombre[100]`) |
| `vptr` | Declaración de puntero con inicialización a NULL |
| `vconst`, `vstatic`, `vextern` | Modificadores de variables |

### Arrays y Memoria Dinámica
| Prefijo | Descripción |
|---|---|
| `array` | Declarar array estático |
| `array_malloc` | Crear array dinámico con `malloc` y validación de error |
| `array_calloc` | Crear array dinámico con `calloc` (inicializado a 0) |
| `array2d_malloc` | Crear matriz 2D dinámica con validación |
| `malloc`, `calloc`, `realloc` | Asignación de memoria con cast y verificación |
| `free` | Liberación segura de memoria (asigna NULL tras `free`) |
| `free2d` | Liberación completa de matrices 2D |

### Bucles y Condicionales
| Prefijo | Descripción |
|---|---|
| `for` | Bucle `for` clásico |
| `for_down` | Bucle `for` descendente |
| `while`, `dowhile` | Bucles `while` y `do-while` |
| `ifelse`, `ifelseif` | Estructuras de decisión |
| `switch` | Estructura `switch-case` con `default` |
| `ternario` | Operador ternario (`? :`) |

### Funciones, Structs, Enums y Punteros
| Prefijo | Descripción |
|---|---|
| `func` | Declaración e implementación de función |
| `proto` | Prototipo de función |
| `struct` | Definición de estructura con `typedef` |
| `enum` | Definición de enumeración con `typedef` |
| `ptr` | Puntero básico asignado a la dirección de una variable |
| `ptr_func` | Puntero a función |

### Entrada / Salida y Archivos
| Prefijo | Descripción |
|---|---|
| `printf_var`, `printf_int`, `printf_float`, `printf_str` | Salida formateada |
| `fgets` | Lectura segura de líneas desde consola sin desbordamiento |
| `fopen_r`, `fopen_w`, `fopen_a`, `fopen_rb` | Apertura de archivos con control de errores |
| `fgets_file` | Lectura línea por línea de un archivo |
| `fread`, `fwrite` | Lectura y escritura binaria |

---

## Configuración Recomendada en VS Code (`settings.json`)

Para una experiencia óptima con autocompletado de snippets, añade estas opciones a tu `settings.json`:

```json
{
  "editor.quickSuggestions": {
    "other": true,
    "comments": false,
    "strings": true
  },
  "editor.snippetSuggestions": "top",
  "editor.tabCompletion": "on"
}
```

---

## Licencia

Este proyecto está bajo la Licencia [MIT](LICENSE). Siéntete libre de modificarlo, compartirlo y mejorar tus flujos de desarrollo.
