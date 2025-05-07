CONFIG_FILE="/etc/nixos/packages.nix"

modify_packages() {
    for PACKAGE in "$@"; do
        if [[ "$PACKAGE" == +* ]]; then
            PACKAGE_NAME="${PACKAGE:1}"
            if ! grep -q "$PACKAGE_NAME" "$CONFIG_FILE"; then
                sed -i "s|\];|  $PACKAGE_NAME\n  ];|" "$CONFIG_FILE"
                echo "Paquete '$PACKAGE_NAME' agregado."
            else
                echo "El paquete '$PACKAGE_NAME' ya está en la lista."
            fi
        elif [[ "$PACKAGE" == -* ]]; then
            PACKAGE_NAME="${PACKAGE:1}"
            if grep -q "$PACKAGE_NAME" "$CONFIG_FILE"; then
                sed -i "/$PACKAGE_NAME/d" "$CONFIG_FILE"
                sed -ri '/^\s*$/d' "$CONFIG_FILE"
                echo "Paquete '$PACKAGE_NAME' eliminado."
            else
                echo "El paquete '$PACKAGE_NAME' no está en la lista."
            fi
        else
            echo "Formato no válido para '$PACKAGE'. Usa +paquete para agregar o -paquete para eliminar."
        fi
    done
}

if [ $# -lt 1 ]; then
    echo "Uso: $0 [+paquete] [-paquete] ..."
    exit 1
fi

modify_packages "$@" && ~/Programming/scripts/rebuild-nix.sh
