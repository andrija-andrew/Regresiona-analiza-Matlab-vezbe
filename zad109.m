data = (xlsread('reka.xlsx'))';
x = data(:, 1);
y = data(:, 2);

plot(x, y, 'b*')
hold on

[beta_hat, y_hat, RSS] = lreg([log(x) ones(size(x, 1), 1)], y);
disp(['Jednacina regresione krive je y = ', num2str(beta_hat(1)), ' * ln(x) + (', num2str(beta_hat(2)), ').'])

xv = (min(x):0.1:max(x))';
plot(xv, [log(xv) ones(size(xv, 1), 1)] * beta_hat, 'r')
hold off
