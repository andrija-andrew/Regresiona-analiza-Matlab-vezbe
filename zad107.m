data = xlsread('zadatak7.xlsx');
x = data(:, 2:5);
y = data(:, 1);

n = size(y, 1);
k = size(x, 2);

[beta_hat, y_hat, RSS] = lreg([ones(n, 1) x], y);
disp(['Jednacina linearne regresije punog modela je y = ', num2str(beta_hat(1)), ' + (', num2str(beta_hat(2)), ') * x1 + (', num2str(beta_hat(3)), ') * x2 + (', num2str(beta_hat(4)), ') * x3 + (', num2str(beta_hat(5)), ') * x4.'])

x_rdc = x(:, [1, 4]);

[beta_hat_rdc, y_hat_rdc, RSS_rdc] = lreg([ones(n, 1) x_rdc], y);
disp(['Jednacina linearne regresije redukovanog modela je y_rdc = ', num2str(beta_hat_rdc(1)), ' + (', num2str(beta_hat_rdc(2)), ') * x1 + (', num2str(beta_hat_rdc(3)), ') * x4.'])

alpha = 0.05;
gamma = 1 - alpha;

deg_fr1 = k - size(x_rdc, 2);
deg_fr2 = n - (k + 1);
F_reg = ((RSS_rdc - RSS) / deg_fr1) / (RSS / deg_fr2);
q = finv(gamma, deg_fr1, deg_fr2);
if F_reg > q
    disp(['Prihvacena je hipoteza H1([beta_2; beta_3] != [0; 0]) na nivou poverenja ', num2str(gamma), '.'])
else
    disp(['Nije odbacena hipoteza H0([beta_2; beta_3] = [0; 0]) na nivou poverenja ', num2str(gamma), '.'])
end
