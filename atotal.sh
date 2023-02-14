#!/bin/bash

# verificar que se haya pasado un parámetro de ciudad
if [ $# -eq 0 ]; then
    echo "Error: No se ha proporcionado una ciudad como parámetro."
    exit 1
fi

# leer el archivo de datos de consumo
archivo="consumos.txt"

# función para calcular el total de consumo de una ciudad
CalculaConsumoTotal() {
    ciudad="$1"
    total=0
    while read -r linea; do
        lineaCiudad=$(echo "$linea" | cut -d " " -f 1)
        if [ "$lineaCiudad" = "$ciudad" ]; then
            consumo=$(echo "$linea" | cut -d " " -f 4)
            total=$((total+consumo))
        fi
    done < "$archivo"
    echo "$total"
}

# bucle para solicitar la entrada del usuario hasta que se ingrese una ciudad válida
while true; do
    consumoTotal=$(CalculaConsumoTotal "$1")
    if [ "$consumoTotal" -eq 0 ]; then
        echo "Error: Ciudad no encontrada o mal introducida."
        read -p "Ingrese el nombre de la ciudad: " ciudad
        set -- "$ciudad"
    else
        echo "El total de consumo de $1 es $consumoTotal"
        break
    fi
done
