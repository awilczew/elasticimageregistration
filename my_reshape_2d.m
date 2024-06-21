function [out] = my_reshape_2d(in,sizey,sizex)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
out=zeros(sizey,sizex);

for i =1:sizex
    out(:,i)=in(((i-1)*sizey+1):i*sizey);
end

end

