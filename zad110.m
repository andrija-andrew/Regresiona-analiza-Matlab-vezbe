data = (xlsread('vlaznost.xlsx'))';
x = data(:, 1);
y = data(:, 2);

n = size(y, 1);

plot(x, y, 'b*')
hold on

w = log(y);
z = log(x);

[beta_hat_a, w_hat_a] = lreg([ones(n, 1) z], w);
p_a = exp(beta_hat_a(1));
q_a = beta_hat_a(2);
disp(['Jednacina stepenog modela je y = ', num2str(p_a), ' * x ^ (', num2str(q_a), ').'])

xv = (min(x):0.1:max(x))';
plot(xv, p_a * (xv .^ q_a), 'r')

RSS_a = sum((y - exp(w_hat_a)) .^ 2);
disp(['Suma kvadrata reziduala stepenog modela je ', num2str(RSS_a), '.'])

[beta_hat_b, w_hat_b] = lreg([ones(n, 1) x], w);
p_b = exp(beta_hat_b(1));
q_b = beta_hat_b(2);
disp(['Jednacina eksponencijalnog modela je y = ', num2str(p_b), ' * e ^ (', num2str(q_b), ' * x).'])

plot(xv, p_b * exp(q_b * xv), 'g')
hold off

RSS_b = sum((y - exp(w_hat_b)) .^ 2);
disp(['Suma kvadrata reziduala eksponencijalnog modela je ', num2str(RSS_b), '.'])
