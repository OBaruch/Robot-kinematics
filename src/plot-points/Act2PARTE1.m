%%%%%%%%%%%%%Parte1
a=[3   3   2;
   1   2   5;
  -4   1   2];
b=[1 2 3;
   4 5 6;
   7 8 9];
[l,m]=size(a);
[p,q]=size(b);
c=zeros(l,q);
for i=1:l
    for j=1:q
        for k=1:m
            c(i,j)=c(i,j)+a(i,k)*b(k,j)
        end
        
    end
    
end


