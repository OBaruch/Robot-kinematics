clear
clc
%OMAR BARUCH MORON LOPEZ 213605572 29/enero/2019
%%
J=@(x)[0 -x(3) x(2);x(3) 0 -x(1); -x(2) x(1) 0]; 
I=eye(3,3);  
%%
w=[0 1 0]';
th=pi/2;                        
u01=cos(th/2);
u1=sin(th/2)*w;
q1=[u01,u1'];
%Matriz de rotacion cuaternion 1
MatrizDeRotacionDelCuaternion1=(((u01*u01)-(u1'*u1))*I)+(2*u01*J(u1))+(2*(u1*u1'))
%%
w=[1 0 0]';
th=pi/4;                        
u02=cos(th/2);
u2=sin(th/2)*w;
q2=[u02,u2'];
%Matriz de rotacion cuaternion 1
MatrizDeRotacionDelCuaternion2=(((u02*u02)-(u2'*u2))*I)+(2*u02*J(u2))+(2*(u2*u2'))

%%
%%Matriz de rotacion multiplicando quaterniones
%producto de cuartiones
a=(u01*u02)   -   (u1'*u2);
b=(u01*u2)   +   (u02*u1)  +  cross(u1,u2);
u0=a;
u=b;
%Matrix de retocaion multiplicando cuartiones
MatrizDeRotacionDeLaMultiplicacionDeCuartenions=(((u0*u0)-(u'*u))*I)+(2*u0*J(u))+(2*(u*u'))
%%
%%Matriz de rotacion multiplicando la matriz 1 por la matriz 2
MatrizDeRotacionDeLaMultiplicacionDeLasMatrizesDeRotacion=MatrizDeRotacionDelCuaternion1*MatrizDeRotacionDelCuaternion2
%%
disp('----------------------SON IGUALES ------------------------')



