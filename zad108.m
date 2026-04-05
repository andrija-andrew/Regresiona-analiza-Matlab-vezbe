data = xlsread('automobili.xlsx');
x = data(:, 1);
y = data(:, 2);

n = size(y, 1);

plot(x, y, 'b*')
hold on

[beta_hat, y_hat, RSS] = lreg([ones(n, 1) x (x .^ 2)], y);
disp(['Jednacina kvadratnog modela je y = ', num2str(beta_hat(1)), ' + (', num2str(beta_hat(2)), ') * x + (', num2str(beta_hat(3)), ') * x ^ 2.'])

xv = (min(x):0.1:max(x))';
m = size(xv, 1);
plot(xv, [ones(m, 1) xv (xv .^ 2)] * beta_hat, 'r')

[beta_hat_ob, y_hat_ob, RSS_ob] = lreg([ones(n, 1) x], y);
disp(['Jednacina linearnog modela je y = ', num2str(beta_hat_ob(1)), ' + (', num2str(beta_hat_ob(2)), ') * x.'])

plot(xv, [ones(m, 1) xv] * beta_hat_ob, 'g')
hold off

Syy = sum((y - mean(y)) .^ 2);
R2 = 1 - RSS / Syy;
R2_ob = 1 - RSS_ob / Syy;
disp(['Koeficijent determinacije kvadratnog modela je ', num2str(R2), ', a linearnog ', num2str(R2_ob), '.'])
