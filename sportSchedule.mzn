int: n; %numero de equipos
int: Min;
int: Max;
array[1..n, 1..n] of int: D; %matriz de distancias
int: dates;
var int: consecutiveNegatives = 0;
dates = 2*(n-1);

array[1..dates, 1..n] of var int: PF;

constraint forall(i in 1..dates) (forall(j in 1..n) (PF[i,j] >= -n /\ PF[i,j] <= n /\ PF[i,j] != 0)); % las variables de desicion podran tomar valores desde 1 hasta n tanto positivos como negativos.

constraint forall(i in 1..dates-1) (forall(j in 1..n) (abs(PF[i,j]) != abs(PF[i+1,j]))); % no pueden haber dos partidos iguales consecutivamente

constraint forall(j in 1..n) (sum(i in 1..n)(PF[i,j] < 0) <= Max /\ sum(i in 1..n)(PF[i,j] < 0) >= Min); % un equipo puede estar de gira o en permanencia con un tamaño de Min a Max (ESTA RESTRICCION NO SIRVE, FALTA IMPLEMENTAR)

constraint forall(j in 1..n) (sum(i in 1..n)(PF[i,j] < 0) == n-1 /\ sum(i in 1..n)(PF[i,j] > 0) == n-1); % un equipo debe jugar de local y de visitante la misma cantidad de veces

constraint forall(j in 1..n) (forall(i1, i2 in 1..dates where i1<i2) (PF[i1,j] != PF[i2, j]) ) ; % un equipo se enfrenta contra otro solo una vez de ida y una vez de vuelta.
constraint forall(i in 1..n) (forall(j1, j2 in 1..n where j1<j2) (PF[i,j1] != PF[i, j2]) ) ; % no pueden haber dos partidos iguales en una misma fecha


solve satisfy;

output["Test = \(PF[1,2])"];