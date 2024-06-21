function [ y1,y2 ] = transformpoint1d( nodes,a,b,i,j,n,m )
%   x2,y2 - wsp??rz?dne punktu wyj?ciowego
%   nodes - tablica wsp??rz?dnych x i y w?z??w siatki
%   x1,y1 - wsp??rz?dne pocz?tkowe punktu


%[n,m]=size(nodes);

y1=0;
y2=0;

%wyznaczenie nowych wsp??rz?dnych punktu
for k=0:3
    for l=0:3  
        y1=y1+a(k+1)*b(l+1)*nodes(j+l+2+n*(m-(i+k)-2));
        y2=y2+a(k+1)*b(l+1)*nodes(j+l+2+n*(2*m-(i+k)-2));    
   
    end
end

end




