function [ x,y,i,j,u,v ] = attributes1d( n, m, iymax,ixmax )
%attributes Summary of this function goes here
%   outimage - output 3D array with image values and all parameteres (coordinates)
%   inimage - input 2D array containing image values
%   N - number of grid nodes in x direction
%   M - number of grid nodes in y direction
%maksymalne indeksy punkt�w wej�ciowego obrazu w 2D

%inicjalizacja obrazu wyj�ciowego
x=zeros(iymax*ixmax,1);
y=zeros(iymax*ixmax,1);
%pozosta�e warstwy macierzy wyj�ciowej - wsp�rz�dne x, y, i, j, u i v
%punkt�w obrazu

for ix=1:ixmax
    for iy=1:iymax
        %wsp�rz�dne x punkt�w
        x((ix-1)*iymax+iy)=(n+1)-(1+((n-1)/(ixmax-1))*(ix-1));
        %wsp�rz�dne y punkt�w
        y((ix-1)*iymax+iy)=1+((m-1)/(iymax-1))*(iy-1);
        
    end
end
i=floor(x)-1;
j=floor(y)-1;
u=x-floor(x);
v=y-floor(y);
end

