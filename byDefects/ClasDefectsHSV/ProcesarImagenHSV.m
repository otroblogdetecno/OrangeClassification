function [ output_args ] = ProcesarImagenHSV( corrida, pathPrincipal, pathEntrada, pathConfiguracion, pathAplicacion, pathResultados, banderaCalibracion, banderaRotar, nombreImagenP, archivoConfiguracion, archivoCalibracion, archivoVector )
%Proceso completo que se realiza por cada fotografia de entrada
% Se obtienen los datos aplicando operaciones morfológicas y extrayendo
% características geométricas.
% Se guardan resultados intermedios de manera a que se puedan obtener
% imagenes del proceso.

% Se han puesto a cero las variables correspondientes a los campos de
% caracteristicas geometricas.
% -----------------------------------------------------------------------

NOCALIBRADO=0; % Se define la constante NO CALIBRADO
imagenInicial=strcat(pathEntrada,nombreImagenP);

% --- NOMBRE DE IMAGENES INTERMEDIAS ---
nombreImagenRecorte1=strcat(pathAplicacion,nombreImagenP,'_','r1.jpg');
nombreImagenRecorte2=strcat(pathAplicacion,nombreImagenP,'_','r2.jpg');
nombreImagenRecorte3=strcat(pathAplicacion,nombreImagenP,'_','r3.jpg');
nombreImagenRecorte4=strcat(pathAplicacion,nombreImagenP,'_','r4.jpg');

% Siluetas operaciones morfologicas
nombreImagenSilueta1=strcat(pathAplicacion,nombreImagenP,'_','s1.jpg');
nombreImagenSilueta2=strcat(pathAplicacion,nombreImagenP,'_','s2.jpg');
nombreImagenSilueta3=strcat(pathAplicacion,nombreImagenP,'_','s3.jpg');
nombreImagenSilueta4=strcat(pathAplicacion,nombreImagenP,'_','s4.jpg');


% Siluetas operaciones morfologicas
nombreImagenSiluetaN1=strcat(pathAplicacion,nombreImagenP,'_','sN1.jpg');
nombreImagenSiluetaN2=strcat(pathAplicacion,nombreImagenP,'_','sN2.jpg');
nombreImagenSiluetaN3=strcat(pathAplicacion,nombreImagenP,'_','sN3.jpg');
nombreImagenSiluetaN4=strcat(pathAplicacion,nombreImagenP,'_','sN4.jpg');

% nombres de archivos con objetos removidos
nombreImagenRemovida1=strcat(pathAplicacion,nombreImagenP,'_','rm1.jpg');
nombreImagenRemovida2=strcat(pathAplicacion,nombreImagenP,'_','rm2.jpg');
nombreImagenRemovida3=strcat(pathAplicacion,nombreImagenP,'_','rm3.jpg');
nombreImagenRemovida4=strcat(pathAplicacion,nombreImagenP,'_','rm4.jpg');

areaObjetosRemover=500; % tamaño para realizar granulometria




%% Lectura de la imagen
IOrig=imread(imagenInicial);

%% Rotacion de la imagen
%Rotar en recortar imagen tambien

if(banderaRotar==1) %ROTAR
    IOrigTemp = imrotate(IOrig,180); %rotar la imagen
    IOrig=IOrigTemp;
end %rotar


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
%
fprintf('Recortando imagenes --> \n');
%Recuadro 1 principal.
recortarImagenHSV(imagenInicial, banderaRotar, nombreImagenRecorte1, Cuadro1_lineaGuiaInicialColumna, Cuadro1_lineaGuiaInicialFila, Cuadro1_espacioColumna, Cuadro1_espacioFila);

%Recuadro 2 izquierda
recortarImagenHSV(imagenInicial, banderaRotar, nombreImagenRecorte2, Cuadro2_lineaGuiaInicialColumna, Cuadro2_lineaGuiaInicialFila, Cuadro2_espacioFila, Cuadro2_espacioColumna);

%Recuadro 3 centro
recortarImagenHSV(imagenInicial, banderaRotar, nombreImagenRecorte3, Cuadro3_lineaGuiaInicialColumna, Cuadro3_lineaGuiaInicialFila, Cuadro3_espacioColumna, Cuadro3_espacioFila);

