data = (xlsread('pamuk.xlsx'))';

alpha = 0.05;

[SA, SE, deg_fr1, deg_fr2, MA, ME, F_reg, H_forall] = owanova(data, alpha);
disp(['Prihvacena je hipoteza H', num2str(H_forall), ' na nivou poverenja ', num2str(1 - alpha), '.'])
[t_reg, H] = lsd(data, alpha);
