function [ cost ] = SSD( image1, image2 )
%funkcja obliczaj?ca warto?? funkcji kosztu (kryterium SSD)
%por?wnywane obrazy musz? by? takich samych rozmiar?w
%cost=sum(sum(((image1-image2).^2)./(image1+image2)))/(numel(image1));
cost=sum(sum(((image1-image2).^2)))/(numel(image1));
%cost=sum(sum((nthroot(abs(image1-image2),3))))/(numel(image1));
end

