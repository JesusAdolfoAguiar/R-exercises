#Matrix inversion is usually a costly computation 
#and there may be some benefit to caching the inverse 
#of a matrix rather than compute it repeatedly. The following
#functions solves this problem, assuming that the matrix supplied is always invertible:

#makeCacheMatrix: This function creates a special "matrix" object that can cache its inverse,
#which is really a list containing a function to:
  
  #set the value of the matrix
  #get the value of the matrix
  #set the value of the inverse
  #get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
  z <- NULL
  set <- function(y) {
    x <<- y
    z <<- NULL
  }
  get <- function() x
  setinverse <- function(inverse) z <<- inverse
  getinverse <- function() z
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}

#cacheSolve: This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
#If the inverse has already been calculated (and the matrix has not changed), then the cachesolve retrieves
#the inverse from the cache. Computing the inverse of a square matrix can be done with the solve function in R. 
#For example, if X is a square invertible matrix, then solve(X) returns its inverse.


cacheSolve <- function(x, ...) {
      
  z <- x$getinverse()
  if(!is.null(z)) {
    message("getting cached data")
    return(z)
  }
  data <- x$get()
  z <- solve(data, ...)
  x$setinverse(z)
  z
}
