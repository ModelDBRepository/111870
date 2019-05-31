function TCRE 
% Simulation of transformation of Pallidal input through Thalamocortical and Thalamic Reticular interaction
% two GPi neurons (GPi1 & GPi2) with phase difference
% two Thalamocortical neurons (TC1 and TC2)
% two Thalamic Reticular neurons (RE1 and RE2)
% Change "dur" to have simulation for longer time % Be patient it takes time for long simulation!!!
% GPi start to display oscillatory activity after 1000 ms from the begining of simulation






%ghtcmean=.02;vargh=.1*ghtcmean;
%gkltcmean=.012;vargkltc=.1*gkltcmean;
%gkltc1=gkltcmean+vargkltc*randn(1),gkltc2=gkltcmean+vargkltc*randn(1),ghtc1=ghtcmean+vargh*randn(1),ghtc2=ghtcmean+vargh*randn(1);
%gkltrmean=.005;vargkltr=.1*gkltrmean;
%gkltr1=gkltrmean+vargkltr*randn(1),gkltr2=gkltrmean+vargkltr*randn(1),
phgpigpi=20;%abs(15*rand(1)); % phase between GPi1 and GPi2
repeat=5;
for i=1:repeat
    if i==1
        x0=[-67.1845,0.0003,0.9999,0.0017,0.2108,0.0188,0.1979,0.3004,0.1415,0,0,0.0003,0.1982,0.0002,0.0043,0.0000, ...
            -65.2962,0.0000,1.0000,0.0003,0.0412,0.2808,0.0003,0.0001,0.0008,0,0,0.0000,0.0000,0.0000,-70.0000, ...
            -60,0,0,0,0,-60,0,0,0,0,0,0,-67.1845,0.0003,0.9999,0.0017,0.2108,0.0188,0.1979,0.3004,0.1415,0,0, ...
            0.0003,0.1982,0.0002,0.0043,0.0000,-65.2962,0.0000,1.0000,0.0003,0.0412,0.2808,0.0003,0.0001,0.0008, ...
            0,0,0.0000,0.0000,0.0000,-70.0000,-60,0,0,0,0,0,0,0];
    end;
dur=600; %  repeat*dur= duration of the simulation in ms;
a=(i-1)*dur;
aa=0;
b=a+dur;
bb=repeat*dur;
gltc=.01,vltc=-70,gkltc1=.0112,gkltc2=.013, ...
    gnatc=90,vnatc=50,gktc=10,vktc=-95,ghtc1=.0225,ghtc2=.0168, ...
    vhtc=-40,iapptc=0,gttc=2.2,gatc=0,vatc=-95;
gltr=.05,vltr=-77,gkltr1=.0043,gkltr2=.0053, ...
    gnatr=100,vnatr=50,gktr=10,vktr=-95,gttr=2,iapptr=.0,gahp=.0,vahp=-95,gcan=.0,vcan=-20;
%gltc=.01,vltc=-70,gnatc=90,vnatc=50,gktc=10,vktc=-95,vhtc=-40,iapptc=0,gttc=2.2,gatc=0,vatc=-95;
%gltr=.05,vltr=-77,gnatr=100,vnatr=50,gktr=10,vktr=-95,gttr=2,iapptr=.0,gahp=.0,vahp=-95,gcan=.0,vcan=-20;
shift=1;
vtrab=50;
vtrabtc=30;
egabaatr=-75,egabaatc=-85,egabab=-95,eampa=0;
ggabaatc=.04*3.44,ggabab=0.0015*3.44,gampa=.02*6.99,ggabaatr=0.04*6.99;
%ggabaatc=0.025*3.41,ggabab=0.04*3.41,gampa=.15*7,ggabaatr=0.18*7;
%ggabaatc=.0,ggabab=0.0,gampa=.0,ggabaatr=0.0;
%ggabaatcne=0.0,ggababne=0.00,gampane=0.0,ggabaatrne=0.0;
ghold=.0;vhold=-40;
k1=.0004,k2=.0004;k3=.1,k4=.001;
ss=0,sss=.225;% syn pulse parameters
at=22.7,bt=.27;% parameter for th RE T-type calcium current/ alternative is 28.3 and 0.33%
%at=22.7,bt=.27;
%at=28.3,bt=.33;
iappgpi=0,iappgpi2=0,iappgpe=0,glgpe=.05,vlgpe=-60;
ggabaagptr=.0,egabaagptr=egabaatr,ggabaagptc=.04*3.44,egabaagptc=egabaatc,ggababgptc=.0015*3.44,egababgptc=egabab;
%refine=5;
options = odeset('RelTol',10^(-6),'AbsTol',10^(-6));%,'initialstep',.01,'maxstep',.01);
[t,x]=ode15s(@TCTR,[a b],x0,options,gltc,gttc,gnatc,gktc,ghtc1,ghtc2,gatc,vltc,vnatc,vktc,vhtc,vatc,iapptc,gltr, ...
      gttr,vltr,iapptr,egabaatr,egabaatc,egabab,eampa,ggabaatc,ggabaatr,ggabab,gampa,iappgpe,glgpe,vlgpe, ...
      ggabaagptr,egabaagptr,iappgpi,iappgpi2,ggabaagptc,egabaagptc,ggababgptc,egababgptc,gnatr,vnatr,gktr, ...
      vktr,gkltc1,gkltc2,b,gahp,vahp,gcan,vcan,ghold,vhold,k1,k2,k3,k4,ss,sss,at,bt,gkltr1,gkltr2,phgpigpi, ...
      shift,vtrab,vtrabtc);
