%Jaskaran Ram - A06

clear all;

K0 = 100;
maxK = 20000;
M = 1000;
DK = 100;
MaxRelErr = 0.04;
gam = 0.95;
d_gamma = 1.96;

K = K0;

tA = 0;
tC = 0;

U = 0; % Utilitazion
U2 = 0;
X = 0; % Throughput
X2 = 0;
R = 0; % AVG Respoonse Time
R2 = 0;
V = 0; % Variance of Response Time
V2 = 0;
NJ = 0;% Average queue length
NJ2 = 0;

lHyper1 = 0.02;
lHyper2 = 0.2;
p1 = 0.1;
kErlang = 10;
lErlang = 1.5;

newIters = K;

while K < maxK
    for i = 1:newIters
        Bi = 0;
        Wi = 0;
        tA0 = tA;
        
        for j = 1:M
            if(rand() < p1)
                a_ji  = -log(rand())/lHyper1;
            else
                a_ji  = -log(rand())/lHyper2;
            end

            s_ji =  -log(prod(rand(kErlang,1)))/lErlang;

            tC = max(tA, tC) + s_ji;
            ri = tC - tA;
            Rd((i-1)*M+j,1) = ri;

            tA = tA + a_ji;

            Bi = Bi + s_ji;

            Wi = Wi + ri;
        end

        Ri = Wi / M;
        R = R + Ri;
        R2 = R2 + Ri^2;

        Ti = tC - tA0;
        Ui = Bi / Ti;
        U = U + Ui;
        U2 = U2 + Ui^2;

        Xi = M/Ti;
        X = X + Xi;
        X2 = X2 + Xi^2;

        Vi = var(Rd);
        V = V + Vi;
        V2 = V2 +Vi^2;

        NJi = Wi/Ti;
        NJ = NJ + NJi;
        NJ2 = NJ2 +NJi^2;
    end

    Xm = X / K;
    Xs = sqrt((X2 - X^2/K)/(K-1));
    CiX = [Xm - d_gamma * Xs / sqrt(K), Xm + d_gamma * Xs / sqrt(K)];
    errX = 2 * d_gamma * Xs / sqrt(K) / Xm;
    
    Rm = R / K;
    Rs = sqrt((R2 - R^2/K)/(K-1));
    CiR = [Rm - d_gamma * Rs / sqrt(K), Rm + d_gamma * Rs / sqrt(K)];
    errR = 2 * d_gamma * Rs / sqrt(K) / Rm;

    Um = U / K;
    Us = sqrt((U2 - U^2/K)/(K-1));
    CiU = [Um - d_gamma * Us / sqrt(K), Um + d_gamma * Us / sqrt(K)];
    errU = 2 * d_gamma * Us / sqrt(K) / Um;

    NJm = NJ / K;
    NJs = sqrt((NJ2 - NJ^2/K)/(K-1));
    CiNJ = [NJm - d_gamma * NJs / sqrt(K), NJm + d_gamma * NJs / sqrt(K)];
    errNJ = 2 * d_gamma * NJs / sqrt(K) / NJm;

    Vm = V / K;
    Vs = sqrt((V2 - V^2/K)/(K-1));
    CiV = [Vm - d_gamma * Vs / sqrt(K), Vm + d_gamma * Vs / sqrt(K)];
    errV = 2 * d_gamma * Vs / sqrt(K) / Vm;

    if errR < MaxRelErr && errU < MaxRelErr &&  errV < MaxRelErr && errX < MaxRelErr && errNJ<MaxRelErr
        break;
    else
        K = K + DK;
        newIters = DK;
    end
end


if errR < MaxRelErr && errU < MaxRelErr && errX < MaxRelErr && errV < MaxRelErr && errNJ < MaxRelErr
	fprintf(1, "SCENARIO 1 - Maximum Relative Error reached in %d Iterations\n", K);
else
	fprintf(1, "Maximum Relative Error NOT REACHED in %d Iterations\n", K);
end	

fprintf(1, "Utilization in [%g, %g], with %g confidence. Relative Error: %g\n", CiU(1,1), CiU(1,2), gam, errU);
fprintf(1, "Resp. Time in [%g, %g], with %g confidence. Relative Error: %g\n", CiR(1,1), CiR(1,2), gam, errR);
fprintf(1, "Throughput in [%g, %g], with %g confidence. Relative Error: %g\n", CiX(1,1), CiX(1,2), gam, errX);
fprintf(1, "Variance of Resp. Time in [%g, %g], with %g confidence. Relative Error: %g\n", CiV(1,1), CiV(1,2), gam, errV);
fprintf(1, "AVG Num of Jobs in [%g, %g], with %g confidence. Relative Error: %g\n", CiNJ(1,1), CiNJ(1,2), gam, errNJ);



