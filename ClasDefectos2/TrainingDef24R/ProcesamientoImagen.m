function [ ] = ProcesamientoImagen(pathEntrada, pathAplicacion, nombreImagenP, ArrayCuadros, areaObjetosRemoverBR, canalLMin, canalLMax, canalAMin, canalAMax, canalBMin, canalBMax )
%Por cada fotografia, se separa el fondo, segmentando las cuatro imagenes
%según cuadros definidos en una configuracion previa.
% Se elimina el fondo utilizando canales en el espacio LAB.
% SE GENERAN IMAGENES INTERMEDIAS:
% * SILUETAS CON CUATRO FRUTAS, REGION DE INTERES CON CUATRO FRUTAS
% * FONDO REMOVIDO. 
% * SILUETAS CORRESPONDIENTE AL FONDO REMOVIDO
% características geométricas.

% -----------------------------------------------------------------------

%% Datos de configuración archivos
imagenInicial=strcat(pathEntrada,nombreImagenP);


%% DIRECTORIOS DE GUARDADO
pathAplicacionBR=strcat(pathAplicacion,'br/'); %background removal
pathAplicacionROI=strcat(pathAplicacion,'roi/'); %region of interest

pathAplicacion2=strcat(pathAplicacion,'sFrutas/'); %siluetas de frutas
pathAplicacion3=strcat(pathAplicacion,'removido/'); %imagenes fondo removido

% --- NOMBRE DE IMAGENES INTERMEDIAS ---
% con fondo removido
nombreImagenBR=strcat(pathAplicacionBR,nombreImagenP,'_','BR.jpg'); %para indicar silueta del fondo removido
nombreImagenROI=strcat(pathAplicacionROI,nombreImagenP,'_','RO.jpg'); %para indicar el fondo removido y ROI

%prefijo para imagenes de fondo removido y siluetas de fondos removidos en
%deteccion de objetos
nombreImagenSiluetaN=strcat(pathAplicacion2,nombreImagenP,'_','sN');
nombreImagenRemovida=strcat(pathAplicacion3,nombreImagenP,'_','rm');



%% -- BEGIN IMAGE PROCESSING ----------------------------------
%% ----- INICIO Definicion de topes
% Para definicion de rectangulos PREVIAMENTE CONFIGURADOS PARA DETECTAR EL
% NUMERO DE IMAGEN A PARTIR DE UNA IMGEN GENERAL CON ESPEJOS
Cuadro1_lineaGuiaInicialColumna=ArrayCuadros(1,1);
Cuadro1_lineaGuiaInicialFila=ArrayCuadros(1,2);
Cuadro1_espacioColumna=ArrayCuadros(1,3);
Cuadro1_espacioFila=ArrayCuadros(1,4);

fprintf('BR -> Segmentación de fondo --> \n'); %salida una imagen con 4 siluetas
BRemovalLAB(imagenInicial, nombreImagenBR, areaObjetosRemoverBR, canalLMin, canalLMax, canalAMin, canalAMax, canalBMin, canalBMax,Cuadro1_lineaGuiaInicialColumna, Cuadro1_lineaGuiaInicialFila-2, Cuadro1_espacioColumna, Cuadro1_espacioFila);

%% Removiendo fondo
fprintf('BR -> Removiendo fondo, separacion ROI--> \n'); %salida una imagen con 4 objetos
removerFondo4(imagenInicial, nombreImagenBR, nombreImagenROI);

%% Recortes de ROI
fprintf('BR -> Detección de objetos en cuadros. Recortando ROI y siluetas ROI --> \n'); %salida 4 imagenes de un objeto cada una
%asigna numeros de objetos segun la pertenencia al cuadro
deteccionObjetos2( nombreImagenBR, nombreImagenROI, nombreImagenSiluetaN, nombreImagenRemovida, ArrayCuadros ); 

%% -- END IMAGE PROCESSING ----------------------------------

end %end ProcesamientoImagen

