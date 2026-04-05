data = xlsread('tezina-otkucaji srca.xlsx');
x = data(:, 1);
y = data(:, 2);

n = size(y, 1);

plot(x, y, 'b*')
hold on

[beta_hat, y_hat, RSS] = lreg([ones(n, 1) x], y);
beta_0_hat = beta_hat(1);
disp(['beta_0_hat = ', num2str(beta_0_hat)])
beta_1_hat = beta_hat(2);
disp(['beta_1_hat = ', num2str(beta_1_hat)])
disp(['Jednacina linearne regresije je y = ', num2str(beta_0_hat), ' + (', num2str(beta_1_hat), ') * x.'])
plot(x, y_hat, 'r')

alpha = 0.05;
gamma = 1 - alpha;

deg_fr = n - size(beta_hat, 1);
S2 = RSS / deg_fr;
mean_x = mean(x);
Sxx = sum((x - mean_x) .^ 2);
t_reg = beta_1_hat / sqrt(S2 / Sxx);
q = tinv(1 - alpha / 2, deg_fr);
if abs(t_reg) > q
    disp(['Prihvacena je hipoteza H1(rho != 0) na nivou poverenja ', num2str(gamma), '.'])
else
    disp(['Nije odbacena hipoteza H0(rho = 0) na nivou poverenja ', num2str(gamma), '.'])
end

x0 = 88;
y0 = [1 x0] * beta_hat;
disp(['Za x = ', num2str(x0), ' predvidjena ocekivana vrednost y je ', num2str(y0), '.'])
plot(x0, y0, 'k+')

pm_ci_E_y0 = q * sqrt(S2 * (1 / n + ((x0 - mean_x) ^ 2) / Sxx));
ci_E_y0 = [y0 - pm_ci_E_y0, y0 + pm_ci_E_y0];
disp(['Interval poverenja na nivou ', num2str(gamma), ' za ocekivanu vrednost y kada je x = ', num2str(x0), ' je [', num2str(ci_E_y0(1)), ', ', num2str(ci_E_y0(2)), '].'])

disp(['Predvidjeni broj otkucaja srca u minuti za ljude koji imaju tezinu ', num2str(x0), 'kg je ', num2str(y0), '.'])
pm_ci_y0 = q * sqrt(S2 * (1 + 1 / n + ((x0 - mean_x) ^ 2) / Sxx));
ci_y0 = [y0 - pm_ci_y0, y0 + pm_ci_y0];
disp(['Interval poverenja na nivou ', num2str(gamma), ' za predvidjeni broj otkucaja srca u minuti za ljude koji imaju tezinu ', num2str(x0), 'kg je [', num2str(ci_y0(1)), ', ', num2str(ci_y0(2)), '].'])

% Ne treba da se radi.
xv = (min(x):0.1:max(x))';
yv_hat = [ones(size(xv, 1), 1) xv] * beta_hat;
pm_ci_E = q * sqrt(S2 * (1 / n + ((xv - mean_x) .^ 2) / Sxx));
pm_ci = q * sqrt(S2 * (1 + 1 / n + ((xv - mean_x) .^ 2) / Sxx));
plot(xv, yv_hat - pm_ci_E, 'c')
plot(xv, yv_hat + pm_ci_E, 'c')
plot(xv, yv_hat - pm_ci, 'g')
plot(xv, yv_hat + pm_ci, 'g')
plot(mean_x, [1 mean_x] * beta_hat, 'k.')
hold off
