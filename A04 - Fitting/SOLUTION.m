File1 = csvread("Trace1.csv");
File2 = csvread("Trace2.csv");

%CAMBIARE QUA IL FILE PER VEDERE I RISULTATI SULLE DIVERSE FONTI
dataset = sort(File1);

N = length(dataset);

M1 = sum(dataset) / N;
M2 = sum(dataset .^ 2) / N;
M3 = sum(dataset .^ 3) / N;

Mu = mean(dataset);
Sigma = std(dataset);
Cv = Sigma / Mu;

cv = Sigma/abs(M1);
% ATTENZIONE
% TRACCIA 1 HyperExp non valida CV<1
% TRACCIA 2 HypoEXP non valida CV>1
% PLOTTATE per comodità

lambda = 1 / Mu;
range = (1:1000) / 10;

a = M1 - sqrt(12 * (M2 - M1^2)) / 2;
b = M1 + sqrt(12 * (M2 - M1^2)) / 2;

k_Erlang = round(M1^2 / (M2 - M1^2));
lambda_Erlang = k_Erlang / M1;

% Pareto
m1_observed = M1;
m2_observed = M2;
initial_guess = [3, 7];
params = fsolve(@(x) pareto_objective(x, m1_observed, m2_observed), initial_guess);
alpha = params(1);
scale_xm = params(2);

% Weibull
k_initial = 1;
options = optimset('Display', 'off');
k_Weibull = fminsearch(@(k_Weibull) abs((Sigma / gamma(1 + 2 / k_Weibull)) - ((M1 / gamma(1 + 1 / k_Weibull))^(1 / k_Weibull))), k_initial, options);
lambda_Weibull = (M1 / gamma(1 + 1 / k_Weibull))^(1 / k_Weibull);

% Hyper-Exponential and Hypo-Exponential distributions

par_Hypo = mle(dataset, 'PDF', @(data, l1, l2) HypoExp_pdf(data, [l1, l2]), 'Start', [1 / (0.3 * M1), 1 / (0.7 * M1)]);
par_Hyper = mle(dataset, 'PDF', @(data, l1, l2, p1) HyperExp_pdf(data, [l1, l2, p1]), 'Start', [0.8 / M1, 1.2 / M1, 0.4]);

figure;

hold on;

% Plot del dataset iniziale solo una volta
plot(dataset, [1:N] / N, ".");

% Plot delle distribuzioni
plot(range, Exp_cdf(range, [lambda]), "-");
plot(range, Unif_cdf(range, [a, b]), "-");
plot(range, Erlang_cdf(range, k_Erlang, lambda_Erlang), "-");
plot(range, Pareto_cdf(range, alpha, scale_xm), "-");
plot(range, Weibull_cdf(range, lambda_Weibull, k_Weibull), "-");
%Togli o metti a piacimento
plot(range, HypoExp_cdf(range, par_Hypo), "-");
%plot(range, HyperExp_cdf(range, par_Hyper), "-");

title('Fitting Trace');
xlabel('Value');
ylabel('Cumulative Probability');
legend('Data', 'Exponential', 'Uniform', 'Erlang', 'Pareto', 'Weibull', 'X');
grid on;
