## The following comments on the functions were taken from comments made by users of the forum of Coursera. I just arranged them in a way to understand the assignment. Any error must be attributed to me, and all the glory to the people in the forum.

## Objective of the two functions (makeCacheMatrix and cacheSolve): one should be able to pass a matrix to the makeCacheMatrix function and save that in a variable (a), then when passing a to cacheSolve it should return the inverse of the matrix one has passed to makeCacheMatrix. Then if one runs it again it will return a message that it's getting the cache and return the inverse.

## Function makeCacheMatrix
## This function generates and stores a list of functions of 4 functions: set, get, setinverse, getinverse
makeCacheMatrix <- function(x = matrix()) { 
## Assigns the function argument (x), and indicates that x is an empty matrix.
## x = matrix() indicates that the function argument is named x, and it also gives it a default value (an empty matrix). Without a default value defined here, it's possible that x will be undefined at all and thus references to it could lead to errors, or R might find a value for x in one of the higher-level or global environments, which also leads to unexpected behavior. Providing an argument assigns a value to x in the enclosure established by the function call. When you do a <- makeCacheMatrix(matrix), you're saying that in a, x = matrix.
## When makeCacheMatrix is created, it creates an enclosure with a value for x native to that enclosure, accessible by any of the sub functions if they use <<-.
    inv <- NULL
## inv is assigned to unknown
    set <- function(y) { 
x <<- y
        inv <<- NULL
    }
## set is is assigned to a function that changes the matrix stored in the main function
## When you call the set function, you are changing the value of the matrix (which means the “inverted” of the matrix has also changed). You could have the set function calculate and set a new inverted itself, but they [the ones in charge of the course] have chosen not to do so in this exercise, because they want you to write those separate functions. So instead, they have you reset the stored inverted to NULL to indicate that you have to recalculate the inverted
## x <<- y substitutes the matrix x with y (the input[argument]) in the main function (makeCacheMatrix). If it was "x <- y" it would have substitute the matrix x with y only in the set function. inv <<- NULL restores to null the value of the inverted inv, because the old inverted of the old matrix is not needed anymore. The new inverted needs to be recalculated through the function cacheSolve.
## The operators <<- and ->> are normally only used in functions, and cause a search to made through parent environments for an existing definition of the variable being assigned. If such a variable is found (and its binding is not locked) then its value is redefined, otherwise assignment takes place in the global environment
    get <- function() x  
## it returns the matrix x stored in the main function. Doesn't require any input.
## defines a function (get) that returns the value of x; is just like get <- function() {x}; not need for curly brackets, because it fits in one line, and has only one argument
    setinverse <- function(inverse) inv <<- inverse
## assigns the function inverse
    getinverse <- function() inv  
## get inverse <- function() {inv}; not need for curly brackets,
## setinverse and getinverse are functions very similar to set and get. They don't calculate the inverse [?], they simply store the value of the input in a variable inv into the main function makeCacheMatrix (setinverse) and return it (getinverse). The value "inverse", input of setinverse, is supposed to be the inverse of the matrix x, but it simply stores a value (as in > a$setinverse(20) / > a$getinverse() / [1] 20)
    list(set=set, get=get, setinverse=setinverse, getinverse=getinverse) 
## Stores the functions. To store the 4 functions in the function makeCacheMatrix, the function list() is needed, so that when makeCacheMatrix is assigned to an object, the object has all the 4 functions.
## Creates a list. The list is an object, which contains 4 other functions (inner ones) as its elements. They are not arguments being set. The 'first' ones are the names for list elements. Its just a coincidence they are named the same. This line can go: list(list_name_set = function_name_set, list_name_get = function_name_get...)
}

## Function cacheSolve
##  The input[argument] of this function is the object where makeCacheMatrix is stored. It calls the list of objects defined in makeCacheMatrix.
cacheSolve <- function(x, ...) {
## In the second function, x no longer refers to the original vector. That was the meaning of x in the first program. In the second, x is meant to be result of the first function (a matrix).
    inv <- x$getinverse() 
        if(!is.null(inv)) {
           message("getting cached data.")
           return(inv)
## the $ just finds the function with that name in the list
## R verifies [that] the value inv, stored previously with getinverse, exists and is not NULL. If it exists in memory, it simply returns a message and the value inv (that is supposed to be the inverted, but not necessarily). If it is the case, return(inv) ends the function.
    }
    data <- x$get()
    inv <- solve(data)
    x$setinverse(inv)
    inv
## the $ just finds the function with that name in the list
## (this is a sort of else {}) if the function is not ended, data gets the matrix stored with makeCacheMatrix, inv calculates the inverted of the matrix and x$setinverse(inv) stores it in the object generated assigned with makeCacheMatrix.
}
