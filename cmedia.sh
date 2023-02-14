#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Error: debes introducir una ciudad como parámetro."
  exit 1
fi

ciudad=$1
suma=0
contador=0

while read linea; do
  ciudad_linea=$(echo $linea | awk '{print $1}')
  consumo=$(echo $linea | awk '{print $4}')
  
  if [ "$ciudad_linea" == "$ciudad" ]; then
    suma=$(($suma + $consumo))
    contador=$(($contador + 1))
  fi
done < consumos.txt

if [ $contador -eq 0 ]; then
  echo "No se encontraron consumos para la ciudad de $ciudad."
else
  media=$((suma / contador))
  echo "La media de consumo para la ciudad de $ciudad es: $media"
fi
