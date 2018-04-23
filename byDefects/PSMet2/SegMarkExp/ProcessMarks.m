function [ ] = ProcesesMarks(pathEntrada, pathEntradaMarca, pathAplicacion, nombreImagenP, ArrayCuadros, areaObjetosRemoverBR, canalLMin, canalLMax, canalAMin, canalAMax, canalBMin, canalBMax )
% ########################################################################
% Project AUTOMATIC CLASSIFICATION OF ORANGES BY SIZE AND DEFECTS USING 
% COMPUTER VISION TECHNIQUES 2018
% juancarlosmiranda81@gmail.com
% ########################################################################
%Por cada fotografia, se separa el fondo, segmentando las cuatro imagenes
%según cuadros definidos en una configuracion previa.
% Se elimina el fondo utilizando canales en el espacio LAB.
% SE GENERAN IMAGENES INTERMEDIAS:
% * SILUETAS CON CUATRO FRUTAS, REGION DE INTERES CON CUATRO FRUTAS
% * FONDO REMOVIDO. 
% * SILUETAS CORRESPONDIENTE AL FONDO REMOVIDO
% características geométricas.
% SE generan imagenes con las marcas pintadas por el experto y se preparan
% recortes de las marcas de defectos y caliz.

% -----------------------------------------------------------------------

%% Datos de configuración archivos
imagenInicial=strcat(pathEntrada,nombreImagenP); % imagen original para obtener los valores de colores
imagenMarca=strcat(pathEntradaMarca,nombreImagenP); % imagen con marcas hechas por el experto

%% DIRECTORIOS DE GUARDADO
pathAplicacionBR=strcat(pathAplicacion,'IBR/'); %imagen inicial, background removal siluetas en 1 imagen
pathAplicacionROI=strcat(pathAplicacion,'IROI/'); %imagen inicial, regiones de interes a color con fondo removido de 1 imagen.
pathAplicacionROIMarca=strcat(pathAplicacion,'MROI/'); %imagen marcada, regiones de interes a color 1 imagen


pathAplicacion2=strcat(pathAplicacion,'ISFrutas/'); %siluetas de frutas 1..4 de imagen inicial
pathAplicacion3=strcat(pathAplicacion,'IRM/'); %imagenes fondo removido 1..4 de imagen inicial
pathAplicacionRemMarca=strcat(pathAplicacion,'MRM/'); %imagenes fondo removido de marcas azules 1..4


%% CONFIGURACIONES DEFECTOS MASCARA Y COLOR
pathAplicacionCALROI=strcat(pathAplicacion,'ROICalyxC/'); % 1 imagen con 4 marcas en magenta
pathAplicacionCALROIBin=strcat(pathAplicacion,'ROICalyxBin/'); % 1 imagen con 4 marcas en binario
pathAplicacionDEFROI=strcat(pathAplicacion,'ROIDefC/'); %1 imagen con 4 marcas en azul
pathAplicacionDEFROIBin=strcat(pathAplicacion,'ROIDefBin/'); % % 1 imagen con 4 marcas en binario

pathCalyxColor=strcat(pathAplicacion,'MCalyxColor/'); %almacenado de calyx en color
pathCalyxBinario=strcat(pathAplicacion,'MCalyxBin/'); %almacenado de calyx en binario

pathDefColor=strcat(pathAplicacion,'MDefColor/'); %almacenado de defectos color
pathDefBinario=strcat(pathAplicacion,'MDefBin/'); %almacenado de defectos binario


% --- NOMBRE DE IMAGENES INTERMEDIAS ---
% con fondo removido
nombreImagenBR=strcat(pathAplicacionBR,nombreImagenP,'_','BR.jpg'); %para indicar silueta del fondo removido
nombreImagenROI=strcat(pathAplicacionROI,nombreImagenP,'_','RO.jpg'); %para indicar el fondo removido y ROI
nombreImagenROIMarca=strcat(pathAplicacionROIMarca,nombreImagenP,'_','MRO.jpg'); %para indicar el fondo removido y ROI

nombreImagenF=strcat(pathAplicacionROI,nombreImagenP,'_','I.jpg'); %previa a la inversa

%prefijo para imagenes de fondo removido y siluetas de fondos removidos en
%deteccion de objetos
nombreImagenSiluetaN=strcat(pathAplicacion2,nombreImagenP,'_','sN');
nombreImagenRemovida=strcat(pathAplicacion3,nombreImagenP,'_','rm');
nombreImagenRemovidaMarca=strcat(pathAplicacionRemMarca,nombreImagenP,'_','Mrm');


%DEFINICION DE NOMBRES DE IMAGENES PARA DEFECTOS SEGMENTADO EN COLOR Y EN
%BINARIO
nombreImagenCALROI=strcat(pathAplicacionCALROI,nombreImagenP,'_','DR.jpg'); %para indicar CALIZ en magenta
nombreImagenCALROIBin=strcat(pathAplicacionCALROIBin,nombreImagenP,'_','DRB.jpg'); %para indicar CALIZ en magenta


