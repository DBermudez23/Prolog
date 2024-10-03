%Definición de hechos
es_hombre(abraham).
es_hombre(clancy).
es_hombre(herbert).
es_hombre(homero).
es_hombre(bart).

es_mujer(mona).
es_mujer(jacqueline).
es_mujer(marge).
es_mujer(patty).
es_mujer(selma).
es_mujer(maggie).
es_mujer(lisa).
es_mujer(ling).

es_madre(mona, herbert).
es_madre(mona, homero).
es_madre(jacqueline, marge).
es_madre(jacqueline, patty).
es_madre(jacqueline, selma).
es_madre(marge, lisa).
es_madre(marge, maggie).
es_madre(marge, bart).
es_madre(selma, ling).

es_padre(abraham, herbert).
es_padre(abraham, homero).
es_padre(clancy, marge).
es_padre(clancy, patty).
es_padre(clancy, selma).
es_padre(homero, bart).
es_padre(homero, lisa).
es_padre(homero, maggie).


%Definición de reglas simples
abuela_de(Abuela, Nieto):- (es_madre(Abuela, Madre), es_madre(Madre, Nieto)); (es_madre(Abuela, Padre),
                           es_padre(Padre, Nieto)).
abuelo_de(Abuelo, Nieto):- (es_padre(Abuelo, Madre), es_madre(Madre, Nieto)); (es_padre(Abuelo, Padre), 
                           es_padre(Padre, Nieto)).

hermano_de(Hijo1, Hijo2):- (es_madre(Madre, Hijo1), es_madre(Madre, Hijo2) , es_hombre(Hijo1));
    						(es_padre(Padre, Hijo1), es_padre(Padre, Hijo2), es_hombre(Hijo1)).

hermana_de(Hijo1, Hijo2):- (es_madre(Madre, Hijo1), es_madre(Madre, Hijo2) , es_mujer(Hijo1));
    						(es_padre(Padre, Hijo1), es_padre(Padre, Hijo2), es_mujer(Hijo1)).

primo_de(Primo1, Primo2):- (es_padre(Abuelo, Madre1), es_padre(Abuelo, Madre2), es_hombre(Primo1)),
    						(es_madre(Madre1, Primo1), es_madre(Madre2, Primo2)).

prima_de(Primo1, Primo2):- (es_padre(Abuelo, Madre1), es_padre(Abuelo, Madre2), es_mujer(Primo1)),
    						(es_madre(Madre1, Primo1), es_madre(Madre2, Primo2)).

tio_de(Tio, Sobrino1):- (es_padre(Abuelo, Padre1), es_padre(Abuelo, Tio), es_hombre(Tio)),
    					(es_padre(Padre1, Sobrino1)).


tia_de(Tia, Sobrino1):- (es_padre(Abuelo, Madre1), es_padre(Abuelo, Tia), es_mujer(Tia)),
    					(es_madre(Madre1, Sobrino1)).

%Definición de reglas recursivas

%caso base para abuela
abuela_recursiva_de(Abuela, Nieto) :-
    es_madre(Abuela, PadreMadre),
    (es_madre(PadreMadre, Nieto); es_padre(PadreMadre, Nieto)).

abuela_recursiva_de(Abuela, Nieto) :-
    es_madre(Abuela, Antecesor),
    (es_madre(Antecesor, PadreMadre); es_padre(Antecesor, PadreMadre)),
    (es_madre(PadreMadre, Nieto); es_padre(PadreMadre, Nieto)).

%caso base para abuelo
abuelo_recursivo_de(Abuelo, Nieto) :-
    es_padre(Abuelo, PadreMadre),
    (es_madre(PadreMadre, Nieto); es_padre(PadreMadre, Nieto)).

abuelo_recursivo_de(Abuelo, Nieto) :-
    es_padre(Abuelo, Antecesor),
    (es_madre(Antecesor, PadreMadre); es_padre(Antecesor, PadreMadre)),
    (es_madre(PadreMadre, Nieto); es_padre(PadreMadre, Nieto)).

