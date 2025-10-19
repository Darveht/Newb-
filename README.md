# Roogle - Motor de Búsqueda para Roblox

Este proyecto es un motor de búsqueda estilo Google creado para Roblox, donde los administradores pueden publicar artículos y los jugadores pueden buscarlos y leerlos.

## 🎮 Descripción

Roogle es una interfaz de búsqueda y lectura de artículos diseñada para funcionar dentro de un juego de Roblox. Incluye:

- **Barra de búsqueda** estilo Google
- **Tarjetas de artículos** con vista previa
- **Vista completa de artículos** al hacer clic
- **Panel de administrador** para publicar y gestionar artículos
- **Sistema de permisos** para administradores

## 📋 Estructura del Proyecto

- `server.lua` - Script del servidor (ServerScriptService)
- `local.lua` - Script del cliente (StarterPlayer > StarterPlayerScripts)

## 🚀 Cómo usar en Roblox Studio

### 1. Configurar el Servidor

1. Abre Roblox Studio
2. En el Explorer, ve a **ServerScriptService**
3. Crea un nuevo Script llamado "RoogleServer"
4. Copia todo el contenido de `server.lua` en este script

### 2. Configurar el Cliente

1. En el Explorer, ve a **StarterPlayer > StarterPlayerScripts**
2. Crea un nuevo LocalScript llamado "RoogleClient"
3. Copia todo el contenido de `local.lua` en este script

### 3. Configurar Administradores

En `server.lua`, líneas 28-31, modifica la lista de administradores:

```lua
local ADMINS = {
    "TuNombreDeUsuario",  -- Reemplaza con tu nombre de usuario
    "OtroAdmin",          -- Agrega más administradores aquí
}
```

### 4. Probar el Juego

1. Presiona F5 o el botón Play en Roblox Studio
2. Si eres administrador, verás un botón ⚙️ en la esquina superior derecha
3. Usa el panel para publicar artículos
4. Busca artículos usando la barra de búsqueda

## ✨ Características Recientes

### Mejoras de Diseño (Última Actualización)

Se corrigieron problemas de diseño donde el texto se salía de los márgenes:

- **Tarjetas de artículos**: El texto ahora se trunca correctamente sin desbordarse
- **Vista completa**: Los artículos largos ahora se muestran con márgenes adecuados y texto envuelto
- **Scroll dinámico**: El área de scroll se ajusta automáticamente al contenido
- **Márgenes consistentes**: Todo el contenido respeta los límites de la pantalla (vertical y horizontal)

## 🔧 Requisitos Técnicos

- **Plataforma**: Roblox Studio
- **API**: Roblox DataStore API (para almacenamiento de artículos)
- **Servicios necesarios**:
  - DataStoreService
  - ReplicatedStorage
  - Players
  - StarterPlayer

## ⚠️ Nota Importante

Este código está diseñado específicamente para Roblox y **NO puede ejecutarse fuera de Roblox Studio**. Usa las APIs propias de Roblox que solo están disponibles en su motor de juego.

## 🛠️ Validación de Código

Este proyecto incluye validación de sintaxis Lua para asegurar que el código no tenga errores de sintaxis antes de usarlo en Roblox Studio.

## 📝 Licencia

Este es un proyecto personal para uso en Roblox.
