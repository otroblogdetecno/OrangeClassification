function [ output_args ] = PrincipalProcesarImagen4R( corrida, pathPrincipal, pathEntrada, pathConfiguracion, pathAplicacion, pathResultados, banderaCalibracion, banderaRotar, nombreImagenP, archivoConfiguracion, archivoCalibracion, archivoVector )
%Proceso completo que se realiza por cada fotografia de entrada
% Se obtienen los datos aplicando operaciones morfológicas y extrayendo
% características geométricas.
% Se guardan resultados intermedios de manera a que se puedan obtener
% imagenes del proceso.
% -----------------------------------------------------------------------

%% Datos de configuración archivos
%pathPrincipal='/home/usuario/ml/';
%pathEntrada=strcat(pathPrincipal,'input/');
%pathConfiguracion=strcat(pathPrincipal,'conf/');
%pathAplicacion=strcat(pathPrincipal,'tmp/');
%pathResultados=strcat(pathPrincipal,'output/');


NOCALIBRADO=0; % Se define la constante NO CALIBRADO
%banderaCalibracion=0; %0 falta calabrar 1=calibrado
%banderaRotar=1; %0 no rotar 1=rotar

% Para la calibración se necesita la secuencia de recorte solamente

%imagenInicial='ultima4.jpg';
%imagenInicial=strcat(pathEntrada,'verde_sin_luz.jpg');
%imagenInicial=strcat(pathEntrada,'verde_con_luz.jpg');
%imagenInicial=strcat(pathEntrada,'amarillo_con_luz.jpg');
%nombreImagenP='ultima4.jpg';
imagenInicial=strcat(pathEntrada,nombreImagenP);
%archivoConfiguracion=strcat(pathConfiguracion,'configuracion2.xml');
%archivoVector=strcat(pathResultados,'archivo.csv');


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
%
fprintf('Recortando imagenes --> \n');
%Recuadro 1 principal.
recortarImagen(imagenInicial, banderaRotar, nombreImagenRecorte1, Cuadro1_lineaGuiaInicialColumna, Cuadro1_lineaGuiaInicialFila, Cuadro1_espacioColumna, Cuadro1_espacioFila);

%Recuadro 2 izquierda
recortarImagen(imagenInicial, banderaRotar, nombreImagenRecorte2, Cuadro2_lineaGuiaInicialColumna, Cuadro2_lineaGuiaInicialFila, Cuadro2_espacioFila, Cuadro2_espacioColumna);

%Recuadro 3 centro
recortarImagen(imagenInicial, banderaRotar, nombreImagenRecorte3, Cuadro3_lineaGuiaInicialColumna, Cuadro3_lineaGuiaInicialFila, Cuadro3_espacioColumna, Cuadro3_espacioFila);

%Recuadro 4 derecha
recortarImagen(imagenInicial, banderaRotar, nombreImagenRecorte4, Cuadro4_lineaGuiaInicialColumna, Cuadro4_lineaGuiaInicialFila, Cuadro4_espacioFila, Cuadro4_espacioColumna);

%% Aplicando operaciones morfologicas
fprintf('Aplicando operaciones morfologicas --> \n');
operacionesMorfologicas(nombreImagenRecorte1,nombreImagenSilueta1);
operacionesMorfologicas(nombreImagenRecorte2,nombreImagenSilueta2);
operacionesMorfologicas(nombreImagenRecorte3,nombreImagenSilueta3);
operacionesMorfologicas(nombreImagenRecorte4,nombreImagenSilueta4);

%% Removiendo objetos pequeños
fprintf('Removiendo objetos pequeños --> \n');
removerObjetos(nombreImagenSilueta1, nombreImagenSiluetaN1, areaObjetosRemover);
removerObjetos(nombreImagenSilueta2, nombreImagenSiluetaN2, areaObjetosRemover);
removerObjetos(nombreImagenSilueta3, nombreImagenSiluetaN3, areaObjetosRemover);
removerObjetos(nombreImagenSilueta4, nombreImagenSiluetaN4, areaObjetosRemover);


