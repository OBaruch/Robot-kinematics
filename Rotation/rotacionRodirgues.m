function [R] = rotacionRodirgues(th,w)
%%Esta funcion da la matriz de rotacion estableciendo un th(cuanto se va a
%%girar) y un w(que es el vector en el cual se ara el giro x=[1 0 0] y=[0 1 0] z=[0  0 1])

J=@(u)[0 -u(3) u(2);u(3) 0 -u(1); -u(2) u(1) 0]; %Matriz asimetrica
I=eye(3,3);                                       %Mtriz identidad
R=(I)+(sin(th)*J(w))+((1-cos(th))*((J(w))*(J(w)))); %formula para sacar la matriz de  rotacion
end

