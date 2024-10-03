%---------------TALLER 5 ESTUDIO--------------------------------

%-----------EJERCICIO 2.1--------------------
%Definir la relación maximo(+X, +Y, ?Z) para que Z sea el maximo de X y Y.


maximo(X, Y, X) :- X > Y.
maximo(X, Y, Y):- Y > X.

%-----------EJERCICIO 2.2--------------------
% Definir la relación factorial(+X, ?Y)
% que se verifique si Y es el factorial de X.

factorial(0, 1).
factorial(X, Y) :- 
    			X > 0,
    			X1 is X - 1,
    			factorial(X1, Y1),
    			Y is X * Y1.

%-----------EJERCICIO 2.3--------------------
%Definir la relación f(X, Y) de forma que:
%si x<3, entonces Y=0;
%si 3<=X<6, entonces Y=2;
%si 6<=X, entonces Y=4;

f(X, Y):- X < 3, Y = 0.
f(X, Y):- X < 6, Y = 2.
f(X, Y):- X >= 6, Y = 4.

%constuir el árbol de deducción correspondiente
%a la cuestión  ?-f(1, Y), 2 < Y.

/*f(1, Y)
   |
   v
Y = 0
   |
   v
2 < Y (falso) */


% 3. Definir la relación f_1(X, Y) con un corte
% después de las dos primeras cláusulas

f_1(X, Y):- X < 3, Y = 0, !.
f_1(X, Y):- X < 6, Y = 2, !.
f_1(X, Y):- X >= 6, Y = 4.


% 4. Construir el árbol de deducción para 
% ?- f_1(1, Y), 2 < Y.

/*f_1(1, Y)
   |
   v
Y = 0 (!)
   |
   v
2 < Y (falso)*/

 % 5. Construir el árbol de deducción correspondiente 
 % a la cuestión ?- f_1(7, Y).

/*f_1(7, Y)
   |
   v
Y = 4 */