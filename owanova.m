function [SA, SE, deg_fr1, deg_fr2, MA, ME, F_reg, H_forall] = owanova(data, alpha)

k = size(data, 2);

n_i = NaN(1, k);
m_i = NaN(1, k);
m = 0;
SE = 0;
for i = 1:k
    X_i = data(:, i);
    X_i = X_i(~isnan(X_i));
    n_i(i) = size(X_i, 1);
    colsum = sum(X_i);
    m_i(i) = colsum / n_i(i);
    m = m + colsum;
    SE = SE + sum((X_i - m_i(i)) .^ 2);
end

n = sum(n_i);
m = m / n;
SA = ((m_i - m) .^ 2) * n_i';

deg_fr1 = k - 1;
deg_fr2 = n - k;
MA = SA / deg_fr1;
ME = SE / deg_fr2;
F_reg = MA / ME;
q_forall = finv(1 - alpha, deg_fr1, deg_fr2);
if F_reg > q_forall
    H_forall = 1;
else
    H_forall = 0;
end

end