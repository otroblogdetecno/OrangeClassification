function [ output_args ] = SegmentacionPrewitt(nombreImagenSegmentar, nombreImagenSalida)

%% segmentacion con filtros Sobel, Prewit
IOrig=imread(nombreImagenSegmentar);

IGris=rgb2gray(IOrig);

BW3 = edge(IGris,'Prewitt');

% Aplicacion de operacion 
SE = strel('disk', 1);
BW4 = imdilate(BW3,SE);

%% Almacenar en archivos las imagenes de clusteres
imwrite(BW4,nombreImagenSalida,'jpg');


end

