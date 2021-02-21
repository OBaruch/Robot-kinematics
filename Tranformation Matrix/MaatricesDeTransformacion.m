clear all
close all
clc
%   a   alpha     d    tehta (q)
DH=[0     pi/2    .5      0;
    .4      0      0     pi/4;
    0     pi/2     0     pi/4;
    0       0     .6      0];

TRevoluta=@(a,alpha,d,theta) [cos(theta) -sin(theta)*cos(alpha)  sin(theta)*sin(alpha) a*cos(theta);
                       sin(theta)  cos(theta)*cos(alpha) -cos(theta)*sin(alpha)  a*sin(theta);
                       0                 sin(alpha)             cos(alpha)           d;
                       0                    0                       0                1];

[z,y]=size(DH);
for i=1:z
    if i==1
    T01=TRevoluta(DH(i,1),DH(i,2),DH(i,3),DH(i,4))
    end
    if i==2
    T12=TRevoluta(DH(i,1),DH(i,2),DH(i,3),DH(i,4))
    end
    if i==3
    T23=TRevoluta(DH(i,1),DH(i,2),DH(i,3),DH(i,4))
    end
    if i==4
    T34=TRevoluta(DH(i,1),DH(i,2),DH(i,3),DH(i,4))
    end
end

disp('Cinematica Directa')
T04=T01*T12*T23*T34