%tt(:,1)=t(:,1)-delayphase;
if i==1
    figure;
end;
% X axis is in ms, and y Axis is in mV;
% Subfig1: TC1; Subfig2: TC1 T-type current; 
% Subfig3: RE1; Subfig4: RE1 T-type current;
% Subfig5: TC2; Subfig6: TC2 T-type current;
% Subfig7: RE2; Subfig8: RE2 T-type current;
% Subfig9: Activity of two GPi neurons (one is in blue and one is in
% black);
subplot (9,1,1);plot (t,x(:,1),'k');xlim ([aa,bb]);ylabel('TC1 (mV)','FontSize',5); 
hold on;
subplot (9,1,2);plot (t,(1*(-gttc.*((x(:,5)).^2).*x(:,6).*(x(:,1)-(13.3197.*(log(2./x(:,12))))))),'k');xlim ([aa,bb]);ylabel('TC1 IT-current','FontSize',5);
hold on;
subplot (9,1,3);plot (t,x(:,17),'k');xlim ([aa,bb]);ylabel('TC2 (mV)','FontSize',5); 
hold on;
subplot (9,1,4);plot (t,(.5*(-gttr.*((x(:,21)).^2).*x(:,22).*(x(:,17)-(13.3197.*(log(2./x(:,23))))))),'k');xlim([aa,bb]);ylabel('TC2 IT-current','FontSize',5);
hold on;
subplot (9,1,5);plot (t,x(:,44),'k');xlim ([aa,bb]); ylabel('RE1 (mV)','FontSize',5); 
hold on;
subplot (9,1,6);plot (t,(1*(-gttc.*((x(:,48)).^2).*x(:,49).*(x(:,44)-(13.3197.*(log(2./x(:,55))))))),'k');xlim([aa,bb]);ylabel('RE1 IT-current','FontSize',5);
hold on;
subplot (9,1,7);plot (t,x(:,60),'k');xlim ([aa,bb]); ylabel('RE2 (mV)','FontSize',5); 
hold on;
subplot (9,1,8);plot (t,(.5*(-gttr.*((x(:,64)).^2).*x(:,65).*(x(:,60)-(13.3197.*(log(2./x(:,66))))))),'k');xlim([aa,bb]);ylabel('RE2 IT-current','FontSize',5);
hold on;
subplot (9,1,9);plot (t,x(:,75),'k',t,x(:,37),'b');xlim ([aa,bb]);ylabel('GPi1 & GPi2 (mV)','FontSize',5);xlabel('Time (ms)');
hold on;
%subplot (10,1,10);plot (t,(20.*(ceil(((1-ceil(1./(1+exp(-(x(:,75)-ss)./.001)))).*x(:,82))-sss))),'k'...
%    ,t,(20.*(ceil(((1-ceil(1./(1+exp(-(x(:,37)-ss)./.001)))).*x(:,53))-sss)))+30,'b');xlim ([aa,bb]);xlabel('Time (ms)','FontSize',10);
hold on;
c=length (t);

x0=[x(c,1),x(c,2),x(c,3),x(c,4),x(c,5),x(c,6),x(c,7),x(c,8),x(c,9),x(c,10),x(c,11),x(c,12),x(c,13), ...
    x(c,14),x(c,15),x(c,16),x(c,17),x(c,18),x(c,19),x(c,20),x(c,21),x(c,22),x(c,23),x(c,24),x(c,25), ...
    x(c,26),x(c,27),x(c,28),x(c,29),x(c,30),x(c,31),x(c,32),x(c,33),x(c,34),x(c,35),x(c,36),x(c,37), ...
    x(c,38),x(c,39),x(c,40),x(c,41),x(c,42),x(c,43),x(c,44),x(c,45),x(c,46),x(c,47),x(c,48),x(c,49), ...
    x(c,50),x(c,51),x(c,52),x(c,53),x(c,54),x(c,55),x(c,56),x(c,57),x(c,58),x(c,59),x(c,60),x(c,61), ...
    x(c,62),x(c,63),x(c,64),x(c,65),x(c,66),x(c,67),x(c,68),x(c,69),x(c,70),x(c,71),x(c,72),x(c,73), ...
    x(c,74),x(c,75),x(c,76),x(c,77),x(c,78),x(c,79),x(c,80),x(c,81),x(c,82)];
a=0;
b=0;
end;
