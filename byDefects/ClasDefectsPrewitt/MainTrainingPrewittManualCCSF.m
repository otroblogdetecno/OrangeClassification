%% A partir de recortes bien especificos procede a calcular el vector de entrenamiento

%% Ajuste de parámetros iniciales
clc; clear all; close all;

 
corrida='train';
 
banderaCalibracion=1; %0 falta calabrar 1=calibrado
banderaRotar=0; %0 no rotar 1=rotar
NOCALIBRADO=0;


nombreImagenP='117.jpg';

 %% Definicion de estructura de directorios 
 pathPrincipal='/home/usuario/ml/clasDefectsPrewitt/';
 
 pathConfiguracion=strcat(pathPrincipal,'conf/');
 pathResultados=strcat(pathPrincipal,'output/mejoraManualCalyxSF/');
 pathEntradaAprender='/home/usuario/ml/inputToLearnCalyx/conCalyxSF/';
 pathAplicacionAprender=strcat(pathPrincipal,'tmpToLearnPrewitt/mejoraManualCalyxSF/');
 

%% Nombres de archivos 
 archivoConfiguracion=strcat(pathConfiguracion,'20170207configuracion.xml');
 archivoCalibracion=strcat(pathConfiguracion,'20170207calibracion.xml');
 

 archivoVector=strcat(pathResultados,'aMConCalyxManualSF.csv');


%carga del listado de nombres
listado=dir(strcat(pathEntradaAprender,'*.jpg'));


 

%% lectura en forma de bach del directorio de la cámara
for n=1:size(listado)
    fprintf('Extrayendo características para entrenamiento Prewitt Manual-> %s \n',listado(n).name);    
    nombreImagenP=listado(n).name;    
    ProcesarImagenManual( corrida, pathPrincipal, pathEntradaAprender, pathConfiguracion, pathAplicacionAprender, pathResultados, banderaCalibracion, banderaRotar, nombreImagenP, archivoConfiguracion, archivoCalibracion, archivoVector );
end %

total=size(listado);

fprintf('\n -------------------------------- \n');
fprintf('Se procesaron un total de %i archivos \n',total(1));
fprintf('El experto deberá ETIQUETAR %i filas \n',total(1));
fprintf('En el archivo %s antes de correr el clasificador \n', archivoVector);
fprintf('\n -------------------------------- \n');
