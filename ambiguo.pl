
%par(a,[0,1,0]).
%par(c,[0,1]).
%par(j,[0,0,1]).
%par(l,[1,0]).
%par(p,[0]).
%par(s,[1]).
%par(v,[1,0,1]).

%defenir ordem lexicografica para as letras


%concatenação
append([], List, List).
append([Head|Tail], List, [Head|Rest]) :- append(Tail, List, Rest).

%defenir ordem de comprimento das listas binarias
%comprimento
compr([], 0).
compr([_|T], X) :- compr(T, Y), X is Y+1.



%os dois topicos anteriores serão utilizados para resolver M e T1
%vamos checar todas as letras e os respetivos codigos binarios
%dizemos que a letra com menor valor lexicografico e maior comprimento binario
%será T1 e o respetivo codigo binario será M



lt(letter(_,V1),letter(_,V2)) :- V1 < V2.

%para descobrir as varias letras de T2, será necessário selecionar os 
% codigos binarios que sao subpartes de M, depois as respetivas letras serão T2

same([],[]).
same([H1|T1],[H2|T2]) :- H1=H2,T1=T2,same(T1,T2).

subcod([],[]).
subcod(1,[1]).
subcod(0,[0]).
subcod([H|T],R) :- subcod(H,R1),subcod(T,R2),append(R1,R2,R).



%subcod(T,_), append(R,  , subcod(H,_)).



%-----------------------------------main----------------------------
bin([0,1,0]).
bin([0,1]).

%cod((BIN,LETTER))) :- (BIN,LETTER).

%montar a BD
parIteration([]).
parIteration([(L,BIN)|T]) :- assertz(cod(L,BIN)), parIteration(T).

ambiguo(List, _, _, _) :- parIteration(List).

%procedimentos para determinar M,T1 e T2


