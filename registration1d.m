function [ imx1,xx1,yx1,nodest ] = registration1d( innodes, imref, immov, step,maskmov,maskref,wk)
%registration Funkcja spinaj?ca algrytm w ca?o??
%  Arumenty wyj?ciowe:
%  imx1 - wyj?ciowy dopasowany obraz
%  xx1 - wsp??rz?dne x po transformacji
%  yx1 - wsp??rz?dne y po transformacji
%  nodest - nowa siatka (transformowana (2D))
%  x1, y1 - wsp??rz?dne referencyjne
%  argumenty wej?ciowe
%  m, n - wymiary siatki (x,y) w pierwszym kroku (przed zag?szczaniem)
%  innodes - siatka wej?ciowa (z poprzedniego kroku)
%  imref - obraz referencyjny
%  immov - obraz przekszta?cany
%  step - numer zag?szczenia - 1 - siatka pierwotna
%pctRunOnAll warning('off','MATLAB:interp1:UsePCHIP');

nodes=untransnodes(innodes);


[n1,m1,~]=size(nodes);
n=n1-4;
m=m1-4;
[iymax,ixmax]=size(immov);
%global ia ja ua va;
%obliczenie parametr?w punktu
[x1,y1,~]=attributes1d(m,n, iymax,ixmax);

x=zeros(size(immov));
y=zeros(size(immov));
iind=zeros(size(immov));
jind=zeros(size(immov));
%pozosta³e warstwy macierzy wyjœciowej - wspó³rzêdne x, y, i, j, u i v
%punktów obrazu

for ix=1:ixmax
    for iy=1:iymax
        %wspó³rzêdne x punktów
        x(iy,ix)=(m1-3)-(1+((m1-5)/(ixmax-1))*(ix-1));
        %wspó³rzêdne y punktów
        y(iy,ix)=1+((n1-5)/(iymax-1))*(iy-1);
        %indeks i punktu
        iind(iy,ix)=floor(x(iy,ix))-1;
        %indeks j punktu
        jind(iy,ix)=floor(y(iy,ix))-1;
    end
end
%warto?ci przemieszcze? do wyznaczania gradientu
zdx=0.08;
zdy=0.08;

%warto?ci wsp??czynnik?w wagowych funkcji kary

ws=0.05;
wv=0;
%wv=(step-1)*0.0005;
%parametry optymalizacji
Tol=(1e-4)/(10^step);
TolFun=0.0002/(10^step);
optim=struct('GradObj','on','Display','iter','HessUpdate','lbfgs','MaxIter',60,'MaxFunEvals',1000,'GoalsExactAchieve',0,'TolFun',TolFun,'TolX',Tol);
%przeniesienie wspo?rz?dnych siatki do tablicy dwuwymiarowej
%(kompatybilno?? z fminunc)
nodest=nodes;
%optymalizacja
nodest = fminlbfgs(@(x)dopas1d(x,imref, immov, x1, y1,zdx,zdy,ws,wv,n+4,2*(m+4),maskmov,maskref,wk,iind,jind),nodest,optim);
%wyznaczenie obrazu i wsp??rz?dnych obrazu - wyniku algorytmu
[imx1,outmask,xx1,yx1]=transformimage1d(nodest,immov,x1,y1,2*(m+4),n+4,maskmov);


end



