function PlanetarySystem(SSorPS)
k=1;
while k==1
    if strcmpi(SSorPS,'ss') %check if user wants to start solar system simulation
        k=0; %break the while loop
        SolarSystem
    elseif strcmpi(SSorPS,'ps') %check if user wants to simulate a planetary system
        k=0; %break the while loop
        Name=input('Please enter the name of your planetary system'); %Prompts the user to choose his system's name
        [df,sf]=dataentry; %prompts user to enter data
        [vd,vs]=data(df,sf); %checks the entered data and prompts user to correct invalid data
        Plotps(vd,vs,Name) %plots the system const  ructed from the entered data
    else
        SSorPS=input('Error! please enter ''ss'' for solar system simulation or ''ps'' to simulate a system from data');
    end
end