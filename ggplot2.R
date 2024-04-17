# ggplot 2
# 9 April 2024
#AC

library(ggplot2)
library(ggthemes)
library(patchwork)


d <- mpg

# Plotting multiple panel graphs

g1 <- ggplot(data=d)+
  aes(x=displ, y=cty)+
  geom_point() +
  geom_smooth()
print(g1)

g2 <- ggplot(data=d) +
  aes(x=fl) +
  geom_bar(fill = "tomato", color = "black") +
  theme(legend.position = "none")
print(g2)

g3 <- ggplot(data=d)

g4 <- ggplot(data=d) +
  aes(x=fl, y=cty, fill=fl)+
  geom_boxplot() +
  theme(legend.position = "none")
print(g4)

g1 + g2 + g4 + plot_layout(ncol=1)
g1 + plot_spacer() + g2

g1 + {
  g2 + {
    g4 +
      plot_layout(ncol=1)
  }
} +
  plot_layout(ncol = 1)


g1 + g2 -g4 + plot_layout(ncol = 1)

g1 + g2 + plot_annotation("this is a title",
                          caption = "made with patchwork")


g1 + g2 + plot_annotation(
  title = "This is a title",
  caption = "made with patchwork",
  theme = theme(plot.title = element_text(size = 16))
)

g1/(g2 | g4) +
  plot_annotation(tag_levels = "A")



g1a <- g1 + scale_x_reverse()
g1b <- g1 + scale_y_reverse()
g1c <- g1 + scale_x_reverse() + scale_y_reverse()
(g1 | g1a)/(g1b | g1c)

(g1 + coord_flip() | g1a coord_flip() ) / (g1b + coord_flip() | g1c + coord_flip())

ggsave(filename = "myplot.pdf", plot = g1, device = "pdf", width = 20, height = 20, units = "cm", dpi = 300)


m1 <- ggplot(data = mpg) +
  aes(x=displ,y=cty, color = class) +
  geom_point(size=3)
print(m1)

m2 <- ggplot(data = mpg) +
  aes(x=displ,y=cty, shape = class) +
  geom_point(size=3)
print(m2)
