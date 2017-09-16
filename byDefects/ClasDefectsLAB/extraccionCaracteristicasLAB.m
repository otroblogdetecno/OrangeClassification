function [ sumaArea, redondez, diametro, ejeMayor, ejeMenor, finalRojo, finalVerde, finalAzul, finalL, finalA, finalB, finalVarianzaH ] = extraccionCaracteristicasLAB( imagenNombreColor1, imagenNombreColor2, imagenNombreColor3, imagenNombreColor4, imagenNombreSilueta1, imagenNombreSilueta2, imagenNombreSilueta3, imagenNombreSilueta4)
% Se realiza el proceso completo de extraccion de caracteristicas,
% utilizando las imagenes generadas en la etapa de adquisicion y
% sirviendose de los archivos temporales para el proceso, el cual proviene
% de un ciclo principal de lectura del directorio.

% ----------------------------------------------------------------------

tamano=2000;

sumaArea=0; redondez=0; diametro=0; ejeMayor=0; ejeMenor=0;
%imagen 1 


%% Extracción de características de color RGB
%imagen 1
[mediaL1, mediaA1, mediaB1, mediaVarianzaH1]=extraerColorPromedioLAB( imagenNombreColor1, imagenNombreSilueta1);


%imagen 2
[mediaL2, mediaA2, mediaB2, mediaVarianzaH2]=extraerColorPromedioLAB( imagenNombreColor2, imagenNombreSilueta2);


%imagen 3 
[mediaL3, mediaA3, mediaB3, mediaVarianzaH3]=extraerColorPromedioLAB( imagenNombreColor3, imagenNombreSilueta3);

%imagen 4 
[mediaL4, mediaA4, mediaB4, mediaVarianzaH4]=extraerColorPromedioLAB( imagenNombreColor4, imagenNombreSilueta4);

% Cálculo de la media en RGB
finalRojo=0; 
finalVerde=0;
finalAzul=0; 

% Cálculo de la media HSV
finalL=(mediaL1+mediaL2+mediaL3+mediaL4)/4;
finalA=(mediaA1+mediaA2+mediaA3+mediaA4)/4;
finalB=(mediaB1+mediaB2+mediaB3+mediaB4)/4;

%Media de la varianza del canal H, para clasificación de color
finalVarianzaH=0;

% ----------------------------------------------------------------------

end %fin extraccionCaracteristicas

