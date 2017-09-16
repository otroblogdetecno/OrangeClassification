function [output_args]=calibracion4R(pathPrincipal, pathCalibracion, nombreImagenP)
%% calibracion de valores
%clc; clear all; close all;

diametromm=0.0;
areaCalibracionmm=0.0;


%% caracteristicas geometricas
%recorte 1
areaPxR1=0;
diametroPxR1=0;
ejeMayorPxR1=0;
ejeMenorPxR1=0;
equivalencia1mmCuadradoR1=0.0;
equivalencia1mmR1=0.0;

%recorte 2
areaPxR2=0;
diametroPxR2=0;
ejeMayorPxR2=0;
ejeMenorPxR2=0;
equivalencia1mmCuadradoR2=0.0;
equivalencia1mmR2=0.0;

%recorte 3
areaPxR3=0;
diametroPxR3=0;
ejeMayorPxR3=0;
ejeMenorPxR3=0;
equivalencia1mmCuadradoR3=0.0;
equivalencia1mmR3=0.0;

%recorte 4
areaPxR4=0;
diametroPxR4=0;
ejeMayorPxR4=0;
ejeMenorPxR4=0;
equivalencia1mmCuadradoR4=0.0;
equivalencia1mmR4=0.0;



%% ------------

tamano=500;

%imagen entrada 
%pathPrincipal='/home/usuario/ml/'; 
%pathAplicacion=strcat(pathPrincipal,'calibration/');
% nombreImagenP='2017-01-27-160836.jpg'; 

nombreImagenSiluetaN1=strcat(pathCalibracion,nombreImagenP,'_','sN1.jpg');
nombreImagenSiluetaN2=strcat(pathCalibracion,nombreImagenP,'_','sN2.jpg');
nombreImagenSiluetaN3=strcat(pathCalibracion,nombreImagenP,'_','sN3.jpg');
nombreImagenSiluetaN4=strcat(pathCalibracion,nombreImagenP,'_','sN4.jpg');

fprintf('------------------------------------------------- \n');
fprintf('Ingrese los valores para la conversion de medidas \n');
fprintf('------------------------------------------------- \n');

fprintf('La calibración se realiza en base a una esfera conocida \n');

fprintf('Calculando características geométricas desde una imagen \n');
[areaPxR1, diametroPxR1, ejeMayorPxR1, ejeMenorPxR1]=extraerCaracteristicasGeometricas4R(nombreImagenSiluetaN1,tamano);
[areaPxR2, diametroPxR2, ejeMayorPxR2, ejeMenorPxR2]=extraerCaracteristicasGeometricas4R(nombreImagenSiluetaN2,tamano);
[areaPxR3, diametroPxR3, ejeMayorPxR3, ejeMenorPxR3]=extraerCaracteristicasGeometricas4R(nombreImagenSiluetaN3,tamano);
[areaPxR4, diametroPxR4, ejeMayorPxR4, ejeMenorPxR4]=extraerCaracteristicasGeometricas4R(nombreImagenSiluetaN4,tamano);



diametromm=input('Ingrese DIÁMETRO de la esfera de calibración en milímetros: ');
areaCalibracionmm=pi*((diametromm^2)/4); %area real de la esfera de calibracion

%% Cálculo de coeficientes de conversion según recortes
equivalencia1mmCuadradoR1=areaCalibracionmm/areaPxR1;
equivalencia1mmR1=sqrt(equivalencia1mmCuadradoR1);

equivalencia1mmCuadradoR2=areaCalibracionmm/areaPxR2;
equivalencia1mmR2=sqrt(equivalencia1mmCuadradoR2);

equivalencia1mmCuadradoR3=areaCalibracionmm/areaPxR3;
equivalencia1mmR3=sqrt(equivalencia1mmCuadradoR3);

equivalencia1mmCuadradoR4=areaCalibracionmm/areaPxR4;
equivalencia1mmR4=sqrt(equivalencia1mmCuadradoR4);

%% 
fprintf('------------------------------------------------- \n');
fprintf('Resultados \n');
fprintf('------------------------------------------------- \n');

