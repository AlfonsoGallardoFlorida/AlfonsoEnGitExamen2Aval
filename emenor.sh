#!/bin/bash

declare -A consumoCiudades

while read linea; do
  ciudad=$(echo $linea | awk '{print $1}')
  consumo=$(echo $linea | awk '{print $4}')

  if [ ${consumoCiudades[$ciudad]+_} ]; then
    consumoCiudades[$ciudad]=$((consumoCiudades[$ciudad] + $consumo))
  else
    consumoCiudades[$ciudad]=$consumo
  fi
done < consumos.txt

ciudadConsumoMenor=""
consumoMenor=0

for ciudad in "${!consumoCiudades[@]}"; do
  media=$((consumoCiudades[$ciudad] / 7)) # dividimos entre el número de meses
  if [ $consumoMenor -eq 0 ] || [ $media -lt $consumoMenor ]; then
    ciudadMenorConsumo=$ciudad
    consumoMenor=$media
  fi
done

if [ $consumoMenor -eq 0 ]; then
  echo "No se encontraron consumos en el archivo."
else
  echo "La ciudad con el menor consumo es: $ciudadMenorConsumo"
fi