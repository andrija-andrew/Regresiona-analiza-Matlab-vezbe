data = readtable('plata.xlsx');

alpha = 0.05;
gamma = 1 - alpha;

male = data(strcmp(data{:, 1}, 'Male'), 2);
female = data(strcmp(data{:, 1}, 'Female'), 2);
gender = [male{:, :} female{:, :}];
[SA_gender, SE_gender, deg_fr1_gender, deg_fr2_gender, MA_gender, ME_gender, F_reg_gender, H_forall_gender] = owanova(gender, alpha);
disp(['Za pol je prihvacena hipoteza H', num2str(H_forall_gender), ' na nivou poverenja ', num2str(gamma), '.'])
[t_reg_gender, H_gender] = lsd(gender, alpha);

chicago = data(strcmp(data{:, 4}, 'Chicago'), 2);
new_york = data(strcmp(data{:, 4}, 'New York'), 2);
washington = data(strcmp(data{:, 4}, 'Washington'), 2);
place = [[chicago{:, :}; NaN; NaN] new_york{:, :} [washington{:, :}; NaN]];
[SA_place, SE_place, deg_fr1_place, deg_fr2_place, MA_place, ME_place, F_reg_place, H_forall_place] = owanova(place, alpha);
disp(['Za grad je prihvacena hipoteza H', num2str(H_forall_place), ' na nivou poverenja ', num2str(gamma), '.'])
[t_reg_place, H_place] = lsd(place, alpha);

bmw = data(strcmp(data{:, 6}, 'BMW'), 2);
ford = data(strcmp(data{:, 6}, 'Ford'), 2);
gm = data(strcmp(data{:, 6}, 'GM'), 2);
company = [[bmw{:, :}; NaN; NaN] ford{:, :} [gm{:, :}; NaN; NaN; NaN; NaN]];
[SA_company, SE_company, deg_fr1_company, deg_fr2_company, MA_company, ME_company, F_reg_company, H_forall_company] = owanova(company, alpha);
disp(['Za kompaniju je prihvacena hipoteza H', num2str(H_forall_company), ' na nivou poverenja ', num2str(gamma), '.'])
[t_reg_company, H_company] = lsd(company, alpha);

nod = data(strcmp(data{:, 7}, 'No'), 2);
bachelor = data(strcmp(data{:, 7}, 'Bachelor'), 2);
master = data(strcmp(data{:, 7}, 'Master'), 2);
ad = [[nod{:, :}; NaN; NaN] [bachelor{:, :}; NaN] master{:, :}];
[SA_ad, SE_ad, deg_fr1_ad, deg_fr2_ad, MA_ad, ME_ad, F_reg_ad, H_forall_ad] = owanova(ad, alpha);
disp(['Za stepen strucne spreme je prihvacena hipoteza H', num2str(H_forall_ad), ' na nivou poverenja ', num2str(gamma), '.'])
[t_reg_ad, H_ad] = lsd(ad, alpha);