%Recuadro 4 derecha
recortarImagenHSV(imagenInicial, banderaRotar, nombreImagenRecorte4, Cuadro4_lineaGuiaInicialColumna, Cuadro4_lineaGuiaInicialFila, Cuadro4_espacioFila, Cuadro4_espacioColumna);

%% Aplicando operaciones morfologicas
fprintf('Aplicando operaciones morfologicas --> \n');
operacionesMorfologicasHSV(nombreImagenRecorte1,nombreImagenSilueta1);
operacionesMorfologicasHSV(nombreImagenRecorte2,nombreImagenSilueta2);
operacionesMorfologicasHSV(nombreImagenRecorte3,nombreImagenSilueta3);
operacionesMorfologicasHSV(nombreImagenRecorte4,nombreImagenSilueta4);

%% Removiendo objetos pequeños
fprintf('Removiendo objetos pequeños --> \n');
removerObjetosHSV(nombreImagenSilueta1, nombreImagenSiluetaN1, areaObjetosRemover);
removerObjetosHSV(nombreImagenSilueta2, nombreImagenSiluetaN2, areaObjetosRemover);
removerObjetosHSV(nombreImagenSilueta3, nombreImagenSiluetaN3, areaObjetosRemover);
removerObjetosHSV(nombreImagenSilueta4, nombreImagenSiluetaN4, areaObjetosRemover);


%% Removiendo fondo
fprintf('Removiendo fondo --> \n');
removerFondoHSV(nombreImagenRecorte1, nombreImagenSiluetaN1, nombreImagenRemovida1);
removerFondoHSV(nombreImagenRecorte2, nombreImagenSiluetaN2, nombreImagenRemovida2);
removerFondoHSV(nombreImagenRecorte3, nombreImagenSiluetaN3, nombreImagenRemovida3);
removerFondoHSV(nombreImagenRecorte4, nombreImagenSiluetaN4, nombreImagenRemovida4);



if(banderaCalibracion==NOCALIBRADO)
    % ---- Si NO está calibrado ----

else

%% Extraccion de caracteristicas
pixelmm=lecturaConfiguracion('pixelLineal', archivoCalibracion);
pixelCuadrado=lecturaConfiguracion('pixelCuadrado', archivoCalibracion);

fprintf('Extraccion de características --> \n');
[ sumaArea, redondez, diametro, ejeMayor, ejeMenor, finalRojo, finalVerde, finalAzul, finalH, finalS, finalV, finalVarianzaH ] = extraccionCaracteristicasHSV( nombreImagenRemovida1, nombreImagenRemovida2, nombreImagenRemovida3, nombreImagenRemovida4, nombreImagenSiluetaN1, nombreImagenSiluetaN2, nombreImagenSiluetaN3, nombreImagenSiluetaN4);


% Cálculo para unidades de medida
diametromm=0;
sumaAreamm=0;







%% Guardado en archivo
clase='SIN_CLASIFICAR';
claseM='SIN_CLASIFICAR';
fprintf('%s, %10.4f, %10.2i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %3i, %3i, %3i, %10.4f, %10.4f, %10.4f, %10.4f, %s, %s \n',imagenInicial, pixelmm, sumaArea, sumaAreamm, redondez, diametro, diametromm, ejeMayor, ejeMenor, finalRojo, finalVerde, finalAzul, finalH, finalS, finalV, finalVarianzaH, clase, claseM);

fila=sprintf('%s, %10.4f, %10.2i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %3i, %3i, %3i, %10.4f, %10.4f, %10.4f, %10.4f, %s, %s \n',imagenInicial, pixelmm, sumaArea, sumaAreamm, redondez, diametro, diametromm, ejeMayor, ejeMenor, finalRojo, finalVerde, finalAzul, finalH, finalS, finalV, finalVarianzaH, clase, claseM);


%(',,,,,,,,,,,, %3i, \n'
%  ,,,,,,,,,,,);


guardarArchivoVectorHSV( archivoVector, fila)

    % ---- fin calibrado ----
end %if calbracion  

% -----------------------------------------------------------------------
end %end proceso completo

