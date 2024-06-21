function [cost,grad] = dopas1d( innodes,image1, image2wz, im2xwz,im2ywz,dx,dy,ws,wv,m,n,maskmov,maskref,wk,iind,jind )
%funkcja wyznaczaj?ca warto?? funkcji kosztu i gradient
%cost warto?? funkcji kosztu
%grad - gradient funkcji kosztu
%nodes - tablica zawieraj?ca wsp??rz?dne w?z??w siatki
%image1 - obraz referencyjny
%image2wz - wzorcowy obraz dopasowywany
%im2xwz, im2ywz - wzorcowe wsp??rz?dne obrazu dopasowywanego
%dx,dy - przemieszczenia do wyznaczania gradientu
%ws, wv - wsp??czynniki wagowe funkcji kosztu
%m,n rozmiar siatki 2d (??cznie z w?z?ami poza p?aszczyzn? obrazu m-il.
%wierszy

% %transformacja obrazu
nodes=transnodes1d(innodes);
 [image2,outmask,~]=transformimage1d(nodes,image2wz,im2xwz,im2ywz,n,m,maskmov);

%wyznaczenie funkcji kosztu
n=n/2;


[ysize,xsize]=size(image1);

if ws~=0
    cost=SSD(image1,image2)+penalties1d(xsize,ysize,nodes,ws,wv,m,n)+wk*sum(sum(abs(maskmov-maskref)))/(numel(maskref));
else
    cost=SSD(image1,image2)+wk*sum(sum(abs(maskmov-maskref)))/(numel(maskref));
end
%wykonywane je?li optymalizator prosi o gradient
if(nargout>1)     
    errx1=zeros(m*n,16);errx2=zeros(m*n,16);
    erry1=zeros(m*n,16);erry2=zeros(m*n,16);
    grad=zeros(m*n*2,1);

    
parfor iter1=1:16
    itery=rem(floor((iter1-1)/4),4)+1;
    iterx=rem(iter1-1,4)+1;
    nodesx1=nodes;
    nodesx2=nodes;
    nodesy1=nodes;
    nodesy2=nodes;
%    
j=0;

        for i=0:4:(m-1)
            a=itery+i+(iterx+j-1)*m:4*n:m*n;
            nodesx1(a)=nodes(a)+dx;
            nodesx2(a)=nodes(a)-dx;
            
            b=itery+i+(iterx+j-1)*m+m*n:4*m:2*m*n;
            nodesy1(b)=nodes(b)+dy;
            nodesy2(b)=nodes(b)-dy;
        end


       %wyznaczenie obraz?w, b?d?cych efektem przemieszcze?
       [ imx1,maskx1,~ ] = transformimage1d( nodesx1,image2wz,im2xwz,im2ywz,n*2,m,maskmov );
       [ imx2,maskx2,~ ] = transformimage1d( nodesx2,image2wz,im2xwz,im2ywz,n*2,m,maskmov );
       [ imy1,masky1,~] = transformimage1d( nodesy1,image2wz,im2xwz,im2ywz,n*2,m,maskmov );
       [ imy2,masky2,~ ] = transformimage1d( nodesy2,image2wz,im2xwz,im2ywz,n*2,m,maskmov );
    
       %wyznaczenie funkcji kosztu 
       errx1(:,iter1)=part1d(iterx,itery,nodesx1,image1, imx1,ws,wv,m,n,errx1(:,iter1),maskx1,maskref,wk,iind,jind);
       errx2(:,iter1)=part1d(iterx,itery,nodesx2,image1, imx2,ws,wv,m,n,errx2(:,iter1),maskx2,maskref,wk,iind,jind); 
       erry1(:,iter1)=part1d(iterx,itery,nodesy1,image1, imy1,ws,wv,m,n,erry1(:,iter1),masky1,maskref,wk,iind,jind); 
       erry2(:,iter1)=part1d(iterx,itery,nodesy2,image1, imy2,ws,wv,m,n,erry2(:,iter1),masky2,maskref,wk,iind,jind);


end
    errx1c=sum(errx1,2);
    errx2c=sum(errx2,2);
    erry1c=sum(erry1,2);
    erry2c=sum(erry2,2);
    grad(1:m*n)=(errx1c-errx2c)/(2*dx);
    grad(m*n+1:2*m*n)=(erry1c-erry2c)/(2*dy);

end

end



