clear 
close all

%%
e=exp(1);

%% source
t=0:0.0001:0.1;
f=60;
V=100;

v=sqrt(2)*V*sin(2*pi*f*t);

figure
plot(t,v);
xlabel('Time[s]');
ylabel('Voltage[V]');
%% resister
R=30;
ir=v/R;

figure
yyaxis right
plot(t,ir);
ylabel('Current[A]');
hold on
yyaxis left
plot(t,v);
xlabel('Time[s]');
ylabel('Voltage[V]');
hold on
%% inductor
R2=30;
L=10*10^3;
omegaL=2*pi*f*L;
phi=atan(omegaL/R);

il=(sqrt(2)*V)/(sqrt(R2^2+omegaL^2))*(e^(-R/L)*sin(phi)+sin(2*pi*f*t-phi));

figure
yyaxis right
plot(t,il);
ylabel('Current[A]');
hold on
yyaxis left
xlabel('Time[s]');
ylabel('Voltage[V]');
plot(t,v);

%% capacitor
R2=10;
C=0.1*10^-6;

omegaC=2*pi*f*C;
phi=atan(omegaC*R2);

ic=(omegaC*sqrt(2)*V)/(sqrt(1+(omegaC*R2)^2)).*(cos(2*pi*f.*t-phi)-e.^(-t/(C*R2)).*cos(phi));

figure
yyaxis right
plot(t,ic);
ylabel('Current[A]');
hold on
yyaxis left
xlabel('Time[s]');
ylabel('Voltage[V]');
plot(t,v);

