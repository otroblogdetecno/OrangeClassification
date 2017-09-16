function [ output_args ] = removerObjetosLAB( imagenNombreSilueta, imagenNombreRe, tamano)
%function [ output_args ] = removerObjetos()
% Remueve objetos mayores al area definida


%Lectura de la imagen original
ISilueta=imread(imagenNombreSilueta);

% Binarizar
umbral=graythresh(ISilueta);
IB1=im2bw(ISilueta,umbral);
%figure; imshow(IB1);

% Elimina los elementos cuya area es igual al parametro
IB2=bwareaopen(IB1,tamano);
%figure; imshow(IB2);

%%guardar la previa de la silueta con remosion de ruido externo
imwrite(IB2,imagenNombreRe,'jpg')


end