%caso base para hermano
hermano_recursivo_de(Hijo1, Hijo2) :-
    es_hombre(Hijo1),
    (es_madre(Madre, Hijo1), es_madre(Madre, Hijo2));
    (es_padre(Padre, Hijo1), es_padre(Padre, Hijo2)).

hermano_recursivo_de(Hijo1, Hijo2) :-
    hermano_de(Hijo1, Intermedio),
    hermano_de(Intermedio, Hijo2).

%caso base para hermana
hermana_recursiva_de(Hijo1, Hijo2) :-
    es_mujer(Hijo1),
    (es_madre(Madre, Hijo1), es_madre(Madre, Hijo2));
    (es_padre(Padre, Hijo1), es_padre(Padre, Hijo2)).

hermana_recursiva_de(Hijo1, Hijo2) :-
    hermana_de(Hijo1, Intermedio),
    hermana_de(Intermedio, Hijo2).

%caso base para primo
primo_recursivo_de(Primo1, Primo2) :-
    es_hombre(Primo1),
    (es_padre(Abuelo, Madre1), es_padre(Abuelo, Madre2)),
    es_madre(Madre1, Primo1),
    es_madre(Madre2, Primo2).

primo_recursivo_de(Primo1, Primo2) :-
    primo_de(Primo1, Intermedio),
    primo_de(Intermedio, Primo2).

%caso base para prima
prima_recursiva_de(Primo1, Primo2) :-
    es_mujer(Primo1),
    (es_padre(Abuelo, Madre1), es_padre(Abuelo, Madre2)),
    es_madre(Madre1, Primo1),
    es_madre(Madre2, Primo2).

prima_recursiva_de(Primo1, Primo2) :-
    prima_de(Primo1, Intermedio),
    prima_de(Intermedio, Primo2).

%caso base para tio
tio_recursivo_de(Tio, Sobrino1) :-
    es_hombre(Tio),
    es_padre(Abuelo, Padre1),
    es_padre(Abuelo, Tio),
    es_padre(Padre1, Sobrino1).

tio_recursivo_de(Tio, Sobrino1) :-
    tio_de(Tio, Intermedio),
    tio_de(Intermedio, Sobrino1).

%caso base para tia
tia_recursiva_de(Tia, Sobrino1) :-
    es_mujer(Tia),
    es_padre(Abuelo, Madre1),
    es_padre(Abuelo, Tia),
    es_madre(Madre1, Sobrino1).

tia_recursiva_de(Tia, Sobrino1) :-
    tia_de(Tia, Intermedio),
    tia_de(Intermedio, Sobrino1).

%--------------------Uso de listas --------------------------------

%Listas para agrupar hombres y mujeres
hombres([abraham, clancy, herbert, homero, bart]).
mujeres([mona, jacqueline, marge, patty, selma, maggie, lisa, ling]).

%Reglas que verifican el genero de una persona evaluando
%si pertenece a la lista antes definida
es_hombre_regla(Persona) :- hombres(Hombres), member(Persona, Hombres).
es_mujer_regla(Persona) :- mujeres(Mujeres), member(Persona, Mujeres).

%este regla verifica y almacena los ancestros de cualquier persona a evaluar
%es una lista recursiva que evalua si la persona a evaluar tiene padre o madre
%definidos y lo almacena como la cabeza de la lista si lo hay y sigue evaluando
%si el padre o madre tiene ancestros y lo almacena en la cola, el caso base es
%cuando la persona no tiene ancestros definidos.
ancestros_de(Persona, [PadreMadre | Ancestros]) :-
    (es_padre(PadreMadre, Persona); es_madre(PadreMadre, Persona)),
    ancestros_de(PadreMadre, Ancestros).
ancestros_de(_, []).

%regla que almacenara los hermanos en una lista si los hay
hermanos_de(Persona, Hermanos) :-
    findall(Hermano, hermano_de(Persona, Hermano), Hermanos).



                   		

