if [ $# -eq 0 ] || [ $# -gt 2 ]; then
    echo "Uso: mycli <target> <destination: ~/.dotfiles/\$target>"
    exit 1
fi

target="$1"

destination="${2:-$HOME/.dotfiles/$(basename $target)}"

cp -ra $target $destination

rm -rf $target

ln -s $destination $target

echo "Operación exitosa"
