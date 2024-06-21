function [ txx,txy,tyx,tyy,txxx,tyyy,txxy ] = volumetransform1d( nodes,a,b,da,db,da2,db2,i,j,m,n )
%txx i tak dalej - odpowiednie pochodne transformacji
%nodes - tablica wezlow siatki
%a,b - wartosci b-splajnow w punkcie
%da, db - wartosci pochodnych b-splajn?w w punkcie
%da2,db2 - wartosci drugich pochodnych b-splajnow w punkcie
%i,j - indeksy punktu

% [n,m]=size(nodes);
%m=m/2;

%i=min(i,m-4); i=max(i,1);
%j=min(j,n-4); j=max(j,1);

txx=0;
txy=0;
tyx=0;
tyy=0;
txxx=0;
tyyy=0;
txxy=0;

%wyznaczanie pochodnych transformacji
for k=0:3
    for l=0:3

        txx=txx+da(k+1)*b(l+1)*nodes((j+l+2)+(m-(i+k)-2)*n);
%         txx=txx+j;
        txy=txy+a(k+1)*db(l+1)*nodes((j+l+2)+(m-(i+k)-2)*n);
        tyx=tyx+da(k+1)*b(l+1)*nodes((j+l+2)+(2*m-(i+k)-2)*n);
        tyy=tyy+a(k+1)*db(l+1)*nodes((j+l+2)+(2*m-(i+k)-2)*n);
        txxx=txxx+da2(k+1)*b(l+1)*nodes((j+l+2)+(m-(i+k)-2)*n)+da2(k+1)*b(l+1)*nodes((j+l+2)+(2*m-(i+k)-2)*n);
        tyyy=tyyy+a(k+1)*db2(l+1)*nodes((j+l+2)+(2*m-(i+k)-2)*n)+a(k+1)*db2(l+1)*nodes((j+l+2)+(m-(i+k)-2)*n);
        txxy=txxy+da(k+1)*db(l+1)*nodes((j+l+2)+(2*m-(i+k)-2)*n)+da(k+1)*db(l+1)*nodes((j+l+2)+(m-(i+k)-2)*n);
   
    end
end
       
end


