append([], List, List).
append([Head|Tail], List, [Head|Rest]) :- append(Tail, List, Rest).

prefixo([], _).
prefixo([X|A], [X|B]) :- prefixo(A, B).

sufixo(A, A).
sufixo(A, [_|B]) :- sufixo(A, B).

sublista(S, L) :- prefixo(P, L), sufixo(S, P).

compr([], 0).
compr([_|T], X) :- compr(T, Y), X is Y+1.

bdMount([]).
bdMount([(L,BIN)|T]) :- assertz(cod(L,BIN)), bdMount(T).

append([], List, List).
append([Head|Tail], List, [Head|Rest]) :- append(Tail, List, Rest).

letter(A) :- cod(A,_).
bin(B) :- cod(_,B).

ambiguo(List, _, _, _) :- \+ compr(List, 0),bdMount(List). 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%letterToList(R) :- 


wordBin(0, []).
wordBin(N, [C|W]) :-
    N > 0,
    N1 is N-1,
    cod(C,_),
    wordBin(N1,W).


deCode(A,R) :- deCode(A,[],R).
deCode([],List,List).
deCode([H1|T1],List,R) :- 
    
    cod(H1,H2),
    deCode(T1,List,R1),
    append(H2,R1,R).


wordsLessThan(S,R) :- wordsLessThan(S,0,[],R).
wordsLessThan(S,S,List,List).
wordsLessThan(S,Count,List,R) :-  
        
        Count < S,
        N1 is Count+1,
        wordList(N1,R1),
        wordsLessThan(S,N1,List,R2),
        append(R1,R2,R).

wordList(S,R) :-  findall(X,wordBin(S,X),R).



subListOf(List,M) :- findall(X,sublista(X,List),M).


%codeTo(Words,Bin,R) :- codeTo(Words,Bin,[],R)
%codeTo([],[],Words).

codeTo(Bin,R) :- subListOf(Bin,M), member(SubBin,M), findall(L,cod(L,SubBin),R).
