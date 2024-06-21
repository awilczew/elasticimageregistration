function [ nodes ] = Grid( m,n )
%UNTITLED2 Summary of this function goes here
%   Setting a grid for mxn control points on the image
%   nodes - mxnx2 matrix of x and y coordinates of control points
%   nodes(:,:,1) - x coordinates, nodes(:,:,2) - y coordinates
%   m - number of control points in x direction
%   n - number of control points in y direction

nodes=zeros(n,m,2);
for i=1:n+4
    for j=1:m+4
        nodes(i,j,1)=m+3-j;
        nodes(i,j,2)=i-2;
    end
end


end

