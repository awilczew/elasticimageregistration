function [dataBBout] = makebaseband(fantom,decimation_coefficient)

dataBBout = zeros(ceil(size(fantom,1)/decimation_coefficient),size(fantom,2),size(fantom,3));
for kk = 1:size(fantom,3)

    
    
    for ii=1:size(fantom,2)
        dataBB=abs(hilbert(fantom(:,ii,kk)));
        dataBBout(:,ii,kk)=decimate(dataBB,decimation_coefficient,'fir');
    end
end