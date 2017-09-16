function [ valorH, valorS, valorV, varianzaH ] = extraerColorPromedioHSV2( imagenNombreColor, imagenNombreMascara)
% Extraer color promedio de una imagen, utilizando una silueta para
% cuantificar el color y los valores que se extraen. 
% El resultado se trabaja en el espacio de color HSV.

PRIMER_PLANO=1;

%Lectura de la imagen con fondo
IRecorteRGB=imread(imagenNombreColor);
IRecorteHSV=rgb2hsv(IRecorteRGB); % hsv

IMascaraC=imread(imagenNombreMascara);

% Binarizar
umbral=graythresh(IMascaraC);
IMascara=im2bw(IMascaraC,umbral);


[filasTope, columnasTope, ~]=size(IRecorteRGB);

sumaH=double(0.0);
sumaS=double(0.0);
sumaV=double(0.0);
contadorPixeles=double(0.0);

%variables para el calculo de varianza
sumaVarianzaH=double(0.0);
varianzaH=double(0.0);

%recorrer la imagen mascara
for f=1:1:filasTope
    for c=1:1:columnasTope
%        % Leer de la imagen mascara si el valor es diferente a cero
        pixelMascara=IMascara(f,c);

        if pixelMascara == PRIMER_PLANO

            sumaH=double(IRecorteHSV(f,c,1))+sumaH;
            sumaS=double(IRecorteHSV(f,c,2))+sumaS;
            sumaV=double(IRecorteHSV(f,c,3))+sumaV; 

            contadorPixeles=contadorPixeles+1;
        end %if        
    end %for columnas
end %for filas


% --------------------------------------
%valores de los promedios porcanales
%---------------------------------------
valorH=double(sumaH/contadorPixeles); %promedio canal H
valorS=double(sumaS/contadorPixeles); %promedio canal S
valorV=double(sumaV/contadorPixeles); %promedio canal V

%------------------------------------------------------------------------
% Varianza muestral
%------------------------------------------------------------------------
for f=1:1:filasTope
    for c=1:1:columnasTope
%        % Leer de la imagen mascara si el valor es diferente a cero
        pixelMascara=IMascara(f,c);

        if pixelMascara == PRIMER_PLANO
            
            sumaVarianzaH=pow2((double(IRecorteHSV(f,c,1))-valorH))+sumaVarianzaH;
        end %if        
    end %for columnas
end %for filas
% -----------------------------------------------------------------------
%cálculo de la varianza por canal H
varianzaH=sumaVarianzaH/(contadorPixeles-1);

%% resultados finales


end %fin de la funcion


