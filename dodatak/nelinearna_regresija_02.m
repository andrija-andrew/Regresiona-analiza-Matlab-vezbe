kpu = [331; 299; 301; 398; 402; 487; 601; 614; 703; 711; 799; 927; 990; 1015];
pc = [129; 138; 121; 139; 127; 111; 103; 122; 101; 110; 100; 99; 97; 95];

n = size(kpu, 1);

plot(pc, kpu, 'b*')
hold on

[b_hat, y_hat, RSS] = lreg([ones(n, 1) pc], kpu);
disp(['Jednacina linearnog modela je y = ', num2str(b_hat(1)), ' + (', num2str(b_hat(2)), ') * x.'])
disp(['Suma kvadrata reziduala linearnog modela je ', num2str(RSS), '.'])
plot(pc, y_hat, 'k')

h = 1e-11;
max_iter = 100;
stop = 1e-11;

f1 = @(b) (b(2) ./ pc) + b(1);
beta_hat_f1 = [200; 1];
[beta_hat_f1, n_iter_f1, y_hat_f1, RSS_f1] = gn(kpu, f1, beta_hat_f1, h, max_iter, stop);
disp(['Jednacina prvog nelinearnog modela je y = (', num2str(beta_hat_f1(2)), ' / x) + (', num2str(beta_hat_f1(1)), ').'])
disp(['Suma kvadrata reziduala prvog nelinearnog modela je ', num2str(RSS_f1), '.'])

f2 = @(b) b(2) ./ (pc + b(1));
beta_hat_f2 = [-55; 36000];
[beta_hat_f2, n_iter_f2, y_hat_f2, RSS_f2] = gn(kpu, f2, beta_hat_f2, h, max_iter, stop);
disp(['Jednacina drugog nelinearnog modela je y = ', num2str(beta_hat_f2(2)), ' / (x + (', num2str(beta_hat_f2(1)), ')).'])
disp(['Suma kvadrata reziduala drugog nelinearnog modela je ', num2str(RSS_f2), '.'])

f3 = @(b) (b(2) ./ (pc + b(1))) + b(3);
beta_hat_f3 = [beta_hat_f2(1); beta_hat_f2(2); 0];
[beta_hat_f3, n_iter_f3, y_hat_f3, RSS_f3] = gn(kpu, f3, beta_hat_f3, h, max_iter, stop);
disp(['Jednacina treceg nelinearnog modela je y = (', num2str(beta_hat_f3(2)), ' / (x + (', num2str(beta_hat_f3(1)), '))) + (', num2str(beta_hat_f3(3)), ').'])
disp(['Suma kvadrata reziduala treceg nelinearnog modela je ', num2str(RSS_f3), '.'])

d = 3;
step = 0.1;
pcv = (min(pc) - d):step:(max(pc) + d);
plot(pcv, (beta_hat_f1(2) ./ pcv) + beta_hat_f1(1), 'r')
plot(pcv, beta_hat_f2(2) ./ (pcv + beta_hat_f2(1)), 'g')
plot(pcv, (beta_hat_f3(2) ./ (pcv + beta_hat_f3(1))) + beta_hat_f3(3), 'b')
hold off
