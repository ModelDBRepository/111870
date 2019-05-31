%%%%%%%ODE%%%%%%%%%

function f=TCTR(t,x,gltc,gttc,gnatc,gktc,ghtc1,ghtc2,gatc,vltc,vnatc,vktc,vhtc,vatc,iapptc,gltr,gttr,vltr, ...
           iapptr,egabaatr,egabaatc,egabab,eampa,ggabaatc,ggabaatr,ggabab,gampa,iappgpe,glgpe,vlgpe,...
           ggabaagptr,egabaagptr,iappgpi,iappgpi2,ggabaagptc,egabaagptc,ggababgptc,egababgptc,gnatr,...
           vnatr,gktr,vktr,gkltc1,gkltc2,b,gahp,vahp,gcan,vcan,ghold,vhold,k1,k2,k3,k4,ss,sss,at,bt,gkltr1,...
           gkltr2,phgpigpi,shift,vtrab,vtrabtc)
f=zeros(81,1);
%if t<150 
%    gampa=0;ggababgptc=0;ggabaagptc=0;ggabaagptr=0;
%end;
%if t<500
%    k1=0;k2=0;k3=0;k4=0;
%end;
%if (t>150 && t<350) || (t>400 && t<600) || (t>650 && t<850) || (t>900 && t<1100) || (t>1150 && t<1250) 
%    iapptc=-.15;
%end;
if t<500
    gampa=0;
end;
gpi1tc1=1;gpi1tc2=1;gpi2tc1=1;gpi2tc2=1;
ph=0;%phase between GPi/GPe

ftc=4;%frequency GPi
t0tc=1000;%start time
dettc=105;%duration
det2tc=(1000/ftc)-dettc;

ftc2=ftc;%frequency GPi2 
dettc2=dettc;
det2tc2=(1000/ftc2)-dettc2;
t0tc2=t0tc+((dettc+det2tc)*phgpigpi)/360;

ftr=ftc;%frequency of RE
dettr=dettc;
det2tr=(1000/ftr)-dettr;
t0tr=t0tc+((dettr+det2tr)*ph)/360;


for ii=1:ftc*(b+500)/1000
    if ((t>t0tc+(ii-1)*dettc+(ii-1)*det2tc & t<t0tc+(ii)*dettc+(ii-1)*det2tc)) 
        iappgpi=6; 
        %iapptc=-1;
        %iapptr=3;
    end;
    if ((t>t0tc2+(ii-1)*dettc2+(ii-1)*det2tc2 & t<t0tc2+(ii)*dettc2+(ii-1)*det2tc2)) 
        iappgpi2=6; 
    end;
    if ((t>t0tr+(ii-1)*dettr+(ii-1)*det2tr & t<t0tr+(ii)*dettr+(ii-1)*det2tr)) 
        iappgpe=-5;
    end;
end;
if t>500 && t<600
 %iapptc=-.25;
end;

%tc1
%matsyn1=[x(79),x(41)];
f(1)=iapptc...
    +(gpi2tc1*((-ggababgptc*(((x(81))^4)/(((x(81))^4)+100))*(x(1)-egababgptc))+(-ggabaagptc*x(79)*(x(1)-egabaagptc))))...
    +(gpi1tc1*((-ggababgptc*(((x(43))^4)/(((x(43))^4)+100))*(x(1)-egababgptc))+(-ggabaagptc*x(41)*(x(1)-egabaagptc))))...
    +(-ggabab*(((x(72))^4)/(((x(72))^4)+100))*(x(1)-egabab))+(-ggabaatc*x(73)*(x(1)-egabaatc))...
    +(-ggabab*(((x(29))^4)/(((x(29))^4)+100))*(x(1)-egabab))+(-ggabaatc*x(30)*(x(1)-egabaatc))...
    +(-gltc*(x(1)-vltc))+(-gkltc1*(x(1)-vktc))+(-gatc*((x(8))^4)*x(9)*(x(1)-vatc))...
    +(-ghold*x(7)*(x(1)-vhold))+(-ghtc1*((x(13)+(2*x(15))))*(x(1)-vhtc))...
    +(-gttc*((x(5))^2)*x(6)*(x(1)-(13.3197*(log(2/x(12))))))...
    +(-gnatc*((x(2))^3)*x(3)*(x(1)-vnatc))+(-gktc*((x(4))^4)*(x(1)-vktc));
