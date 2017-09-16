%function [ output_args ] = extraerCaracteristicasGeometricas()
function [ sumaAreapx, diametroPx, ejeMayorPx, ejeMenorPx ] = extraerCaracteristicasGeometricas4R( imagenNombreSilueta, tamano)
% Extraer caracteristicas geometricas basadas en pixeles a partir de la
% silueta

%% -------------------------------------
%% Ajuste de parámetros iniciales
%clc; clear all; close all;

%imagenNombreSilueta='siluetaN1.jpg';
%imagenNombreSilueta='siluetaN2.jpg';
%imagenNombreSilueta='siluetaN3.jpg';


%% Lectura de la imagen
IOrig=imread(imagenNombreSilueta);

%B=imresize(IOrig,[501 501]);
%IOrig=B;

%% Convertir a escala de grises
%IGray=rgb2gray(IOrig);

%% Umbralización y Binarización
umbral=graythresh(IOrig);
IB1=im2bw(IOrig,umbral);

%% Mostrar imagen original
%imshow(IOrig)

%% Etiquetado de áreas conectadas, se necesita una imagen binaria
[L Ne]=bwlabel(IB1); %en L los objetos y en Ne= números de áreas etiquetadas

%% Cálculo de propiedades de los objetos de la imagen
% se toman los datos geométricos necesarios para luego poder caracterizarlos.
%propiedades= regionprops(L,'Area','Perimeter','MajorAxisLength','MinorAxisLength');
propiedades= regionprops(L,'Area','MajorAxisLength','MinorAxisLength');


%% Mostrar características geométricas
% Se recorre de principio a fin las propiedades obtenidas
sumaAreapx=0;
diametroPx=0;

ejeMayorPx=0;
ejeMenorPx=0;

%fprintf('       N#;      Area;  Perimetro; \n');
for n=1:size(propiedades,1)
    if(propiedades(n).Area > tamano)
%        fprintf('%s %10.2i; %10.2i; %10.2f; %10.4f; \n', imagenNombreSilueta, n,propiedades(n).Area, propiedades(n).Perimeter, redondez);
        sumaAreapx=sumaAreapx+propiedades(n).Area;
        ejeMayorPx=propiedades(n).MajorAxisLength;
        ejeMenorPx=propiedades(n).MinorAxisLength;
    end
end
%calculo de diametroPx por circunferencia
diametroPx=sqrt((sumaAreapx*4)/pi);

%fprintf('Imagen; Suma de Areas; Redondez; diametroPx; eMayor; eMenor \n');
%fprintf('%s; %10.2i; %10.4f; %10.4f; %10.4f; %10.4f \n',imagenNombreSilueta, sumaAreapx, redondez, diametroPx, ejeMayorPx, ejeMenorPx);


%% -------------------------------------
%imwrite(IB2,imagenNombreRe,'jpg')


end

