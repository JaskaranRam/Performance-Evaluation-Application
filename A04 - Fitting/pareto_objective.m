% pareto_objective.m

function residual = pareto_objective(params, m1_observed, m2_observed)
    % Estrai i parametri stimati dalla variabile di input
    alpha = params(1);
    scale_xm = params(2);

    % Calcola i momenti teorici della distribuzione di Pareto
    m1_theoretical = scale_xm * alpha / (alpha - 1);
    m2_theoretical = (scale_xm^2) * alpha / ((alpha - 1)^2 * (alpha - 2));

    % Calcola la differenza tra i momenti osservati e teorici
    residual = [m1_observed - m1_theoretical; m2_observed - m2_theoretical];
end