%m na
f(2)=((((.32*(x(1)+vtrabtc-13))/(1-exp(-(x(1)+vtrabtc-13)/4)))/shift)*(1-x(2)))-((((.28*(x(1)+vtrabtc-40))/(exp((x(1)+vtrabtc-40)/5)-1))/shift)*(x(2))); 
%h na
f(3)=(((.128*exp(-(x(1)+vtrabtc-17)/18))/shift)*(1-x(3)))-(((4/(1+exp(-(x(1)+vtrabtc-40)/5)))/shift)*x(3));
%n k
f(4)=((((.032*(x(1)+vtrabtc-15))/(1-exp(-(x(1)+vtrabtc-15)/5)))/shift)*(1-x(4)))-(((.5*exp(-(x(1)+vtrabtc-10)/40))/shift)*x(4));
%m ca
f(5)=((1/(1+exp(-(x(1)+59)/6.2)))-x(5))/((.22/((exp(-(x(1)+132)/16.7))+(exp((x(1)+16.8)/18.2))))+.13);%f(5)=((1/(1+exp(-(x(1)+59)/6.2)))-x(5))/((1/((exp(-(x(1)+132)/16.7))+(exp((x(1)+16.8)/18.2))))+.612);
%h ca 
f(6)=((1/(1+exp((x(1)+83)/4)))-x(6))/(((56.6+(.27*(exp((x(1)+115.2)/5))))/(1+exp((x(1)+86)/3.2)))+8.2);%f(6)=((1/(1+exp((x(1)+83)/4)))-x(6))/(30.8+(211.4+(exp((x(1)+113.2)/5)))/(1+exp((x(1)+84)/3.2)));
%h hcurrent old version
f(7)=((1/(1+exp((x(1)+75)/5.5)))-x(7))/(1/(exp(-.086*x(1)-14.6)+exp(.07*x(1)-1.87)));
%m Ia
f(8)=((1/(1+exp(-(x(1)+60)/8.5)))-x(8))/(.1+(.27/(exp((x(1)+35.8)/19.7)+exp(-(x(1)+79.7)/12.7))));
%h Ia
f(9)=((1/(1+exp((x(1)+78)/6)))-x(9))/(((ceil(1000/(1000+exp(((x(1)+63)-0)/.001))))*(.27/(exp((x(1)+46)/5)+exp(-(x(1)+238)/37.5))))+((1-(ceil(1000/(1000+exp(((x(1)+63)-0)/.001)))))*5.1));
%m Ia2 not included
f(10)=0;%((1/(1+exp(-(x(1)+36)/20)))-x(10))/(.37+(1/(exp((x(1)+35.8)/19.7)+exp(-(x(1)+79.7)/12.7))));
% syn pulse
f(11)=(1000*ceil(1/(1+exp(-(x(1)-ss)/.001)))*(1-x(11)))-((1-ceil(1/(1+exp(-(x(1)-ss)/.001))))*(5*x(11)));%((1/(1+exp((x(1)+78)/6)))-x(11))/((ceil((1000/(1000+exp(((x(1)+73)-0)/.001))))*(1/(exp((x(1)+46)/5)+exp(-(x(1)+238)/37.5))))+((1-ceil((1000/(1000+exp(((x(1)+73)-0)/.001)))))*60));
% Ca++ concentration
f(12)=(max((-(5.18*(10^(-5)))*(gttc*((x(5))^2)*x(6)*((x(1)-(13.3197*(log(2/x(12)))))))),0)-((x(12)-(2.4*(10^(-4))))/5));
% Ih with calcium effect
f(13)=(((1/(1+exp((x(1)+75)/5.5)))/(20+(1000/((exp((x(1)+71.5)/14.2))+(exp(-(x(1)+89)/11.6))))))*(1-x(13)-x(15)))-(((1-(1/(1+exp((x(1)+75)/5.5))))/(20+(1000/((exp((x(1)+71.5)/14.2))+(exp(-(x(1)+89)/11.6))))))*(x(13)))-(x(13)*x(14)*k3)+(k4*x(15));
%5.3+(267/((exp((x(1)+71.5)/14.2))+(exp(-(x(1)+89)/11.6)))))
f(14)=(k1*(1-x(14))*(((x(12))/.002)^4))-(k2*x(14))-(x(13)*x(14)*k3)+(k4*x(15));
f(15)=(k3*x(14)*x(13))-(k4*x(15));
%synaptic AMPA
f(16)=(.94*(.5*(ceil(((1-ceil(1/(1+exp(-(x(1)-ss)/.001))))*x(11))-sss)))*(1-x(16)))-(.18*x(16));
%/////////////////////////////////////

