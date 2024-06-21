function a = dB2( t ,i )
%obliczanie drugich pochodnych transformacji
switch i
    case 0
        a=-t+1;
    case 1
        a=3*t-2;
    case 2
        a=-3*t+1;
    case 3
        a=t;
end

end

