%A05 - Jaskaran Ram

clear all;

% 1) Using the Linear Congruent Generator
a = 1664525;
m = 2^32;
c = 1013904223;
seed = 521191478;
N = 10000;
samples = zeros(N, 1);
samples(1,1) = seed;

for i = 2:N
    samples(i) = mod(a * samples(i-1,1) + c, m);
end

samples = samples ./m;

% 2) Exponential distribution of rate Lambda = 0.1
lambda_exponential = 0.1;

e = -log(samples)/lambda_exponential;
t = (1:250)/10;
figure;
plot(sort(e), (1:N)/N, ".", t, 1-exp(-lambda_exponential*t), "-");
xlim([0,25]);

% 3) Pareto distribution a = 1.5, m = 5
a = 1.5;
m = 5;
v = m./(samples.^(1/a));
figure;
plot(sort(v), (1:N)/N, ".", t, Pareto_cdf(t,a,m), "-");
xlim([0,25]);

% 4) Erlang distribuiton k_erlang = 4, lambda_erlang =  0.4
k_erlang = 4;
lambda_erlang  = 0.4;

indice = 1;
for i = 1:4:N
    v2(indice,1) = -log(samples(i)*samples(i+1)*samples(i+2)*samples(i+3))/lambda_erlang;
    indice = indice + 1;
end
figure;
plot(sort(v2), (1:2500)/2500, ".", t, Erlang_cdf(t,k_erlang,lambda_erlang));
xlim([0,25]);

%5) Hypo-Exponential distribution with rates lambdaHYP_1 = 0.5, lambdaHYP_2 = 0.125
lambda_hypo_1 = 0.5;
lambda_hypo_2 = 0.125;

indice = 1;
for i = 1:2:N
    v3(indice,1) = -log(samples(i))/lambda_hypo_1 - log(samples(i+1))/lambda_hypo_2;
    indice = indice +1;
end
figure;
plot(sort(v3), (1:5000)/5000, ".", t, HypoExp_cdf(t, [lambda_hypo_1,lambda_hypo_2]));
xlim([0,25]);

% 6) a Hyper-Exponential distribution with rates lambda_hyper_1 = 0.5,  lambda_hyper_2 = 0.05, p1 = 0.55
lambda_hyper_1 = 0.5;
lambda_hyper_2 = 0.05;
p1 = 0.55;

indice = 1;
for i = 1:2:N   
    if (samples(i)<= p1)
        v4(indice,1)= -log(samples(i+1))/lambda_hyper_1;
    else
        v4(indice,1) = -log(samples(i+1))/lambda_hyper_2;
    end
    indice = indice +1;
end

figure;
plot(sort(v4), (1:5000)/5000, ".", t, HyperExp_cdf(t, [lambda_hyper_1,lambda_hyper_2,p1]), ".");
xlim([0,25]);

%Compute the total cost for storing
costo1 = 0.01;
costo2 = 0.02;

costo_e = 0;
costo_p = 0;
costo_erlang = 0;
costo_hypo = 0;
costo_hyper = 0;

for i=1:N
    if e(i,1)<10
        costo_e = costo_e + e(i,1)*costo1;
    else
        costo_e = costo_e + e(i,1)*costo2;
    end

    if v(i,1)<10
        costo_p = costo_p + v(i,1)*costo1;
    else
        costo_p = costo_p + v(i,1)*costo2;
    end
end

for i=1:N/4
    if v2(i,1)<10
        costo_erlang = costo_erlang + v2(i,1)*costo1;
    else
        costo_erlang = costo_erlang + v2(i,1)*costo2;
    end
end

for i=1:N/2
    if v3(i,1)<10
        costo_hypo = costo_hypo + v3(i,1)*costo1;
    else
        costo_hypo = costo_hypo + v3(i,1)*costo2;
    end

    if v4(i,1)<10
        costo_hyper = costo_hyper + v4(i,1)*costo1;
    else
        costo_hyper = costo_hyper + v4(i,1)*costo2;
    end
end

