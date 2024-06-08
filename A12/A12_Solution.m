%A12 Solution - Jaskaran Ram

clear all;

lambda = 10;
mu1 = 50;
mu2 = 5;
p = 0.8;

M1 = p/mu1 + (1-p)/mu2;
D = M1;

M2 = 2*p/mu1^2 + 2*(1-p)/mu2^2;

rho = lambda * D;
U = rho;

R = D + (lambda*M2)/(2*(1-rho));
N = rho + (lambda^2*M2)/(2*(1-rho));

fprintf(1,"The utilization of the system: %g\n", U);
fprintf(1,"The (exact) average response time : %g\n", R);
fprintf(1,"The (exact) average number of jobs in the system : %g\n", N);


fprintf(1,"-----SCENARIO 2 -----\n");

%Erlang rappresenta i nuovi Arrival
kErlang = 5;
lErlang = 240;

mean = kErlang/lErlang;
variance = kErlang/lErlang^2;

% D La stessa di prima
T = kErlang/lErlang;
rho = D/(3*T);
U = rho;

Ca = 1/sqrt(kErlang);
Cv = sqrt( M2 - M1^2 )/ M1;   %Cv = Var/Avg

Theta =  ( D/(3*(1-rho)) )/ ( 1 + (1-rho)*factorial(3)/(3*rho)^3 * (1 + 3*rho + ((3*rho)^2)/2) );
R = D + ( (Ca^2 + Cv^2)/2 )*Theta;   

N = lErlang*R/kErlang;

fprintf(1,"The average utilization of the system: %g\n", U);
fprintf(1,"The approximate average response time: %g\n", R);
fprintf(1,"The approximate average number of jobs in the system: %g\n", N);


