#!/bin/bash
numLineas=`cat consumos.txt | wc -l`
maxConsumo=0
minConsumo=1000

for i in `seq 2 $numLineas`
do
    linea=`cat consumos.txt | tail -n+$i | head -n1 | awk '{print $4}'`

    if [ $linea -lt $minConsumo ]
    then
        minConsumo=$linea
        minCiudad=`cat consumos.txt | tail -n+$i | head -n1 | awk '{print $1}'`
        minMes=`cat consumos.txt | tail -n+$i | head -n1 | awk '{print $2}'`
        minAnyo=`cat consumos.txt | tail -n+$i | head -n1 | awk '{print $3}'`
    fi

    if [ $linea -gt $maxConsumo ]
    then
        maxConsumo=$linea
        maxCiudad=`cat consumos.txt | tail -n+$i | head -n1 | awk '{print $1}'`
        maxMes=`cat consumos.txt | tail -n+$i | head -n1 | awk '{print $2}'`
        maxAnyo=`cat consumos.txt | tail -n+$i | head -n1 | awk '{print $3}'`
    fi
done

echo "El consumo máximo ha sido en $maxCiudad el mes $maxMes del año $maxAnyo."
echo "El consumo mínimo ha sido en $minCiudad el mes $minMes del año $minAnyo."
