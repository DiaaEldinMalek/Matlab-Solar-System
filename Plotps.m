function Plotps (vd,vs,Name)
if strcmpi(Name,'Solar System')
    vd(:,3)=vd(:,3)/25;
else
    vd(:,1)=vd(:,1)/(6371/(1.5e+8));
    disp('Warning, model is to scale... Objects may not be seen clearly,'); 
   X=input('press the factor by which you want to magnify objects(1 will not change it)');
       vd(:,3)=vd(:,3)*X;
end
%Takes the valid data and valid strings file
k=0;
while k==0
    k=1;
    slvl=input('Enter speed level of animation (1-6)'); %There are 6 available levels as follows
    if slvl==1 %level 1: ~54seconds/earth year
        ss=1;
    elseif slvl==2 %~20seconds/earth year
        ss=5;
    elseif slvl==3 %~7s/y
        ss=10;
    elseif slvl==4 %4s/y
        ss=20;
    elseif slvl==5 %1.2s/y
        ss=40;
    elseif slvl==6 %0.7s/y
        ss=80;
    else
        k=0;
        disp('Error, invalid number!')
    end
end%the value of ss is used in line 72 to increment points along the orbit, ss points each iteration.
phi=linspace(0,(201)*2*pi,(201)*1000); %a vector of angular positions to move the objects along
x=cos(phi);
y=sin(phi);  %used for plotting the elliptical orbitals of the objects
[theta,alpha] = ndgrid(linspace(0,pi), linspace(0,2*pi)); %construct polar coordinates to draw each surface
maxim=max(vd);
if size(vd,1)>1
    le=1.5*maxim(1);
else %useful in finding the suitable scale of the figure, used in line 32
    le=vd(1)+vd(3);
end
figure('Name',Name,'NumberTitle','off','DoubleBuffer','on'); %setup the figure
axis([-le le -le le -le le])
N=size(vd,1); %number of objects to set limits of loops
hold on %add all plots together in one figure
Z=zeros(1,N); %preconstruct a handle array
d=1;
for i=1:N
    vd(i,6)=vd(i,6)/365;
    im=vs(i,2); %reads the image/color inserted for each object to map-texture it
    I= imread(im);
    if vd(i,9)==1 %plots elliptical orbits of planets(if-condition added to prevent plotting of moons' orbitals)
        plot3(vd(i,1)*vd(i,2)+vd(i,1)*x,vd(i,1)*sqrt(1-vd(i,2)^2)*y*cos(vd(i,10)),vd(i,1)*sqrt(1-vd(i,2)^2)*y*sin(vd(i,10)));
    end
    Z(i)= warp(0,0,0,I); %construct each object with image I, values of x,y,z are unimportant since they change instantly
end
while true %loop iterations resemble time passing
    for c=1:N %motion for each object
        if vd(c,9)~=1 %vd(c,9) is 1 in case of planet (orbits star index no. 1), x in case of moon(orbits planet index no. x)
            set(Z(c),'XData',vd(vd(c,9),1)*vd(vd(c,9),2)+... %places planet in focus of central star
                vd(vd(c,9),1)*cos(vd(vd(c,9),8)+vd(vd(c,9),5)*phi(d)/(vd(vd(c,9),4)))+ ... %makes the moon move with the object
                vd(c,1)*cos(vd(c,8)+vd(c,5)*phi(d)/(vd(c,4)))+... %rotates moon around planet
                vd(c,3)*sin(theta).*cos(alpha+phi(d)*vd(c,7)/vd(c,6)), ... %rotates moon about itself
                'YData',vd(vd(c,9),1)*sqrt(1-vd(vd(c,9),2)^2)*sin(vd(vd(c,9),8)+ ...
                vd(vd(c,9),5)*phi(d)/(vd(vd(c,9),4)))*cos(vd(vd(c,9),10))+ ...%makes the moon move with the object
                vd(c,1)*sqrt(1-vd(c,2)^2)*sin(vd(c,8)+vd(c,5)*phi(d)/(vd(c,4)))*cos(vd(c,10))+...  %rotates moon about planet
                vd(c,3)*sin(theta).*sin(alpha+phi(d)*vd(c,7)/vd(c,6)), ...%rotates moon about itself
                'ZData',vd(vd(c,9),1)*sqrt(1-vd(vd(c,9),2)^2)*sin(vd(vd(c,9),8)+vd(vd(c,9),5)*phi(d)/(vd(vd(c,9),4)))*sin(vd(vd(c,9),10))+ ...%makes the moon move with the object
                vd(c,3)*cos(theta)+vd(c,1)*sqrt(1-vd(c,2)^2)*sin(vd(c,8)+vd(c,5)*phi(d)/(vd(c,4)))*sin(vd(c,10))) %rotates moon about itself
        else
            set(Z(c),'XData',vd(c,1)*vd(c,2)+ ... %places planet in star's focus
                vd(c,1)*cos(vd(c,8)+vd(c,5)*phi(d)/(vd(c,4)))+ ...%rotates planet around star
                vd(c,3)*sin(theta).*cos(alpha+phi(d)*vd(c,7)/vd(c,6)), ...%rotates planet around itself
                'YData',vd(c,1)*sqrt(1-vd(c,2)^2)*sin(vd(c,8)+vd(c,5)*phi(d)/(vd(c,4)))*cos(vd(c,10)) +...%rotates planet around star
                vd(c,3)*sin(theta).*sin(alpha+phi(d)*vd(c,7)/vd(c,6)), ...%rotates planet around itself
                'ZData',vd(c,1)*sqrt(1-vd(c,2)^2)*sin(vd(c,8)+vd(c,5)*phi(d)/(vd(c,4)))*sin(vd(c,10))+...%rotates planet around star
                vd(c,3)*cos(theta))%rotates planet around itself
        end
    end
    drawnow %refreshes the graph after each object is moved
    d= rem(d+ss,200*1000)+ss; %resets counter when the array is over
end