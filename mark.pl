/* This Prolog program marks CM20214/221 2015/16 CW2 as specified in <http://www.cs.bath.ac.uk/ag/CM20214-20221/CM20214-21-CW2-2016.pdf>

v1.03 Alessio Guglielmi (University of Bath) 22 February 2016

Instructions:

1) Put the file mark.pl in the same directory as your solution Prolog program, which we suppose is called abc12.pl (where abc12 is your BUCS id).

2) Run SWI-Prolog in that directory and do:

   ?- consult(mark).
   ?- mark('abc12.pl').

The result should be the grade for your solution and an explanation.

If Prolog loops or crashes, the most likely cause is the presence of an infinite number of answers. In that case a manual grading will be performed and marks will be subtracted as specified in the coursework specification.

Tip: if you want to check whether a query, say ?- s2(Q,100), admits multiple answers, just perform

   ?- findall(Q,s2(Q,100),L), length(L,N).

If the answer for N is different from 1 (including Prolog looping) then there are multiple answers.

This is an example run on a correct program with a good but not spectacular efficiency in finding the solutions:

   ?- mark('abc12.pl').
   % abc12.pl compiled 0.00 sec, 56 clauses
   Task 1 is solved correctly and with no multiple answers.
   Task 2 is solved correctly and with no multiple answers.
   Task 3 is solved correctly and with no multiple answers.
   Task 4 is solved correctly and with no multiple answers.
   Task 4 requires 359701 inferences.
   Task 5 is solved correctly and with no multiple answers.
   Task 5 requires 78818869 inferences.
   The grades for tasks 1 to 5 are: 20 + 20 + 20 + 7 + 5 = 72.
   *** Found built-in not(.
   Because of built-ins the grade is 72 - 20 = 52.
   The penalty for multiple answers is 0.
   The final grade is therefore 52.
   The marker will inspect the program for soundness and fairness and might    change the grade.
   -id:abc12.pl-t4:359701-t5:78818869-BI:1-MG:52-
   true.

Please note that I reserve the right to add other built-ins to the list contained in this program. In fact, the specification tells you exactly what you can use, all the rest you can't! There simply are too many possibilities for me to list them all in this program.

Further tips:

1) To run SWI-Prolog with more memory than the default, use something like

   swipl -G32g -L32g

on the command line.

2) Use the following to get unabbreviated answers (for lists of quadruples especially):

   ?- set_prolog_flag(answer_write_options,[quoted(true), portray(true)]).

A final recommendation: please make sure that your program does not write anything to the display (in other words, don't use write/1 and similar and take care of all the warnings, such as for singleton variables). This is so that there is no interference with the marking program's output.                   */

mark(X) :- consult(X),
           string_codes(X,C), string_codes('.res',D), append(C,D,E), 
           string_codes(Y,E),
           open(Y,write,IX), write(IX,''), close(IX),
           asserta(fileid(Y) :- !),
           check1(M1,Mul1),
           check2(M2,Mul2),
           check3(M3,Mul3),
           check4(M4,Mul4,I4),
           check5(M5,Mul5,I5),
           M is M1 + M2 + M3 + M4 + M5,
           mywrite([
           'The grades for tasks 1 to 5 are: ',M1,' + ',
                                               M2,' + ',
                                               M3,' + ',
                                               M4,' + ',
                                               M5,' = ',
                                               M ,'.\n']),
           readfiletocodes(X,XC),
           string_codes(XC,XS),
           built-ins(BL),
           find_built_ins(BL,XS,F),
           grade_after_built_ins(M,F,Grade),
           penalty(Mul1,Mul2,Mul3,Mul4,Mul5,Grade,Pen),
           mywrite(['The penalty for multiple answers is ',Pen,'.\n']),
           Final is Grade - Pen,
           mywrite(['The final grade is therefore ',Final,'.\n']),
           mywrite([
           'The marker will inspect the program for soundness and fairness '
           ,'and might change the grade.\n',
           '-id:',X,'-t4:',I4,'-t5:',I5,'-BI:',F,'-MG:',Grade,'-\n']).

f(X,Y) :- Y is min(18,(12500/X^0.45)).

built-ins(['->',
           'abolish(',
           'apply(',
           'assert(',
           'asserta(',
           'assertz(',
           'bagof(',
           'call_cleanup(',
           'call_with_depth_limit(',
           'call_with_inference_limit(',
           'call(',
           'copy_predicate_clauses(',
           'erase(',
           'findall(',
           'findnsols(',
           'forall(',
           'ignore(',
           'instance(',
           'not(',
           'once(',
           'recorda(',
           'recorded(',
           'recordz(',
           'redefine_system_predicate(',
           'retract(',
           'retractall(',
           'setof(',
           'setup_call_cleanup(',
           '\\+']).

