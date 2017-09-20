% MainTraining.m
% Esta funcion recorre un directorio y genera un conjunto de entrenamiento
% para el algoritmo, el mismo se guarda en un archivo de
% texto separado por comas .csv y sirve de entrada para el algoritmo
% clasificador.
% Se asume CALIBRADO EL SISTEMA, este script recorre todos los archivos de
% un directorio de entrada.
%
% Posteriormente, un EXPERTO DEBERA CLASIFICAR LOS RESULTADOS


%% Ajuste de parámetros iniciales
clc; clear all; close all;
 
 %% Definicion de estructura de directorios 
 pathPrincipal='/home/usuario/ml/clasDefectos2/'; 

 %pathEntradaImagenes=strcat(pathPrincipal,'inputToLearn/');
 pathEntradaImagenes='/home/usuario/ml/inputToLearn/';
 %pathEntradaImagenes='/home/usuario/ml/clasDefectos2/analizar/'; 
 
 pathConfiguracion=strcat(pathPrincipal,'conf/');

 pathAplicacion=strcat(pathPrincipal,'tmpToLearn/'); %se utiliza para situar las imagenes de calibracion
 %pathAplicacion=pathPrincipal;
 pathAplicacionSiluetas=strcat(pathAplicacion,'sFrutas/');

 pathResultados=strcat(pathPrincipal,'output/');%se guardan los resultados



nombreImagenP='nombreImagenP';

 %% Nombres de archivos de configuracion
 % trabajan con métodos para equivalencia con las 4 vistas
 
 %%
 archivoConfiguracion=strcat(pathConfiguracion,'20170916configuracion.xml'); %Para coordenadas iniciales en tratamiento de imagenes
 archivoCalibracion=strcat(pathConfiguracion,'20170916calibracion.xml'); %para indicar al usuario en la parte final la calibracion
 
 archivoVector=strcat(pathResultados,'acm2.csv'); %archivo de salida

  
 %% Definicion de los cuadros, según numeración 
Fila1=lecturaConfiguracion('Fila1', archivoConfiguracion);
FilaAbajo=lecturaConfiguracion('FilaAbajo', archivoConfiguracion);

%Cuadro 1 abajo
Cuadro1_lineaGuiaInicialFila=lecturaConfiguracion('Cuadro1_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro1_lineaGuiaInicialColumna=lecturaConfiguracion('Cuadro1_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro1_espacioFila=lecturaConfiguracion('Cuadro1_espacioFila', archivoConfiguracion);
Cuadro1_espacioColumna=lecturaConfiguracion('Cuadro1_espacioColumna', archivoConfiguracion);

%Cuadro 2 izquierda
Cuadro2_lineaGuiaInicialFila=lecturaConfiguracion('Cuadro2_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro2_lineaGuiaInicialColumna=lecturaConfiguracion('Cuadro2_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro2_espacioFila=lecturaConfiguracion('Cuadro2_espacioFila', archivoConfiguracion);
Cuadro2_espacioColumna=lecturaConfiguracion('Cuadro2_espacioColumna', archivoConfiguracion);

%Cuadro 3 centro
Cuadro3_lineaGuiaInicialFila=lecturaConfiguracion('Cuadro3_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro3_lineaGuiaInicialColumna=lecturaConfiguracion('Cuadro3_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro3_espacioFila=lecturaConfiguracion('Cuadro3_espacioFila', archivoConfiguracion);
Cuadro3_espacioColumna=lecturaConfiguracion('Cuadro3_espacioColumna', archivoConfiguracion);

%Cuadro 4 derecha
Cuadro4_lineaGuiaInicialFila=lecturaConfiguracion('Cuadro4_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro4_lineaGuiaInicialColumna=lecturaConfiguracion('Cuadro4_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro4_espacioFila=lecturaConfiguracion('Cuadro4_espacioFila', archivoConfiguracion);
Cuadro4_espacioColumna=lecturaConfiguracion('Cuadro4_espacioColumna', archivoConfiguracion);

%%carga en memoria para que sea mas rapido
ArrayCuadros=[Cuadro1_lineaGuiaInicialColumna, Cuadro1_lineaGuiaInicialFila, Cuadro1_espacioColumna, Cuadro1_espacioFila;
Cuadro2_lineaGuiaInicialColumna, Cuadro2_lineaGuiaInicialFila, Cuadro2_espacioColumna, Cuadro2_espacioFila;
Cuadro3_lineaGuiaInicialColumna, Cuadro3_lineaGuiaInicialFila, Cuadro3_espacioColumna, Cuadro3_espacioFila;
Cuadro4_lineaGuiaInicialColumna, Cuadro4_lineaGuiaInicialFila, Cuadro4_espacioColumna, Cuadro4_espacioFila;
0,0,0,0
];

%% GRANULOMETRIAS
areaObjetosRemoverBR=5000; % para siluetas y detección de objetos. Tamaño para realizar granulometria
%% configuracion de umbrales
canalLMin = 0.0; canalLMax = 96.653; canalAMin = -23.548; canalAMax = 16.303; canalBMin = -28.235; canalBMax = -1.169; %parametros de umbralizacion de fondo


% ----- FIN Definicion de topes
%% Remover archivos antiguos, borrar archivos antiguos
removerArchivos(archivoVector);

%% --------------------------------------------------------------------
%carga del listado de nombres
listado=dir(strcat(pathEntradaImagenes,'*.jpg'));

%% lectura en forma de bach del directorio de la cámara
for n=1:size(listado)
    fprintf('Extrayendo características para entrenamiento-> %s \n',listado(n).name);    
    nombreImagenP=listado(n).name;    
%    nombreImagenP='010.jpg';
         ProcesarImagen(pathEntradaImagenes, pathAplicacion, nombreImagenP , archivoCalibracion, archivoVector, ArrayCuadros, areaObjetosRemoverBR, canalLMin, canalLMax, canalAMin, canalAMax, canalBMin, canalBMax);
    %break;
end %

total=size(listado);

fprintf('\n -------------------------------- \n');
fprintf('Se procesaron un total de %i archivos \n',total(1));
fprintf('El experto deberá ETIQUETAR %i filas \n',total(1));
fprintf('En el archivo %s antes de correr el clasificador \n', archivoVector);
fprintf('\n -------------------------------- \n');