%tr1
f(17)=iapptr...
    +(-ggabaagptr*x(36)*(x(17)-egabaagptr))+(-ggabaatr*x(73)*(x(17)-egabaatr))...
    +(-gampa*x(59)*(x(17)-eampa))+(-gampa*x(16)*(x(17)-eampa))...
    +(-gltr*(x(17)-vltr))+(-gkltr1*(x(17)+95))+(-gttr*((x(21))^2)*x(22)*(x(17)-(13.3197*(log(2/x(23))))))+...
    (-gnatr*((x(18))^3)*x(19)*(x(17)-vnatr))+(-gktr*((x(20))^4)*(x(17)-vktr));
%m na
f(18)=((((.32*(x(17)+vtrab-13))/(1-exp(-(x(17)+vtrab-13)/4)))/shift)*(1-x(18)))-((((.28*(x(17)+vtrab-40))/(exp((x(17)+vtrab-40)/5)-1))/shift)*(x(18))); 
%h na
f(19)=(((.128*exp(-(x(17)+vtrab-17)/18))/shift)*(1-x(19)))-(((4/(1+exp(-(x(17)+vtrab-40)/5)))/shift)*x(19));
%n k
f(20)=((((.032*(x(17)+vtrab-15))/(1-exp(-(x(17)+vtrab-15)/5)))/shift)*(1-x(20)))-(((.5*exp(-(x(17)+vtrab-10)/40))/shift)*x(20));
%m ca
f(21)=((1/(1+exp(-(x(17)+52)/7.4)))-x(21))/((.33/((exp(-(x(17)+102)/15))+(exp((x(17)+27)/10))))+1);
%h ca
f(22)=((1/(1+exp((x(17)+80)/5)))-x(22))/(at+(bt/((exp((x(17)+48)/4))+(1+exp(-(x(17)+407)/50)))));
% Ca++ concentration
f(23)=max((-(5.18*10^(-5))*(gttr*((x(21))^2)*x(22)*((x(17)-(13.3197*(log(2/x(23)))))))),0)-((x(23)-(2.4*10^(-4)))/5);
% AHP
f(24)=(((48*((x(23))^2))/((48*((x(23))^2))+.03))-x(24))/(max(((1/(((48*((x(23))^2))+.03)))/4.65),.1));
% Ican
f(25)=(((20*((x(23))^2))/((20*((x(23))^2))+.002))-x(25))/(max(((1/(((20*((x(23))^2))+.002)))/4.65),.1));
% Rerserve
f(26)=0;
% syn pulse 
f(27)=(1000*ceil(1/(1+exp(-(x(17)-ss)/.001)))*(1-x(27)))-((1-ceil(1/(1+exp(-(x(17)-ss)/.001))))*(5*x(27)));
% GABA B
f(28)=(.5*(1-x(28))*(.5*(ceil(((1-ceil(1/(1+exp(-(x(17)-ss)/.001))))*x(27))-sss))))-(.0012*(x(28)));
f(29)=(.1*x(28))-(.034*x(29));
% GABA A
f(30)=(20*(.5*(ceil(((1-ceil(1/(1+exp(-(x(17)-ss)/.001))))*x(27))-sss)))*(1-x(30)))-(.16*x(30));
% a cell for the test of synaptic current
f(31)=(-.2*(x(31)+70))+(-.032*x(16)*(x(31)+80));%(-ggabab*(((x(29))^4)/(((x(29))^4)+100))*(x(31)-egabab))+(-ggabaatc*x(30)*(x(31)-egabaatc));
%///////////////////////////////


%GPe===>tr
f(32)=iappgpe+(-glgpe*(x(32)-vlgpe))+(-gnatc*((x(33))^3)*x(34)*(x(32)-vnatc))+(-gktc*((x(35))^4)*(x(32)-vktc));
%m na
f(33)=(((.38*(x(32)+29.7))/(1-exp(-.1*(x(32)+29.7))))*(1-x(33)))-((15.2*exp(-.0556*(x(32)+54.7)))*(x(33))); 
%h na
f(34)=((.266*exp(-.05*(x(32)+48)))*(1-x(34)))-((3.8/(1+exp(-.1*(x(32)+18))))*x(34));
%n k
f(35)=(((.02*(x(32)+45.7))/(1-exp(-.1*(x(32)+45.7))))*(1-x(35)))-((.25*exp(-.0125*(x(32)+55.7)))*x(35));
%gabaa
f(36)=(20*(.5*(ceil(((1-ceil(1/(1+exp(-(x(32)-ss)/.001))))*x(69))-sss)))*(1-x(36)))-(.16*x(36));
%gabab


