#!/bin/bash

# Lectura del archivo de consumos
readarray -t consumos < consumos.txt

# Definición de las ciudades
ciudades=("Valencia" "Barcelona" "Madrid")

# Recorrido de las ciudades
for ciudad in "${ciudades[@]}"; do
  # Obtención de los consumos de la ciudad
  ciudad_consumos=()
  for linea in "${consumos[@]}"; do
    ciudad_linea=$(echo "$linea" | awk '{print $1}')
    if [ "$ciudad_linea" == "$ciudad" ]; then
      ciudad_consumos+=($(echo "$linea" | awk '{print $4}'))
    fi
  done

  # Comprobación si la ciudad tiene un consumo decreciente
  consumo_anterior="${ciudad_consumos[0]}"
  decreciente="true"
  for consumo in "${ciudad_consumos[@]:1}"; do
    if [ "$consumo" -ge "$consumo_anterior" ]; then
      decreciente="false"
      break
    fi
    consumo_anterior="$consumo"
  done

  # Impresión del resultado si la ciudad tiene un consumo decreciente
  if [ "$decreciente" == "true" ]; then
    echo "La ciudad de $ciudad ha tenido un consumo decreciente a lo largo del año 2022."
  fi
done