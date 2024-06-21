function [ out ] = coord( in, param,grid,c )
%coord przeliczanie wsp??rz?dnych siatki na wsp??rz?dne rzeczywiste
%je?li w kierunku r (y)
if param == 1
    out = ((in-1)/(grid-1))*((max(max(c))-min(min(c))))+min(min(c));
    %jesli w kierunku theta (x)
elseif param == 2
         out = ((in-1)/(grid-1))*((max(max(c))-min(min(c))))+min(min(c));
end


end

