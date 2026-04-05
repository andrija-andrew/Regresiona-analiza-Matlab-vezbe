data = xlsread('prasina.xlsx');
x = data(:, 1);
y = data(:, 3);

plot(x, y, 'b*')
hold on

[beta_hat, y_hat, RSS] = lreg(x, y);
disp(['Jednacina linearne regresije bez odsecka je y = ', num2str(beta_hat(1)), ' * x.'])
plot(x, y_hat, 'r')

% Ne treba da se radi.
deg_fr = size(y, 1) - size(beta_hat, 1);
S2 = RSS / deg_fr;
SSx = sum(x .^ 2);
var_hat_beta_hat = S2 / SSx;
var_hat_y_hat = (x .^ 2) * var_hat_beta_hat;
sigma2_F_hat = S2 + var_hat_y_hat;

q = tinv(0.975, deg_fr);
xv = (min(x):0.1:max(x))';
yv_hat = xv * beta_hat;
pm_ci_E = q * sqrt(S2 * (xv .^ 2) / SSx);
pm_ci = q * sqrt(S2 * (1 + (xv .^ 2) / SSx));
plot(xv, yv_hat - pm_ci_E, 'c')
plot(xv, yv_hat + pm_ci_E, 'c')
plot(xv, yv_hat - pm_ci, 'g')
plot(xv, yv_hat + pm_ci, 'g')
hold off
