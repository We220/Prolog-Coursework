% Generates the list from X = 2 to Y = 3. When X and Y are equal to 98 and 99 there cases are set and the program stops.
% Y is incremented by 1 until it is equal to 99.
% When Y is equal to 99 X is incremented by 1 and Y is reset to X + 2.



g_List(2,3,A,[[2,3,5,6]|A],_). 
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

remove_values([[_,_,_,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P2]|T],L,A) :- P1\=P2, remove_values([[X2,Y2,S2,P2],[X3,Y3,S3,P2]|T],L,A),!.

remove_values([[X1,Y1,S1,P1],[X2,Y2,S2,P1]|T],L,A) :- remove_values(T,[[X1,Y1,S1,P1],[X2,Y2,S2,P1]|L],A),!.

remove_values([[_,_,_,P1],[X2,Y2,S2,P2]|T],L,A) :- P1\=P2, remove_values([[X2,Y2,S2,P2]|T],L, A),!.

remove_values([[_,_,_,_]|T],L,A) :- remove_values(T,L,A),!.


correspond_sums([],A,A,B,B).
correspond_sums([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P1]|T],OL,A,SL,B) :- correspond_sums([[X2,Y2,S2,P1],[X3,Y3,S3,P1]|T],[[X1,Y1,S1,P1]|OL],A,SL,B),!.

correspond_sums([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P3]|T],OL,A,SL,B) :- P1\=P3, correspond_sums([[X3,Y3,S3,P3]|T],[[X1,Y1,S1,P1],[X2,Y2,S2,P1]|OL],A,SL,B),!.

correspond_sums([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]|T],OL,A,SL,B) :- P1\=P2,P2\=P3,P1\=P3, correspond_sums([[X3,Y3,S3,P3]|T],OL,A,[S1,S2|SL],B),!.

correspond_sums([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P2]|T],OL,A,SL,B) :- P1\=P2, correspond_sums([[X2,Y2,S2,P2],[X3,Y3,S3,P2]|T],OL,A,[S1|SL],B),!.

correspond_sums([[X1,Y1,S1,P1],[X2,Y2,S2,P1]|T],OL,A,SL,B) :- correspond_sums(T,[[X1,Y1,S1,P1],[X2,Y2,S2,P1]|OL],A,SL,B),!.

correspond_sums([[X1,Y1,S1,P1],[X2,Y2,S2,P2]|T],OL,A,SL,B) :- P1\=P2, correspond_sums([[X2,Y2,S2,P2]|T],OL,A,[S1|SL],B),!.

correspond_sums([[X1,Y1,S1,P1]|T],OL,A,SL,B) :- correspond_sums(T,OL,A,[S1|SL],B),!.


remove_dup_values([],A,A).
remove_dup_values([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P1]|T],L,A) :- remove_dup_values([[X2,Y2,S2,P1],[X3,Y3,S3,P1]|T],L,A),!.

remove_dup_values([[X1,Y1,S1,P1],[X2,Y2,S2,P1],[X3,Y3,S3,P3]|T],L,A) :- P1\=P3, remove_dup_values([[X3,Y3,S3,P3]|T], L,A),!.

remove_dup_values([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]|T],L,A) :- P1\=P2,P2\=P3,P1\=P3, remove_dup_values([[X3,Y3,S3,P3]|T],[[X1,Y1,S1,P1],[X2,Y2,S2,P2]|L],A),!.

remove_dup_values([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P2]|T],L,A) :- P1\=P2, remove_dup_values([[X2,Y2,S2,P2],[X3,Y3,S3,P2]|T],[[X1,Y1,S1,P1]|L],A),!.

remove_dup_values([[X1,Y1,S1,P1],[X2,Y2,S2,P1]|T],L,A) :- remove_dup_values(T,L,A),!.

remove_dup_values([[X1,Y1,S1,P1],[X2,Y2,S2,P2]|T],L,A) :- P1\=P2, remove_dup_values([[X2,Y2,S2,P2]|T],[[X1,Y1,S1,P1]|L], A),!.

