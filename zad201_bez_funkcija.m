data = xlsread('pamuk.xlsx');

k = size(data, 1);

n_i = NaN(k, 1);
m_i = NaN(k, 1);
m = 0;
SE = 0;
for i = 1:k
    X_i = data(i, :);
    % X_i = X_i(~isnan(X_i));
    n_i(i) = size(X_i, 2);
    rowsum = sum(X_i);
    m_i(i) = rowsum / n_i(i);
    m = m + rowsum;
    SE = SE + sum((X_i - m_i(i)) .^ 2);
end

n = sum(n_i);
m = m / n;
SA = ((m_i - m) .^ 2)' * n_i;

alpha = 0.05;
gamma = 1 - alpha;

deg_fr1 = k - 1;
deg_fr2 = n - k;
MA = SA / deg_fr1;
ME = SE / deg_fr2;
F_reg = MA / ME;
q_forall = finv(gamma, deg_fr1, deg_fr2);
if F_reg > q_forall
    H_forall = 1;
else
    H_forall = 0;
end
disp(['Prihvacena je hipoteza H', num2str(H_forall), ' na nivou poverenja ', num2str(gamma), '.'])

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
