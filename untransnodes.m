function [ outnodes ] = untransnodes( innodes )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[k,l]=size(innodes);
outnodes=zeros(k,l/2,2);
for i=1:k
    for j=1:l/2
        outnodes(i,j,1)=innodes(i,j);
        outnodes(i,j,2)=innodes(i,j+l/2);
    end
end

end

