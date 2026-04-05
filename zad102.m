data = xlsread('gejzir.xlsx');
x = data(:, 2);
y = data(:, 1);

n = size(y, 1);

[beta_hat, y_hat, RSS] = lreg([ones(n, 1) x], y);
beta_0_hat = beta_hat(1);
disp(['beta_0_hat = ', num2str(beta_0_hat)])
beta_1_hat = beta_hat(2);
disp(['beta_1_hat = ', num2str(beta_1_hat)])
disp(['Jednacina linearne regresije je y = ', num2str(beta_0_hat), ' + (', num2str(beta_1_hat), ') * x.'])

test_numb = 0;
alpha = 0.05;
gamma = 1 - alpha;

deg_fr = n - size(beta_hat, 1);
S2 = RSS / deg_fr;
Sxx = sum((x - mean(x)) .^ 2);
SD_hat_beta_1_hat = sqrt(S2 / Sxx);
t_reg = (beta_1_hat - test_numb) / SD_hat_beta_1_hat;
q = tinv(1 - alpha / 2, deg_fr);
if abs(t_reg) > q
    disp(['Prihvacena je hipoteza H1(beta_1 != ', num2str(test_numb), ') na nivou poverenja ', num2str(gamma), '.'])
else
    disp(['Nije odbacena hipoteza H0(beta_1 = ', num2str(test_numb), ') na nivou poverenja ', num2str(gamma), '.'])
end

pm_ci = q * SD_hat_beta_1_hat;
ci_beta_1 = [beta_1_hat - pm_ci, beta_1_hat + pm_ci];
disp(['Interval poverenja na nivou ', num2str(gamma), ' za parametar beta_1 je [', num2str(ci_beta_1(1)), ', ', num2str(ci_beta_1(2)), '].'])

Syy = sum((y - mean(y)) .^ 2);
R2 = 1 - RSS / Syy;
disp(['Koeficijent determinacije je ', num2str(R2), '.'])
