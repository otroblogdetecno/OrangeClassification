function [ output_args ] = removerObjetosSobel( imagenNombreSilueta, imagenNombreRe, tamano)

%Lectura de la imagen original
ISilueta=imread(imagenNombreSilueta);

% Binarizar
umbral=graythresh(ISilueta);
IB1=im2bw(ISilueta,umbral);

% Elimina los elementos cuya area es igual al parametro
IB2=bwareaopen(IB1,tamano);

%%guardar la previa de la silueta con remosion de ruido externo
imwrite(IB2,imagenNombreRe,'jpg')


end

