function [ output_args ] = SegmentacionSobel2(nombreImagenSegmentar, nombreImagenSalida)

%% segmentacion con filtros Sobel, Prewit
IOrig=imread(nombreImagenSegmentar);

IGris=rgb2gray(IOrig);

BW3 = edge(IGris,'Sobel');

% Aplicacion de operacion 
SE = strel('disk', 2);
BW4 = imdilate(BW3,SE);

    
%% Almacenar en archivos las imagenes de clusteres
imwrite(BW4,nombreImagenSalida,'jpg');

end

