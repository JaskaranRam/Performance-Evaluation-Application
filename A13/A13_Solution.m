%A13 Solution - Jaskaran Ram

clear all;

fprintf(1,"------ SCENARIO 1 ------\n");

N = 10;

Z_Terminals = 10; %Seconds
S_CPU = 20/1000;
S_Disk = 10/1000;
S_RAM = 3/1000;
S = [S_CPU,S_Disk,S_RAM, Z_Terminals];


%CPU, DISK, RAM, Terminals
P =[ -1 , 0.3 , 0.6 , 0.1;
    0.85,  -1 , 0.15, 0  ;
    0.75, 0.25,  -1 , 0  ;
      1 ,   0 ,   0 , -1];

b = [0,0,0,-1];
lambda_matrix = P';

lambdas = lambda_matrix \ b';

Vk = lambdas/lambdas(4);
fprintf(1,"Visits for each Stations (CPU, DISK, RAM, Terminals) \n:");
disp (Vk);


D = S' .* Vk;
fprintf(1,"Demand for each Stations : \n");
disp(D);



fprintf(1,"------- Scenario 2 ------ \n");

lambda0 = 0.3;
%Service Time S is the same

%Probabilities (CPU, Disk, RAM, LeaveSystem)

P = [   -1 , 1  , 0   , 0   , 0;
         0, -1  , 0.3 , 0.6 , 0.1 ;
         0, 0.8 , -1  , 0.15, 0.05;
         0, 0.75, 0.25,  -1 , 0   ;
         0,  0  ,  0  ,  0  , -1   ];

b = [-lambda0, 0,0,0,0];

lambda_matrix = P';

lambdas = lambda_matrix \ b';

Vk = lambdas/lambdas(5);
fprintf(1,"Visits for each Stations (CPU, Disk, RAM): \n");
disp(Vk(2:4));

S = [1, S_CPU,S_Disk,S_RAM,0];
Dk = S' .* Vk;
fprintf(1,"Demand for each Stations : \n");
disp(Dk(2:4));

Xk = Vk .* lambda0; 
fprintf(1,"Throughput for each Stations (CPU, Disk, RAM): \n");
disp(Xk(2:4));


