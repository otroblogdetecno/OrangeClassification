function [ ] = SegmentacionSobel1(nombreImagenSegmentar, nombreImagenSalida)

%% segmentacion con filtros Sobel, Prewit
IOrig=imread(nombreImagenSegmentar);

IGris=rgb2gray(IOrig);

h1=fspecial('average',[5,5]); 
media1=imfilter(IGris,h1);

%%

[Gmag, ~] = imgradient(media1,'Sobel');
I = mat2gray(Gmag);

%nivel=graythresh(I)
nivel=0.10; %umbral colocado en base a la experiencia
IB2=im2bw(I,nivel);

% apertura para eliminar los detalles pequeños
SE = strel('disk', 1);
IB3 = imopen(IB2,SE);



% Aplicacion de cerradura para agrandar y cerrar agujeros, esto permite
% tener una mejor siluetas de los defectos. Utiliza un elemento
% estructurante mayor. La aplicación de cerradura daba un elemento menor
% que el defecto. No reconocia defectos grises
SE = strel('disk', 2);
IB4 = imdilate(IB3,SE);% exagerando la máscara me permite tomar mas region del defecto

%IB4 = imclose(IB3,SE);

%% Almacenar en archivos las imagenes de clusteres
imwrite(IB4,nombreImagenSalida,'jpg');
end

