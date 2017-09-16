function [ output_args ] = ProcesarImagenManual( corrida, pathPrincipal, pathEntrada, pathConfiguracion, pathAplicacion, pathResultados, banderaCalibracion, banderaRotar, nombreImagenP, archivoConfiguracion, archivoCalibracion, archivoVector )
% 
% recorte planificado y modificado manualmente
%-----------------------------------------------------------------------

%% Datos de configuración archivos


NOCALIBRADO=0; % Se define la constante NO CALIBRADO
%banderaCalibracion=0; %0 falta calabrar 1=calibrado
%banderaRotar=1; %0 no rotar 1=rotar



% Para la calibración se necesita la secuencia de recorte solamente
imagenInicial=strcat(pathEntrada,nombreImagenP);

pathAplicacion1=strcat(pathAplicacion,'recortesManual/');
pathAplicacion2=strcat(pathAplicacion,'siluetas/');
pathAplicacion3=strcat(pathAplicacion,'removido/');
pathAplicacion4=strcat(pathAplicacion,'siluetasManchas/');
pathAplicacion5=strcat(pathAplicacion,'manchas/');

% --- NOMBRE DE IMAGENES INTERMEDIAS ---
nombreImagenRecorte1=strcat(pathAplicacion1,nombreImagenP,'_','r1.jpg');
nombreImagenRecorte2=strcat(pathAplicacion1,nombreImagenP,'_','r2.jpg');
nombreImagenRecorte3=strcat(pathAplicacion1,nombreImagenP,'_','r3.jpg');
nombreImagenRecorte4=strcat(pathAplicacion1,nombreImagenP,'_','r4.jpg');

% Siluetas operaciones morfologicas
nombreImagenSilueta1=strcat(pathAplicacion2,nombreImagenP,'_','s1.jpg');
nombreImagenSilueta2=strcat(pathAplicacion2,nombreImagenP,'_','s2.jpg');
nombreImagenSilueta3=strcat(pathAplicacion2,nombreImagenP,'_','s3.jpg');
nombreImagenSilueta4=strcat(pathAplicacion2,nombreImagenP,'_','s4.jpg');


% Siluetas operaciones morfologicas
nombreImagenSiluetaN1=strcat(pathAplicacion2,nombreImagenP,'_','sN1.jpg');
nombreImagenSiluetaN2=strcat(pathAplicacion2,nombreImagenP,'_','sN2.jpg');
nombreImagenSiluetaN3=strcat(pathAplicacion2,nombreImagenP,'_','sN3.jpg');
nombreImagenSiluetaN4=strcat(pathAplicacion2,nombreImagenP,'_','sN4.jpg');

% nombres de archivos con objetos removidos
nombreImagenRemovida1=strcat(pathAplicacion3,nombreImagenP,'_','rm1.jpg');
nombreImagenRemovida2=strcat(pathAplicacion3,nombreImagenP,'_','rm2.jpg');
nombreImagenRemovida3=strcat(pathAplicacion3,nombreImagenP,'_','rm3.jpg');
nombreImagenRemovida4=strcat(pathAplicacion3,nombreImagenP,'_','rm4.jpg');


    %% salida segmentacion
    nombreImagenSalida1=strcat(pathAplicacion4,nombreImagenP,'_','so1.jpg');
    nombreImagenSalida2=strcat(pathAplicacion4,nombreImagenP,'_','so2.jpg');
    nombreImagenSalida3=strcat(pathAplicacion4,nombreImagenP,'_','so3.jpg');
    nombreImagenSalida4=strcat(pathAplicacion4,nombreImagenP,'_','so4.jpg');

    %% salida manchas
    nombreImagenDefectos1=strcat(pathAplicacion5,nombreImagenP,'_','soM1.jpg');
    nombreImagenDefectos2=strcat(pathAplicacion5,nombreImagenP,'_','soM2.jpg');
    nombreImagenDefectos3=strcat(pathAplicacion5,nombreImagenP,'_','soM3.jpg');
    nombreImagenDefectos4=strcat(pathAplicacion5,nombreImagenP,'_','soM4.jpg');



areaObjetosRemover=500; % tamaño para realizar granulometria




%% Lectura de la imagen
IOrig=imread(imagenInicial);
%figure; imshow(IOrig);
%% Rotacion de la imagen
%Rotar en recortar imagen tambien

if(banderaRotar==1) %ROTAR
    IOrigTemp = imrotate(IOrig,180); %rotar la imagen
    IOrig=IOrigTemp;
end %rotar


%figure; imshow(IOrig);

%% ----- INICIO Definicion de topes
% Para definicion de rectangulos
% Se calcula el tamaño de la imagen para luego aplicar las lineas de
% cortes.
% obtener el tamaño

[filasTope, columnasTope, color]=size(IOrig);
inicioFilas=0;
inicioColumnas=0;

% ----- FIN Definicion de las variables de configuracion -----



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


% ----- FIN Definicion de topes


