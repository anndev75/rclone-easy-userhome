
#!/bin/bash

directorios=("Descargas" "Documentos" "Imágenes" "Música" "Escritorio" "ISOs")
directorio_padre="/home/$USER"

# Tener una nube previamente conectada
remoto="Gdrive:LINUX-HOME"  

confirm() { # Confirmación
    read -p "$1 (s/N): " respuesta
    case "$respuesta" in
        [SsYy]*) return 0 ;;
        *) return 1 ;;
    esac
}

sincronizar() {
    local _from="$1"
    local _to="$2"

    for dir in "${directorios[@]}"; do
        if confirm "¿Deseas sincronizar desde ${_from}/${dir} a ${_to}/${dir}?"; then
            rclone sync "${_from}/${dir}" "${_to}/${dir}" --progress
        else
            printf "No se sincronizará %s/%s a %s/%s\n" "$_from" "$dir" "$_to" "$dir"
        fi
    done
}

copiar() {
    local _from="$1"
    local _to="$2"

    for dir in "${directorios[@]}"; do
        if confirm "¿Deseas copiar desde ${_from}/${dir} a ${_to}/${dir}?"; then
            rclone copy "${_from}/${dir}" "${_to}/${dir}" --progress
        else
            printf "No se copiará %s/%s a %s/%s\n" "$_from" "$dir" "$_to" "$dir"
        fi
    done
}

# Verificar rclone
if ! command -v rclone &> /dev/null; then
    printf "❌ Error: El paquete rclone no está instalado.\nInstálalo con tu gestor de paquetes por defecto (apt|pacman|dnf)\n"
    exit 1
fi

# MENÚ PRINCIPAL
printf "\nSincronizado ahora en %s\nSe recomienda actualizar con su propia nube configurada con rclone.\n" "$remoto"
printf "================================\n"
printf "    COPY OR SYNC LOCAL-CLOUD    \n"
printf "================================\n"
printf "1. COPIAR de local → remoto\n"
printf "2. COPIAR de remoto → local\n"
printf "3. SINCRONIZAR de local → remoto\n"
printf "4. SINCRONIZAR de remoto → local\n"
printf "5. Salir\n"
printf "============================\n"
read -p "Selecciona una opción [1-5]: " opcion

case $opcion in
    1)
        copiar "$directorio_padre" "$remoto"
        ;;
    2)
        copiar "$remoto" "$directorio_padre"
        ;;
    3)
        sincronizar "$directorio_padre" "$remoto"
        ;;
    4)
        sincronizar "$remoto" "$directorio_padre"
        ;;
    5)
        printf "Saliendo... ¡Hasta la próxima!\n"
        exit 0
        ;;
    *)
        printf "Opción inválida.\n"
        ;;
esac
