%A11 Solution - Jaskaran Ram
clear all;

lambda = 150/(60); % req/s 
D = 350/(1000);
mu = 1/D;

K = 32;
rho = lambda/mu;

P0 = (1-rho)/(1-rho^(K+1));
U = 1-P0;
fprintf(1,"Utilization : %g\n", U);

PL = (rho^K - rho^(K+1)) / (1 - rho^(K+1));
fprintf(1,"Loss probability : %g\n", PL);

AVG_Job = rho/(1-rho) - ((K+1)*rho^(K+1))/(1 -rho^(K+1));
fprintf(1,"AVG Number of Jobs : %g\n", AVG_Job);

Drop_rate = lambda * PL;
AVG_Job = rho/(1-rho) - ((K+1)*rho^(K+1))/(1 -rho^(K+1));
fprintf(1,"Drop Rate : %g\n", Drop_rate);

RT = AVG_Job/(lambda*(1-PL));
AVG_Job = rho/(1-rho) - ((K+1)*rho^(K+1))/(1 -rho^(K+1));
fprintf(1,"AVG Response Time : %g\n", RT);

fprintf(1,"Average time spent in the queue %g\n", RT-D);


fprintf(1,"\n---------SCENARIO 2--------\n");


lambda = 250/60;
c = 2;
mu = 1/D;
rho = lambda/(c*mu);

P0 = (c* rho^c * ((1-rho^(K-c+1)) /(1-rho))  + 1 + (c*rho)^1 )^-1 ;
pN = ([P0, P0*(c*rho), P0*c^c*rho.^[2:K]/factorial(c)]);
fprintf(1, "P0 : %g\n", P0);

N = sum([0:K] * pN');
fprintf(1,"AVG number of Jobs: %g\n", N);

U = [0:c] * pN(1:c+1)' + c*sum(pN(c+1+1:end));
fprintf(1,"Total Utilization: %g\n", U);
fprintf(1,"AVG Utilization: %g\n", U/c);


PK = pN(1, end);
fprintf(1,"Loss Probability: %g\n", PK);

Drop_rate = lambda * PK;
fprintf(1,"Drop Rate: %g\n", Drop_rate);

X = lambda * (1-PK);
RT = N/X;
fprintf(1,"Response Time: %g\n", RT);

fprintf(1,"Average time spent in the queue %g\n", RT-D);