y = [0; 1; 2.7183; 6.7781; 5.7781; 7; 9; 17.1672; 18; 29.5562];
x = (1:size(y, 1))';

plot(x, y, 'b*')
hold on

f = @(b) exp(b(1) + b(2) * x) + b(3);
beta_hat = [0; 1; -1];
h = 1e-11;
max_iter = 100;
stop = 1e-11;
[beta_hat, n_iter, y_hat, RSS] = gn(y, f, beta_hat, h, max_iter, stop);

disp(['Jednacina nelinearnog modela je y = e ^ (', num2str(beta_hat(1)), ' + (', num2str(beta_hat(2)), ') * x) + (', num2str(beta_hat(3)), ').'])
disp(['Suma kvadrata reziduala nelinearnog modela je ', num2str(RSS), '.'])

d = 1;
step = 0.1;
xv = (min(x) - d):step:(max(x) + d);
plot(xv, exp(beta_hat(1) + beta_hat(2) * xv) + beta_hat(3), 'r')
hold off
