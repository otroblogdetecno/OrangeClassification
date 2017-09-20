#!/bin/sh

echo "hola"
dUsuario=$HOME"/";
dAplicacion="ml/";
dMetodo="clasDefectos2/";

pathCompleto=$dUsuario$dAplicacion$dMetodo;

# ----------------------------------------
# Directorios para salida
# ----------------------------------------
dConfiguration=$pathCompleto"conf/"; # archivos de configuracion
dCalibration=$pathCompleto"calibration/"; #imagenes de calibracion
dOutput=$pathCompleto"output/"; #nombre del metodo a probar
dInputToLearn=$pathCompleto"inputToLearn/"; # entradas para aprendizaje


# SALIDAS INTERMEDIAS DE IMAGENES.
dTmpToLearn=$pathCompleto"tmpToLearn/"; # imagenes intrmedias
dTmpRecortes=$dTmpToLearn"recortes/";
dTmpSiluetasFrutas=$dTmpToLearn"sFrutas/";
dTmpRemovido=$dTmpToLearn"removido/";
dTmpSiluetasDefectos=$dTmpToLearn"sDefectos/";
dTmpDefectos=$dTmpToLearn"defectos/";
dTmpColorDefectos=$dTmpToLearn"cDefectos/";








archivos="*";

clear;
echo "------------------- \n";
echo "ESTRUCTURA DE DIRECTORIOS \n";
echo "------------------- \n";
echo "directorio usuario        ->"$dUsuario;
echo "directorio aplicacion     ->"$dAplicacion;
echo "directorio metodo         ->"$dMetodo;
echo "pathCompleto              ->"$pathCompleto;
# --------------------------------
echo "ARCHIVOS DE CONFIGURACION ->"$dConfiguration;
echo "ARCHIVOS DE CALIBRACION   ->"$dCalibration;
echo "ENTRADAS PARA APRENDIZAJE ->"$dInputToLearn;

echo "SALIDAS INTERMEDIAS       ->"$dTmpToLearn;
echo "RECORTES                  ->"$dTmpRecortes;
echo "FONDO REMOVIDO            ->"$dTmpRemovido;
echo "SILUETAS DE FRUTAS        ->"$dTmpSiluetasFrutas;
echo "SILUETAS DEFECTOS                  ->"$dTmpSiluetasDefectos;
echo "DEFECTOS                  ->"$dTmpDefectos;
echo "DEFECTOS EN COLOR         ->"$dTmpColorDefectos;

echo "SALIDAS DE RESULTADOS     ->"$dOutput;



echo "------------------- \n";
echo "CREANDO DIRECTORIOS \n";
echo "------------------- \n";
mkdir $dConfiguration;
mkdir $dCalibration;
mkdir $dInputToLearn;

mkdir $dTmpToLearn;
mkdir $dTmpRecortes;
mkdir $dTmpRemovido;
mkdir $dTmpSiluetasFrutas;
mkdir $dTmpSiluetasDefectos;
mkdir $dTmpDefectos;
mkdir $dTmpColorDefectos;

mkdir $dTmpToLearn;
mkdir $dOutput;




#echo "BORRANDO TEMPORALES \n"
#rm -f $directorioUsuario$directorioAplicacion$tmp$archivos;
#rm -f $directorioUsuario$directorioAplicacion$tmpToLearn$archivos;
#rm -f $directorioUsuario$directorioAplicacion$tmpToPredict$archivos;



