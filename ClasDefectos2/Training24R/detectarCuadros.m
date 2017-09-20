%%Detectar el numero de cuadro en el que se encuentra
%% deteccion del numero de cuadro


%% Ajuste de parámetros iniciales
clc; clear all; close all;

pathPrincipal='/home/usuario/ml/clasDefectos2/'; 
pathConfiguracion=strcat(pathPrincipal,'conf/');


archivoConfiguracion=strcat(pathConfiguracion,'20170916configuracion.xml'); %Para coordenadas iniciales en tratamiento de imagenes
archivoCalibracion=strcat(pathConfiguracion,'20170916calibracion.xml'); %para indicar al usuario en la parte final la calibracion


%% Definicion de los cuadros, según numeración 


%% Definicion de los cuadros, según numeración 
Fila1=lecturaConfiguracion('Fila1', archivoConfiguracion);
FilaAbajo=lecturaConfiguracion('FilaAbajo', archivoConfiguracion);


%Cuadro 1 abajo
Cuadro1_lineaGuiaInicialFila=lecturaConfiguracion('Cuadro1_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro1_lineaGuiaInicialColumna=lecturaConfiguracion('Cuadro1_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro1_espacioFila=lecturaConfiguracion('Cuadro1_espacioFila', archivoConfiguracion);
Cuadro1_espacioColumna=lecturaConfiguracion('Cuadro1_espacioColumna', archivoConfiguracion);

%Cuadro 2 izquierda
Cuadro2_lineaGuiaInicialFila=lecturaConfiguracion('Cuadro2_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro2_lineaGuiaInicialColumna=lecturaConfiguracion('Cuadro2_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro2_espacioFila=lecturaConfiguracion('Cuadro2_espacioFila', archivoConfiguracion);
Cuadro2_espacioColumna=lecturaConfiguracion('Cuadro2_espacioColumna', archivoConfiguracion);

%Cuadro 3 centro
Cuadro3_lineaGuiaInicialFila=lecturaConfiguracion('Cuadro3_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro3_lineaGuiaInicialColumna=lecturaConfiguracion('Cuadro3_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro3_espacioFila=lecturaConfiguracion('Cuadro3_espacioFila', archivoConfiguracion);
Cuadro3_espacioColumna=lecturaConfiguracion('Cuadro3_espacioColumna', archivoConfiguracion);

%Cuadro 4 derecha
Cuadro4_lineaGuiaInicialFila=lecturaConfiguracion('Cuadro4_lineaGuiaInicialFila', archivoConfiguracion);
Cuadro4_lineaGuiaInicialColumna=lecturaConfiguracion('Cuadro4_lineaGuiaInicialColumna', archivoConfiguracion);
Cuadro4_espacioFila=lecturaConfiguracion('Cuadro4_espacioFila', archivoConfiguracion);
Cuadro4_espacioColumna=lecturaConfiguracion('Cuadro4_espacioColumna', archivoConfiguracion);


% ----- FIN Definicion de topes
% Sigue la sintaxis de los rectangulos xmin,ymin,width,height
%Cuadro1_lineaGuiaInicialColumna, Cuadro1_lineaGuiaInicialFila, Cuadro1_espacioColumna, Cuadro1_espacioFila

ArrayCuadros=[Cuadro1_lineaGuiaInicialColumna, Cuadro1_lineaGuiaInicialFila, Cuadro1_espacioColumna, Cuadro1_espacioFila;
Cuadro2_lineaGuiaInicialColumna, Cuadro2_lineaGuiaInicialFila, Cuadro2_espacioColumna, Cuadro2_espacioFila;
Cuadro3_lineaGuiaInicialColumna, Cuadro3_lineaGuiaInicialFila, Cuadro3_espacioColumna, Cuadro3_espacioFila;
Cuadro4_lineaGuiaInicialColumna, Cuadro4_lineaGuiaInicialFila, Cuadro4_espacioColumna, Cuadro4_espacioFila;
0,0,0,0
]

[totalFilas, totalCol]=size(ArrayCuadros);
%xmin=401; ymin=201; %Cuadro 1
%xmin=100; ymin=100; %Cuadro 2
%xmin=351; ymin=10; %Cuadro 3
%xmin=831; ymin=31; %Cuadro 4

%%
%xmin=80; ymin=71; %cuadro 2
%xmin=412; ymin=248; %cuadro 1
%xmin=465; ymin=69; %cuadro 3
xmin=848; ymin=47; %cuadro 2


%% REcorrer tabla con cuadros para detectar el punto inicial
n=1; %indice detector de objetos
for (n=1:totalFilas) 
     if((xmin>ArrayCuadros(n,1)) & (xmin<ArrayCuadros(n,1)+ArrayCuadros(n,3)))
        fprintf('dentro de columnas cuadro numero=%i\n',n);
        if((ymin>ArrayCuadros(n,2)) & (ymin<ArrayCuadros(n,2)+ArrayCuadros(n,4)))
                    fprintf('dentro de filas cuadro numero=%i\n',n);
                    break;
        end% filas    
     else
        fprintf('fuera de columnas para cuadro=%i\n',n);
     end
end% for     

%%resultados
if(n==totalFilas)
    fprintf('xmin=%i ymin=%i NO ENCAJA\n', xmin, ymin);
else
    fprintf('EL CUADRO ES %i\n', n);    
end %