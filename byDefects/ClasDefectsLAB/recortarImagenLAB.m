function [ output_args ] = recortarImagenLAB(imagenNombreRecortar, bRotar, imagenNombreSalida, xmin, ymin, width, height)
% Recortar Imágenes segun un rectangulo
% Recordar que las coordenadas en la imagen se toman a partir de la esquina
% superior izquierda

%% Lectura de la imagen
IRecorte=imread(imagenNombreRecortar);
IRecorte(:,:,3)=0; % sacar el canal azul que no aporta
%% Rotacion de la imagen
if(bRotar==1)
    IRecorteTemp = imrotate(IRecorte,180); %rotar la imagen
    IRecorte=IRecorteTemp;
end %fin rotar


rect=[xmin ymin width height]; %definicion de la zona rectangular de recorte
I2 = imcrop(IRecorte,rect);

%escritura del resultado
imwrite(I2,imagenNombreSalida,'jpg')

end

