%%%%%%%%%%%%%Parte1
%%%%%%%%%%%%%%%%%%%%%%p1
p1=[1;1;1];
p2=[2;1;1];
p3=[1.5;2;1];

axis([-20 20 -20 20])
hold on
grid on
plot3(p1(1),p1(2),p1(3),'k.');
plot3(p2(1),p2(2),p2(3),'k.');
plot3(p3(1),p3(2),p3(3),'k.');

%%%%%%%%%%%%Cambios
sx=3;
sy=2;
tx=4;
ty=8;
th=pi;
%Escalamiento
e=[sx 0 0;
   0 sy 0;
   0 0  1];
%Rotacion
r=[cos(th) -sin(th) 0;
   sin(th)  cos(th) 0;
   0          0     1];
%Traslacion
t=[1 0 tx;
   0 1 ty;
   0 0  1];


p1escalado=e*p1;
p2escalado=e*p2;
p3escalado=e*p3;
plot3(p1escalado(1),p1escalado(2),p1escalado(3),'r*');
plot3(p2escalado(1),p2escalado(2),p2escalado(3),'r*');
plot3(p3escalado(1),p3escalado(2),p3escalado(3),'r*');


p1rotado=r*p1;
p2rotado=r*p2;
p3rotado=r*p3;
plot3(p1rotado(1),p1rotado(2),p1rotado(3),'g*');
plot3(p2rotado(1),p2rotado(2),p2rotado(3),'g*');
plot3(p3rotado(1),p3rotado(2),p3rotado(3),'g*');

p1trasladado=t*p1;
p2trasladado=t*p2;
p3trasladado=t*p3;
plot3(p1trasladado(1),p1trasladado(2),p1trasladado(3),'b*');
plot3(p2trasladado(1),p2trasladado(2),p2trasladado(3),'b*');
plot3(p3trasladado(1),p3trasladado(2),p3trasladado(3),'b*');