nombreImagenDEFROI=strcat(pathAplicacionDEFROI,nombreImagenP,'_','DR.jpg'); %para indicar DEFECTOS EN AZUL
nombreImagenDEFROIBin=strcat(pathAplicacionDEFROIBin,nombreImagenP,'_','DRB.jpg'); %para indicar DEFECTOS EN AZUL



nombreImagenCalColor=strcat(pathCalyxColor,nombreImagenP,'_','DC.jpg'); % imagen numerada de cada ROI 1..4  en color calyx  
nombreImagenCalBin=strcat(pathCalyxBinario,nombreImagenP,'_','CALB'); % imagen numerada de cada ROI 1..4 mascara binaria calyx

nombreImagenDefColor=strcat(pathDefColor,nombreImagenP,'_','DC.jpg'); % imagen numerada de cada ROI 1..4  en color calyx  
nombreImagenDefBin=strcat(pathDefBinario,nombreImagenP,'_','DEFB'); % imagen numerada de cada ROI 1..4 mascara binaria calyx




%% -- BEGIN IMAGE PROCESSING ----------------------------------
%% ----- INICIO Definicion de topes
% Para definicion de rectangulos PREVIAMENTE CONFIGURADOS PARA DETECTAR EL
% NUMERO DE IMAGEN A PARTIR DE UNA IMGEN GENERAL CON ESPEJOS
Cuadro1_lineaGuiaInicialColumna=ArrayCuadros(1,1);
Cuadro1_lineaGuiaInicialFila=ArrayCuadros(1,2);
Cuadro1_espacioColumna=ArrayCuadros(1,3);
Cuadro1_espacioFila=ArrayCuadros(1,4);

fprintf('BR -> Segmentación de fondo --> \n'); %salida una imagen con 4 siluetas
BRemovalLAB(imagenInicial, nombreImagenBR, nombreImagenF, areaObjetosRemoverBR, canalLMin, canalLMax, canalAMin, canalAMax, canalBMin, canalBMax,Cuadro1_lineaGuiaInicialColumna, Cuadro1_lineaGuiaInicialFila-2, Cuadro1_espacioColumna, Cuadro1_espacioFila);

%% Removiendo fondo
fprintf('BR -> Removiendo fondo, separacion ROI--> \n'); %salida una imagen con 4 objetos
backgroundRemoval4(imagenInicial, nombreImagenBR, nombreImagenROI);
backgroundRemoval4(imagenMarca, nombreImagenBR, nombreImagenROIMarca);


%% Calyx segmentado
fprintf('DR -> SEGMENTANDO CALIZ MARCADO POR EXPERTO EN 4 ROI, separacion ROI--> \n'); %salida una imagen con 4 objetos
channel1Min = 216.000;
channel1Max = 255.000;
channel2Min = 0.000;
channel2Max = 132.000;
channel3Min = 201.000;
channel3Max = 255.000;
SegmentDefMarksRGB(imagenMarca, nombreImagenCALROI, nombreImagenCALROIBin, channel1Min, channel1Max, channel2Min, channel2Max, channel3Min, channel3Max);


%% Defectos segmentados
fprintf('DR -> SEGMENTANDO AREAS DE DEFECTOS MARCADOS POR EXPERTO EN 4 ROI, separacion ROI--> \n'); %salida una imagen con 4 objetos
channel1Min = 0.000;
channel1Max = 15.000;
channel2Min = 0.000;
channel2Max = 11.000;
channel3Min = 231.000;
channel3Max = 255.000;


SegmentDefMarksRGB(imagenMarca, nombreImagenDEFROI, nombreImagenDEFROIBin, channel1Min, channel1Max, channel2Min, channel2Max, channel3Min, channel3Max);

%% Recortes de ROI
fprintf('BR -> Detección de objetos en cuadros. Recortando ROI y siluetas ROI --> \n'); %salida 4 imagenes de un objeto cada una
%asigna numeros de objetos segun la pertenencia al cuadro
objectDetection2( nombreImagenBR, nombreImagenROI, nombreImagenSiluetaN, nombreImagenRemovida, ArrayCuadros ); 
objectDetection2( nombreImagenBR, nombreImagenROIMarca, nombreImagenSiluetaN, nombreImagenRemovidaMarca, ArrayCuadros ); 


%recorta en base a siluetas caliz
objectDetectionCut( nombreImagenBR, nombreImagenCALROI, nombreImagenCalColor, ArrayCuadros );
objectDetectionCut( nombreImagenBR, nombreImagenCALROIBin, nombreImagenCalBin, ArrayCuadros );

% recorta en base a siluetas defectos
objectDetectionCut( nombreImagenBR, nombreImagenDEFROI, nombreImagenDefColor, ArrayCuadros );
objectDetectionCut( nombreImagenBR, nombreImagenDEFROIBin, nombreImagenDefBin, ArrayCuadros );

%% -- END IMAGE PROCESSING ----------------------------------

end %end ProcesamientoImagen

