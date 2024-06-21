function [ penalty] = penalties1d(  xsize,ysize,nodes,ws,wv,n,m )
%penalty warto?? sumy funkcji kosztu
%x y - wsp??rz?dne punktu
%nodes - tablica w?z??w siatki
%ws - wsp??czynnik wagowy kary g?adko?ci
%wv - wsp??czynnik wagowy kary powierzchni


% txx=zeros(a,b);
% txy=zeros(a,b);
% tyx=zeros(a,b);
% tyy=zeros(a,b);
% txxx=zeros(a,b);
% tyyy=zeros(a,b);
% txxy=zeros(a,b);
% jt=zeros(a,b);

[vpenaltyt, spenalty]=penalties(nodes,n,m,xsize,ysize);
vpenalty=vpenaltyt;
vpenalty(vpenaltyt~=0)=abs(log(vpenaltyt(vpenaltyt~=0)));
%wyznaczone wcze?niej warto?ci B-splajn?w 
% stxx=0;styy=0;stxy=0;styx=0;stxxx=0;styyy=0;stxxy=0;
% for ind=1:a
%    
% 
%         %wyznaczanie pochodnych transformacji
%        
% %         [txx((i2-1)*n+i),txy((i2-1)*n+i),tyx((i2-1)*n+i),tyy((i2-1)*n+i),txxx((i2-1)*n+i),tyyy((i2-1)*n+i),txxy((i2-1)*n+i)]=...
% %             volumetransform1d(nodes, [Bu0((i2-1)*n+i),Bu1((i2-1)*n+i), Bu2((i2-1)*n+i), Bu3((i2-1)*n+i)],...
% %            [Bv0((i2-1)*n+i),Bv1((i2-1)*n+i), Bv2((i2-1)*n+i), Bv3((i2-1)*n+i)],[dBu0((i2-1)*n+i),dBu1((i2-1)*n+i), dBu2((i2-1)*n+i), dBu3((i2-1)*n+i)],...
% %            [dBv0((i2-1)*n+i),dBv1((i2-1)*n+i), dBv2((i2-1)*n+i), dBv3((i2-1)*n+i)],[dB2u0((i2-1)*n+i),dB2u1((i2-1)*n+i), dB2u2((i2-1)*n+i), dB2u3((i2-1)*n+i)],...
% %            [dB2v0((i2-1)*n+i),dB2v1((i2-1)*n+i), dB2v2((i2-1)*n+i), dB2v3((i2-1)*n+i)],ia((i2-1)*n+i),ja((i2-1)*n+i),m,n); 
% %        
% 
%         [txx,txy,tyx,tyy,txxx,tyyy,txxy]=...
%             volumetransform1d(nodes, [glob.Bu0(ind),glob.Bu1(ind), glob.Bu2(ind), glob.Bu3(ind)],...
%            [glob.Bv0(ind),glob.Bv1(ind), glob.Bv2(ind), glob.Bv3(ind)],[glob.dBu0(ind),...
%            glob.dBu1(ind), glob.dBu2(ind), glob.dBu3(ind)],[glob.dBv0(ind),glob.dBv1(ind),...
%            glob.dBv2(ind), glob.dBv3(ind)],[glob.dB2u0(ind),glob.dB2u1(ind), glob.dB2u2(ind),...
%            glob.dB2u3(ind)],[glob.dB2v0(ind),glob.dB2v1(ind), glob.dB2v2(ind), glob.dB2v3(ind)],...
%            glob.ia(ind),glob.ja(ind),m,n);   
%     
%         p=(txx*tyy-tyx*txy);
%         if p
%             jt=abs(log(txx*tyy-tyx*txy));
%         else
%             jt=0;
%         end
% %kara powierzchni
%         penalty=penalty+jt;
%         spenalty=spenalty+txxx.^2+tyyy.^2+2*txxy.^2;
% %         stxx(ind)=txx;styy(ind)=tyy;
% %         stxy(ind)=txy;styx(ind)=tyx;
% %         stxxx(ind)=txxx;styyy(ind)=tyyy;
% %         stxxy(ind)=txxy;
% end

%penalty=sum(jt);
%kara obj?to?ci
% spenalty=sum(sum(txxx.^2+tyyy.^2+2*txxy.^2));
%suma kar
 penalty=(wv*sum(vpenalty)+ws*sum(spenalty))/(xsize*ysize);

end


