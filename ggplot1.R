dicot <-  c(1,0,0,0,1)
dicot == 0
sum(dicot==0) ## solves code
sum(dicot)


library("ggplot2")

##Solve code using for loop
count <-  0
for (i in seq_along(dicot)) {
  count <-  count + as.numeric(dicot[i]==0)
}

print(count)

###
x_treatment <- c("control", "Low", "High")
y_response <- c(12, 2.5, 22.9)

d_frame <- data.frame(x=x_treatment, y =y_response)
ggplot(data=d_frame) + aes(x=x, y=y) + geom_line()


###
my_vec <- seq(1,100, by = 0.1)

d_frame <- data.frame(x=my_vec, y =sin(my_vec))
ggplot(data=d_frame) + aes(x=x, y=y) + geom_line()


###
d_frame <- data.frame(x=my_vec, y=dgamma(my_vec, shape = 5, scale =3))
ggplot(data=d_frame) + aes(x=x, y=y) + geom_line()

###
my_fune <- funcation(x) sin(x)+0.01*x,
d_frame <- data.frame