%GPi===>tc
f(37)=iappgpi+(-glgpe*(x(37)-vlgpe))+(-gnatc*((x(38))^3)*x(39)*(x(37)-vnatc))+(-gktc*((x(40))^4)*(x(37)-vktc));
%m na
f(38)=(((.38*(x(37)+29.7))/(1-exp(-.1*(x(37)+29.7))))*(1-x(38)))-((15.2*exp(-.0556*(x(37)+54.7)))*(x(38))); 
%h na
f(39)=((.266*exp(-.05*(x(37)+48)))*(1-x(39)))-((3.8/(1+exp(-.1*(x(37)+18))))*x(39));
%n k
f(40)=(((.02*(x(37)+45.7))/(1-exp(-.1*(x(37)+45.7))))*(1-x(40)))-((.25*exp(-.0125*(x(37)+55.7)))*x(40));
%gabaa
f(41)=(20*(.5*(ceil(((1-ceil(1/(1+exp(-(x(37)-ss)/.001))))*x(53))-sss)))*(1-x(41)))-(.16*x(41));
%gabab
f(42)=(.5*(1-x(42))*(.5*(ceil(((1-ceil(1/(1+exp(-(x(37)-ss)/.001))))*x(53))-sss))))-(.0012*(x(42)));
f(43)=(.1*x(42))-(.034*x(43));

%tc2
f(44)=iapptc...
    +(gpi2tc2*((-ggababgptc*(((x(81))^4)/(((x(81))^4)+100))*(x(44)-egababgptc))+(-ggabaagptc*x(79)*(x(44)-egabaagptc))))...
    +(gpi1tc2*((-ggababgptc*(((x(43))^4)/(((x(43))^4)+100))*(x(44)-egababgptc))+(-ggabaagptc*x(41)*(x(44)-egabaagptc))))...
    +(-ggabab*(((x(72))^4)/(((x(72))^4)+100))*(x(44)-egabab))+(-ggabaatc*x(73)*(x(44)-egabaatc))...
    +(-ggabab*(((x(29))^4)/(((x(29))^4)+100))*(x(44)-egabab))+(-ggabaatc*x(30)*(x(44)-egabaatc))...
    +(-gltc*(x(44)-vltc))+(-gkltc2*(x(44)-vktc))+(-gatc*((x(51))^4)*x(52)*(x(44)-vatc))...
    +(-ghold*x(50)*(x(44)-vhold))+(-ghtc2*((x(56)+(2*x(58))))*(x(44)-vhtc))...
    +(-gttc*((x(48))^2)*x(49)*(x(44)-(13.3197*(log(2/x(55))))))+(-gnatc*((x(45))^3)*x(46)*(x(44)-vnatc))...
    +(-gktc*((x(47))^4)*(x(44)-vktc));
