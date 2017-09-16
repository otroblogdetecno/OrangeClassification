function [ valorL, valorA, valorB, varianzaH ] = extraerColorPromedioLAB( imagenNombreColor, imagenNombreMascara)
% Extraer color promedio de una imagen, utilizando una silueta para
% cuantificar el color y los valores que se extraen. 
% El resultado se trabaja en el espacio de color HSV.


% -----------------------------------------------------------------------
PRIMER_PLANO=1;


%Lectura de la imagen con fondo
IRecorteRGB=imread(imagenNombreColor);
IRecorteLAB=rgb2lab(IRecorteRGB); % LAB

IMascaraC=imread(imagenNombreMascara);

% Binarizar
umbral=graythresh(IMascaraC);
IMascara=im2bw(IMascaraC,umbral);


[filasTope, columnasTope, ~]=size(IRecorteRGB);

sumaL=double(0.0);
sumaA=double(0.0);
sumaB=double(0.0);
contadorPixeles=double(0.0);

%variables para el calculo de varianza
sumaBarianzaH=double(0.0);
varianzaH=double(0.0);

%recorrer la imagen mascara
for f=1:1:filasTope
    for c=1:1:columnasTope
%        % Leer de la imagen mascara si el valor es diferente a cero
        pixelMascara=IMascara(f,c);

        if pixelMascara == PRIMER_PLANO

            sumaL=double(IRecorteLAB(f,c,1))+sumaL;
            sumaA=double(IRecorteLAB(f,c,2))+sumaA;
            sumaB=double(IRecorteLAB(f,c,3))+sumaB; 

            contadorPixeles=contadorPixeles+1;
        end %if        
    end %for columnas
end %for filas

% --------------------------------------
%valores de los promedios porcanales
%---------------------------------------
valorL=double(sumaL/contadorPixeles); %promedio canal H
valorA=double(sumaA/contadorPixeles); %promedio canal S
valorB=double(sumaB/contadorPixeles); %promedio canal V


varianzaH=0;

end %fin de la funcion


