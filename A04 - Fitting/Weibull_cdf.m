function F = Weibull_cdf(x, lambda, k)
    F = 1 - exp(-((x / lambda).^k));
end
