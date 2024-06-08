function cdf = erlang_cdf(x, k, lambda)
    if k <= 0 || lambda <= 0
        error('k e lambda devono essere valori positivi.');
    end
    
    cdf = zeros(size(x)); % Inizializza l'array CDF con zeri
    
    for i = 1:length(x)
        sum_term = 0;
        for j = 0:(k-1)
            sum_term = sum_term + (exp(-lambda * x(i)) * (lambda * x(i))^j) / factorial(j);
        end
        cdf(i) = 1 - sum_term;
    end
end