%SCENARIO 2
K = K0;

tA = 0;
tC = 0;

U = 0; % Utilitazion
U2 = 0;
X = 0; % Throughput
X2 = 0;
R = 0; % AVG Respoonse Time
R2 = 0;
V = 0; % Variance of Response Time
V2 = 0;
NJ = 0; % Average queue length
NJ2 = 0;

lExp = 0.1;
a = 5;
b = 10;

newIters = K;

while K < maxK
    for i = 1:newIters
        Bi = 0;
        Wi = 0;
        tA0 = tA;

        for j = 1:M
            a_ji  = -log(rand())/lExp;
            s_ji =  a+(b-a).*rand();

            tC = max(tA, tC) + s_ji;
            ri = tC - tA;
            Rd((i-1)*M+j,1) = ri;

            tA = tA + a_ji;

            Bi = Bi + s_ji;

            Wi = Wi + ri;
        end

        Ri = Wi / M;
        R = R + Ri;
        R2 = R2 + Ri^2;

        Ti = tC - tA0;
        Ui = Bi / Ti;
        U = U + Ui;
        U2 = U2 + Ui^2;

        Xi = M/Ti;
        X = X + Xi;
        X2 = X2 + Xi^2;

        Vi = var(Rd);
        V = V + Vi;
        V2 = V2 +Vi^2;

        NJi = Wi/Ti;
        NJ = NJ + NJi;
        NJ2 = NJ2 +NJi^2;
    end

    Xm = X / K;
    Xs = sqrt((X2 - X^2/K)/(K-1));
    CiX = [Xm - d_gamma * Xs / sqrt(K), Xm + d_gamma * Xs / sqrt(K)];
    errX = 2 * d_gamma * Xs / sqrt(K) / Xm;
    
    Rm = R / K;
    Rs = sqrt((R2 - R^2/K)/(K-1));
    CiR = [Rm - d_gamma * Rs / sqrt(K), Rm + d_gamma * Rs / sqrt(K)];
    errR = 2 * d_gamma * Rs / sqrt(K) / Rm;

    Um = U / K;
    Us = sqrt((U2 - U^2/K)/(K-1));
    CiU = [Um - d_gamma * Us / sqrt(K), Um + d_gamma * Us / sqrt(K)];
    errU = 2 * d_gamma * Us / sqrt(K) / Um;

    NJm = NJ / K;
    NJs = sqrt((NJ2 - NJ^2/K)/(K-1));
    CiNJ = [NJm - d_gamma * NJs / sqrt(K), NJm + d_gamma * NJs / sqrt(K)];
    errNJ = 2 * d_gamma * NJs / sqrt(K) / NJm;

    Vm = V / K;
    Vs = sqrt((V2 - V^2/K)/(K-1));
    CiV = [Vm - d_gamma * Vs / sqrt(K), Vm + d_gamma * Vs / sqrt(K)];
    errV = 2 * d_gamma * Vs / sqrt(K) / Vm;

    if errR < MaxRelErr && errU < MaxRelErr &&  errV < MaxRelErr && errX < MaxRelErr && errNJ < MaxRelErr
        break;
    else
        K = K + DK;
        newIters = DK;
    end
end


if errR < MaxRelErr && errU < MaxRelErr && errX < MaxRelErr && errV < MaxRelErr && errNJ < MaxRelErr
	fprintf(1, "SCENARIO 2 - Maximum Relative Error reached in %d Iterations\n", K);
else
	fprintf(1, "Maximum Relative Error NOT REACHED in %d Iterations\n", K);
end	

fprintf(1, "Utilization in [%g, %g], with %g confidence. Relative Error: %g\n", CiU(1,1), CiU(1,2), gam, errU);
fprintf(1, "Resp. Time in [%g, %g], with %g confidence. Relative Error: %g\n", CiR(1,1), CiR(1,2), gam, errR);
fprintf(1, "Throughput in [%g, %g], with %g confidence. Relative Error: %g\n", CiX(1,1), CiX(1,2), gam, errX);
fprintf(1, "Variance of Resp. Time in [%g, %g], with %g confidence. Relative Error: %g\n", CiV(1,1), CiV(1,2), gam, errV);
fprintf(1, "AVG Num of Jobs in [%g, %g], with %g confidence. Relative Error: %g\n\n", CiNJ(1,1), CiNJ(1,2), gam, errNJ);

