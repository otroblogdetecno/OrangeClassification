function [ ] = ExtraerDefImagen(pathEntrada, pathAplicacion, nombreImagenP, archivoVectorDef, tamanoManchas)
% Extrae los defectos de las naranjas, genera como salida un archivo con
% datos separados por comas y genera imagenes intermedias con los defectos
% en, la fruta y los defectos, el contorno de las frutas.
%
% tamanoManchas representa el tamano en pixeles, se utiliza para eliminar
% manchas pequenas y dejar un contorno de la fruta. El objetivo final es
% obtener solaente las manchas.
%
% Se generan imagenes intermedias que corresponden a:
% * imagen generada previamente con fondo removido
% * imagen intermedia con frutas y defectos
% * solamente los defectos aislados
%
% -----------------------------------------------------------------------

%% Datos de configuración archivos
imagenInicial=strcat(pathEntrada,nombreImagenP); %para escritura en archivo de resultados


pathAplicacion3=strcat(pathAplicacion,'removido/'); %imagen generada previamente con fondo removido
pathAplicacion4=strcat(pathAplicacion,'sDefectos/'); %imagen intermedia con frutas y defectos
pathAplicacion5=strcat(pathAplicacion,'defectos/'); %solamente los defectos aislados
pathAplicacion6=strcat(pathAplicacion,'cDefectos/');
pathAplicacion7=strcat(pathAplicacion,'contornos/'); %contornos de frutas


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

    %% salida defectos
    nombreImagenDefectos1=strcat(pathAplicacion5,nombreImagenP,'_','soM1.jpg');
    nombreImagenDefectos2=strcat(pathAplicacion5,nombreImagenP,'_','soM2.jpg');
    nombreImagenDefectos3=strcat(pathAplicacion5,nombreImagenP,'_','soM3.jpg');
    nombreImagenDefectos4=strcat(pathAplicacion5,nombreImagenP,'_','soM4.jpg');

    %% salida defectos en COLOR
    nombreImagenDefectosC1=strcat(pathAplicacion6,nombreImagenP,'_','soC1.jpg');
    nombreImagenDefectosC2=strcat(pathAplicacion6,nombreImagenP,'_','soC2.jpg');
    nombreImagenDefectosC3=strcat(pathAplicacion6,nombreImagenP,'_','soC3.jpg');
    nombreImagenDefectosC4=strcat(pathAplicacion6,nombreImagenP,'_','soC4.jpg');

    
    
    %% salida contornos
    nombreImagenContorno1=strcat(pathAplicacion7,nombreImagenP,'_','CM1.jpg');
    nombreImagenContorno2=strcat(pathAplicacion7,nombreImagenP,'_','CM2.jpg');
    nombreImagenContorno3=strcat(pathAplicacion7,nombreImagenP,'_','CM3.jpg');
    nombreImagenContorno4=strcat(pathAplicacion7,nombreImagenP,'_','CM4.jpg');
    
    
%% GRANULOMETRIAS
%tamanoManchas=1000; %1000 sacabuenos contornos
   
%% -- BEGIN DEFECTS FEATURES EXTRACTION ----------------------------------
%% Segmentacion de mascara para obtener defectos aislados de ROI
fprintf('Segmentacion de mascara para obtener defectos aislados de ROI --> \n');
   SegmentacionPrewitt2(nombreImagenRemovida1, nombreImagenSalida1);
   SegmentacionPrewitt2(nombreImagenRemovida2, nombreImagenSalida2);
   SegmentacionPrewitt2(nombreImagenRemovida3, nombreImagenSalida3);
   SegmentacionPrewitt2(nombreImagenRemovida4, nombreImagenSalida4);   
   

   extraerRegionManchasPrewitt( nombreImagenSalida1, nombreImagenDefectos1, nombreImagenContorno1, tamanoManchas);
   extraerRegionManchasPrewitt( nombreImagenSalida2, nombreImagenDefectos2, nombreImagenContorno2, tamanoManchas);
   extraerRegionManchasPrewitt( nombreImagenSalida3, nombreImagenDefectos3, nombreImagenContorno3, tamanoManchas);    
   extraerRegionManchasPrewitt( nombreImagenSalida4, nombreImagenDefectos4, nombreImagenContorno4, tamanoManchas);

   
   %% Esto no da tan buenos resultados, luego de experimentar, el procedimiento 1 es el mejor
%   SegmentacionSobel2(nombreImagenRemovida1, nombreImagenSalida1);
%   SegmentacionSobel2(nombreImagenRemovida2, nombreImagenSalida2);
%   SegmentacionSobel2(nombreImagenRemovida3, nombreImagenSalida3);
%   SegmentacionSobel2(nombreImagenRemovida4, nombreImagenSalida4);   
   
%% Separación de defectos
fprintf('Separación de defectos en color --> \n');
removerFondo4(nombreImagenRemovida1, nombreImagenDefectos1, nombreImagenDefectosC1);
removerFondo4(nombreImagenRemovida2, nombreImagenDefectos2, nombreImagenDefectosC2);
removerFondo4(nombreImagenRemovida3, nombreImagenDefectos3, nombreImagenDefectosC3);
removerFondo4(nombreImagenRemovida4, nombreImagenDefectos4, nombreImagenDefectosC4);

%% -- END DEFECTS FEATURES EXTRACTION ----------------------------------
    

fprintf('Extraccion de características Defectos--> \n');
totalPixelesManchas=0; totalManchas=0;
%[ totalPixelesManchas, totalManchas ] = extraerCarDefPrewitt( nombreImagenDefectos1, nombreImagenDefectos2, nombreImagenDefectos3, nombreImagenDefectos4);


%% --- BEGIN CONTEO DE PIXELES
% en base a las cuatro caras de la fruta se calculan las características
sumaParcial1=0;
sumaParcial2=0;
sumaParcial3=0;
sumaParcial4=0;

%% imagen 1 

%conteo de pixeles manchados
[sumaParcial1, totalManchas1]=extraerPixelesManchasPrewitt(nombreImagenDefectos1);

%% imagen 2
[sumaParcial2, totalManchas2]=extraerPixelesManchasPrewitt(nombreImagenDefectos2);

%% imagen 3
[sumaParcial3, totalManchas3]=extraerPixelesManchasPrewitt(nombreImagenDefectos3);


%% imagen 4 
[sumaParcial4, totalManchas4]=extraerPixelesManchasPrewitt(nombreImagenDefectos4);


totalPixelesManchas=sumaParcial1+sumaParcial2+sumaParcial3+sumaParcial4;
totalManchas=totalManchas1+totalManchas2+totalManchas3+totalManchas4;


%% --- END CONTEO DE PIXELES


%% Extracción de características DEFECTOS

%% Guardado en archivo
fprintf('Características de DEFECTOS obtenidas --> \n');
% -----------------------------------------------------------------------
%% Guardado en archivo
claseM='SIN_CLASIFICAR';
fprintf('%s, %3i, %3i, %s \n',imagenInicial, totalPixelesManchas, totalManchas, claseM);
fila=sprintf('%s, %3i, %3i, %s \n',imagenInicial, totalPixelesManchas, totalManchas, claseM);
guardarAVDef( archivoVectorDef, fila)


% -----------------------------------------------------------------------
end %end proceso completo

