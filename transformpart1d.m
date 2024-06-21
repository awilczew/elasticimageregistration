function [ outimage,outmask,xo,yo] = transformpart1d( pnode,iter,nodes, inimage,x1,y1, indy,indx,n,m,glob,mask)
%transformacja czesci obrazu
%outimage - obraz wyj?ciowy
%x2,y2 - wsp??rz?dne obrazu wyj?ciowego
%nodes - tablica w?zl?w siatki
%inimage - obraz wej?ciowy
% x1,y1 - wspo?rz?dne wej?ciowe
%indx indy - indeksy przemieszczanego w?z?a
%wyznaczone wcze?niej warto?ci B-splineu w punkcie
%global Bu0 Bu1 Bu2 Bu3 Bv0 Bv1 Bv2 Bv3 ia ja
outimage=zeros(size(inimage));
outmask=mask;

[iymax,ixmax]=size(inimage);
x=zeros(size(inimage));
y=zeros(size(inimage));
xo=x;
yo=y;
iind=zeros(size(inimage));
jind=zeros(size(inimage));
%pozosta³e warstwy macierzy wyjœciowej - wspó³rzêdne x, y, i, j, u i v
%punktów obrazu
for ix=1:ixmax
    for iy=1:iymax
        %wspó³rzêdne x punktów
        x(iy,ix)=(m-3)-(1+((m-5)/(ixmax-1))*(ix-1));
        %wspó³rzêdne y punktów
        y(iy,ix)=1+((n-5)/(iymax-1))*(iy-1);
        %indeks i punktu
        iind(iy,ix)=floor(x(iy,ix))-1;
        %indeks j punktu
        jind(iy,ix)=floor(y(iy,ix))-1;
    end
end
clear x y;

nodeswz=Grid(m-4,n-4);
            xminval=nodeswz(indy+2,indx+2,1)-3;
            xmaxval=nodeswz(indy+2,indx+2,1);
            yminval=nodeswz(indy+2,indx+2,2)-3;
            ymaxval=nodeswz(indy+2,indx+2,2);
            [rowxmin,colxmin]=find(iind==xminval);
            [rowxmax,colxmax]=find(iind==xmaxval);
            [rowymin,colymin]=find(jind==yminval);
            [rowymax,colymax]=find(jind==ymaxval);
            a1=min(rowymin); a2=max(rowymax);
            b1=min(colxmax); b2=max(colxmin);
            if (size(a1,1)==0&&size(a2,1)==0)||(size(b1,1)==0&&size(b2,1)==0)
                return;
            end
            if size(a1,1)==0; a1=1; end
            if size(a2,1)==0; a2=iymax; end    
            if size(b1,1)==0; b1=1; end
            if size(b2,1)==0; b2=ixmax; end  
nodes(iter)=pnode;
%obliczenie granic zakresu obejmowanego przez przemieszczany w?ze?
% a1=floor(((indy-2)/(n-4))*(iymax-1)+1);
% a2=ceil(((indy+2)/(n-4))*(iymax-1)+1);
% b1=floor(((indx-2)/(m-4))*(ixmax-1)+1);
% b2=ceil(((indx+2)/(m-4))*(ixmax-1)+1);
%            a1=floor(((indy-2)/(n-5))*(iymax-1));
%             a2=ceil(((indy+2)/(n-5))*(iymax-1));   
%             b1=floor((n-4-m+indx)/(((n-5)/(ixmax-1))))+1;
%             b2=ceil((n-4-m+indx+4)/(((n-5)/(ixmax-1))))+1;
%ograniczenie wsp??rz?dnych, aby nie przekroczy?y wymiar?w obrazu
a1=max(a1,1);b1=max(b1,1);a2=max(a2,1);b2=max(b2,1);
a1=min(a1,iymax);a2=min(a2,iymax);b1=min(b1,ixmax);b2=min(b2,ixmax);
x2=x1;
y2=y1;


%transformacja punkt?w z zakresu
for b=b1:b2
    for a=a1:a2
    
       iter=a+(b-1)*iymax;
       [x2(iter),y2(iter)]=transformpoint1d(nodes,...
           [glob.Bu0(iter),glob.Bu1(iter), glob.Bu2(iter), glob.Bu3(iter)],[glob.Bv0(iter),...
           glob.Bv1(iter),glob.Bv2(iter), glob.Bv3(iter)], glob.ia(iter), glob.ja(iter),n,m);
    end
end
%interpolacja wsp??rz?dnych
x3=reshape(x2,iymax,[]);
y3=reshape(y2,iymax,[]);
x4=reshape(x1,iymax,[]);
y4=reshape(y1,iymax,[]);
xo=x4;
yo=y4;
% xo2=x4;
% yo2=y4;
for i=a1:a2
   xo(i,:)=my_interp(x3(i,:),x4(i,:),x4(i,:));
  % xo(i,:)=my_interp(x3(i,:),x4(i,:),x4(i,:));
end

for i=b1:b2
  yo(:,i)=my_interp(y3(:,i),y4(:,i),y4(:,i));
%    yo(:,i)=my_interp(y3(:,i),y4(:,i),y4(:,i));
end
%interpolacja obrazu
outimage=interp2(x4,y4,inimage,xo,yo,'cubic');
% outimage2=interp2(x4,y4,inimage,xo2,yo2,'cubic');

%outimage=griddata(x4,y4,inimage,xo,yo,'cubic');
if(nargin>11)
    outmask=interp2(x4,y4,mask,xo,yo,'cubic',1);
    outmask(isnan(outmask))=mask(isnan(outmask));
else
    outmask=zeros(size(outimage));
end
outimage(isnan(outimage))=inimage(isnan(outimage));

%outimage = image_interpolation(inimage,x4,y4,'bicubic','replicate');
%wype?nienie punkt?w spoza obrazu warto?ciami granicznymi
% maska=isnan(0./outimage);
% [n,m]=size(inimage);
% for i=round(n/2):n
%     for j=1:m
%         if maska(i,j)
%             outimage(i,j)=inimage(iymax,j);
%             maska(i,j)=0;
%         end
%     end
% end
% for j=round(m/2):m
%     for i=1:n
%         if maska(i,j)
%            outimage(i,j)=inimage(i,ixmax); 
%            maska(i,j)=0;
%         end
%     end
% end
end


