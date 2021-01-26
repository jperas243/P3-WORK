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

same([],[]).
same([H1|T1],[H2|T2]) :- H1=H2,T1=T2,same(T1,T2).

lessThanEqual([],S) :- S >= 0.
lessThanEqual([H1|T1],S) :- X = S - 1, lessThanEqual(T1,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%letterToList(R) :- 


wordBin(0, []).
wordBin(N, [C|W]) :-
    N > 0,
    N1 is N-1,
    cod(C,_),
    wordBin(N1,W).


wordBinaries(S,Z,A,B) :- words(S,A),deCode(A,B),lessThanEqual(B,Z).
findAmbigous(S,Z,A1,A2,B2) :- wordBinaries(S,Z,A1,B1),wordBinaries(S,Z,A2,B2),\+ same(A1,A2),isSubBinarieOf(B1,B2),\+ isSubWordOf(A1,A2),!.

subWords(S,Z,A1,A2,B2) :- wordBinaries(S,Z,A1,B1),wordBinaries(S,Z,A2,B2),\+ same(A1,A2),isSubBinarieOf(B1,B2),\+ isSubWordOf(A1,A2).
result(C,L,M) :- findAmbigous(3,18,_,C,M), findall(Y,subWords(3,18,Y,C,_),L).

isSubBinarieOf(B1,B2) :- findall(X,sublista(X,B2),R),member(B1,R).
isSubWordOf(A1,A2) :- findall(X,sublista(X,A2),R),member(X,R),same(X,A1).


wordBinariesLessThan(S,Z,A,B) :- wordBinariesLessThan(S,Z,0,A,B).
wordBinariesLessThan(_,Z,Z,[],[]).
wordBinariesLessThan(S,Z,Count,A,B) :- 

                wordBinaries(S,Z,A,B),
                N1 is Count+1,
                Z1 is Z+1,
                wordBinariesLessThan(S,Z1,N1,_,_).



wordsLessThan(S,R) :- wordsLessThan(S,0,[],R).
wordsLessThan(S,S,List,List).
wordsLessThan(S,Count,List,R) :-  
        
        Count < S,
        N1 is Count+1,
        wordList(N1,R1),
        wordsLessThan(S,N1,List,R2),
        append(R1,R2,R).

wordList(S,R) :-  findall(X,wordBin(S,X),R).
words(S,A) :- wordsLessThan(S,R), member(A,R).



deCode(A,R) :- deCode(A,[],R).
deCode([],List,List).
deCode([H1|T1],List,R) :- 
    
    cod(H1,H2),
    deCode(T1,List,R1),
    append(H2,R1,R).





























subListOf(List,M) :- findall(X,sublista(X,List),M).


codeToList(Words,Bin,R) :- subListOf(Bin,SubBins),codeTo(Words,SubBins,[],R).

codeTo([],_,List,List).
codeTo([H1,T1],SubBins,List,R) :- 
        
        deCode(H1,B1),
        member(B1,SubBins),
        append(R1,H1,R),
        codeTo(T1,SubBins,List,R1).

giveMeTheSauce(S,R) :- wordsLessThan(S,Words),codeToList(Words,[0,1],R).

%codeTo(Bin,L) :- subListOf(Bin,M), member(SubBin,M), cod(L,SubBin).
