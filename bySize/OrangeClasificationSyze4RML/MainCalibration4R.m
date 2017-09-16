%% MainCalibration.m
% Se trabaja con una equivalencia para los 4 recortes o vistas. Anteriormente se
% trabajaba para uno.

% Se debe ejecutar primeramente este script para calibrar las
% configuraciones requeridas para procesar imagenes. Aquí se configuran los
% tamaños de imagenes y de los cuadros y la correspondencia entre pixeles y
% las unidades de medidas de milímetros.

%% --------------------------------------------
%%----- inicio cuerpo de la funcion -----
%% Ajuste de parámetros iniciales
clc; clear all; close all;

 %corrida = datetime('now','Format','yyyyMMdd''T''HHmmss')
 corrida='cali';
 
 %% Definicion de estructura de directorios 
 pathPrincipal='/home/usuario/ml/'; 
 pathEntradaCalibracion=strcat(pathPrincipal,'inputToCalibrate/');
 pathConfiguracion=strcat(pathPrincipal,'conf/');
 pathCalibracion=strcat(pathPrincipal,'calibration/');
 pathAplicacion=strcat(pathPrincipal,'tmp/'); %se guardan temporales cuando calcula el vector
 pathResultados=strcat(pathPrincipal,'output/');%se guardan los resultados

 banderaRotar=0; %0 no rotar 1=rotar

 nombreImagenP='calibracion_001.jpg';
fprintf('\n 1) Copie el archivo de calibración obtenido en el directorio %s \n',pathEntradaCalibracion);   
fprintf('\n 2) Renombre el archivo a  %s \n',nombreImagenP);   
 

 
 % --- NOMBRE DE IMAGENES INTERMEDIAS calibracion ---
nombreImagenRecorte1=strcat(pathCalibracion,nombreImagenP,'_','r1.jpg');
nombreImagenRecorte2=strcat(pathCalibracion,nombreImagenP,'_','r2.jpg');
nombreImagenRecorte3=strcat(pathCalibracion,nombreImagenP,'_','r3.jpg');
nombreImagenRecorte4=strcat(pathCalibracion,nombreImagenP,'_','r4.jpg');
 

% Siluetas operaciones morfologicas calibraion
nombreImagenSiluetaN1=strcat(pathCalibracion,nombreImagenP,'_','sN1.jpg');
nombreImagenSiluetaN2=strcat(pathCalibracion,nombreImagenP,'_','sN2.jpg');
nombreImagenSiluetaN3=strcat(pathCalibracion,nombreImagenP,'_','sN3.jpg');
nombreImagenSiluetaN4=strcat(pathCalibracion,nombreImagenP,'_','sN4.jpg');

 %% Nombres de archivos de configuracion
 % trabajan con métodos para equivalencia con las 4 vistas
 archivoConfiguracion=strcat(pathConfiguracion,'20170801configuracion.xml'); %se almacenan las configuraciones
 archivoCalibracion=strcat(pathConfiguracion,'20170801calibracion.xml'); %se almacenan las correspondencias
 archivoVector=strcat(pathResultados,'archivoCalibracion.csv'); %archivo de salida
 
%% Ingreso de valores 
 banderaCalibracion=input('Ingrese 0=falta calibrar, 1=ya esta calibrado >'); %0 falta calabrar 1=calibrado
 NOCALIBRADO=0;
 
%% Inicio del proceso
 if(banderaCalibracion==NOCALIBRADO)
    fprintf('\n--- PROCESO DE CALIBRACIÓN EN MARCHA --- \n');
    corrida='cali';

    PrincipalProcesarImagen4R( corrida, pathPrincipal, pathEntradaCalibracion, pathConfiguracion, pathCalibracion, pathResultados, banderaCalibracion, banderaRotar, nombreImagenP, archivoConfiguracion, archivoCalibracion, archivoVector );
    calibracion4R(pathPrincipal, pathCalibracion, nombreImagenP);
    
    %% Mostrando figuras de cuadros
    figure('name', 'Vistas');
        subplot(2,2,1);imshow(nombreImagenRecorte1);
        subplot(2,2,2);imshow(nombreImagenRecorte2);
        subplot(2,2,3);imshow(nombreImagenRecorte3);
        subplot(2,2,4);imshow(nombreImagenRecorte4);    
    
    figure('name', 'Siluetas');
        subplot(2,2,1);imshow(nombreImagenSiluetaN1);
        subplot(2,2,2);imshow(nombreImagenSiluetaN2);
        subplot(2,2,3);imshow(nombreImagenSiluetaN3);
        subplot(2,2,4);imshow(nombreImagenSiluetaN4);    

    fprintf('\n--- ATENCIÓN! --- \n');        
    fprintf('1) Repita el proceso de tantas veces sea posible, ajuste los \n valores manualmente para hacer coincidir \n los cuadros en el archivo Para calibrar sobre escriba MANUALMENTE con los valores obtenidos como resultados en el archivo %s \n', archivoConfiguracion);        
    fprintf('2) Para calibrar la correspondencia entre pixeles y milímetros \n sobreescriba MANUALMENTE con los valores \n obtenidos como resultados en el archivo %s \n', archivoCalibracion);
 else
    fprintf('\n--- CALCULANDO VALORES DE PRUEBA --- \n');     
%     PrincipalProcesarImagen4R( corrida, pathPrincipal, pathEntradaCalibracion, pathConfiguracion, pathAplicacion, pathResultados, banderaCalibracion, banderaRotar, nombreImagenP, archivoConfiguracion, archivoCalibracion, archivoVector );          

     fprintf('\n Verifique el vector de resultados en el archivo %s \n', archivoVector);
     
 end %fin if(banderaCalibracion==NOCALIBRADO)
