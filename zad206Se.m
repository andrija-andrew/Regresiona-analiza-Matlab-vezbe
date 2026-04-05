data = csvread('crop.data.csv');
fert = data(:, 3);
dens = data(:, 1);
yield = data(:, 4);

k = 3;
L = 2;
N = size(yield, 1);
s = N / (k * L);

mean_x_i = NaN(k, 1);
for i = 1:k
    mean_x_i(i) = mean(yield(fert == i));
end

mean_x_j = NaN(1, L);
for j = 1:L
    mean_x_j(j) = mean(yield(dens == j));
end

mean_x = mean(yield);
alpha_hat_i = mean_x_i - mean_x;
beta_hat_j = mean_x_j - mean_x;

mean_x_ij = NaN(k, L);
for i = 1:k
    for j = 1:L
        mean_x_ij(i, j) = mean(yield(fert == i & dens == j));
    end
end

gamma_hat_ij = mean_x_ij - repmat(mean_x_i, 1, L) - repmat(mean_x_j, k, 1) + mean_x;

Sw = 0;
for i = 1:k
    for j = 1:L
        Sw = Sw + sum((yield(fert == i & dens == j) - mean_x_ij(i, j)) .^ 2);
    end
end

sl = 0.05;
cl = 1 - sl;

Si = s * sum(sum(gamma_hat_ij .^ 2));
F_reg_gamma = (Si / ((k - 1) * (L - 1))) / (Sw / (N - k * L));
q_gamma = finv(cl, (k - 1) * (L - 1), N - k * L);
if F_reg_gamma > q_gamma
    disp(['Prihvacena je hipoteza H1(postoji gamma_ij != 0) na nivou poverenja ', num2str(cl), '.'])
else
    disp(['Nije odbacena hipoteza H0(svi gamma_ij = 0) na nivou poverenja ', num2str(cl), '.'])
end

Se = 0;
for i = 1:N
    Se = Se + (yield(i) - mean_x_i(fert(i)) - mean_x_j(dens(i)) + mean_x) ^ 2;
end

Sr = L * s * sum(alpha_hat_i .^ 2);
F_reg_alpha = (Sr / (k - 1)) / (Se / (N - k - L + 1));
q_alpha = finv(cl, k - 1, N - k - L + 1);
if F_reg_alpha > q_alpha
    disp(['Prihvacena je hipoteza H1(postoji alpha_i != 0) na nivou poverenja ', num2str(cl), '.'])
else
    disp(['Nije odbacena hipoteza H0(svi alpha_i = 0) na nivou poverenja ', num2str(cl), '.'])
end

Sc = k * s * sum(beta_hat_j .^ 2);
F_reg_beta = (Sc / (L - 1)) / (Se / (N - k - L + 1));
q_beta = finv(cl, L - 1, N - k - L + 1);
if F_reg_beta > q_beta
    disp(['Prihvacena je hipoteza H1(postoji beta_j != 0) na nivou poverenja ', num2str(cl), '.'])
else
    disp(['Nije odbacena hipoteza H0(svi beta_j = 0) na nivou poverenja ', num2str(cl), '.'])
end
