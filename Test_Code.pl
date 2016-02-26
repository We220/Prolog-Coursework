% Generates the list from X = 2 to Y = 3. When X and Y are equal to 98 and 99 there cases are set and the program stops.
% Y is incremented by 1 until it is equal to 99.
% When Y is equal to 99 X is incremented by 1 and Y is reset to X + 2.



g_List(98,99,A,[[98,99,197,9702]|A]). % End case for the list
g_List(X,99,L,A) :- Z is X + 1, Y is Z + 1, S is X+99, P is X*99, g_List(Z,Y,[[X,99,S,P]|L],A), % Increments X and resets Y
					!.
g_List(X,Y,L,A) :- Z is Y + 1, S is X+Y, P is X*Y, g_List(X,Z,[[X,Y,S,P]|L],A). % Increments Y