y = [0; 1; 2.7183; 6.7781; 5.7781; 7; 9; 17.1672; 18; 29.5562];
x = (1:size(y, 1))';

plot(x, y, 'b*')
hold on

r = @(beta) beta(1) * exp(beta(2) * x) - y;
J = @(beta) [exp(beta(2) * x), beta(1) * exp(beta(2) * x) .* x];

beta_hat = [1; 1];
for i = 1:100
    beta_hat = beta_hat - (J(beta_hat)' * J(beta_hat)) \ (J(beta_hat)' * r(beta_hat));
end

y_hat = beta_hat(1) * exp(beta_hat(2) * x);
RSS = sum((y - y_hat) .^ 2);

disp(['Jednacina eksponencijalnog modela je y = ', num2str(beta_hat(1)), ' * e ^ (', num2str(beta_hat(2)), ' * x).'])
disp(['Suma kvadrata reziduala eksponencijalnog modela je ', num2str(RSS), '.'])

xv = min(x):0.1:max(x);
plot(xv, beta_hat(1) * exp(beta_hat(2) * xv), 'r')
hold off
