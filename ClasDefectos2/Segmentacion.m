function [ output_args ] = Segmentacion(nombreImagenSegmentar, nombreImagenSalida)

%% segmentacion con filtros Sobel, Prewit
IOrig=imread(nombreImagenSegmentar);
%IS=imsharpen(IOrig);

%IOrig=IS; %realzada


IGris=rgb2gray(IOrig);
%ITopHat = imtophat(IGris, strel('disk', 10));
%figure('Name','Tophat'); imshow(ITophat);


%IGris2 = medfilt2(IGris,[3 3]);
%figure('Name','Igris'); imshow(IGris2);

BW3 = edge(IGris,'Sobel');
%BW3 = edge(IGris,'Prewitt');
%BW6 = edge(ITopHat,'Sobel');


% Aplicacion de operacion 
SE = strel('disk', 2);
%BW4 =imclose(BW3,SE);

%BW4 = imdilate(BW3,SE);
%BW4 = imopen(BW3,SE);


%figure; imshow(BW3); 
%figure; imshow(BW4);    
%% Almacenar en archivos las imagenes de clusteres
imwrite(BW4,nombreImagenSalida,'jpg');


end

