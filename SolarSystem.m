function SolarSystem
[vd,vs]=SOLARDATA;
m=0;
X=input('press 1 for a 100% scaled animation, press 2 to get scaled orbitals only');
while m==0
    if X==1 %to scale sizes
        for i=1:size(vd,1)
            vd(i,1)=vd(i,1)/(6371/(1.5e+8));
        end
        clc;
        m=1;
        disp('Warning! objects are too small to be seen, even the sun is not even a pixel');
    elseif X==2
        vd(1,3)=vd(1,3)/20;
        vd(11,3)=vd(11,3)*1000;
        vd(11,1)=vd(11,1)*40;
        m=1;
        clc;
        disp('Great choice! The sun was reduced to 1/20 its size');
        disp('The moon to 1000th its size and 40 times as large orbit'); 
    else
        X=input('Error, please enter 1 for a 100% scaled animation, press 2 to get scaled orbitals only');
    end
end
    Plotps(vd,vs,'Solar System')