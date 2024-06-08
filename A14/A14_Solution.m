%A14 Solution - Jaskaran Ram

clear all;

S_2 = 30/1000;
S_3 = 100/1000;
S_4 = 80/1000;

Lambda_IN1 = 3; %job/s
Lambda_IN2 = 2;

Lambda0 = Lambda_IN1 + Lambda_IN2;

S_1 = 2;

S = [0,S_1,S_2,S_3,S_4];

P = [
    -1 , 0 ,  0 ,  0 ,  0 ;
    0.2, -1 , 0.8,  0 , 0 ;
    0.2, 0 , -1 , 0.3, 0.5;
     0 , 0 ,  1 , -1 ,  0 ;
     0 , 0 ,  1 ,  0 , -1 ;];

b = [0,-Lambda_IN1, -Lambda_IN2,0,0];

lambda_matrix = P';
lambdas = lambda_matrix \ b';
Vk = lambdas/Lambda0;
Dk = S' .* Vk;

X = Lambda0;
fprintf(1,"1. The throughput of the system (X) : %f\n", X);

Uk = X * Dk;

Rk = Dk./(1- Uk);
Rk(2) = Dk(2);  % Infinte Servers System 
R = sum(Rk);

N = Lambda0 * R;
Qk = Uk ./ (1-Uk);
Qk(2) = Uk(2);

fprintf(1,"2. The average number of jobs in the system (N): %f\n", N);
fprintf(1, "3. The average system response time (R): %f\n", R);
