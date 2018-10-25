function Y = tfidf( X )
% FUNCTION computes TF-IDF weighted word histograms.
%
%   Y = tfidf( X );
%
% INPUT :
%   X        - document-term matrix (documents in columns)
%
% OUTPUT :
%   Y        - TF-IDF weighted document-term matrix
%
 
% get term frequencies
X = tf(X);
 
% get inverse document frequencies
I = idf(X);
 
% apply weights for each document
for j=1:size(X, 2)
    X(:, j) = X(:, j)*I(j);
end
 
Y = X;
 
 
function X = tf(X)
% SUBFUNCTION computes word frequencies
 
% for every word
for i=1:size(X, 1)
    
    % get word i counts for all documents
    x = X(i, :);
    
    % sum all word i occurences in the whole collection
    sumX = sum( x );
    
    % compute frequency of the word i in the whole collection
    if sumX ~= 0
        X(i, :) = x / sum(x);
    else
        % avoiding NaNs : set zero to never appearing words
        X(i, :) = 0;
    end
    
end
 
 
function I = idf(X)
% SUBFUNCTION computes inverse document frequencies
 
% m - number of terms or words
% n - number of documents
[m, n]=size(X);
 
% allocate space for document idf's
I = zeros(n, 1);
 
% for every document
for j=1:n
    
    % count non-zero frequency words
    nz = nnz( X(:, j) );
    
    % if not zero, assign a weight:
    if nz
        I(j) = log( m / nz );
    end
    
end