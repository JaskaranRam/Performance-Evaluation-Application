% A06 - Jaskaran Ram

clear all;

N = 1000;

%First Scenario
%Inter-Arrival :  hyper-exponential distribution with: lHyper1 = 0.02, lHyper2 = 0.2, p1 = 0.1
%Service : Erlang with: kErlang = 10, lErlang = 1.5

lHyper1 = 0.02;
lHyper2 = 0.2;
p1 = 0.1;
kErlang = 10;
lErlang = 1.5;

U1_i = [];
X1_i = [];
AVG_RT1_i = [];
AVG_NumJobs1_i = [];
Variance1_i = [];

for i = 1:N
    if(rand() < p1)
        inter_Arrivals1(i,1) = -log(rand())/lHyper1;
    else
        inter_Arrivals1(i,1) = -log(rand())/lHyper2;
    end
end

IN1 = cumsum(inter_Arrivals1);

indice = 1;
for i = 1:N
    Service1(i,1) = -log(prod(rand(kErlang,1)))/lErlang;
end

OUT1 = [];
OUT1(1,1)= IN1(1,1) + Service1(1,1);
for i = 2:N
    OUT1(i,1) = max(IN1(i,1),OUT1(i-1,1)) + Service1(i,1);
end

T1 = OUT1(end,1)-IN1(1,1);

% Throughput
X1_i(1,1) = N/T1;

% Average Response Time
M1 = [IN1,OUT1];
RT1 = M1(:,2) - M1(:,1);
AVG_RT1_i(1,1) = mean(RT1);

%Utilization
B1 = sum(Service1);
U1_i(1,1) = B1/T1;

%Average number of jobs in the system
matrice1 = [IN1, ones(N,1); OUT1, -ones(N, 1)];
matrice1 = sortrows(matrice1,1);
matrice1(:,3) = cumsum(matrice1(:,2));
AVG_NumJobs1_i(1,1) = mean(matrice1(:,3));

%Variance of Response Time
Variance1_i(1,1) = var(RT1);



% PROVVISORIO

error_Throughput_1 = 1;
error_Utilization_1 = 1;
error_AvgResponseTime_1 = 1;
error_AvgNumJobs_1 = 1;
error_Variance_1 = 1;

