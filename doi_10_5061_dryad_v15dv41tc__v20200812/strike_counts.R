#look at averages of trees damaged and killed per strike for each size class
#calculate the proportion of trees damaged and killed by lightning each year within each size class
library(dplyr)
library(ggplot2)
library(extrafont)
loadfonts(device="win")
library(lme4)
library(multcomp)

#clear workspace
rm(list=ls())

#create theme basis
theme_basis<-theme(axis.title = element_text(family = "Arial", color="black", face="bold", size=14))+
  theme(axis.text.y=element_text(family = "Arial", 
                                 colour="black", face ="bold", size = 12)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line.x = element_line(colour = "black"),
        axis.line.y = element_line(colour = "black"),axis.ticks = element_line(colour="black"))+
  theme(axis.text.x = element_text(family = "Arial", colour="black", face ="bold", size = 12))+
  theme(plot.margin = unit(c(.5, .5, .5, .5), "cm"))


#import data
strike_counts <- read.csv("Peru_strike_counts.csv")
str(strike_counts)

#reorder size class
strike_counts$diameter.size.class<-factor(strike_counts$diameter.size.class, levels = c("1-10cm","10-30cm","30-60cm",">60cm"))

#replace strike codes with numbers
inter1<-gsub("P19001","1",strike_counts$strike)
inter2<-gsub("P19003","3",inter1)
inter3<-gsub("P19005","5",inter2)
inter4<-gsub("P19006","6",inter3)
inter5<-gsub("P19007","7",inter4)
inter6<-gsub("P19008","8",inter5)
strike_counts$strike.num<-as.factor(gsub("P19009","9",inter6))
strike_counts$strike.num
#####################################
#run basic anova on the total number of trees affected
#best fit seems to be poisson glm
mod1<-glmer(total_trees~diameter.size.class + (1|strike), data = strike_counts, family = poisson)
mod1_null<-glmer(total_trees~1 + (1|strike), data = strike_counts, family = poisson)
anova(mod1,mod1_null)
plot(mod1)
qqnorm(resid(mod1));qqline(resid(mod1))
#mediocre fit for extreme values, but it fits most of the data well overall

#run Tukey test
summary(glht(mod1, linfct = mcp(diameter.size.class = "Tukey")))

############################################
#run basic anova on the number of trees killed
#best fit seems to be poisson glm
mod2<-lmer(dead_trees~diameter.size.class + (1|strike), data = strike_counts)
mod2_null<-lmer(dead_trees~1 + (1|strike), data = strike_counts)
anova(mod2,mod2_null)
plot(mod2)
qqnorm(resid(mod2));qqline(resid(mod2))
#similar to above, this is an imperfect fit, but it describes the data decently (alternatives are not improvements)

#run Tukey test
summary(glht(mod2, linfct = mcp(diameter.size.class = "Tukey")))
#no differences in the numbers of trees killed
####Note, the mortality data are less reliable because age differs among the strikes
#####################################################


#######################################
#calculate counts of trees damaged and killed by lightning annually

#bootstrap 95% confidence intervals for dead trees >60cm
ov60cm_dead<-rep(NA,1000)
for(i in 1:1000){
  ov60cm_dead[i]<-mean(sample(strike_counts$dead_trees[strike_counts$diameter.size.class==">60cm"],7,replace=T))
}

#calculate mean damaged trees over 60cm in diameter
dead_ov60cm_trees_mean <- mean(strike_counts$dead_trees[strike_counts$diameter.size.class==">60cm"])*2.1
dead_ov60cm_trees_025 <- quantile(ov60cm_dead,0.025)*2.1
dead_ov60cm_trees_975 <- quantile(ov60cm_dead,0.975)*2.1

#bootstrap 95% CI for damaged trees >60cm
ov60cm_dmg<-rep(NA,1000)
for(i in 1:1000){
  ov60cm_dmg[i]<-mean(sample(strike_counts$damaged_trees[strike_counts$diameter.size.class==">60cm"],7,replace=T))
}

#calculate mean damaged trees over 60cm in diameter
dmg_ov60cm_trees_mean <- mean(strike_counts$damaged_trees[strike_counts$diameter.size.class==">60cm"])*2.1
dmg_ov60cm_trees_025 <- quantile(ov60cm_dmg,0.025)*2.1
dmg_ov60cm_trees_975 <- quantile(ov60cm_dmg,0.975)*2.1

#estimate the percent of trees >70cm DBH killed and damaged by lightning every year
####5 trees >70 cm per ha - so 500 trees per km2
#we divide by 100 to convert from km2 to ha, but then we also multiply by 100, so I"ll just drop this

#dead trees
dead_ov60cm_trees_mean/500*100
dead_ov60cm_trees_025/500*100
dead_ov60cm_trees_975/500*100

#damaged trees
dmg_ov60cm_trees_mean/500*100
dmg_ov60cm_trees_025/500*100
dmg_ov60cm_trees_975/500*100

###############################################################
