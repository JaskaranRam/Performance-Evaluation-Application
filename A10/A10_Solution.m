%Solution A10 - Jaskaran Ram

clear all;

lambda = 40;
D = 16/1000;

%Service Rate
mu = 1/ D;

%Probability having n job in System
rho = lambda/mu;
P1 = (1-rho)*rho^1;
Pless10 = 1 - rho^(9+1);
fprintf(1,"-----SCENARIO 1----\n");
fprintf(1, "Probability having one job in System: %g\n",P1);
fprintf(1, "Probability having less than 10 job in System: %g\n",Pless10);

%Utilization
U = rho;
fprintf(1, "Utilization of the System: %g\n",U);

%Avg Number of Jobs in the System
AVG_Job = rho/(1-rho);
fprintf(1, "Avg Number of Jobs in the System: %g\n",AVG_Job);

%Avg Response Time 
AVG_RT = AVG_Job/lambda;
fprintf(1, "Avg Response Time: %g\n",AVG_RT);

%Avg Queue Lenght (Job not in Service)
AVG_Queue = rho^2/ (1-rho);
fprintf(1, "Avg Queue Lenght: %g\n",AVG_Queue);

% The probability that the response time is greater than 0.5 s
P = exp(-0.5/AVG_RT);
fprintf(1, "Probability that the response time is greater than 0.5 s: %g\n",P);

% The 90 percentile of the response time distribution
percentile = -log(1 - 90/100)*AVG_RT;
fprintf(1, "The 90 percentile of the response time distribution: %g\n",percentile);

%SCENARIO 2
lambda = 90; %job/s
D = 16/1000;

mu = 1/D;

%Total and avg Utilization
rho = lambda/(2*mu);
U = lambda /mu;
U2 = rho;
fprintf(1,"-----SCENARIO 2----\n");
fprintf(1,"Utilization : %g\n",U);
fprintf(1,"AVG Utilization : %g\n",U2);

P0 = (1 - rho)/(1 + rho);
P1 = 2 * P0 * rho^1;
P2 = sum(2 * (1-rho)/(1 + rho) *rho.^[1:9]);
fprintf(1,"Probability of having exactly 1 Job : %g\n",P1);
fprintf(1,"Probability of having less than 10 Job: %g\n",P2);

AVG_RT = (D)/(1-rho^2);
AVG_Time_Queue = AVG_RT - D;

fprintf(1,"Avg Response Time: %g\n",AVG_RT);
fprintf(1,"Avg Queue Lenght: %g\n",lambda* AVG_Time_Queue);

