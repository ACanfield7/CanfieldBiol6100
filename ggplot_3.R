# GGplot 3

install.packages("remotes")

remotes::install_github("clauswilke/colorblindr")

library(ggplot2)
library(ggthemes)
library(patchwork)
library(colorblindr)
library(cowplot)
library(wesanderson)
library(ggsci)
library(scales)


my_cols <- c("thistle", "tomato", "cornsilk", "cyan", "chocolate")

# From Color Space Palette
demoplot(my_cols, "map")
demoplot(my_cols, "bar")
demoplot(my_cols, "scatter")
demoplot(my_cols, "heatmap")
demoplot(my_cols, "spine")
demoplot(my_cols, "perspective")

# Built in Greys (0 = black, 100 = white)
my_greys <- c("grey20", "grey50", "grey80")
demoplot(my_greys, "bar")

# Function Grey
my_grey2 <- grey(seq(from=0.1,to = 0.9, length.out = 10))
demoplot(my_grey2, "heatmap")

# convcerting color plates to black and white
d = mpg
p1 <- ggplot(d, aes(x=as.factor(cyl), y=cty, fill=as.factor(cyl))) +
  geom_boxplot()
plot(p1)

# deafult color look identical in black and white
pl_des <- colorblindr::edit_colors(p1, desaturate)
plot(pl_des)

# custom colors not prety but convert okay to black and white
p2 <- p1 + scale_fill_manual(values=c("red", "blue", "green", "yellow"))
plot(p2)

p2_des <-  colorblindr::edit_colors(p2, desaturate)
plot(p2_des)

# GG plot dataframe
x1 <- rnorm(n=100, mean = 0)
x2 <- rnorm(n=100, mean = 2.2)
d_frame <- data.frame(v1 = c(x1,x2))
lab <- rep(c("Control", "Treatment"), each = 100)
d_frame <- cbind(d_frame, lab)
str(d_frame)

h1 <- ggplot(d_frame) +
  aes(x = v1, fill = lab)

h1 + geom_histogram(position = "identity",
                    alpha = 0.5,
                    color = "black")

