function [t_reg, H] = lsd(data, alpha)

k = size(data, 2);

n_i = NaN(1, k);
m_i = NaN(1, k);
SE = 0;
for i = 1:k
    X_i = data(:, i);
    X_i = X_i(~isnan(X_i));
    n_i(i) = size(X_i, 1);
    m_i(i) = mean(X_i);
    SE = SE + sum((X_i - m_i(i)) .^ 2);
end

n = sum(n_i);
deg_fr2 = n - k;
ME = SE / deg_fr2;

t_reg = zeros(k);
H = zeros(k);
q = tinv(1 - alpha / 2, deg_fr2);
for i = 1:(k - 1)
    for j = (i + 1):k
        t_reg(i, j) = (m_i(i) - m_i(j)) / sqrt(ME * ((1 / n_i(i)) + (1 / n_i(j))));
        t_reg(j, i) = -t_reg(i, j);
        if abs(t_reg(i, j)) > q
            H(i, j) = 1;
            H(j, i) = 1;
        end
    end
end

end