remove_dup_values([[X1,Y1,S1,P1]|T],L,A) :- remove_dup_values(T,[[X1,Y1,S1,P1]|L],A),!.


remove_sum_dup_values([],A,A).
remove_sum_dup_values([[X1,Y1,S1,P1],[X2,Y2,S1,P2],[X3,Y3,S1,P3]|T],L,A) :- remove_sum_dup_values([[X2,Y2,S1,P2],[X3,Y3,S1,P3]|T],L,A),!.

remove_sum_dup_values([[X1,Y1,S1,P1],[X2,Y2,S1,P2],[X3,Y3,S3,P3]|T],L,A) :- S1\=S3, remove_sum_dup_values([[X3,Y3,S3,P3]|T], L,A),!.

remove_sum_dup_values([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S3,P3]|T],L,A) :- S1\=S2,S2\=S3,S1\=S3, remove_sum_dup_values([[X3,Y3,S3,P3]|T],[[X1,Y1,S1,P1],[X2,Y2,S2,P2]|L],A),!.

remove_sum_dup_values([[X1,Y1,S1,P1],[X2,Y2,S2,P2],[X3,Y3,S2,P3]|T],L,A) :- S1\=S2, remove_sum_dup_values([[X2,Y2,S2,P2],[X3,Y3,S2,P3]|T],[[X1,Y1,S1,P1]|L],A),!.

remove_sum_dup_values([[X1,Y1,S1,P1],[X2,Y2,S1,P2]|T],L,A) :- remove_sum_dup_values(T,L,A),!.

remove_sum_dup_values([[X1,Y1,S1,P1],[X2,Y2,S2,P2]|T],L,A) :- S1\=S2, remove_sum_dup_values([[X2,Y2,S2,P2]|T],[[X1,Y1,S1,P1]|L], A),!.

remove_sum_dup_values([[X1,Y1,S1,P1]|T],L,A) :- remove_sum_dup_values(T,[[X1,Y1,S1,P1]|L],A),!.


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
merge_sum([[X1,Y1,S1,P1]|AT], [[X2,Y2,S2,P2]|BT], [[X2,Y2,S2,P2]|T]) :- S1 > S2, merge_sum([[X1,Y1,S1,P1]|AT],BT,T).
merge_sum([S1|AT], [S2|BT], [S1|T]) :- S1 < S2, merge_sum(AT,[S2|BT],T).
merge_sum([S1|AT], [S2|BT], [S2|T]) :- S1 > S2, merge_sum([S1|AT],BT,T).
merge_sum([S1|AT], [S2|BT], [S2|T]) :- S1 == S2, merge_sum(AT,BT,T).


remove_sum_product([],L,L).
remove_sum_product(_,[],[]). 
remove_sum_product([H|T],[[X,Y,S,P]|ST],[[X,Y,S,P]|A]) :- S < H, remove_sum_product([H|T],ST,A),!.
remove_sum_product([H|T],[[X,Y,S,P]|ST],A) :- S = H, remove_sum_product([H|T],ST,A),!.
remove_sum_product([H|T],[[X,Y,S,P]|ST],A) :- S > H,  remove_sum_product(T,[[X,Y,S,P]|ST],A),!. 



s1(Q,A) :- 
Z is A - 2, 
g_List(2,Z,[],X,A),
merge_sort_product(X,Y),
remove_values(Y,[],Q),
write(B),nl.

s2(Q,A) :-
Z is A - 2, 
g_List(2,Z,[],X,A),
merge_sort_product(X,Y),
correspond_sums(Y,[],B,[],C),
merge_sort_sum(B,N),
merge_sort_sum(C,M),
remove_sum_product(M,N,Q).

s3(Q,A) :-
s2(Q2,A),
merge_sort_product(Q2,X),
remove_dup_values(X,[],Q).

s4(Q,A) :-
s3(Q3,A),
merge_sort_sum(Q3,X),
remove_sum_dup_values(X,[],Q).







