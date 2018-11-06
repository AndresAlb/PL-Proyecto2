function [xo, zo, ban, iter, lambda0] = mSimplexDual(A, b, c) 

% Esta funcion realiza el Metodo Simplex Dual para problemas primales
% que tienen la siguiente forma:
%
%               minimizar   c'x 
%               sujeto a    Ax >= b , x >= 0 , c >= 0 
% 
% In :  A ... m x n matrix 
%       b ... column vector with as many rows as A 
%       c ... column vector with as many columns as A 
% 
% Out:  xo ... SFB optima del problema 
%       zo ... valor optimo del problema 
%       ban ... indica casos: 
%           -1 ... si el conjunto factible es vacio 
%           0 ... si se encontro una solucion optima 
%           1 ... si la funci´on objectivo no es acotada. 
%       iter ... numero de iteraciones que hizo el metodo 
%       lambda0 ... Solucion del problema dual 



end