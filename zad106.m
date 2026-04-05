data = xlsread('zadatak6.xlsx');
x = data(:, 3:4);
y = data(:, 2);

[beta_hat, y_hat, RSS] = lreg([ones(size(x, 1), 1) x], y);
disp(['Jednacina visestruke linearne regresije je y = ', num2str(beta_hat(1)), ' + (', num2str(beta_hat(2)), ') * x1 + (', num2str(beta_hat(3)), ') * x2.'])