%m na
f(45)=((((.32*(x(44)+vtrabtc-13))/(1-exp(-(x(44)+vtrabtc-13)/4)))/shift)*(1-x(45)))-((((.28*(x(44)+vtrabtc-40))/(exp((x(44)+vtrabtc-40)/5)-1))/shift)*(x(45))); 
%h na
f(46)=(((.128*exp(-(x(44)+vtrabtc-17)/18))/shift)*(1-x(46)))-(((4/(1+exp(-(x(44)+vtrabtc-40)/5)))/shift)*x(46));
%n k
f(47)=((((.032*(x(44)+vtrabtc-15))/(1-exp(-(x(44)+vtrabtc-15)/5)))/shift)*(1-x(47)))-(((.5*exp(-(x(44)+vtrabtc-10)/40))/shift)*x(47));
%m ca
f(48)=((1/(1+exp(-(x(44)+59)/6.2)))-x(48))/((.22/((exp(-(x(44)+132)/16.7))+(exp((x(44)+16.8)/18.2))))+.13);%f(5)=((1/(1+exp(-(x(44)+59)/6.2)))-x(48))/((1/((exp(-(x(44)+132)/16.7))+(exp((x(44)+16.8)/18.2))))+.612);
%h ca
f(49)=((1/(1+exp((x(44)+83)/4)))-x(49))/(((56.6+(.27*(exp((x(44)+115.2)/5))))/(1+exp((x(44)+86)/3.2)))+8.2);%f(6)=((1/(1+exp((x(44)+83)/4)))-x(49))/(30.8+(211.4+(exp((x(44)+113.2)/5)))/(1+exp((x(44)+84)/3.2)));
%h hcurrent
f(50)=((1/(1+exp((x(44)+75)/5.5)))-x(50))/(1/(exp(-.086*x(44)-14.6)+exp(.07*x(44)-1.87)));
%m Ia
f(51)=((1/(1+exp(-(x(44)+60)/8.5)))-x(51))/(.1+(.27/(exp((x(44)+35.8)/19.7)+exp(-(x(44)+79.7)/12.7))));
%h Ia
f(52)=((1/(1+exp((x(44)+78)/6)))-x(52))/(((ceil(1000/(1000+exp(((x(44)+63)-0)/.001))))*(.27/(exp((x(44)+46)/5)+exp(-(x(44)+238)/37.5))))+((1-(ceil(1000/(1000+exp(((x(44)+63)-0)/.001)))))*5.1));
%syn pulse for GPi
f(53)=(1000*ceil(1/(1+exp(-(x(37)-ss)/.001)))*(1-x(53)))-((1-ceil(1/(1+exp(-(x(37)-ss)/.001))))*(5*x(53)));%((1/(1+exp(-(x(44)+36)/20)))-x(53))/(.37+(1/(exp((x(44)+35.8)/19.7)+exp(-(x(44)+79.7)/12.7))));
%syn pulse
f(54)=(1000*ceil(1/(1+exp(-(x(44)-ss)/.001)))*(1-x(54)))-((1-ceil(1/(1+exp(-(x(44)-ss)/.001))))*(5*x(54)));%((1/(1+exp((x(44)+78)/6)))-x(54))/((ceil((1000/(1000+exp(((x(44)+73)-0)/.001))))*(1/(exp((x(44)+46)/5)+exp(-(x(44)+238)/37.5))))+((1-ceil((1000/(1000+exp(((x(44)+73)-0)/.001)))))*60));
% Ca++ concentration
f(55)=max((-(5.18*(10^(-5)))*(gttc*((x(48))^2)*x(49)*((x(44)-(13.3197*(log(2/x(55)))))))),0)-((x(55)-(2.4*(10^(-4))))/5);
% Ih with calcium effect
f(56)=(((1/(1+exp((x(44)+75)/5.5)))/(20+(1000/((exp((x(44)+71.5)/14.2))+(exp(-(x(44)+89)/11.6))))))*(1-x(56)-x(58)))-(((1-(1/(1+exp((x(44)+75)/5.5))))/(20+(1000/((exp((x(44)+71.5)/14.2))+(exp(-(x(44)+89)/11.6))))))*(x(56)))-(x(56)*x(57)*k3)+(k4*x(58));
%5.3+(267/((exp((x(44)+71.5)/14.2))+(exp(-(x(44)+89)/11.6)))))
f(57)=(k1*(1-x(57))*(((x(55))/.002)^4))-(k2*x(57))-(x(56)*x(57)*k3)+(k4*x(58));
f(58)=(k3*x(57)*x(56))-(k4*x(58));
%synaptic AMPA
f(59)=(.94*(.5*(ceil(((1-ceil(1/(1+exp(-(x(44)-ss)/.001))))*x(54))-sss)))*(1-x(59)))-(.18*x(59));
%/////////////////////////////////////

%tr2
f(60)=iapptr...
    +(-ggabaagptr*x(36)*(x(60)-egabaagptr))+(-ggabaatr*x(30)*(x(60)-egabaatr))...
    +(-gampa*x(59)*(x(60)-eampa))+(-gampa*x(16)*(x(60)-eampa))...
    +(-gltr*(x(60)-vltr))+(-gkltr2*(x(60)+95))+(-gttr*((x(64))^2)*x(65)*(x(60)-(13.3197*(log(2/x(66))))))...
    +(-gnatr*((x(61))^3)*x(62)*(x(60)-vnatr))+(-gktr*((x(63))^4)*(x(60)-vktr));
