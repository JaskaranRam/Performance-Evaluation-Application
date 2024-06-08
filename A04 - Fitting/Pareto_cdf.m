function F = Pareto_cdf(x, alpha, x_min)
    % Assicurati che x sia maggiore o uguale a x_min
    x(x < x_min) = x_min;
    
    F = 1 - (x_min ./ x).^alpha;
end