K = 2;
while(error_Throughput_1>0.04 || error_Utilization_1>0.04 || error_AvgResponseTime_1 >0.04 || error_AvgNumJobs_1 >0.04 || error_Variance_1 > 0.04  )

    for i = 1:N
        if(rand() < p1)
            inter_Arrivals1(i,1) = -log(rand())/lHyper1;
        else
            inter_Arrivals1(i,1) = -log(rand())/lHyper2;
        end
    end
    IN1 = cumsum(inter_Arrivals1);

    indice = 1;
    for i = 1:N
        Service1(i,1) = -log(prod(rand(kErlang,1)))/lErlang;
    end

    OUT1 = [];
    OUT1(1,1)= IN1(1,1) + Service1(1,1);
    for i = 2:N
        OUT1(i,1) = max(IN1(i,1),OUT1(i-1,1))+Service1(i,1);
    end

    T1 = OUT1(end,1)-IN1(1,1);

    % Throughput
    X1_i(K,1) = N/T1;

    % Average Response Time
    M1 = [IN1,OUT1];
    RT1 = M1(:,2) - M1(:,1);
    AVG_RT1_i(K,1) = mean(RT1);

    %Utilization
    B1 = sum(Service1);
    U1_i(K,1) = B1/T1;

    %Average number of jobs in the system
    matrice1 = [IN1, ones(N,1); OUT1, -ones(N, 1)];
    matrice1 = sortrows(matrice1,1);
    matrice1(:,3) = cumsum(matrice1(:,2));
    AVG_NumJobs1_i(K,1) = mean(matrice1(:,3));

    %Variance of Response Time
    Variance1_i(K,1) = var(RT1);

    %Confidence
    d = 1.96;

    %Average
    U1_i_mean = sum(U1_i)/K;
    X1_i_mean = sum(X1_i)/K;
    AVG_RT1_i_mean = sum(AVG_RT1_i)/K;
    AVG_NumJobs1_i_mean = sum(AVG_NumJobs1_i)/K;
    Variance1_i_mean(K,1) = sum(Variance1_i)/K;


    %S^2 Throughput
    S1 = sum((X1_i - X1_i_mean).^2)/(K-1);
    Bounds = [X1_i_mean - d*sqrt(S1/K); X1_i_mean + d*sqrt(S1/K)];
    Bounds;
    error_Throughput_1 = 2*(Bounds(2,1) - Bounds(1,1))/(Bounds(2,1) + Bounds(1,1));

    %S^2 Utilization
    S1 = sum((U1_i - U1_i_mean).^2)/(K-1);
    Bounds = [U1_i_mean - d*sqrt(S1/K); U1_i_mean + d*sqrt(S1/K)];
    Bounds;
    error_Utilization_1 = 2*(Bounds(2,1) - Bounds(1,1))/(Bounds(2,1) + Bounds(1,1));

    %S^2 Avg Response Time
    S1 = sum((AVG_RT1_i - AVG_RT1_i_mean).^2)/(K-1);
    Bounds = [AVG_RT1_i_mean - d*sqrt(S1/K); AVG_RT1_i_mean + d*sqrt(S1/K)];
    Bounds;
    error_AvgResponseTime_1 = 2*(Bounds(2,1) - Bounds(1,1))/(Bounds(2,1) + Bounds(1,1));

    %S^2 Avg Number of Jobs
    S1 = sum((AVG_NumJobs1_i - AVG_NumJobs1_i_mean).^2)/(K-1);
    Bounds = [AVG_NumJobs1_i_mean - d*sqrt(S1/K); AVG_NumJobs1_i_mean + d*sqrt(S1/K)];
    Bounds;
    error_AvgNumJobs_1 = 2*(Bounds(2,1) - Bounds(1,1))/(Bounds(2,1) + Bounds(1,1));

    %S^2 Variance
    S1 = sum((Variance1_i - Variance1_i_mean).^2)/(K-1);
    Bounds = [Variance1_i_mean - d*sqrt(S1/K); Variance1_i_mean + d*sqrt(S1/K)];
    Bounds;
    error_Variance_1 = 2*(Bounds(2,1) - Bounds(1,1))/(Bounds(2,1) + Bounds(1,1));

    K = K+1;

end


% FINE PROVVISORIO


K





%Second Scenario
%Arrival : Exponential with: lExp = 0.1
%Service : Uniform with: a = 5, b = 10

lExp = 0.1;
a = 5;
b = 10;

U2_i = [];
X2_i = [];
AVG_RT2_i = [];
AVG_NumJobs2_i = [];
Variance2_i = [];

%Genero il primo sample
Inter_Arrivals2 = -log(rand(1000,1))/lExp;
Arrivals2 = cumsum(Inter_Arrivals2);
Service2 = a+(b-a).*rand(1000,1);
IN2 = Arrivals2;
OUT2 = [];

OUT2(1,1)= IN2(1,1) + Service2(1,1);
for i = 2:N
    OUT2(i,1) = max(IN2(i,1),OUT2(i-1,1))+Service2(i,1);
end

T2 = OUT2(end,1)-IN2(1,1);
% Throughput
X2_i(1,1) = N/T2;

% Average Response Time
M2 = [IN2,OUT2];
RT2 = M2(:,2) - M2(:,1);
AVG_RT2_i(1,1) = mean(RT2);

% Utilization
B2 = sum(Service2);
U2_i(1,1) = B2/T2;

%Average number of jobs in the system
matrice2 = [IN2, ones(N,1); OUT2, -ones(N, 1)];
matrice2 = sortrows(matrice2,1);
matrice2(:,3) = cumsum(matrice2(:,2));
AVG_NumJobs2_i(1,1) = mean(matrice2(:,3));

%Variance of Response Time
Variance2_i(1,1) = var(RT2);


