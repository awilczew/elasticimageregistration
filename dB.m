function a = dB( t ,i )
%obliczanie pierwszych pochodnych transformacji
switch i
    case 0
        a=((-t.^2+2*t-1)/2);
    case 1
        a=((3*t.^2-4*t)/2);
    case 2
        a=((-3*t.^2+2*t+1)/2);
    case 3
        a=((t.^2)/2);
end

end

