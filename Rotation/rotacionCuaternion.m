function [R] = rotacionCuaternion(th,w)
%%Esta funcion da la matriz de rotacion estableciendo un th(cuanto se va a
%%girar) y un w(que es el vector en el cual se ara el giro x=[1 0 0] y=[0 1 0] z=[0  0 1])

J=@(x)[0 -x(3) x(2);x(3) 0 -x(1); -x(2) x(1) 0]; %Matriz asimetrica
I=eye(3,3);                                       %Mtriz identidad
%Cuaternion=(u0,u)
u0=cos(th/2);
u=sin(th/2)*w;

R=(((u0*u0)-(u'*u))*I)+(2*u0*J(u))+(2*(u*u'));
end

