
par(a,[0,1,0]).
par(c,[0,1]).
par(j,[0,0,1]).
par(l,[1,0]).
par(p,[0]).
par(s,[1]).
par(a,[1,0,1]).


%concatenação
append([], List, List).
append([Head|Tail], List, [Head|Rest]) :- append(Tail, List, Rest).

%comprimento
compr([], 0).
compr([_|T], X) :- compr(T, Y), X is Y+1.

%convertToList([], List, List).

%lengthOfCode()

%findall(PADRÃO, GERADOR, SOLUÇÕES)


%ambiguo([[LETRA|par]],M, T1, T2) :- 




%se
%ambiguo([],).

%ambiguo(
%    [(a, [0,1,0]),
%    
%    (c, [0,1]),
%
%   (j, [0,0,1]),
%
%   (l, [1,0]),
%
%   (p, [0]),
%
%   (s, [1]),
%
%   (v, [1,0,1])], 
%   
%   M, T1, T2). 
%
%    :-
