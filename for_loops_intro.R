# Introduction to For Loops
# 21 March 2024

#for (var in seq) { # start of For loop

  # Body of For loop

} # End of the For loop


# Use I, J, or K for variable

for (i in 1:5) {
  cat("stuck in a loop", "\n")
  cat(3+2, "\n")
  cat(runif(1), "\n")
}


my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")
for (i in 1:length(my_dogs)){
  cat("i=", i, "my_dogs[i]=", my_dogs[i], "\n")
}

my_bad_dogs <- NULL
for (i in 1:length(my_bad_dogs)){
  cat("i =",i,"my_bad_dogs[i] =" ,my_bad_dogs[i],"\n")
}


for (i in seq_along(my_dogs)){
  cat("i =",i,"my_dogs[i] =" ,my_dogs[i],"\n")
}


# This time we correctly skip my_bad_dogs and do not make the loop
for (i in seq_along(my_bad_dogs)){
  cat("i =",i,"my_bad_dogs[i] =" ,my_bad_dogs[i],"\n")
}

zz <- 5
for (i in seq_len(zz)){
  cat("i =",i,"my_dogs[i] =" ,my_dogs[i],"\n")
}

## Tip One: Don’t do things in the loop if you do not need to!
for (i in 1:length(my_dogs)){
  my_dogs[i] <- toupper(my_dogs[i])
  cat("i =",i,"my_dogs[i] =" ,my_dogs[i],"\n")
}
my_dogs <- tolower(my_dogs)

## Tip Two: Do not change object dimensions (cbind,rbind,c,list) in the loop!
my_dat <- runif(1)
for (i in 2:10) {
  temp <- runif(1)
  my_dat <- c(my_dat,temp) # do not change vector size in the loop!
  cat("loop number =",i,"vector element =", my_dat[i],"\n")
}
print(my_dat)


## Tip Three: Do not write a loop if you can vectorize an operation
my_dat <- 1:10
for (i in seq_along(my_dat)) {
  my_dat[i] <-  my_dat[i] + my_dat[i]^2
  cat("loop number =",i,"vector element =", my_dat[i],"\n")
}

# No loop is needed here!
z <- 1:10
z <- z + z^2
print(z)

## Tip Four: Always be alert to the distinction between the counter variable i and the vector element z[i]
z <- c(10,2,4)
for (i in seq_along(z)) {
  cat("i =",i,"z[i] = ",z[i],"\n")
}
# What is value of i at this point?
print(i)


## Tip Five: Use next to skip certain elements in the loop
z <- 1:20
# What if we want to work with only the odd-numbered elements?
for (i in seq_along(z)) {
  if(i %% 2==0) next
  print(i)
}
# Another method, probably faster (why?)
z <- 1:20
zsub <- z[z %% 2!=0] # contrast with logical expression in previous if statement!
length(z)

for (i in seq_along(zsub)) {
  cat("i = ",i,"zsub[i] = ",zsub[i],"\n")
}

