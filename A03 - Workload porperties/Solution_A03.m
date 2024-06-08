%Jaskaran Ram - A03 

clear all;

File1 = csvread("Trace1.csv");
File2 = csvread("Trace2.csv");
File3 = csvread("Trace3.csv");

dataset = [File1, File2, File3];
dataset = sort(dataset);
N = length(dataset);

plot(dataset,[1:N]/N, "-");

M1 = sum(dataset)/N;
M2 = sum(dataset .^2)/N;
M3 = sum(dataset .^3)/N;
M4 = sum(dataset .^4)/N;

Variance = M2 - M1.^2;   % Equals to C2
Variance_from_mathlab = var(dataset);

Sigma = sqrt(Variance);  % Standard Deviation
Sigma_by_mathlab = std(dataset);
Coefficient_variation = Sigma ./M1;

C2 = sum((dataset - M1) .^2)/N;
C3 = sum((dataset - M1) .^3)/N;
C4 = sum((dataset - M1) .^4)/N;

S4 = sum(((dataset - M1)./Sigma) .^4)/N;

Skewness = sum(((dataset - M1)./Sigma).^3)/N;
excess_Kurtosis = sum(((dataset - M1)./Sigma).^4)/N  -3;  

%Percentile
first_quartile = prctile(dataset,25);
median = prctile(dataset,50);
third_quartile = prctile(dataset,75);

% Pearson Correlation Coefficient
Stot =[];
for j = 1:100
    S = sum((dataset(1:end-j, :)- M1) .* (dataset(j+1:end, :)- M1)) / (N-j); % cross covariance lag j
    Stot = [Stot; S];    
end
PC = [Stot] ./ var(dataset);
figure;
plot([1:100], PC, "-");

