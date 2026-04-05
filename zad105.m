data = xlsread('masnoca u krvi.xlsx');
x = data(:, 1:2);
y = data(:, 3);

ones_x = [ones(size(x, 1), 1) x];

[beta_hat, y_hat, RSS] = lreg(ones_x, y);
disp(['Jednacina visestruke linearne regresije je y = ', num2str(beta_hat(1)), ' + (', num2str(beta_hat(2)), ') * x1 + (', num2str(beta_hat(3)), ') * x2.'])

x0 = [75 65];
y0 = [1 x0] * beta_hat;
disp(['Predvidjena vrednost mosnoce u krvi za osobu staru ', num2str(x0(2)), ' god. i tezine ', num2str(x0(1)), 'kg je ', num2str(y0), '.'])

[beta_hat_a, y_hat_a, RSS_a] = lreg(ones_x(:, [1, 2]), y);
disp(['Jednacina prve jednostruke linearne regresije je y = ', num2str(beta_hat_a(1)), ' + (', num2str(beta_hat_a(2)), ') * x1.'])

[beta_hat_b, y_hat_b, RSS_b] = lreg(ones_x(:, [1, 3]), y);
disp(['Jednacina druge jednostruke linearne regresije je y = ', num2str(beta_hat_b(1)), ' + (', num2str(beta_hat_b(2)), ') * x2.'])
