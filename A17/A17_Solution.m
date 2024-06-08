%A17 Solution - Jaskaran Ram

clear all;

lambdaIN = [2/60, 3/60, 2.5/60];
D1 = [10,4,6];
D2 = [12,3,6];
U1 = sum(lambdaIN .* D1);
U2 = sum(lambdaIN .* D2);

R1A = D1(1) / (1 - U1);
R1B = D1(2) / (1 - U1);
R1C = D1(3) / (1 - U1);

R2A = D2(1) / (1 - U2);
R2B = D2(2) / (1 - U2);
R2C = D2(3) / (1 - U2);

RA = R1A + R2A;
RB = R1B + R2B;
RC = R1C + R2C;

NA = RA * lambdaIN(1);
NB = RB * lambdaIN(2);
NC = RC * lambdaIN(3);

R1 = lambdaIN(1) / (sum(lambdaIN)) * R1A + lambdaIN(2) / sum(lambdaIN) * R1B + lambdaIN(3) / sum(lambdaIN) * R1C;
R2 = lambdaIN(1) / (sum(lambdaIN)) * R2A + lambdaIN(2) / sum(lambdaIN) * R2B + lambdaIN(3) / sum(lambdaIN) * R2C;

R = R1 + R2;

fprintf(1, "1. The utilization of the two stations: %f %f\n", U1, U2);
fprintf(1, "2. The average number of jobs in the system for each type of product (class c - Nc): %f %f %f\n",NA,NB,NC);
fprintf(1, "3. The average system response time per product type (class c - Rc): %f %f %f \n", RA, RB, RC);
fprintf(1, "4. The class-independent average system response time (R): %f\n", R);