error_Throughput = 1;
error_Utilization = 1;
error_AvgResponseTime = 1;
error_AvgNumJobs = 1;
error_Variance = 1;

K = 2;

while(error_Throughput>0.04 || error_Utilization>0.04 || error_AvgResponseTime >0.04 || error_AvgNumJobs >0.04 || error_Variance >0.04  )
    Inter_Arrivals2 = -log(rand(1000,1))/lExp;
    Arrivals2 = cumsum(Inter_Arrivals2);
    Service2 = a+(b-a).*rand(1000,1);
    IN2 = Arrivals2;
    OUT2 = [];

    OUT2(1,1)= IN2(1,1) + Service2(1,1);
    for i = 2:N
        OUT2(i,1) = max(IN2(i,1),OUT2(i-1,1))+Service2(i,1);
    end

    T2 = OUT2(end,1)-IN2(1,1);

    % Throughput
    X2_i(K,1) = N/T2;

    % Average Response Time
    M2 = [IN2,OUT2];
    RT2 = M2(:,2) - M2(:,1);
    AVG_RT2_i(K,1) = mean(RT2);

    % Utilization
    B2 = sum(Service2);
    U2_i(K,1) = B2/T2;

    %Average number of jobs in the system
    matrice2 = [IN2, ones(N,1); OUT2, -ones(N, 1)];
    matrice2 = sortrows(matrice2,1);
    matrice2(:,3) = cumsum(matrice2(:,2));
    AVG_NumJobs2_i(K,1) = mean(matrice2(:,3));

    %Variance of Response Time
    Variance2_i(K,1) = var(RT2);


    %Confidence
    d = 1.96;

    %Average
    U2_i_mean = sum(U2_i)/K;
    X2_i_mean = sum(X2_i)/K;
    AVG_RT2_i_mean = sum(AVG_RT2_i)/K;
    AVG_NumJobs2_i_mean = sum(AVG_NumJobs2_i)/K;
    Variance2_i_mean = sum(Variance2_i)/K;


    %S^2 Throughput
    S2 = sum((X2_i - X2_i_mean).^2)/(K-1);
    Bounds = [X2_i_mean - d*sqrt(S2/K); X2_i_mean + d*sqrt(S2/K)];
    error_Throughput = 2*(Bounds(2,1) - Bounds(1,1))/(Bounds(2,1) + Bounds(1,1));

    %S^2 Utilization
    S2 = sum((U2_i - U2_i_mean).^2)/(K-1);
    Bounds = [U2_i_mean - d*sqrt(S2/K); U2_i_mean + d*sqrt(S2/K)];
    error_Utilization = 2*(Bounds(2,1) - Bounds(1,1))/(Bounds(2,1) + Bounds(1,1));

    %S^2 Avg Response Time
    S2 = sum((AVG_RT2_i - AVG_RT2_i_mean).^2)/(K-1);
    Bounds = [AVG_RT2_i_mean - d*sqrt(S2/K); AVG_RT2_i_mean + d*sqrt(S2/K)];
    Bounds;
    error_AvgResponseTime = 2*(Bounds(2,1) - Bounds(1,1))/(Bounds(2,1) + Bounds(1,1));

    %S^2 Avg Number of Jobs
    S2 = sum((AVG_NumJobs2_i - AVG_NumJobs2_i_mean).^2)/(K-1);
    Bounds = [AVG_NumJobs2_i_mean - d*sqrt(S2/K); AVG_NumJobs2_i_mean + d*sqrt(S2/K)];
    error_AvgNumJobs = 2*(Bounds(2,1) - Bounds(1,1))/(Bounds(2,1) + Bounds(1,1));

    %S^2 Variance
    S2 = sum((Variance2_i - Variance2_i_mean).^2)/(K-1);
    Bounds = [Variance2_i_mean - d*sqrt(S2/K); Variance2_i_mean + d*sqrt(S2/K)];
    error_Variance = 2*(Bounds(2,1) - Bounds(1,1))/(Bounds(2,1) + Bounds(1,1));

    K = K+1;

end


