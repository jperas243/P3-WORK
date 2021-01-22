

%concatenação
append([], List, List).
append([Head|Tail], List, [Head|Rest]) :- append(Tail, List, Rest).

prefixo([], _).
prefixo([X|A], [X|B]) :- prefixo(A, B).

sufixo(A, A).
sufixo(A, [_|B]) :- sufixo(A, B).

sublista(S, L) :- prefixo(P, L), sufixo(S, P).

%defenir ordem de comprimento das listas binarias
%comprimento
compr([], 0).
compr([_|T], X) :- compr(T, Y), X is Y+1.

%lessThan([],_). 
%lessThan([H1|T1],[H2|T2]) :- lessThan(T1,T2).

lessThanEqual([],S) :- S >= 0.
lessThanEqual([H1|T1],S) :- X = S - 1, lessThanEqual(T1,X).

count(_, [], 0).
count(X, [X | T], N) :- !, count(X, T, N1), N is N1 + 1.
count(X, [_ | T], N) :- count(X, T, N).


%os dois topicos anteriores serão utilizados para resolver M e T1
%vamos checar todas as letras e os respetivos codigos binarios
%dizemos que a letra com menor valor lexicografico e maior comprimento binario
%será T1 e o respetivo codigo binario será M

letter(A) :- cod(A,_).
bin(B) :- cod(_,B).


%para descobrir as varias letras de T2, será necessário selecionar os 
% codigos binarios que sao subpartes de M, depois as respetivas letras serão T2

same([],[]).
same([H1|T1],[H2|T2]) :- H1=H2,T1=T2,same(T1,T2).



%-----------------------------------main----------------------------


%montar a BD
bdMount([]).
bdMount([(L,BIN)|T]) :- assertz(cod(L,BIN)), bdMount(T).

letter(A) :- cod(A,_).
bin(B) :- cod(_,B).


%procedimento para gerar as combinações possiveis
codList([A],B) :-  cod(A,B).
%codList([H1|T1],R) :- lessThanEqual([H1|T1],3),!.
codList([H1|T1],R) :- cod(H1,B),codList(T1,R1),append(R1,B,R).%lessThanEqual([H1|T1],3).






wordLetters(0,[]).
%wordLetters(S,[H1|T1]) :- \+ lessThanEqual([H1|T1],S).
%wordLetters([H1|T1]) :- letter(H1),count(H1,[H1|T1],X), X >= 3,!.
%wordLetters([H1|T1]) :- letter(H1),lessThanEqual([H1|T1],1),!.
wordLetters(S,[H1|T1]) :- letter(H1),X is S - 1,wordLetters(X ,T1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%get(A,B) :- codList(A,B).

%findBin(S,R) :- findall(compr(S,B), codList(A,B),R).

sameBin(S,A1,A2,B2) :- codList(A1,B1),codList(A2,B2),\+ same(A1,A2),same(B1,B2).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





ambiguo(List, _, _, _) :- \+ compr(List, 0),bdMount(List). 