%% Removiendo fondo
fprintf('Removiendo fondo --> \n');
removerFondo4(nombreImagenRecorte1, nombreImagenSiluetaN1, nombreImagenRemovida1);
removerFondo4(nombreImagenRecorte2, nombreImagenSiluetaN2, nombreImagenRemovida2);
removerFondo4(nombreImagenRecorte3, nombreImagenSiluetaN3, nombreImagenRemovida3);
removerFondo4(nombreImagenRecorte4, nombreImagenSiluetaN4, nombreImagenRemovida4);


%% SI NO CALIBRADO
% Sin o está calibrado el sistema, se utiliza la función hasta el recorte
% de imágenes y siluetas.

if(banderaCalibracion==NOCALIBRADO)
    % ---- Si NO está calibrado ----

else

%% Extraccion de caracteristicas
pixelmmR1=lecturaConfiguracion('pixelLinealR1', archivoCalibracion);
pixelmmR2=lecturaConfiguracion('pixelLinealR2', archivoCalibracion);
pixelmmR3=lecturaConfiguracion('pixelLinealR3', archivoCalibracion);
pixelmmR4=lecturaConfiguracion('pixelLinealR4', archivoCalibracion);


%pixelCuadradoR1=lecturaConfiguracion('pixelCuadradoR1',archivoCalibracion); %para area




tamano=2000;


%% Declaracion de variables con valores de pixeles
%% Recorte 1
sumaAreaPxR1=0; 
diametroPxR1=0; 
ejeMayorPxR1=0; 
ejeMenorPxR1=0;

sumaAreammR1=0.0;
diametrommR1=0.0;
ejeMayormmR1=0.0;
ejeMenormmR1=0.0;

%% Recorte 2
sumaAreaPxR2=0; 
diametroPxR2=0; 
ejeMayorPxR2=0; 
ejeMenorPxR2=0;

sumaAreammR2=0.0;
diametrommR2=0.0;
ejeMayormmR2=0.0;
ejeMenormmR2=0.0;

%% Recorte 3
sumaAreaPxR3=0; 
diametroPxR3=0; 
ejeMayorPxR3=0; 
ejeMenorPxR3=0;

sumaAreammR3=0.0;
diametrommR3=0.0;
ejeMayormmR3=0.0;
ejeMenormmR3=0.0;

%% Recorte 4
sumaAreaPxR4=0; 
diametroPxR4=0; 
ejeMayorPxR4=0; 
ejeMenorPxR4=0;

sumaAreammR4=0.0;
diametrommR4=0.0;
ejeMayormmR4=0.0;
ejeMenormmR4=0.0;

%% Extracción de características
fprintf('Extraccion de características geometricas--> \n');
fprintf('Extraccion Recorte 1 --> \n');
[ sumaAreaPxR1, diametroPxR1, ejeMayorPxR1, ejeMenorPxR1]=extraerCaracteristicasGeometricas4R( nombreImagenSiluetaN1,tamano);
fprintf('Extraccion Recorte 2 --> \n');
[ sumaAreaPxR2, diametroPxR2, ejeMayorPxR2, ejeMenorPxR2]=extraerCaracteristicasGeometricas4R( nombreImagenSiluetaN2,tamano);
fprintf('Extraccion Recorte 3 --> \n');
[ sumaAreaPxR3, diametroPxR3, ejeMayorPxR3, ejeMenorPxR3]=extraerCaracteristicasGeometricas4R( nombreImagenSiluetaN3,tamano);
fprintf('Extraccion Recorte 4 --> \n');
[ sumaAreaPxR4, diametroPxR4, ejeMayorPxR4, ejeMenorPxR4]=extraerCaracteristicasGeometricas4R( nombreImagenSiluetaN4,tamano);


