function [ cost ] = part1d( iterx,itery,nodes, image1,image2,ws,wv,n,m,cost,maskmov,maskref,wk,iind,jind )
%funkcja wyznaczaj?ca funkcj? kosztu cz??ci obrazu
%cost - warto?? funkcji kosztu
%nodes - tablica wsp??rz?dnych w?z??w siatki
%image1 - obraz referencyjny
%image2 - obraz dopasowywany
%indy, indx - indeksy przemieszczanego w?z?a siatki
%ws,wv - wsp??czynniki wagowe funkcji kary
tic
[ysize,xsize]=size(image1);
if ws~=0
    [vpenalty, spenalty]=penalties(nodes,n,m,xsize,ysize);
end




[iymax,ixmax]=size(image1);
% test=zeros(size(image1));
%wyznaczenie cz??ci obrazu, na kt?re wp?yw ma w?ze? siatki
% x=zeros(size(image1));
% y=zeros(size(image1));
% iind=zeros(size(image1));
% jind=zeros(size(image1));
% %pozosta³e warstwy macierzy wyjœciowej - wspó³rzêdne x, y, i, j, u i v
% %punktów obrazu
% 
% for ix=1:ixmax
%     for iy=1:iymax
%         %wspó³rzêdne x punktów
%         x(iy,ix)=(m-3)-(1+((m-5)/(ixmax-1))*(ix-1));
%         %wspó³rzêdne y punktów
%         y(iy,ix)=1+((n-5)/(iymax-1))*(iy-1);
%         %indeks i punktu
%         iind(iy,ix)=floor(x(iy,ix))-1;
%         %indeks j punktu
%         jind(iy,ix)=floor(y(iy,ix))-1;
%     end
% end

nodeswz=Grid(m-4,n-4);

%wyznaczenie SSD w tym obszarze
 %cost=sum(sum(((image1(a1:a2,b1:b2)-image2(a1:a2,b1:b2)).^2)));
% dot=0;
%wyznaczenie warto?ci funkcji kary
j=0;
% for j=0:4:(n-1)

    for i=0:4:(m-1)
    
        for iter2=itery+i+(iterx+j-1)*n:4*m:m*n
            
            xminval=nodeswz(iter2)-3;
            xmaxval=nodeswz(iter2);
            yminval=nodeswz(iter2+m*n)-3;
            ymaxval=nodeswz(iter2+m*n);

            a1=find(sum(jind==yminval,2),1,'first'); a2=find(sum(jind==ymaxval,2),1,'last');
            b1=find(sum(iind==xmaxval,1),1,'first'); b2=find(sum(iind==xminval,1),1,'last');
            
          
            if (size(a1,1)==0&&size(a2,1)==0)||(size(b1,2)==0&&size(b2,2)==0)
                continue;
            end
            
            if size(a1,1)==0; a1=1; end
            if size(a2,1)==0; a2=iymax; end    
            if size(b1,2)==0; b1=1; end
            if size(b2,2)==0; b2=ixmax; end

if ws~=0
            cost(iter2)=SSD(image1(a1:a2,b1:b2),image2(a1:a2,b1:b2))+...
                (wv*sum(vpenalty((a1+(b1-1)*n):(a2+(b2-1)*n)))+ws*sum(spenalty((a1+(b1-1)*n):(a2+(b2-1)*n)))+...
                wk*sum(sum(abs(maskmov(a1:a2,b1:b2)-maskref(a1:a2,b1:b2)))))/((a2-a1+1)*(b2-b1+1));
else
    cost(iter2)=SSD(image1(a1:a2,b1:b2),image2(a1:a2,b1:b2))+...
                wk*sum(sum(abs(maskmov(a1:a2,b1:b2)-maskref(a1:a2,b1:b2))))/((a2-a1+1)*(b2-b1+1));
end
            %if(nargin>12)
%             cost(iter2) = cost(iter2)+wk*sum(sum(((maskmov(a1:a2,b1:b2)-maskref(a1:a2,b1:b2)).^2)))/((a2-a1+1)*(b2-b1+1)); 
%             cost(iter2) = cost(iter2)+wk*sum(sum(abs(maskmov(a1:a2,b1:b2)-maskref(a1:a2,b1:b2))))/((a2-a1+1)*(b2-b1+1)); 
        
           % end
        end
       
    end
    
% end

%funkcja kosztu



end


