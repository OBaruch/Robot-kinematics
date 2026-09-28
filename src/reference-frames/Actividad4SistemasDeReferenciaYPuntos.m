clear
clc
cla
Rx=@(theta)[1 0 0; 0 cos(theta) -sin(theta);0 sin(theta) cos(theta)];
Ry=@(theta)[cos(theta) 0 sin(theta) ;0 1 0 ;-sin(theta) 0 cos(theta)];
Rz=@(theta)[cos(theta) -sin(theta) 0;sin(theta) cos(theta) 0;0 0 1];
Tinv=@(T)([T(1:3,1:3)'-T(1:3,1:3)'*T(1:3,4);0 0 0 1]); %Inversa de la tranformada

%%
%Transformacion ab
R_ab=Rx(0)*Ry(0)*Rz(pi/4); %Rotaciones
t_ab=[2 2 0]';           %Traslaciones
T_ab=[[R_ab t_ab];0 0 0 1];   %Matriz de Transformacion
%%
%Transformacion bc
R_bc=Rx(0)*Ry(0)*Rz(pi/4); %Rotaciones
t_bc=[2 2 0]';           %Traslaciones
T_bc=[[R_bc t_bc];0 0 0 1];   %Matriz de Transformacion
%%
%Transformacion ad
R_ad=Rx(0)*Ry(0)*Rz(0); %Rotaciones
t_ad=[2 2 0]';           %Traslaciones
T_ad=[[R_ad t_ad];0 0 0 1];   %Matriz de Transformacion
%%
%Transfomracion cd
disp('Se encuentra T_cd con la la multiplicacion de: Rinv(T_bc)*Rinv(T_ab)*T_ad')
T_cd=Tinv(T_bc)*Tinv(T_ab)*T_ad;



hold on 
Dibujar_Sistema_Referencia_3D(eye(4,4),'Origen a')
Dibujar_Sistema_Referencia_3D(T_ab,'b')
Dibujar_Sistema_Referencia_3D(T_ab*T_bc,'c')
Dibujar_Sistema_Referencia_3D(T_ab*T_bc*T_cd,'d')
% Dibujar_Punto_3D(pa)

