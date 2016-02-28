% Generates the list from X = 2 to Y = 3. When X and Y are equal to 98 and 99 there cases are set and the program stops.
% Y is incremented by 1 until it is equal to 99.
% When Y is equal to 99 X is incremented by 1 and Y is reset to X + 2.



g_List(2,3,A,[[2,3,5,6]|A],B). 
g_List(2,Y,L,A,B) :- Z is Y - 1, X is Z - 1, S is Y+2, P is Y*2, g_List(X,Z,[[2,Y,S,P]|L],A,B), 
                   !.
g_List(X,Y,L,A,B) :- X+Y > B, Z is X - 1 , g_List(Z,Y,L,A,B),
                   !.
g_List(X,Y,L,A,B) :- Z is X - 1, S is X+Y, P is X*Y, g_List(Z,Y,[[X,Y,S,P]|L],A,B).


% merge_sort_product(L, A)
% True if S is a sorted copy of L, using merge sort
merge_sort_product([], []).
merge_sort_product([X], [X]).
merge_sort_product([A,B|T], S) :- split_product([A,B|T],L1,L2), merge_sort_product(L1,L1T), merge_sort_product(L2,L2T), merge_product(L1T,L2T,S),!.
 
% split(LIST, L, R)
% Alternate elements of LIST in L and R
split_product([], [], []).
split_product([X], [X], []).
split_product([A,B|T], [A|AT], [B|BT]) :- split_product(T, AT, BT).
 
% merge(LS, RS, M)
% Assuming LS and RS are sorted, True if M is the sorted merge of the two
merge_product(A,[],A).
merge_product([],B,B) :- B\=[].
merge_product([[X1,Y1,S1,P1]|AT], [[X2,Y2,S2,P2]|BT], [[X1,Y1,S1,P1]|T]) :- P1 =< P2, merge_product(AT,[[X2,Y2,S2,P2]|BT],T).
merge_product([[X1,Y1,S1,P1]|AT], [[X2,Y2,S2,P2]|BT], [[X2,Y2,S2,P2]|T]) :- P1 > P2,  merge_product([[X1,Y1,S1,P1]|AT],BT,T).



remove_values([],A,A).
remove_values([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P1]|T],L,A) :- remove_values([[X2,Y2,S2,P1],[X3,Y3,S3,P1]|T],[[X1,Y1,S1,P1]|L],A),!.

remove_values([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P3]|T],L,A) :- P1\=P3, remove_values([[X3,Y3,S3,P3]|T], [[X1,Y1,S1,P1],[X2,Y2,S2,P1]|L],A),!.

remove_values([[_,_,_,P1],[_,_,_,P2],[X3,Y3,S3,P3]|T],L,A) :- P1\=P2,P2\=P3,P1\=P3, remove_values([[X3,Y3,S3,P3]|T],L,A),!.

remove_values([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P2]|T],L,A) :- P1\=P2, remove_values([[X2,Y2,S2,P2],[X3,Y3,S3,P2]|T],L,A),!.

remove_values([[X1,Y1,S1,P1],[X2,Y2,S2,P1]|T],L,A) :- remove_values(T,[[X1,Y1,S1,P1],[X2,Y2,S2,P1]|L],A),!.

remove_values([[_,_,_,P1],[X2,Y2,S2,P2]|T],L,A) :- P1\=P2, remove_values([[X2,Y2,S2,P2]|T],L, A),!.

remove_values([[X1,Y1,S1,P1]|T],L,A) :- remove_values(T,L,A),!.



s1(Q,A) :- 
Z is A - 2, 
g_List(2,Z,[],X,A),
merge_sort_product(X,Y),
remove_values(Y,[],Q). 


% merge_sort_sum(L, A)
% True if S is a sorted copy of L, using merge sort
merge_sort_sum([], []).
merge_sort_sum([X], [X]).
merge_sort_sum([A,B|T], S) :- split_sum([A,B|T],L1,L2), merge_sort_sum(L1,L1T), merge_sort_sum(L2,L2T), merge_sum(L1T,L2T,S),!.
 
% split(LIST, L, R)
% Alternate elements of LIST in L and R
split_sum([], [], []).
split_sum([X], [X], []).
split_sum([A,B|T], [A|AT], [B|BT]) :- split_sum(T, AT, BT).
 
% merge(LS, RS, M)
% Assuming LS and RS are sorted, True if M is the sorted merge of the two
merge_sum(A,[],A).
merge_sum([],B,B) :- B\=[].
merge_sum([[X1,Y1,S1,P1]|AT], [[X2,Y2,S2,P2]|BT], [[X1,Y1,S1,P1]|T]) :- S1 =< S2, merge_sum(AT,[[X2,Y2,S2,P2]|BT],T).
merge_sum([[X1,Y1,S1,P1]|AT], [[X2,Y2,S2,P2]|BT], [[X2,Y2,S2,P2]|T]) :- S1 > S2,  merge_sum([[X1,Y1,S1,P1]|AT],BT,T).







run() :-
g_List(2,98,[],X,100),
merge_sort_product(X,Y),
remove_values(Y,[],Z),
merge_sort_sum(Z,A),
write(A), nl.




