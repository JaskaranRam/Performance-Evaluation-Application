%Jaskaran Ram - A09

clear all;

% From Scanning to Sleeping all the probability are multiplied by 12/24 
% (50% Day and 50% Night) expressed in Hours

p_Scan = 2/60;
p_SN = 12/24 * 18/60;
p_SS = 12/24 * 8/12 * 3/60;
p_SC = 12/24 * 4/12 * 8/60;

Q = [ -(p_SN + p_SS + p_SC ), p_SN , p_SS, p_SC;
      p_Scan,-p_Scan,0,0;
      p_Scan,0,-p_Scan,0;
      p_Scan,0,0,-p_Scan];

% Equal probabilty to start anywhere
p0 = [0.25, 0.25, 0.25, 0.25];

[t, Sol] = ode45(@(t,x) Q'*x, [0 100], p0');

figure;
plot(t, Sol, "-");
legend("Scanning", "Sleep Night", "Sleep Sunny Day", "Sleep Cloudy Day");

% Consumption in Watt in each state
alpha2 = [12,0.1,0.1,0.1];
AVG_consumption = Sol(end,:) * alpha2';
fprintf("AVG Consumption: %g [WATT]\n",AVG_consumption);

%Utilization
alpha3 = [1,0,0,0];
U = Sol(end,:) * alpha3';
fprintf("Utilization : %g \n", U);

fprintf("Probability of Scan : %g, SleepN: %g, SleepS: %g, SleepC: %g\n", Sol(end,:));

cM = [  0,1,1,1;
        0,0,0,0;
        0,0,0,0;
        0,0,0,0
     ];

fprintf("Throughput : %g scan/hour \n", Sol(end,:) * sum((cM .* Q)')'); 
% dovrei moltiplicare per 24 ma c'è qualcosa che non va, probabilmente non ho uniformato bene l'unità di misura dei Lambda 

fprintf("Throughput : %g scan/day \n", Sol(end,1)*24*60/2); % risultato corretto 