%% Cálculo para unidades de medida
diametrommR1=diametroPxR1*pixelmmR1;
%sumaAreammR1=sumaAreaPxR1*pixelCuadradoR1;
ejeMayormmR1=ejeMayorPxR1*pixelmmR1;
ejeMenormmR1=ejeMenorPxR1*pixelmmR1;

diametrommR2=diametroPxR2*pixelmmR2;
%sumaAreammR2=sumaAreaPxR2*pixelCuadradoR2;
ejeMayormmR2=ejeMayorPxR2*pixelmmR2;
ejeMenormmR2=ejeMenorPxR2*pixelmmR2;

diametrommR3=diametroPxR3*pixelmmR3;
%sumaAreammR3=sumaAreaPxR3*pixelCuadradoR3;
ejeMayormmR3=ejeMayorPxR3*pixelmmR3;
ejeMenormmR3=ejeMenorPxR3*pixelmmR3;

diametrommR4=diametroPxR4*pixelmmR4;
%sumaAreammR4=sumaAreaPxR4*pixelCuadradoR4;
ejeMayormmR4=ejeMayorPxR4*pixelmmR4;
ejeMenormmR4=ejeMenorPxR4*pixelmmR4;


%% Guardado en archivo
clase='SIN_CLASIFICAR';
% se saca el area, dado que no se utiliza
%fprintf('%s, %10.4f, %10.2f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %s \n',imagenInicial, pixelmmR1, sumaAreaPxR1, sumaAreammR1, diametroPxR1, diametrommR1, ejeMayorPxR1, ejeMenorPxR1, ejeMayormmR1, ejeMenormmR1, clase);
%fprintf('%s, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %s \n',imagenInicial, pixelmmR1, diametroPxR1, diametrommR1, ejeMayorPxR1, ejeMenorPxR1, ejeMayormmR1, ejeMenormmR1, clase);
fprintf('%s, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %s \n', imagenInicial, pixelmmR1, pixelmmR2, pixelmmR3, pixelmmR4, diametroPxR1, diametroPxR2, diametroPxR3, diametroPxR4, ejeMayorPxR1, ejeMayorPxR2, ejeMayorPxR3, ejeMayorPxR4, ejeMenorPxR1, ejeMenorPxR2, ejeMenorPxR3, ejeMenorPxR4, diametrommR1, diametrommR2, diametrommR3, diametrommR4, ejeMayormmR1, ejeMayormmR2, ejeMayormmR3, ejeMayormmR4, ejeMenormmR1, ejeMenormmR2, ejeMenormmR3, ejeMenormmR4, clase);


%fila=sprintf('%s, %10.4f, %10.2i, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %s \n',imagenInicial, pixelmmR1, sumaArea, sumaAreamm, redondez, diametro, diametromm, ejeMayor, ejeMenor, ejeMayormm, ejeMenormm, clase);
% Se guardan primero todo lo relacionado a pixeles, luego las conversiones
% a milimetros
fila=sprintf('%s, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %10.4f, %s \n', imagenInicial, pixelmmR1, pixelmmR2, pixelmmR3, pixelmmR4, diametroPxR1, diametroPxR2, diametroPxR3, diametroPxR4, ejeMayorPxR1, ejeMayorPxR2, ejeMayorPxR3, ejeMayorPxR4, ejeMenorPxR1, ejeMenorPxR2, ejeMenorPxR3, ejeMenorPxR4, diametrommR1, diametrommR2, diametrommR3, diametrommR4, ejeMayormmR1, ejeMayormmR2, ejeMayormmR3, ejeMayormmR4, ejeMenormmR1, ejeMenormmR2, ejeMenormmR3, ejeMenormmR4, clase);
     
 
%(',,,,,,,,,,,, %3i, \n'
%  ,,,,,,,,,,,);


guardarArchivoVector4R( archivoVector, fila)

    % ---- fin calibrado ----
end %if calbracion  

% -----------------------------------------------------------------------
end %end proceso completo

