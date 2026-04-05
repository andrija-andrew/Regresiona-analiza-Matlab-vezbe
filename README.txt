Rešeni zadaci sa vežbi (i predavanja) iz predmeta Regresiona analiza
od školske 2022/2023 godine.

Zadaci.pdf - tekstovi zadataka sa vežbi.

Rešenja pokrivaju ono što je rađeno na vežbama (i predavanjima),
ali ne i kompletna rešenja svih zadataka iz fajla Zadaci.pdf.

Zadaci sa vežbi iz linearne i nelinearne regresije su rešeni u fajlovima zad1**.m,
a iz analize varijanse (ANOVA) u fajlovima zad2**.m, gde je ** broj zadatka i eventualno sufiks.

Prvi zadatak iz ANOVE je urađen i bez korišćenja funkcija u fajlu zad201_bez_funkcija.m.

Fajl crop.data.xlsx je zamenjen sa crop.data.csv, jer prvi ne može dobro da se učita.

Šesti zadatak iz ANOVE je urađen na dva načina. Prva verzija, zad206Se.m, je urađena prema predavanjima/vežbama,
tj. tako da model ne sadrži gamma_ij kad se odbaci hipoteza H0(svi gamma_ij = 0), na nivou poverenja 0.95.
Druga verzija, zad206Sw.m, je urađena tako da model sadrži gamma_ij.

Peti zadatak iz ANOVE (nakon pokretanja odgovarajuće skripte) može da se proveri u komandnom prozoru pomoću
anova2(data, s);
(primetiti da model ugrađene funkcije anova2 sadrži gamma_ij za s >= 2),
a šesti zadatak iz ANOVE sa
anovan(yield, {fert, dens});
za prvu verziju, i
anovan(yield, {fert, dens}, 'model', 'interaction');
za drugu. Alternativno, oba zadatka mogu da se provere pomoću one-hot encoding-a za svaku nezavisnu promenljivu
i linearne regresije (sa odsečkom) gde se (ako je potrebno) interakcija između dve promenljive modelira kao konjukcija,
odnosno proizvod, svih kombinacija parova one-hot encoding-a te dve promenljive. U tom slučaju se za testiranje hipoteza
koristi F-test za celu grupu onih one-hot encoding promenljivih koje su dobijene na osnovu jedne nezavisne promenljive
(gde se interakcija između dve nezavisne promenljive posmatra kao zasebna nezavisna promenljiva).

Skripte u Matlabu koriste sledeće funkcije:
lreg.m - linearna regresija,
owanova.m - one-way ANOVA,
lsd.m - Fišerov LSD test.

Funkcija lreg za ulaz uzima matricu x čije su kolone uzorak prediktora
i vektor-kolonu y (sa istim brojem redova) uzorka onog što treba da se predvidi.
Kao izlaz vraća vektor-kolonu ocena parametara beta_hat (koji odgovaraju kolonama matrice x),
predikcije y_hat, i neobjašnjenu sumu kvadrata RSS, tj. sumu kvadrata reziduala.
Na primer, za
[beta_hat, y_hat, RSS] = lreg([x2 ones(n, 1) x5], y);
gde su x2 i x5 vektori-kolone uzorka prediktora,
y vektor-kolona uzorka onog što se predviđa,
i n veličina uzorka (tj. broj redova vektora-kolone x2, x5, ili y),
dobijamo vektor-kolonu ocena parametara beta_hat,
gde beta_hat(1) ide uz x2, beta_hat(2) je slobodan član (intercept), i beta_hat(3) ide uz x5,
y_hat su predikcije za y na ravni beta_hat(1) * x2 + beta_hat(2) + beta_hat(3) * x5,
i RSS je suma kvadrata reziduala.

Funkcija owanova za ulaz uzima matricu u kojoj su nezavisni uzorci dati po KOLONAMA, i nivo značajnosti alpha.
Uzorci ne moraju biti iste veličine (prazna mesta u matrici trebaju da budu NaN).
Ova funkcija kao izlaz vraća elemente iz standardne tabele za jednofaktorsku analizu varijanse,
sa jedinom razlikom da umesto p-vrednosti vraća broj prihvaćene hipoteze.
Preciznije, izlaz čine SA, SE, deg_fr1, deg_fr2, MA, ME, F_reg - registovana vrednost na F testu,
i H_forall - ili 0 ili 1, u zavisnosti od toga koja hipoteza je prihvaćena, 0 za nultu hipotezu, a 1 za alternativnu.
Za primer videti zad201.m.

Funkcija lsd uzima isti ulaz (na isti način) kao i funkcija owanova.
Kao prvi izlaz vraća matricu t_reg sa registrovanim vrednostima na t-testu,
gde je t_reg(i, j) registrovana vrednost za par (i, j), 1 <= i, j <= k, k - broj kolona,
dok je drugi izlaz matrica H, istih dimenzija kao matrica t_reg, koja na mestu H(i, j) sadrži ili 0 ili 1,
u zavisnosti od toga koja hipoteza je prihvaćena, 0 za nultu hipotezu, a 1 za alternativnu, sve to za iste i i j.
Za primer videti zad201.m.

U folderu dodatak se nalaze dva primera nelinearne regresije
urađena pomoću funkcije koja ne zahteva ručno traženje izvoda.

Matlab skripte u tom folderu koriste sledeće funkcije:
gn.m - Gaus-Njutnov postupak,
lreg.m - linearna regresija (ista kao funkcija navedena iznad).

Funkcija gn za ulaz uzima uzorak zavisne promenljive,
funkciju po koeficijentima koje želimo da ocenimo i čije su konstante uzorak nezavisnih promenljivih dat po kolonama,
vektor-kolonu za početak iterativnog postupka, korak za numeričku aproksimaciju parcijalnih izvoda u Jakobijanu,
maksimalan broj iteracija i broj za uslov zaustavljanja, respektivno.
Numerički postupak koji ova funkcija koristi za aproksimaciju parcijalnih izvoda se naziva
diferenciranje kompleksnim korakom (eng. Complex Step Differentiation).
Algoritam se zaustavlja pre nego što dostigne maksimalan broj iteracija ako je euklidska norma vektora-kolone
koji se oduzima u Gaus-Njutnovom postupku (strogo) manja od broja za uslov zaustavljanja
ili ona ne može da se izračuna (daje vrednost NaN).
Izlaz ove funkcije čine vektor-kolona ocena koeficijenata, broj iteracija,
vektor-kolona ocena uzorka zavisne promenljive i suma kvadrata reziduala, tim redom.
Za primer videti nelinearna_regresija_01.m (u folderu dodatak).