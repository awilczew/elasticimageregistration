function [ outnodes ] = transnodes1d( innodes )
%transformacja siatki z tablicy 3d na 2d
[k,l,m]=size(innodes);
outnodes=zeros(2*k*l,1);
outnodes(1:k*l)=reshape(innodes(:,:,1),1,[]);
outnodes(k*l+1:2*k*l)=reshape(innodes(:,:,2),1,[]);
end
