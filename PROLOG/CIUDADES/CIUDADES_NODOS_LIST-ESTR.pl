%-----------------TALLER CONEXIÓN ENTRE CIUDADES DE CANADA.---------------------
%Definición de hechos, conexiones entre nodos
conexion_entre(vancouver, edmonton, 16).
conexion_entre(vancouver, calgary, 13).
conexion_entre(calgary, edmonton, 4).
conexion_entre(calgary, regina, 14).
conexion_entre(edmonton, saskatoon, 12).
conexion_entre(saskatoon, calgary,4).
conexion_entre(saskatoon, winnipeg, 20).
conexion_entre(regina, winnipeg, 4).
conexion_entre(regina, saskatoon, 7).

%Regla que evaluara si un nodo tiene o no aristas(conexiones)
tiene_aristas(Nodo) :- conexion_entre(Nodo, _, _).
tiene_aristas(Nodo) :- conexion_entre(_, Nodo, _).

%Regla que evaluara el costo para ir de una ciudad X a una Z
%pasando por Y
costo_de(NodoX, NodoZ, X) :- (conexion_entre(NodoX, NodoY, X1),
    conexion_entre(NodoY, NodoZ, X2)), (X is X1+X2).

%Regla que evaluara si es posible ir de edmonton a calgary
es_posible(NodoX, NodoY) :- costo_de(NodoX, NodoY, _).


% Regla que evaluará si existe una ruta entre dos ciudades, almacenando la ruta.
%caso base (dos ciudades tienen una conexión directa)
es_posible_con_ruta(NodoX, NodoZ, [NodoX, NodoZ]) :- 
    conexion_entre(NodoX, NodoZ, _).
es_posible_con_ruta(NodoX, NodoZ, [NodoX | Ruta]) :-
    conexion_entre(NodoX, NodoY, _),
    es_posible_con_ruta(NodoY, NodoZ, Ruta).

%Regla que evaluara si es posible ir de una ciudad a otra almacenando costo y su 
%ruta. caso base (dos ciudades tienen conexión directa por lo tanto hay un 
%unico costo)
es_posible_costo(NodoX, NodoZ,Costo, [NodoX , NodoZ]):-
    conexion_entre(NodoX, NodoZ, Costo).
es_posible_costo(NodoX, NodoZ,CostoTotal, [NodoX | Ruta]):-
    conexion_entre(NodoX, NodoY, Costo1),
    es_posible_costo(NodoY, NodoZ, Costo2, Ruta),
    CostoTotal is Costo1 + Costo2.

%---------------------Uso de estructuras------------------------------------------
% Definición de estructura de ciudad y sus conexiones
ciudad(vancouver, [conexion(edmonton, 16), conexion(calgary, 13)]).
ciudad(calgary, [conexion(edmonton, 4), conexion(regina, 14)]).
ciudad(edmonton, [conexion(saskatoon, 12)]).
ciudad(saskatoon, [conexion(calgary, 4), conexion(winnipeg, 20)]).
ciudad(regina, [conexion(winnipeg, 4), conexion(saskatoon, 7)]).

%Regla que evaluara la conexión entre dos ciudades
conexion_entre_estructura(Ciudad1, Ciudad2, Costo) :-
    ciudad(Ciudad1, Conexiones),
    %Evaluara si la conexion con Ciudad2 esta en la lista
    %de conexiones de Ciudad1
    member(conexion(Ciudad2, Costo), Conexiones).

%Regla que evaluara y nos dara las conexiones posibles

conexiones(Ciudad1, Conexiones):- 
    ciudad(Ciudad1, Conexiones).

%cabe destacar que las reglas definidas antes de definir las 
%estructuras funcionan de igual manera con las estructuras definidas
%y no lo hacen estrictamente con los hechos