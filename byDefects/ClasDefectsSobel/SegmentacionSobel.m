function [ output_args ] = SegmentacionSobel(nombreImagenSegmentar, nombreImagenSalida)

%% segmentacion con filtros Sobel
IOrig=imread(nombreImagenSegmentar);

IGris=rgb2gray(IOrig);

BW3 = edge(IGris,'Sobel');

% Aplicacion de operacion 
SE = strel('disk', 1);
BW4 = imdilate(BW3,SE);

%% Almacenar en archivos las imagenes de clusteres
imwrite(BW4,nombreImagenSalida,'jpg');


end

