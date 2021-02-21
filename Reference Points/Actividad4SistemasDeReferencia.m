clear
clc
cla
Tinv=@(T)([T(1:3,1:3)'-T(1:3,1:3)'*T(1:3,4);0 0 0 1]); %Inversa de la tranformada
T_ab=[0 1 0 2;
     -1 0 0 2;
      0 0 1 2;
      0 0 0 1];
  
 T_bc=[1 0 0 2;
      0 0 -1 2; 
      0 1 0 -1;
      0 0 0 1];
  
T_ad=[0 -1 0 6;
      1 0 0 -6;
      0 0 1 3;
      0 0 0 1];
p_b=[0;
    -2;
     0;
     1]; %Coordenadas del punto respecto a b
%%
disp('Se encuentra T_cd con la la multiplicacion de: Tinv(T_bc)*Tinv(T_ab)*T_ad')
T_cd=inv(T_bc)*inv(T_ab)*T_ad
%%
disp('Se encuentra T_cd con la la multiplicacion de: T_ab*T_bc')
T_ac=T_ab*T_bc

%%
Dibujar_Sistema_Referencia_3D(eye(4,4),'Origen a')
Dibujar_Sistema_Referencia_3D(T_ab,'b')
T_ac=(T_ab*T_bc);
Dibujar_Sistema_Referencia_3D(T_ac,'c')
T_ad=(T_ab*T_bc*T_cd);
Dibujar_Sistema_Referencia_3D(T_ad,'d')
Dibujar_Punto_3D(T_ab*p_b)%Coordenadas del punto respecto de b



%%

disp('Las coordenadas del punto respecto de A son:')
p_a=(T_ab*p_b)
disp('Las coordenadas del punto respecto de B son:')
P_b=(p_b)
disp('Las coordenadas del punto respecto de C son:')
p_c=(inv(T_bc)*p_b)
disp('Las coordenadas del punto respecto de D son:')
p_d=(inv(T_cd)*p_c)


