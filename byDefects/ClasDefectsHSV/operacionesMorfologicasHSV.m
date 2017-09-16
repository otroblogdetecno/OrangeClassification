function [ output_args ] = OperacionesMorfologicasHSV( imagenNombreOp, imagenNombreSilueta)
% Trabaja aplicando las operaciones morfologicas sobre cada imagen
% recortada

%Lectura de la imagen original
IMor=imread(imagenNombreOp);
I=imsharpen(IMor);
IMor=I;


%Separacion de canales RGB
canalRojo = IMor(:, :, 1);
canalVerde = IMor(:, :, 2);
canalAzul = IMor(:, :, 3);

% Canal Rojo aporta mayor contraste
umbral=graythresh(canalRojo);
IB1=im2bw(canalRojo,umbral);

%Inversa de la imagen
inversa=1-IB1;

% Aplicacion de operacion erosion
SE = strel('disk', 5);
IB2 = imerode(inversa,SE);

%Se vuelve a invertir para dejar con unos la silueta
inversa=1-IB2;

%%guardar la previa de la silueta
imwrite(inversa,imagenNombreSilueta,'jpg')


end

