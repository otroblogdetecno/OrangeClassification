function [ sumaArea, redondez, diametro, ejeMayor, ejeMenor, finalRojo, finalVerde, finalAzul, finalH, finalS, finalV, finalVarianzaH ] = extraccionCaracteristicasHSV( imagenNombreColor1, imagenNombreColor2, imagenNombreColor3, imagenNombreColor4, imagenNombreSilueta1, imagenNombreSilueta2, imagenNombreSilueta3, imagenNombreSilueta4)
% Se realiza el proceso completo de extraccion de caracteristicas,
% utilizando las imagenes generadas en la etapa de adquisicion y
% sirviendose de los archivos temporales para el proceso, el cual proviene
% de un ciclo principal de lectura del directorio.

% ----------------------------------------------------------------------

tamano=2000;

%por compatibilidad se guardan, pero se colocan con valor cero
sumaArea=0; 
redondez=0; 
diametro=0;
ejeMayor=0; 
ejeMenor=0;

%% Extracción de características de color RGB
%imagen 1
[mediaRojo1, mediaVerde1, mediaAzul1]=extraerColorPromedio( imagenNombreColor1, imagenNombreSilueta1);
[mediaH1, mediaS1, mediaV1, mediaVarianzaH1]=extraerColorPromedioHSV2( imagenNombreColor1, imagenNombreSilueta1);

%imagen 2
[mediaRojo2, mediaVerde2, mediaAzul2]=extraerColorPromedio( imagenNombreColor2, imagenNombreSilueta2);
[mediaH2, mediaS2, mediaV2, mediaVarianzaH2]=extraerColorPromedioHSV2( imagenNombreColor2, imagenNombreSilueta2);

%imagen 3 
[mediaRojo3, mediaVerde3, mediaAzul3]=extraerColorPromedio( imagenNombreColor3, imagenNombreSilueta3);
[mediaH3, mediaS3, mediaV3, mediaVarianzaH3]=extraerColorPromedioHSV2( imagenNombreColor3, imagenNombreSilueta3);


%imagen 4 
[mediaRojo4, mediaVerde4, mediaAzul4]=extraerColorPromedio( imagenNombreColor4, imagenNombreSilueta4);
[mediaH4, mediaS4, mediaV4, mediaVarianzaH4]=extraerColorPromedioHSV2( imagenNombreColor4, imagenNombreSilueta4);

% Cálculo de la media en RGB
finalRojo=uint8((mediaRojo1+mediaRojo2+mediaRojo3+mediaRojo4)/4);
finalVerde=uint8((mediaVerde1+mediaVerde2+mediaVerde3+mediaVerde4)/4);
finalAzul=uint8((mediaAzul1+mediaAzul2+mediaAzul3+mediaAzul4)/4);

% Cálculo de la media HSV
finalH=(mediaH1+mediaH2+mediaH3+mediaH4)/4;
finalS=(mediaS1+mediaS2+mediaS3+mediaS4)/4;
finalV=(mediaV1+mediaV2+mediaV3+mediaV4)/4;

%Media de la varianza del canal H, para clasificación de color
finalVarianzaH=(mediaVarianzaH1+mediaVarianzaH2+mediaVarianzaH3+mediaVarianzaH4)/4;

% ----------------------------------------------------------------------

end %fin extraccionCaracteristicas