%% --------------------------------------------
%% Recortando imagenes 
% Se colocaron imágenes tratadas manualmente. Las imágenes corresponden a
% los recortes, los cuales contienen objetos que generan ruido.

%% Aplicando operaciones morfologicas
fprintf('Aplicando operaciones morfologicas --> \n');
operacionesMorfologicasPrewitt(nombreImagenRecorte1,nombreImagenSilueta1);
operacionesMorfologicasPrewitt(nombreImagenRecorte2,nombreImagenSilueta2);
operacionesMorfologicasPrewitt(nombreImagenRecorte3,nombreImagenSilueta3);
operacionesMorfologicasPrewitt(nombreImagenRecorte4,nombreImagenSilueta4);

%% Removiendo objetos pequeños
fprintf('Removiendo objetos pequeños --> \n');
removerObjetosPrewitt(nombreImagenSilueta1, nombreImagenSiluetaN1, areaObjetosRemover);
removerObjetosPrewitt(nombreImagenSilueta2, nombreImagenSiluetaN2, areaObjetosRemover);
removerObjetosPrewitt(nombreImagenSilueta3, nombreImagenSiluetaN3, areaObjetosRemover);
removerObjetosPrewitt(nombreImagenSilueta4, nombreImagenSiluetaN4, areaObjetosRemover);


%% Removiendo fondo
fprintf('Removiendo fondo --> \n');
removerFondoPrewitt(nombreImagenRecorte1, nombreImagenSiluetaN1, nombreImagenRemovida1);
removerFondoPrewitt(nombreImagenRecorte2, nombreImagenSiluetaN2, nombreImagenRemovida2);
removerFondoPrewitt(nombreImagenRecorte3, nombreImagenSiluetaN3, nombreImagenRemovida3);
removerFondoPrewitt(nombreImagenRecorte4, nombreImagenSiluetaN4, nombreImagenRemovida4);


%% Tercera opcion, segmentacion con TopHat, Sobel.
fprintf('Segmentación y extracción Prewitt --> \n');
%tamanoManchas=1500;   
tamanoManchas=1000;   
%Imagen 1 
   SegmentacionPrewitt(nombreImagenRemovida1, nombreImagenSalida1);
   extraerRegionManchasPrewitt( nombreImagenSalida1, nombreImagenDefectos1, tamanoManchas);
   
   %Imagen 2
   SegmentacionPrewitt(nombreImagenRemovida2, nombreImagenSalida2);
   extraerRegionManchasPrewitt( nombreImagenSalida2, nombreImagenDefectos2, tamanoManchas);
    
    %Imagen 3
   SegmentacionPrewitt(nombreImagenRemovida3, nombreImagenSalida3);
   extraerRegionManchasPrewitt( nombreImagenSalida3, nombreImagenDefectos3, tamanoManchas);    
    
   %Imagen 4
   SegmentacionPrewitt(nombreImagenRemovida4, nombreImagenSalida4);
   extraerRegionManchasPrewitt( nombreImagenSalida4, nombreImagenDefectos4, tamanoManchas);


%% si está calibrado o no

if(banderaCalibracion==NOCALIBRADO)
    % ---- Si NO está calibrado ----

else

%% Extraccion de caracteristicas
pixelmm=lecturaConfiguracion('pixelLineal', archivoCalibracion);
pixelCuadrado=lecturaConfiguracion('pixelCuadrado', archivoCalibracion);

fprintf('Extraccion de características --> \n');
[ sumaArea, redondez, diametro, ejeMayor, ejeMenor, totalPixelesManchas, totalManchas ] = extraerCarPrewitt( nombreImagenRemovida1, nombreImagenDefectos1, nombreImagenDefectos2, nombreImagenDefectos3, nombreImagenDefectos4);


% Cálculo para unidades de medida
diametromm=0;
sumaAreamm=0;







%% Guardado en archivo
clase='SIN_CLASIFICAR';
claseM='SIN_CLASIFICAR';
%fprintf('%s, %10.4f, %10.2i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %3i, %3i, %3i, %10.4f, %10.4f, %10.4f, %10.4f, %s, %s \n',imagenInicial, pixelmm, sumaArea, sumaAreamm, redondez, diametro, diametromm, ejeMayor, ejeMenor, finalRojo, finalVerde, finalAzul, finalL, finalA, finalB, finalVarianzaH, clase, claseM);

fprintf('%s, %10.4f, %10.2i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %3i, %3i, %s, %s \n',imagenInicial, pixelmm, sumaArea, sumaAreamm, redondez, diametro, diametromm, ejeMayor, ejeMenor, totalPixelesManchas, totalManchas, clase, claseM);


fila=sprintf('%s, %10.4f, %10.2i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %3i, %3i, %s, %s \n',imagenInicial, pixelmm, sumaArea, sumaAreamm, redondez, diametro, diametromm, ejeMayor, ejeMenor, totalPixelesManchas, totalManchas, clase, claseM);




guardarArchivoVectorManchas( archivoVector, fila)

    % ---- fin calibrado ----
end %if calbracion  

% -----------------------------------------------------------------------
end %end proceso completo