find_built_ins([   ], _,0) :- !.
find_built_ins([B|R],XS,F) :- sub_string(exact,B,XS),
                              !,
                              mywrite(['*** Found built-in ',B,'.\n']),
                              find_built_ins(R,XS,G),
                              F is G + 1.
find_built_ins([_|R],XS,F) :- find_built_ins(R,XS,F).

grade_after_built_ins(M,0,M    ) :- !, 
                                    mywrite(['No built-ins found.\n']).
grade_after_built_ins(M,_,Grade) :- Grade is max(0,M - 20),
       mywrite(['Because of built-ins the grade is ',M,' - 20 = ',Grade,'.\n']).

load(X) :- retract(count(_)), !,
           assert(fact(X)),
           fail.
load(_).

check1(M1,Mul1) :- current_predicate(s1/2),
                   !,
                   findtwo(1,LQ1),
                   length(LQ1,S1),
                   [Q1|_] = LQ1,
                   length(Q1,L1),
                   marks1(L1,S1,M1,Mul1).
check1( 0,   0) :-
     mywrite(['Task 1 is not solved because predicate s1/2 does not exist.\n']).

check2(M2,Mul2) :- current_predicate(s2/2),
                   !,
                   findtwo(2,LQ2),
                   length(LQ2,S2),
                   [Q2|_] = LQ2,
                   length(Q2,L2),
                   marks2(L2,S2,M2,Mul2).
check2( 0,   0) :-
     mywrite(['Task 2 is not solved because predicate s2/2 does not exist.\n']).

check3(M3,Mul3) :- current_predicate(s3/2),
                   !,
                   findtwo(3,LQ3),
                   length(LQ3,S3),
                   [Q3|_] = LQ3,
                   length(Q3,L3),
                   marks3(L3,S3,M3,Mul3).
check3( 0,   0) :-
     mywrite(['Task 3 is not solved because predicate s3/2 does not exist.\n']).

check4inf(I4) :- statistics(inferences,B4),
                 s4(_,100),
                 statistics(inferences,A4),
                 !,
                 I4 is A4 - B4 - 1.
check4inf(0).

check4(M4,Mul4,I4)   :- current_predicate(s4/2),
                        !,
                        findtwo(4,LQ4),
                        check4inf(I4),
                        marks4(LQ4,I4,M4,Mul4).
check4( 0,   0,'NA') :-
     mywrite(['Task 4 is not solved because predicate s4/2 does not exist.\n']).

check5inf(I5) :- statistics(inferences,B5),
                 s4(_,500),
                 statistics(inferences,A5),
                 !,
                 I5 is A5 - B5 - 1.
check5inf(0).

check5(M5,Mul5,I5)   :- current_predicate(s4/2),
                        !,
                        findtwo(5,LQ5),
                        check5inf(I5),
                        marks5(LQ5,I5,M5,Mul5).
check5( 0,   0,'NA') :-
     mywrite(['Task 5 is not solved because predicate s4/2 does not exist.\n']).

marks1(1747,1,20,0) :-         !,
           mywrite([
           'Task 1 is solved correctly and with no multiple answers.\n'
           ]).
marks1(1747,N,20,1) :- N >= 1, !,
           mywrite([
           'Task 1 is solved correctly but there are multiple answers.\n'
           ]).
marks1(   _,1, 0,0) :-         !,
           mywrite([
           'Task 1 is not solved correctly but there are no multiple answers.\n'
           ]).
marks1(   _,N, 0,1) :- N >= 1   ,
           mywrite([
           'Task 1 is not solved correctly and there are multiple answers.\n'
           ]).

marks2( 145,1,20,0) :-         !,
           mywrite([
           'Task 2 is solved correctly and with no multiple answers.\n'
           ]).
marks2( 145,N,20,1) :- N >= 1, !,
           mywrite([
           'Task 2 is solved correctly but there are multiple answers.\n'
           ]).
marks2(   _,1, 0,0) :-         !,
           mywrite([
           'Task 2 is not solved correctly but there are no multiple answers.\n'
           ]).
marks2(   _,N, 0,1) :- N >= 1   ,
           mywrite([
           'Task 2 is not solved correctly and there are multiple answers.\n'
           ]).

marks3(  86,1,20,0) :-         !,
           mywrite([
           'Task 3 is solved correctly and with no multiple answers.\n'
           ]).
