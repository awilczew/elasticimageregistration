function a = B( t ,i )

%   calculating b-splines
switch i
    case 0
        a=(((1-t).^3)/6);
    case 1
        a=((3*t.^3-6*t.^2+4)/6);
    case 2
        a=((-3*t.^3+3*t.^2+3*t+1)/6);
    case 3
        a=((t.^3)/6);
end

end

