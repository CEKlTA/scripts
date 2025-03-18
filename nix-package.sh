CONFIG_FILE="/etc/nixos/packages.nix"

add_package() {
    for PACKAGE in "$@"; do
        if ! grep -q "$PACKAGE" "$CONFIG_FILE"; then
            sed -i "s|\];|  $PACKAGE\n  ];|" "$CONFIG_FILE"
            echo "Paquete '$PACKAGE' agregado."
        else
            echo "El paquete '$PACKAGE' ya está en la lista."
        fi
    done
}

remove_package() {
    for PACKAGE in "$@"; do
        if grep -q "$PACKAGE" "$CONFIG_FILE"; then
            sed -i "/$PACKAGE/d" "$CONFIG_FILE"
            sed -ri '/^\s*$/d' "$CONFIG_FILE"
            echo "Paquete '$PACKAGE' eliminado."
        else
            echo "El paquete '$PACKAGE' no está en la lista."
        fi
    done
}

if [ $# -lt 2 ]; then
    echo "Uso: $0 {add|remove} <paquete1> [paquete2] [paquete3] ..."
    exit 1
fi

ACTION=$1
shift

case $ACTION in
    add)
        add_package "$@"
        ;;
    remove)
        remove_package "$@"
        ;;
    *)
        echo "Acción no válida. Usa 'add' o 'remove'."
        exit 1
        ;;
esac
