function [vd,vs]=data(df,sf)
s=size(df);
for k=1:s(1)
    for l=1:2
        switch l
            case 1 %checks if the name of object is a string and prompts user to re-enter if invalid
                while ~isstring(sf(k,l))
                    fprintf('please enter the name of object no.%d in this format ''name''\n',k)
                    sf(k,l)=input('');
                end
            case 2  %checks if the color of object is a string and prompts user to re-enter if invalid
                while ~isstring(sf(k,l))
                    fprintf('please enter the color of object no.%d in this format ''name''\n',k)
                    sf(k,l)=input('');
                end
        end
    end
end
for i=1:s(1)
    for j=1:10
        switch j
            case 1  %checks the value of the semi-major axis object and prompts user to re-enter if invalid
                while df(i,j)<0
                    fprintf('please enter a positive value for the semi-majour axis of %s\n',sf(i,1))
                    df(i,j)=input('');
                end
            case 2  %checks the value of the eccentricity of object and prompts user to re-enter if invalid
                while df(i,j)>1 && df(i,j)<0
                    fprintf('please enter a value between 0 and 1 for the eccentricity of %s''s orbital \n',sf(i,1))
                    df(i,j)=input('');
                end
            case 3  %checks the value of the radius of object and prompts user to re-enter if invalid
                while df(i,j)<=0
                    fprintf('please enter a positive value for the radius of %s\n',sf(i,1))
                    df(i,j)=input('');
                end
            case 4  %checks the value of the orbital period of object and prompts user to re-enter if invalid
                while df(i,j)<=0
                    if df(i,1)==0 %checks if the object is the central object
                        df(i,j)=1; %sets period of central object to 1 to avoid errors in plotps function
                    elseif df(i,j)<=0 %checks the value of the orbital period of object and prompts user to re-enter if invalid
                        fprintf('please enter a positive value for the orbital period of %s\n',sf(i,1))
                        df(i,j)=input('');
                    end
                end
            case 5  %checks the orbit direction of object and prompts user to re-enter if invalid
                while df(i,j)~=1 && df(i,j)~=-1
                    fprintf('please enter a valid value for the direction of orbit of %s (-1 for clockwise, 1 for counter clockwise)\n',sf(i,1))
                    df(i,j)=input('');
                end
            case 6  %checks the value of the rotation period of object and prompts user to re-enter if invalid
                while df(i,j)<=0
                    fprintf('please enter a positive value for the rotation period of %s\n',sf(i,1))
                    df(i,j)=input('');
                end
            case 7  %checks the rotation direction of object and prompts user to re-enter if invalid
                while df(i,j)~=1 && df(i,j)~=-1
                    fprintf('please enter a valid value for the direction of orbit of %s (1 for clockwise, -1 for counter clockwise)\n',sf(i,1))
                    df(i,j)=input('');
                end
            case 8  %checks the value of the initial angular postion of object and prompts user to re-enter if invalid
                while df(i,j)<0
                    fprintf('please enter a positive value for the initial angle of orbit of %s (in radians)\n',sf(i,1))
                    df(i,j)=input('');
                end
            case 9  %checks the no. of object this object orbits and prompts user to re-enter if invalid
                while df(i,j)<0 || df(i,j)>s(1) || df(i,j)==i
                    if df(i,j)==1 && i==1
                        break
                    end
                    fprintf('please enter the object no. that %s orbits\n',sf(i,1))
                    df(i,j)=input('');
                end
            case 10 %checks the tilt angle of the elliptical orbit
                while df(i,j)<0
                    fprintf('please enter a positive value for the tilt angle of orbit of %s(in radians)\n',sf(i,1))
                    df(i,j)=input('');
                end
        end
    end
end
vd=df;
vs=sf;

