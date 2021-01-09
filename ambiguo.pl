
%par(a,[0,1,0]).
%par(c,[0,1]).
%par(j,[0,0,1]).
%par(l,[1,0]).
%par(p,[0]).
%par(s,[1]).
%par(v,[1,0,1]).

%gerar combinação de palavras


%concatenação
append([], List, List).
append([Head|Tail], List, [Head|Rest]) :- append(Tail, List, Rest).

prefixo([], _).
prefixo([X|A], [X|B]) :- prefixo(A, B).

sufixo(A, A).
sufixo(A, [_|B]) :- sufixo(A, B).

sublista(S, L) :- prefixo(P, L), sufixo(S, P).

catena([], L, L).
catena([X|Xs], L, [X|Y]) :- catena(Xs, L, Y).




%defenir ordem de comprimento das listas binarias
%comprimento
compr([], 0).
compr([_|T], X) :- compr(T, Y), X is Y+1.



%os dois topicos anteriores serão utilizados para resolver M e T1
%vamos checar todas as letras e os respetivos codigos binarios
%dizemos que a letra com menor valor lexicografico e maior comprimento binario
%será T1 e o respetivo codigo binario será M




%para descobrir as varias letras de T2, será necessário selecionar os 
% codigos binarios que sao subpartes de M, depois as respetivas letras serão T2

same([],[]).
same([H1|T1],[H2|T2]) :- H1=H2,T1=T2,same(T1,T2).







%-----------------------------------main----------------------------


%montar a BD
bdMount([]).
bdMount([(L,BIN)|T]) :- assertz(cod(L,BIN)), bdMount(T).






codList([A],B) :-  cod(A,B).
codList([H1|T1],R) :-  cod(H1,B),codList(T1,R1),append(R1,B,R).







letter(A) :- cod(A,_).
bin(B) :- cod(_,B).

ambiguo(List, _, _, _) :- \+ compr(List, 0),bdMount(List). 

%, combinations(List,Words,Binary).

%procedimentos para gerar as combinações possiveis

%makeList(L,R) :- 