%m na
f(61)=((((.32*(x(60)+vtrab-13))/(1-exp(-(x(60)+vtrab-13)/4)))/shift)*(1-x(61)))-((((.28*(x(60)+vtrab-40))/(exp((x(60)+vtrab-40)/5)-1))/shift)*(x(61))); 
%h na
f(62)=(((.128*exp(-(x(60)+vtrab-17)/18))/shift)*(1-x(62)))-(((4/(1+exp(-(x(60)+vtrab-40)/5)))/shift)*x(62));
%n k
f(63)=((((.032*(x(60)+vtrab-15))/(1-exp(-(x(60)+vtrab-15)/5)))/shift)*(1-x(63)))-(((.5*exp(-(x(60)+vtrab-10)/40))/shift)*x(63));
%m ca
f(64)=((1/(1+exp(-(x(60)+52)/7.4)))-x(64))/((.33/((exp(-(x(60)+102)/15))+(exp((x(60)+27)/10))))+1);
%h ca
f(65)=((1/(1+exp((x(60)+80)/5)))-x(65))/(at+(bt/((exp((x(60)+48)/4))+(1+exp(-(x(60)+407)/50)))));
% Ca++ concentration
f(66)=max((-(5.18*10^(-5))*(gttr*((x(64))^2)*x(65)*((x(60)-(13.3197*(log(2/x(66)))))))),0)-((x(66)-(2.4*10^(-4)))/5);
% AHP
f(67)=(((48*((x(66))^2))/((48*((x(66))^2))+.03))-x(67))/(max(((1/(((48*((x(66))^2))+.03)))/4.65),.1));
% Ican
f(68)=(((20*((x(66))^2))/((20*((x(66))^2))+.002))-x(68))/(max(((1/(((20*((x(66))^2))+.002)))/4.65),.1));
% syn pulse for GPe
f(69)=(1000*ceil(1/(1+exp(-(x(32)-ss)/.001)))*(1-x(69)))-((1-ceil(1/(1+exp(-(x(32)-ss)/.001))))*(5*x(69)));
% syn pulse 
f(70)=(1000*ceil(1/(1+exp(-(x(60)-ss)/.001)))*(1-x(70)))-((1-ceil(1/(1+exp(-(x(60)-ss)/.001))))*(5*x(70)));
% GABA B
f(71)=(.5*(1-x(71))*(.5*(ceil(((1-ceil(1/(1+exp(-(x(60)-ss)/.001))))*x(70))-sss))))-(.0012*(x(71)));
f(72)=(.1*x(71))-(.034*x(72));
% GABA A
f(73)=(20*(.5*(ceil(((1-ceil(1/(1+exp(-(x(60)-ss)/.001))))*x(70))-sss)))*(1-x(73)))-(.16*x(73));
% a cell for the test of synaptic current
f(74)=(-ggabab*(((x(72))^4)/(((x(72))^4)+100))*(x(74)-egabab))+(-ggabaatc*x(73)*(x(74)-egabaatc))+(-gltc*(x(74)-vltc));

%second gpi
f(75)=iappgpi2+(-glgpe*(x(75)-vlgpe))+(-gnatc*((x(76))^3)*x(77)*(x(75)-vnatc))+(-gktc*((x(78))^4)*(x(75)-vktc));
%m na
f(76)=(((.38*(x(75)+29.7))/(1-exp(-.1*(x(75)+29.7))))*(1-x(76)))-((15.2*exp(-.0556*(x(75)+54.7)))*(x(76))); 
%h na
f(77)=((.266*exp(-.05*(x(75)+48)))*(1-x(77)))-((3.8/(1+exp(-.1*(x(75)+18))))*x(77));
%n k
f(78)=(((.02*(x(75)+45.7))/(1-exp(-.1*(x(75)+45.7))))*(1-x(78)))-((.25*exp(-.0125*(x(75)+55.7)))*x(78));
%gabaa
f(79)=(20*(.5*(ceil(((1-ceil(1/(1+exp(-(x(75)-ss)/.001))))*x(82))-sss)))*(1-x(79)))-(.16*x(79));
%gabab
f(80)=(.5*(1-x(80))*(.5*(ceil(((1-ceil(1/(1+exp(-(x(75)-ss)/.001))))*x(82))-sss))))-(.0012*(x(80)));
f(81)=(.1*x(80))-(.034*x(81));
f(82)=(1000*ceil(1/(1+exp(-(x(75)-ss)/.001)))*(1-x(82)))-((1-ceil(1/(1+exp(-(x(75)-ss)/.001))))*(5*x(82)));
%//////////////////////////////////
%end;