fprintf('Area de Calibración= %f \n', areaCalibracionmm);
fprintf('Area en pixeles R1 = %f \n', areaPxR1);
fprintf('1 pixel^2 R1= %f mm^2\n', equivalencia1mmCuadradoR1);
fprintf('1 pixel lineal R1= %f mm\n', equivalencia1mmR1);

%% impresion de archivo
cadenaDiametro=sprintf('<listitem>\n <label>diametroEsfera</label>\n <value>%f</value>\n </listitem>\n',diametromm);
cadenaAreaCalibracion=sprintf('<listitem>\n <label>areaCalibracion</label>\n <value>%f</value>\n </listitem>\n',areaCalibracionmm);
cadenaAreaPixelesR1=sprintf('<listitem>\n <label>areaPixelesR1</label>\n <value>%f</value>\n </listitem>\n',areaPxR1);
cadenaAreaPixelesR2=sprintf('<listitem>\n <label>areaPixelesR2</label>\n <value>%f</value>\n </listitem>\n',areaPxR2);
cadenaAreaPixelesR3=sprintf('<listitem>\n <label>areaPixelesR3</label>\n <value>%f</value>\n </listitem>\n',areaPxR3);
cadenaAreaPixelesR4=sprintf('<listitem>\n <label>areaPixelesR4</label>\n <value>%f</value>\n </listitem>\n',areaPxR4);
cadenaPixelCuadradoR1=sprintf('<listitem>\n <label>pixelCuadradoR1</label>\n <value>%f</value>\n </listitem>\n', equivalencia1mmCuadradoR1);	
cadenaPixelCuadradoR2=sprintf('<listitem>\n <label>pixelCuadradoR2</label>\n <value>%f</value>\n </listitem>\n', equivalencia1mmCuadradoR2);
cadenaPixelCuadradoR3=sprintf('<listitem>\n <label>pixelCuadradoR3</label>\n <value>%f</value>\n </listitem>\n', equivalencia1mmCuadradoR3);
cadenaPixelCuadradoR4=sprintf('<listitem>\n <label>pixelCuadradoR4</label>\n <value>%f</value>\n </listitem>\n', equivalencia1mmCuadradoR4);	
cadenaPixelLinealR1=sprintf('<listitem>\n <label>pixelLinealR1</label>\n <value>%f</value>\n </listitem> \n',equivalencia1mmR1);
cadenaPixelLinealR2=sprintf('<listitem>\n <label>pixelLinealR2</label>\n <value>%f</value>\n </listitem> \n',equivalencia1mmR2);
cadenaPixelLinealR3=sprintf('<listitem>\n <label>pixelLinealR3</label>\n <value>%f</value>\n </listitem> \n',equivalencia1mmR3);
cadenaPixelLinealR4=sprintf('<listitem>\n <label>pixelLinealR4</label>\n <value>%f</value>\n </listitem> \n',equivalencia1mmR4);


fprintf('\n------------ RECORTAR DESDE AQUI ------\n');
fprintf('%s',cadenaDiametro);
fprintf('%s',cadenaAreaCalibracion);
fprintf('%s',cadenaAreaPixelesR1);
fprintf('%s',cadenaAreaPixelesR2);
fprintf('%s',cadenaAreaPixelesR3);
fprintf('%s',cadenaAreaPixelesR4);
fprintf('%s',cadenaPixelCuadradoR1);
fprintf('%s',cadenaPixelCuadradoR2);
fprintf('%s',cadenaPixelCuadradoR3);
fprintf('%s',cadenaPixelCuadradoR4);
fprintf('%s',cadenaPixelLinealR1);
fprintf('%s',cadenaPixelLinealR2);
fprintf('%s',cadenaPixelLinealR3);
fprintf('%s',cadenaPixelLinealR4);
fprintf('\n------------ RECORTAR HASTA AQUI ------\n');


%%
%fprintf('Ingrese los valores para la conversion de medidas \n');


% Primeramente obtener un buen recorte de las fotografías, modificando los
% archivos que sean necesarios.

%Abrir fotografía.
%Medir características geométricas.
%Presentar valores.
end %Fin de la funcion