marks3(  86,N,20,1) :- N >= 1, !,
           mywrite([
           'Task 3 is solved correctly but there are multiple answers.\n'
           ]).
marks3(   _,1, 0,0) :-         !,
           mywrite([
           'Task 3 is not solved correctly but there are no multiple answers.\n'
           ]).
marks3(   _,N, 0,1) :- N >= 1   ,
           mywrite([
           'Task 3 is not solved correctly and there are multiple answers.\n'
           ]).

marks4([[Q           ]  ],I,M4,0) :-  nonvar(Q), Q = [4,13,17,52], !,
           mywrite([
           'Task 4 is solved correctly and with no multiple answers.\n',
           'Task 4 requires ',I,' inferences.\n'
           ]),
           AI is I * 100,
           f(AI,MP4),
           M4 is ceiling(MP4 + 2).
marks4([[Q           ]|_],I,M4,1) :-  nonvar(Q), Q = [4,13,17,52], !,
           mywrite([
           'Task 4 is solved correctly but there are multiple answers.\n',
           'Task 4 requires ',I,' inferences.\n'
           ]),
           AI is I * 100,
           f(AI,MP4),
           M4 is ceiling(MP4 + 2).
marks4([               _],_, 0,0) :- !,
           mywrite([
           'Task 4 is not solved correctly but there are no multiple answers.\n'
           ]).
marks4([                ],_, 0,0) :- !,
           mywrite([
           'Task 4 is not solved correctly but there are no multiple answers.\n'
           ]).
marks4([             _|_],_, 0,1) :-
           mywrite([
           'Task 4 is not solved correctly and there are multiple answers.\n'
           ]).

marks5([[Q           ]  ],I,M5,0) :- nonvar(Q), Q = [4,13,17,52], !,
           mywrite([
           'Task 5 is solved correctly and with no multiple answers.\n',
           'Task 5 requires ',I,' inferences.\n'
           ]),
           f(I,MP5),
           M5 is round(MP5 + 2).
marks5([[Q           ]|_],I,M5,1) :- nonvar(Q), Q = [4,13,17,52], !,
           mywrite([
           'Task 5 is solved correctly but there are multiple answers.\n',
           'Task 5 requires ',I,' inferences.\n'
           ]),
           f(I,MP5),
           M5 is round(MP5 + 2).
marks5([               _],_, 0,0) :- !,
           mywrite([
           'Task 5 is not solved correctly but there are no multiple answers.\n'
           ]).
marks5([                ],_, 0,0) :- !,
           mywrite([
           'Task 5 is not solved correctly but there are no multiple answers.\n'
           ]).
marks5([             _|_],_, 0,1) :-
           mywrite([
           'Task 5 is not solved correctly and there are multiple answers.\n'
           ]).

mywriteaux(_ ,[])    :- !.
mywriteaux(IX,[H|T]) :- write(IX,H), 
                        write(   H), 
                        mywriteaux(IX,T).

mywrite(L) :- fileid(X), open(X,append,IX),
              mywriteaux(IX,L),
              close(IX).

penalty(0,0,0,0,0,_    ,0  ) :- !.
penalty(_,_,_,_,_,Grade,Pen) :- Pen is floor(Grade * 0.3).

/* The following procedure finds the first two answers of the five predicates */

findtwoaux(1) :- s1(Q,100),
                 load(Q).
findtwoaux(2) :- s2(Q,100),
                 load(Q).
findtwoaux(3) :- s3(Q,100),
                 load(Q).
findtwoaux(4) :- s4(Q,100),
                 load(Q).
findtwoaux(5) :- s4(Q,500),
                 load(Q).
findtwoaux(_).

findtwo(N,L) :- assertz(count(1)),
                assertz(count(2)),
                findtwoaux(N), !,
                findall(X,fact(X),L),
                retractall(count(X)),
                retractall(fact(X)).

/* The following is adapted from the readutil.pl SWI-Prolog library           */

readfiletocodes(Spec, Codes) :-
	absolute_file_name(Spec,
			   [ access(read)
			   | []
			   ],
			   Path),
	setup_call_cleanup(
	    open(Path, read, Fd, []),
	    readstreamtocodes(Fd, Codes, []),
	    close(Fd)).

readstreamtocodes(Fd, Codes, Tail) :-
	get_code(Fd, C0),
	readstreamtocodes(C0, Fd, Codes0, Tail),
	Codes = Codes0.

readstreamtocodes(-1, _, Tail, Tail) :- !.
readstreamtocodes(C, Fd, [C|T], Tail) :-
	get_code(Fd, C2),
	readstreamtocodes(C2, Fd, T, Tail).
