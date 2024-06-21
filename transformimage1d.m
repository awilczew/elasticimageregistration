function [ outimage,outmask,x2,y2,xo,yo,x4,y4 ] = transformimage1d( nodes,inimage,x,y,m,n,mask )
%Dirk-Jan Kroon (2024). FMINLBFGS: Fast Limited Memory Optimizer 
%(https://www.mathworks.com/matlabcentral/fileexchange/23245-fminlbfgs-fast-limited-memory-optimizer),
% MATLAB Central File Exchange. 
%outimage - obraz wyj?ciowy
%x2,y2 - wsp??rz?dne obrazu wyj?ciowego
%nodes - tablica w?zl?w siatki
%inimage - obraz wej?ciowy
% x1,y1 - wspo?rz?dne wej?ciowe


[a,b]=size(inimage);
x2=zeros(size(inimage));
y2=zeros(size(inimage));

itmax=numel(inimage);
[x2,y2,xo1,yo1]=transformallpoints_full(nodes,n,m/2,b,a,x,y);
x4=my_reshape_2d(x,a,b);
y4=my_reshape_2d(y,a,b);
xo=my_reshape_2d(xo1,a,b);
yo=my_reshape_2d(yo1,a,b);

outimage=interp2(x4,y4,inimage,xo,yo,'cubic',0);
outimage(isnan(outimage))=inimage(isnan(outimage));


outmask=interp2(x4,y4,mask,xo,yo,'nearest',0);
outmask(isnan(outmask))=mask(isnan(outmask));


end



