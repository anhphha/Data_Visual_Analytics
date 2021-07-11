---
title: 'assignment 1 #2'
author: "Anh Ha"
date: "11/18/2020"
output: pdf_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)

#Checking the version 
getRversion()
```

```{r}
library(ggplot2)
library(ggthemes)
library(nlme)
library(gganimate)
library(gapminder)
library(ggExtra)
library(psych)
library(reshape2)
library(dplyr)
library(nycflights13)
library(ggcorrplot)
library(waffle)
library(tidyr)
library(scales)
library(ggalt)
library(data.table)
library(extrafont)
library(lubridate)
library(DT)
library(grid)
library(gridExtra)
library(prettydoc)
library(devtools)
library(tidyverse)
library(ggdark)
library(here)
library(gifski)
library(forcats)
library(tufte)
library(colorspace)
library(viridisLite)
library(formatR)
library(DiagrammeR)
library(xaringan)
library(ggridges)
library(GGally)
library(ggplot2movies)
library(corrplot)
library(ggpointdensity)
library(ggstatsplot)
library(ggTimeSeries)
library(ggbeeswarm)
library(gghalves)

```

Exercise 1:

- There is also a dark theme option with black background
```{r}
trend_color = 'orange'
theme_set(dark_theme_gray()+ theme(
  panel.grid.major = element_blank(), 
  panel.grid.minor = element_blank(),
  plot.title = element_text(size = 18, hjust = 0, color = trend_color),
  axis.ticks = element_blank(),
  axis.title = element_text(size = 15, hjust = 0.5, color = trend_color),
  legend.title = element_blank(),
  panel.background =element_rect(fill = "black"),
  strip.background =element_rect(fill = "black"), 
  plot.background = element_rect(fill = "black"),
  legend.background = element_rect(fill = "black")
))
```

- #Simple chart
```{r}
trend_color = 'orange'
ggplot(diamonds, aes(carat)) + 
  geom_freqpoly(colour = trend_color)
```

Excercise 2:

- #Explorative Analysis (gapminder dataset)
- # Creating a visual analytic story 
```{r}
names(gapminder)
head(gapminder, n=10)
str(gapminder)
summary(gapminder)
```

- #Simple chart
```{r}
ggplot(gapminder, aes(gdpPercap)) + 
  geom_freqpoly(colour = trend_color, bins=30) 
```

- #Changing the bin width (less details)
```{r}
ggplot(gapminder, aes(gdpPercap)) + 
  geom_freqpoly(colour = trend_color, binwidth = 10) 
```

- #Changing the bin width (more details)
```{r}
ggplot(gapminder, aes(gdpPercap)) + 
  geom_freqpoly(colour = trend_color, binwidth = 0.8)
```

- #Adding color as a visual encoding
```{r}
ggplot(gapminder, aes(gdpPercap, colour = continent)) +
  geom_freqpoly(bins=30) +
  scale_color_manual(values=c("#478adb", "#cccccc", "#f20675", "#bcc048", "#1ce3cd")) 
```

- #How to zoom by defining the limits for the x axis
```{r}
ggplot(gapminder, aes(gdpPercap, colour = continent)) +
  geom_freqpoly(bins=30) +
  scale_color_manual(values=c("#478adb", "#cccccc", "#f20675", "#bcc048", "#1ce3cd")) + 
  xlim(400, 80000)
```

Excercise 3:

- #Checking the options
```{r}
?geom_histogram
```

- #Simple chart, the same with a histogram 
```{r}
ggplot(gapminder, aes(gdpPercap)) + 
  geom_histogram(colour = trend_color, fill = trend_color, binwidth = 10) 
```

- #How to zoom by defining the limits for the x axis 
```{r}
ggplot(gapminder, aes(gdpPercap)) + 
  geom_histogram(colour = "white", fill = trend_color) + 
  xlim(400, 80000)
```

- #Histogram for different cut options 
```{r}
ggplot(gapminder, aes(gdpPercap, fill = continent)) +
  geom_histogram(position = "dodge", bins=1200) + 
  scale_fill_manual(values=c("#478adb", "#f20675", "#1ce3cd", "#bcc048", "#cccccc"))
```

- #Changing the bin options
```{r}
ggplot(gapminder, aes(gdpPercap, fill = continent)) +
  geom_histogram(position = "dodge", binwidth = 30000) + 
  scale_fill_manual(values=c("#478adb", "#f20675", "#1ce3cd", "#bcc048", "#cccccc"))
```

- #The whole idea of the grammar of graphs 
```{r}
ggplot(gapminder, aes(gdpPercap, color = continent)) +
  geom_histogram(colour= trend_color, fill = "white", alpha = 0.2, size =0, bins=30) +
  geom_freqpoly(bins=30)+ 
  scale_colour_manual(values=c("#478adb", "#f20675", "#1ce3cd", "#bcc048", "#cccccc"))
```

Excercise 4:
- #Checking the options
```{r}
?geom_boxplot
```

- #Simple boxplot by category 
```{r}
ggplot(gapminder, aes(continent, gdpPercap)) +
  geom_boxplot(colour=trend_color)
```

- #Boxplot using to numeric variable, we need to define a grouping rule
```{r}
ggplot(gapminder, aes(lifeExp, pop)) +
  geom_boxplot(aes(group = cut_width(lifeExp, 10)), color=trend_color)
```

- #Without outliers 
```{r}
ggplot(gapminder, aes(lifeExp, pop)) +
  geom_boxplot(aes(group = cut_width(lifeExp, 8)), color=trend_color,
               outlier.alpha=0)
```

- # Use a specific encoding for the outliers
```{r}
ggplot(gapminder, aes(lifeExp, pop)) +
  geom_boxplot(aes(group = cut_width(lifeExp, 5)), color=trend_color, 
               color= "white",
               outlier.alpha = 0.5, 
               outlier.shape = 19, 
               outlier.color=trend_color)
```

- #Tufe boxplot
```{r}
ggplot(gapminder, aes(factor(continent),gdpPercap)) + 
  geom_tufteboxplot(outlier.colour="transparent", size=1, color=trend_color)
```

- #Tufe boxplot
```{r}
ggplot(gapminder, aes(factor(lifeExp),gdpPercap)) + 
  geom_tufteboxplot(aes(group = cut_width(lifeExp, 5)), color=trend_color) 
```

Excercise 5:
- #Checking the options
```{r}
?geom_density
```

- #Simple chart - the same with a density chart
```{r}
ggplot(gapminder, aes(gdpPercap)) +  
  geom_density(fill = trend_color, color = NA)
```

- #Multiple density chart 
```{r}
ggplot(gapminder, aes(gdpPercap, group = continent, fill = continent)) +
  geom_density(adjust = 1.5 , color = NA, alpha = 0.4) + 
  scale_fill_manual(values=c("#478adb", "#cccccc", "#f20675", "#bcc048", "#1ce3cd"))   
```

- #Multiple density chart, with using one color and transparency we can identify easly the overlap as a more dense part through all cuts 
```{r}
ggplot(gapminder, aes(gdpPercap, group=continent, fill=continent)) +
  geom_density(adjust=1.5 , color= NA, fill=trend_color, alpha =0.1) 
```

- #Small multiple density for carat by the different cuts 
```{r}
ggplot(gapminder, aes(gdpPercap, stat(density), fill=continent)) + 
  geom_density(color = NA) +
  scale_fill_manual(values=c("#478adb", "#cccccc", "#f20675", "#bcc048", "#1ce3cd")) +   
  facet_wrap(. ~ continent) 
```

Excercise 6:
- #Scatter plot 
- #Checking the options
```{r}
?geom_point
```

- #Basic scatter plot 
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) + 
  geom_point(color=trend_color)
```

- #Basic scatter plot - adjusting the size
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) +  
  geom_point(size=0.5, color=trend_color)
```

- #Basic scatter plot - adjusting the opacity
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) +  
  geom_point(alpha=0.3, color=trend_color)
```

- #Basic scatter plot changing the Y limits
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) + 
  geom_point(size=0.5, color=trend_color) + 
  ylim(0, 1e+08)
```

- #Axis labeling depending on the quantiles 
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) + 
  geom_point(size=0.9, alpha=0.9, color=trend_color)  + 
  scale_x_continuous(breaks = round(as.vector(quantile(gapminder$lifeExp)), digits = 2))+
  scale_y_continuous(breaks = round(as.vector(quantile(gapminder$gdpPercap)), digits = 2)) 
```

- #Adding price as another visual encoding using a colour code 
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop, colour = lifeExp)) +
  geom_point(size=0.9, alpha=5)+
  scale_colour_gradient(low = "cyan", high = trend_color) 
```

- #Another way to handle big datasets is to create a sample 
```{r}
gapminder_sample <- gapminder[sample(nrow(gapminder), 1000),]
```

- #Basic scatter plot 
```{r}
ggplot(gapminder_sample, aes(x=lifeExp, y=pop)) + 
  geom_point(color=trend_color)
```

- #Change the position scale to logarithmic scaling
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) + 
  geom_point(size=2, alpha=0.5, color=trend_color) +
  scale_y_log10() 
```

- #Axis labeling depending on the quantiles
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) + 
  geom_point(size=2, alpha=0.5, color=trend_color) + 
  xlab("")+ 
  ylab("")+ 
  scale_x_continuous(breaks = round(as.vector(quantile(gapminder$lifeExp)), digits = 1))+
  scale_y_continuous(breaks = round(as.vector(quantile(gapminder$gdpPercap)), digits = 1))
```

- #Axis labeling depending on the quantiles for logaritmic scaling
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) +
  geom_point(size=0.02, alpha=1, color=trend_color)  + 
  xlab("")+ 
  ylab("")+ 
  scale_x_log10(breaks = round(as.vector(quantile(diamonds$carat)), digits = 2))+
  scale_y_log10(breaks = round(as.vector(quantile(diamonds$price)), digits = 2))
```

- #Adding a trend line
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) +
  geom_point(color=trend_color, size=0.8, alpha=0.7)+
  stat_smooth(color=trend_color)
```

- #Small multiples - one variable
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) +
  geom_point(color=trend_color, size=0.8, alpha=0.2)+
  facet_wrap( ~ continent, ncol=2) +
  stat_smooth(color=trend_color) 
```

- #Small multiples - one variable with free scale
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) +
  geom_point(color=trend_color, size=0.8, alpha=0.2)+
  facet_wrap( ~ continent, ncol=2, scales = "free") +
  stat_smooth(color=trend_color)
```

Exercise 7:
- #Now we set the new defined theme to the default option
```{r}
?ggMarginal
```

- #Density
```{r}
pp <- ggplot(gapminder, aes(x=lifeExp, y=pop)) +
  geom_point(color=trend_color) + 
  theme(axis.title=element_blank(), axis.text=element_blank())
ggMarginal(pp, type = "density", fill = trend_color, alpha=1, color='transparent')
```

- #Box-plot
```{r}
ggMarginal(pp, type = "boxplot", size=10, fill=trend_color)
```

- #Histogram  
```{r}
ggMarginal(pp, type = "histogram", size=20, fill=trend_color)
```

Exercise 8:

- #Beeswarm
```{r}
?geom_jitter()
```

- #Simple jitter plot
```{r}
ggplot(gapminder, aes(x=gdpPercap, y=continent)) +
  geom_jitter(color=trend_color)
```

- #Switching axis
```{r}
ggplot(gapminder, aes(y=gdpPercap, x=continent)) +
  geom_jitter(color=trend_color)
```

- #Check the options
```{r}
?geom_quasirandom()
```

- #Simple beewswarm
```{r}
ggplot(gapminder, aes(x=gdpPercap, y=continent)) + 
  geom_quasirandom(size=3, alpha=0.7, color=trend_color, groupOnX=FALSE)
```

- #Simple beewswarm
```{r}
ggplot(gapminder, aes(x=gdpPercap, y=continent, colour=continent)) + 
  geom_quasirandom(size=3, alpha=0.7, groupOnX=FALSE) +
  scale_colour_manual(values=c("#cccccc", "#478adb", "#f20675", "#1ce3cd", "#bcc048"))
```

- #Simple beewswarm
```{r}
ggplot(gapminder, aes(x=gdpPercap, y=continent, colour=continent)) + 
  geom_quasirandom(alpha=0.7, groupOnX=FALSE, method = "smiley") +
  scale_colour_manual(values=c("#cccccc", "#478adb", "#f20675", "#1ce3cd", "#bcc048"))
```

- #Exercise 9:

- #Hexagonal binning

- #Checking the options
```{r}
?geom_hex
```

- #Aggregation through hexagonal binning - defining the number of bins 
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) +
  geom_hex(bins=60, alpha =0.8)+
  scale_fill_gradient(low="cyan", high=trend_color) 
```

- #Aggregation through hexagonal binning - logarithmic scaling
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) +
  geom_hex(alpha = 0.6) +
  scale_x_log10(breaks = round(as.vector(quantile(gapminder$lifeExp)), digits = 1))+
  scale_y_log10(breaks = round(as.vector(quantile(gapminder$gdpPercap)), digits = 1))+
  scale_fill_gradient(low="cyan", high=trend_color) 
```

- #Checking the options
```{r}
?geom_bin2d
```

- #Heatmap based on rectangles
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) +
  geom_bin2d(bins = 60) +
  scale_fill_gradient(low="cyan", high=trend_color)
```

- #Heatmap based on rectangles
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) +
  geom_bin2d(bins = 50, alpha = 0.4)+
  scale_fill_gradient(low="cyan", high=trend_color) 
```

- #Checking the options
```{r}
?stat_density_2d
```

- #Density estimation with contours
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon")  +
  scale_fill_continuous(type = "viridis") 
```

- #Density estimation with contours
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon") +
  scale_fill_gradient(low="cyan", high=trend_color)
```

- #Adding a stroke 
```{r}
ggplot(gapminder, aes(x=lifeExp, y=pop)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", colour="white") +
  scale_fill_gradient(low="cyan", high=trend_color)
```

- #Exercise 10:

- #Scales 

- #Check on the data 
```{r}
names(gapminder)
head(gapminder, n=10)
str(gapminder)
summary(gapminder)
```

- #General scatter plot
```{r}
ggplot(gapminder, aes(pop, lifeExp)) +
  geom_point(colour = trend_color)
```

- #Apply a log scale to the X axis postiion 
```{r}
ggplot(gapminder, aes(pop, lifeExp)) +
  geom_point(colour = trend_color) +
  scale_x_log10()  
```

- #Apply a a linear transformation to the Y axis position with limits 
```{r}
ggplot(gapminder, aes(pop, lifeExp)) +
  geom_point(colour = trend_color) +
  scale_x_log10() +
  scale_y_continuous(limits = c(0, 60))
```

- #Apply a a linear transformation to the Y axis position with defining the breaks 
```{r}
ggplot(gapminder, aes(pop, lifeExp)) +
  geom_point(colour = trend_color) +
  scale_x_log10() +
  scale_y_continuous(breaks = c(0, 20, 25, 35, 40, 45, 50, 55, 60, 80))
```

- #Add labels 
```{r}
ggplot(gapminder, aes(pop, lifeExp)) +
  geom_point(colour = trend_color) +
  scale_x_log10() +
  scale_y_continuous(breaks = c(30, 40, 60), label = c("low", "center", "high"))
```

- #Change the Y scale in reverse 
```{r}
ggplot(gapminder, aes(pop, lifeExp)) +
  geom_point(colour = trend_color) +
  scale_x_log10() +
  scale_y_reverse()
```

- #Add another visual encoding size 
```{r}
ggplot(gapminder, aes(pop, lifeExp, size = gdpPercap)) +
  geom_point(colour = trend_color) +
  scale_x_log10()  +
  scale_size() 
```

- #Apply a scale rage to the variable size 
```{r}
ggplot(gapminder, aes(pop, lifeExp, size = gdpPercap, alpha=gdpPercap)) +
  geom_point(colour = trend_color) +
  scale_x_log10()  +
  scale_size(range = c(2, 12))  
```

- #Add another visual encoding color 
```{r}
ggplot(gapminder, aes(pop, lifeExp, size = gdpPercap,  colour = continent)) +
  geom_point() +
  scale_x_log10()  +
  scale_size(range = c(2, 12)) +
  scale_colour_manual(values=c("#478adb", "#f20675", "#1ce3cd", "#bcc048", "#cccccc"))
```

- #Apply another scale to color  
```{r}
ggplot(gapminder, aes(pop, lifeExp, size = gdpPercap,  color = continent)) +
  geom_point() +
  scale_x_log10()  +
  scale_size(range = c(2, 12)) +
  scale_colour_manual(values = continent_colors) +
  scale_colour_manual(values=c("#478adb", "#f20675", "#1ce3cd", "#bcc048", "#cccccc"))
```

- #Change to facet 
```{r}
ggplot(gapminder, aes(pop, lifeExp,  colour = continent)) +
  geom_point() +
  scale_x_log10()  +
  scale_size(range = c(2, 12)) +
  scale_colour_manual(values = continent_colors) +
  facet_wrap(~continent) +
  scale_colour_manual(values=c("#478adb", "#f20675", "#1ce3cd", "#bcc048", "#cccccc"))
```

- #Adding transparency 
```{r}
ggplot(gapminder, aes(pop, lifeExp, size = gdpPercap,  colour = continent)) +
  geom_point(alpha=0.2) +
  scale_x_log10()  +
  scale_size(range = c(2, 12)) +
  scale_colour_manual(values = continent_colors) +
  facet_wrap(~continent) +
  scale_colour_manual(values=c("#478adb", "#f20675", "#1ce3cd", "#bcc048", "#cccccc"))
```

- #Creating a subsample and define the color scale 
```{r}
diamonds_sample <- diamonds[sample(nrow(diamonds), 1000),]

d <- ggplot(diamonds_sample, aes(carat, price)) +
  geom_point(aes(colour = cut))+
  facet_wrap(~cut)
```

- # Change scale label
```{r}
d + scale_colour_brewer("Diamond\nclarity")
d + scale_colour_brewer(palette = "Greens")
d + scale_colour_brewer(palette = "Set1")
```

- # scale_fill_brewer works just the same as
- # scale_color_brewer but for fill colors
```{r}
p <- ggplot(diamonds, aes(x = price, fill = cut)) +
  geom_histogram(position = "dodge", binwidth = 1000)

p + scale_fill_brewer()
```

- # the order of color can be reversed
```{r}
p + scale_fill_brewer(direction = -1)
```

- #Creating some random numbers
```{r}
df <- data.frame(
  x = runif(100),
  y = runif(100),
  z1 = rnorm(100),
  z2 = abs(rnorm(100))
)
```

-#Check on the data 
```{r}
names(df)
head(df, n=10)
str(df)
summary(df)
```

- # Default colour scale colours from light blue to dark blue
```{r}
ggplot(df, aes(x, y)) +
  geom_point(aes(colour = z2))
```

- # For diverging colour scales use gradient2
```{r}
ggplot(df, aes(x, y)) +
  geom_point(aes(colour = z1), size=5) +
  scale_colour_gradient2()
```

- # Adjust colour choices with low and high
```{r}
ggplot(df, aes(x, y)) +
  geom_point(aes(colour = z2), size=5) +
  scale_colour_gradient(low = "red", high = "blue")
```

- #Check on the data 
```{r}
names(mtcars)
head(mtcars, n=10)
str(mtcars)
summary(mtcars)
```

- #Creating color scale manual 
```{r}
p <- ggplot(mtcars, aes(mpg, wt)) +
  geom_point(aes(colour = factor(cyl)))

p + scale_colour_manual(values = c("red", "blue", "green"))
```

- #Check on the data 
```{r}
names(mpg)
head(mpg, n=10)
str(mpg)
summary(mpg)
```

- # Scale size 
```{r}
p <- ggplot(mpg, aes(displ, hwy, size = hwy)) +
  geom_point()
plot(p)

p + scale_size("Highway mpg")
p + scale_size(range = c(0, 10))
```

- # If you want zero value to have zero size, use scale_size_area:
```{r}
p + scale_size_area()
```

- # If you want to map size to radius (usually bad idea), use scale_radius
```{r}
p + scale_radius()
```

- #Axis

- # Flip the X and Y axis 
```{r}
p + coord_flip()
```

- # Reverse the X and Y Axis 
```{r}
p + scale_x_reverse() + scale_y_reverse()
```

- # Zoom in by defining the limits of the axis 
```{r}
p + coord_cartesian(xlim=c(0,7), ylim=c(0, 40))
```

- #Exercise 11:

- # Creating a visual analytical story 
```{r}
names(gapminder)
head(gapminder, n=10)
str(gapminder)
summary(gapminder)
```

- #General trend in Population
```{r}
ggplot(gapminder) +
  geom_line(aes (year, pop, group = country), lwd = 0.3, show.legend = FALSE, colour = trend_color) +
  labs(title = "Population has increased worldwide") 
```

- #Checking on continents 
```{r}
ggplot(gapminder) +
  geom_line(aes (year, pop, group = country, color= continent), lwd = 0.3, show.legend = TRUE) +
  scale_color_manual(values=c("#478adb", "#cccccc", "#f20675", "#bcc048", "#1ce3cd")) + 
  labs(title = "Population has increased worldwide") 
```

- #Introducing a small multiple to better distinguish between continents 
```{r}
ggplot() +
  geom_line(data=gapminder, aes (year, pop, group = country, color = continent), lwd = 0.3, show.legend = FALSE) + 
  facet_wrap(~ continent, ncol=5, strip.position = "bottom") +
  scale_color_manual(values=c("#478adb", "#cccccc", "#f20675", "#bcc048", "#1ce3cd")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Population by continent")
```

- # Zooming in to see only Europe 
```{r}
ggplot(subset(gapminder, continent ==  "Europe")) +
  geom_line(aes(year, pop, group = country), color= trend_color, show.legend = FALSE) +
  labs(title = "Population in Europe - detecting an outlier") 
```

- # Select only Europe in order to understand which country is the outlier
```{r}
europe <- dplyr::filter(gapminder, continent == "Europe")

ggplot(europe, aes(year, pop)) +
  geom_line(color=trend_color) +
  facet_wrap(~country) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Changes in Population by country in europe") 
```

- #We can also show the trend as dots 
```{r}
ggplot(europe, aes(year, pop)) +
  geom_point(color="grey", size=2) +
  facet_wrap(~country) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Changes in Population by country in europe") 
```

- #Coming back to the general checking on patterns globally 

- #What will be the output of this code?

- #Adding a trend line - defining the method as loss 
```{r}
ggplot() +
  geom_line(data=gapminder, aes (year, pop, group = country), lwd = 0.3, show.legend = FALSE, color= "white") + 
  facet_wrap(~ continent, ncol=5, strip.position = "bottom") +
  geom_smooth(data=gapminder, aes(year, pop, group = 1), lwd = 1, method = 'loess', span = 2, se = TRUE, color = trend_color) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Population  by continent including trendline")
```

- #We can even add all data in the background by setting the variable we do the facet with to zero 
```{r}
ggplot() +
  geom_line(data = transform(gapminder, continent = NULL), aes (year, pop, group = country), alpha = 0.5, lwd = 0.1, colour = "white") +
  geom_line(data=gapminder, aes (year, pop, group = country), lwd = 0.3, show.legend = FALSE, color= trend_color) +
  geom_smooth(data=gapminder, aes(year, pop, group = 1), lwd = 1, method = 'loess', span = 0.1, se = TRUE, color = "white") + 
  facet_wrap(~ continent, ncol=5, strip.position = "bottom") + 
  theme(strip.background = element_blank(), strip.placement = "outside") +
  theme(axis.text.x = element_blank()) +
  labs(title = "Population by continent including trendline, showing all data in the back") 

trend_color = 'orange'
```

- #Now we could filter again on Europe and have far more context 
```{r}
ggplot() +
  geom_line(data = transform(gapminder, continent = NULL), aes (year, pop, group = country), alpha = 0.5, lwd = 0.1, colour = "white") +
  geom_line(data=europe, aes (year, pop, group = country), lwd = 0.3, show.legend = FALSE, color= "cyan") +
  geom_smooth(data=europe, aes(year, pop, group = 1), lwd = 1, method = 'loess', span = 0.1, se = TRUE, color = trend_color) +
  theme(strip.background = element_blank(), strip.placement = "outside") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Population by country in europe, including a trend line and showing all data in the back") 
```

- #Showing how to add a line by aggregating the data 

- #Aggregating the data 
```{r}
gapminderavg<-aggregate(. ~year, data=gapminder, mean, na.rm=TRUE)
head(gapminderavg, n=10)
```

- #Make a plot with the aggregated data 
```{r}
ggplot(gapminderavg) +
  geom_line(aes (year, pop), lwd = 0.3, show.legend = FALSE, color = trend_color) +
  labs(title = "Total") 
```

- #Adding this line to the general plot by using twice the geom_line with different data sets  
```{r}
ggplot() +
  geom_line(data=gapminderavg, aes (year, pop), lwd = 2, show.legend = FALSE, color = trend_color) +
  geom_line(data=gapminder, aes (year, pop, group = country), lwd = 0.3, show.legend = FALSE, color = "white") +
  labs(title = "Total vs. all countries") 
```

- #Exercise 12:

- #Advanced data visualization

- #Parallel coordinates
```{r}
?ggparcoord
```

- #Check the data 
```{r}
names(gapminder)
head(gapminder, n=10)
str(gapminder)
summary(gapminder)
```

- #Simple chart
```{r}
ggparcoord(gapminder, columns = 1:4, alphaLines = 0.3)
```

- #Simple chart, adding a color code 
```{r}
ggparcoord(gapminder, columns = 1:4,groupColumn = 2, alphaLines = 0.3) + 
  scale_color_manual(values=c("#478adb", "#f20675", "#1ce3cd", "#bcc048", "#cccccc"))
```

- #Simple chart, adding a color code 
```{r}
ggparcoord(gapminder, columns = 1:4, groupColumn = 2, alphaLines = 0.3, boxplot = TRUE) + 
  scale_color_manual(values=c("#478adb", "#f20675", "#1ce3cd", "#bcc048", "#cccccc"))
```

- #Showing points, changing transparency and color
```{r}
ggparcoord(gapminder, columns = 1:4, groupColumn = 2, order = "anyClass",
           showPoints = TRUE, alphaLines = 0.3)+ 
  scale_color_manual(values=c("#478adb", "#f20675", "#1ce3cd", "#bcc048", "#cccccc"))
```

- #Showing points, changing transparency and color
```{r}
ggparcoord(gapminder, columns = 1:4, groupColumn = 2, order = "anyClass",
           showPoints = TRUE, alphaLines = 0.3)+ 
  scale_color_manual(values=c("#478adb", "#f20675", "#1ce3cd", "#bcc048", "#cccccc"))
```

- #Different way of scaling: No scaling
```{r}
ggparcoord(gapminder, columns = 1:4, groupColumn = 2, order = "anyClass",
           showPoints = TRUE, alphaLines = 0.3, scale="globalminmax") + 
  scale_color_manual(values=c("#478adb", "#f20675", "#1ce3cd", "#bcc048", "#cccccc"))
```

- #Different way of scaling: Standardize to Min = 0 and Max = 1
```{r}
ggparcoord(gapminder, columns = 1:4, groupColumn = 2, order = "anyClass",
           alphaLines = 0.3, scale="uniminmax") + 
  scale_color_manual(values=c("#478adb", "#f20675", "#1ce3cd", "#bcc048", "#cccccc"))+   
  facet_wrap(. ~ continent) 
```

- #Different way of scaling: Normalize univariately (substract mean & divide by sd)
```{r}
ggparcoord(gapminder, columns = 1:4, groupColumn = 2, order = "anyClass",
           showPoints = TRUE, alphaLines = 0.3, scale="std") + 
  scale_color_manual(values=c("#478adb", "#f20675", "#1ce3cd", "#bcc048", "#cccccc"))
```

- #Exercise 13:

- #Creating a subsample 

```{r}
years <- filter(gapminder, year %in% c(1952, 2007)) %>% select(country, continent, year, lifeExp)
```

- #Check the data 
```{r}
names(years)
head(years, n=10)
str(years)
summary(years)
```

- #Convert data to wide format
```{r}
years2 <- spread(years, year, lifeExp)
names(years2) <- c("country", "continent", "y1952", "y2007")
```

- #Sorted by 2007
```{r}
years3 <- arrange(years2, desc(y2007))
years3$country <- factor(years3$country, levels=rev(years3$country))
```

- #Create a simple dumbbell plot
```{r}
ggplot(years3, aes(country, x=y2007, xend=y2007))+
  geom_dumbbell(colour=trend_color, size_x=0, size_xend=0)
```

- #Create a simple dumbbell plot
```{r}
ggplot(years3, aes(country, x=y2007, xend=y2007, color=continent))+
  scale_color_manual(values=c("#478adb", "#cccccc", "#f20675", "#bcc048", "#1ce3cd"))+
  geom_dumbbell(size_x=0, size_xend=0, dot_guide=FALSE, dot_guide_size=0.2, dot_guide_colour="white")
```

- #Create a simple dumbbell plot
```{r}
ggplot(years3, aes(country, x=y2007, xend=y2007, color=continent))+
  scale_color_manual(values=c("#478adb", "#cccccc", "#f20675", "#bcc048", "#1ce3cd"))+
  geom_dumbbell(size_x=0, size_xend=0, dot_guide=FALSE, dot_guide_size=0.2, dot_guide_colour="white") +
  facet_wrap(. ~ continent, ncol=5) 
```

- #Creating a subsample 
```{r}
asia2 <- filter(gapminder, continent == "Asia" & year %in% c(1952, 2007)) %>% select(country, year, lifeExp)
```

- #Checking
```{r}
head(asia2, n=10)
```

- #Convert data to wide format
```{r}
asia3 <- spread(asia2, year, lifeExp)
names(asia3) <- c("country", "y1952", "y2007")
```

- #Checking
```{r}
head(asia3, n=10)
```

- #Create a simple dumbbell plot
```{r}
ggplot(asia3, aes(country, x = y2007, xend = y2007))+
  geom_dumbbell(color=trend_color)  
```

- #Create a simple dumbbell plot
```{r}
ggplot(asia3, aes(country, x = y2007, xend = y2007)) +
  geom_vline(xintercept=mean(asia3$y2007), color= "white", linetype = "dashed") +
  geom_dumbbell(color=trend_color) 
```

- #Normally what we want is a sorted dumbbell plot 

-#Sorted by 2007
```{r}
asia4 <- arrange(asia3, desc(y2007))
asia4$country <- factor(asia4$country, levels=rev(asia4$country))
```

- #Create dumbbell plot now sorted 
```{r}
ggplot(asia4, aes(country, x = y2007, xend = y2007)) +
  geom_dumbbell(color=trend_color) 
```

- #Create dumbbell plot now sorted 
```{r}
ggplot(asia4, aes(country, x = y2007, xend = y2007)) +
  geom_vline(xintercept=mean(asia4$y1952), color= "white", linetype = "dashed")+
  geom_dumbbell(color=trend_color) 
```

- #Sorted by 2007
```{r}
asia5 <- arrange(asia3, desc(y2007))
asia5$country <- factor(asia5$country, levels=rev(asia5$country))
```

- #Create dumbbell plot now sorted 
```{r}
ggplot(asia5, aes(country, x = y2007, xend = y2007)) +
  geom_vline(xintercept=mean(asia5$y2007), color= "white", linetype = "dashed") +
  geom_dumbbell(color=trend_color) 
```

- #Exercise 14:

- #Waffle chart

```{r}
?waffle
```

- #Create a random data set
```{r}
d <- c(100, 80, 50, 30)
```

- #

- #1. Basic waffle 
```{r}
waffle(d, rows = 20, colors = c("#478adb", "#f20675", "#bcc048", "#1ce3cd"))
```

- #2. Change size
```{r}
waffle(d, rows = 10, colors = c("#478adb", "#f20675", "#bcc048", "#1ce3cd"), size = 0.1) 
```

- #4. Change the position of the legend
```{r}
waffle(d/2 , rows = 5, colors = c("#478adb", "#f20675", "#bcc048", "#1ce3cd"), size = 0.1, legend_pos = "bottom")
```

- #New simple dataset created 
```{r}
professional <- c(`Male` = 44, `Female (56%)` = 56)
```

- #A simple waffle 
```{r}
waffle(
  professional, rows = 20, size = 0.5,
  colors = c(trend_color, "cyan"), legend_pos = "bottom"
)
```

- #You can use the iron statment to create a small multiple of waffles 
```{r}
iron(
  waffle(c(thing1 = 0, thing2 = 100), colors = c(trend_color, "cyan"), rows = 5, flip=TRUE),
  waffle(c(thing1 = 25, thing2 = 75), colors = c(trend_color, "cyan"), rows = 5, flip=TRUE)
)
```

- #It's better to add the legend then separatly instead of showing it in every chart 
```{r}
iron(
  waffle(c(thing1 = 0, thing2 = 100), colors = c(trend_color, "cyan"), rows = 5, keep = FALSE, legend='none'),
  waffle(c(thing1 = 25, thing2 = 75), colors = c(trend_color, "cyan"), rows = 5, keep = FALSE, legend_pos = "bottom")
)
```

- #5. Adding the legend only to one 
```{r}
iron(
  
  waffle(
    c(men = 90.5, woman = 9.5), rows = 5, size = 0.3,
    colors = c("cyan", trend_color),
    keep = FALSE,
    title = "% Women as Members of Finnish Parliament 1907", 
    legend='none'),
  
  waffle(
    c(men = 87.5, woman = 12.5), rows = 5, size = 0.3,
    colors = c("cyan", trend_color),
    keep = FALSE,
    title = "% Women as Members of Finnish Parliament 1916", 
    legend='none'),
  
  waffle(
    c(men = 53, woman = 47), rows = 5, size = 0.3,
    colors = c("cyan", trend_color),
    keep = FALSE,
    title = "% Women as Members of Finnish Parliament 2019",
    legend_pos = "bottom")
  
)
```

- #PART 2:

- #Load data:
```{r}
data <- read.csv("~/Downloads/Big Data analytics/Course 3 Visual Analytics/Assignment 1/DP_LIVE_16112020222502225.csv")
```

- #Check the data 
```{r}
names(data)
head(data, n=10)
str(data)
summary(data)
```

- #DISTRIBUTION
- #Chart of the world unemployment rate over years:
```{r}
ggplot(data, aes(Value)) + 
  geom_freqpoly(colour = trend_color)
```

- #Changing the bin width (more details)
```{r}
ggplot(data, aes(Value)) + 
  geom_freqpoly(colour = trend_color, binwidth = 0.5)
```


-#Adding color as a visual encoding
```{r}
ggplot(data, aes(Value, colour = LOCATION)) +
  geom_freqpoly(bins=30) +
  scale_color_manual(values=c("#478adb", "#cccccc", "#f20675", "#bcc048", "#1ce3cd","orange","green","#89DE00","#DECA00","#FACA00","#5700A8","#840CF5","#A81998","#F500D9","#E6A55A","#E67C5A","#37E6BB","#E6DD2C","#FFF0F5","#ADD8E6","#FFB6C1","#66CDAA","#48D1CC","#C71585","#F5FFFA","#FFDAB9","#DB7093","#DDA0DD","#CD853F","#F5F5DC","#A52A2A","#5F9EA0","#DEB887","#FF7F50","#D2691E","#6495ED","#FFF8DC","#008B8B","#BDB76B","#8FBC8F")) 
```

- # Simple chart of the world unemployedment rate sorted by country over year 2005-2020
```{r}
ggplot(data, aes(x=TIME, y=Value)) + 
  geom_point(color=trend_color)+
  labs(title = "the world unemployedment rate sorted by country over year 2005-2020") 
```

- #Adding a trend line 
```{r}
ggplot(data, aes(x=TIME, y=Value)) +
  geom_point(color=trend_color, size=0.8, alpha=0.2)+
  stat_smooth(color="white")
```
- #Simple jitter plot 
```{r}
ggplot(data, aes(y= LOCATION, x=Value)) +
geom_jitter(color=trend_color)
```

```{r}
ggplot(data, aes(x= TIME, y=Value, colour=LOCATION)) +
geom_quasirandom(alpha=0.7, groupOnX=FALSE, method = "smiley")
```

```{r}
ggplot(data, aes(y=TIME, x=Value, colour=LOCATION)) +
geom_point() +
scale_x_log10() +
scale_size(range = c(2, 12)) +
facet_wrap(~LOCATION) +
scale_colour_manual(values=c("#478adb", "#cccccc", "#f20675", "#bcc048", "#1ce3cd","orange","green","#89DE00","#DECA00","#FACA00","#5700A8","#840CF5","#A81998","#F500D9","#E6A55A","#E67C5A","#37E6BB","#E6DD2C","#FFF0F5","#ADD8E6","#FFB6C1","#66CDAA","#48D1CC","#C71585","#F5FFFA","#FFDAB9","#DB7093","#DDA0DD","#CD853F","#F5F5DC","#A52A2A","#5F9EA0","#DEB887","#FF7F50","#D2691E","#6495ED","#FFF8DC","#008B8B","#BDB76B","#8FBC8F"))
```

- #RELATIONSHIP Analysis

- #Basic scatter plot 
```{r}
ggplot(data, aes(x= TIME, y=Value)) + 
  geom_point(color=trend_color)
```

- #Basic scatter plot - color as visual encoding redundant  
```{r}
ggplot(data, aes(x= TIME, y=Value, color=LOCATION)) + 
  geom_point(size=0.02)
```
 
 - #Another way to handle big data sets is to create a sample  
```{r}
data_sample <- data[sample(nrow(data), 500),]
```

- #Basic scatter plot 
```{r}
ggplot(data_sample, aes(x=TIME, y=Value)) + 
  geom_point(color=trend_color)
```

- #Change the position scale to logarithmic scaling
```{r}
ggplot(data, aes(y=TIME, x=Value)) + 
  geom_point(size=0.1, alpha=0.09, color=trend_color) +
  scale_x_log10() 
```

- #Adding a trend line 
```{r}
ggplot(data, aes(x=TIME, y=Value)) +
  geom_point(color=trend_color, size=0.8, alpha=0.09)+
  stat_smooth(color="white")
```

- #Small multiples- two variables
```{r}
ggplot(data, aes(x=TIME, y=Value)) +
  geom_point(color=trend_color, size=0.8, alpha=0.09)+
  facet_wrap(Value ~ LOCATION) +
  stat_smooth(color="white")
```
-#Dot-dash scatter plot 
```{r}
ggplot(data, aes(TIME, Value)) + 
  geom_point(size=0.05, alpha=0.09, color=trend_color) + 
  geom_rug(size=0.04, alpha=0.08, color="cyan") + 
  xlab("") + 
  ylab("")
```
-#Marginal plot to compare all simple distributions with the scatter plot relationship representation 

- #Heatmap based on rectangles
```{r}
ggplot(data, aes(x=TIME, y=Value)) +
  geom_bin2d(bins = 50) +
  scale_fill_gradient(low="cyan", high=trend_color)
```

- #Time series analysis:
- #Check the data 
```{r}
names(data)
head(data, n=10)
str(data)
summary(data)
```


- #The normal line chart 
```{r}
ggplot(data, aes(TIME, Value)) + geom_line()
```

- # A single line tries to connect all the observations 
```{r}
h<- ggplot(data, aes(LOCATION, Value)) 
h + geom_line() 
```

- #Grouping the observation by the location
```{r}
h1 <- ggplot(data, aes(TIME, Value, group=LOCATION))
h1 + geom_line()
```

- # groups the data the same way for both layers
```{r}
h1 + geom_line() + 
     geom_smooth(aes(), colour = trend_color, size = 0.5, method = "lm", se = FALSE)
```

- # Adding a confidence intervall
```{r}
h1 + geom_line() +
  geom_smooth(aes(group = 1), colour = trend_color, size = 0.5, method = "lm", se = TRUE)
```

- # Now we combine a box-plot with the line chart 
```{r}
h2 <- ggplot(data, aes(LOCATION, Value))
h2 + geom_boxplot() + geom_line()
```

- # We can add the a line chart again for time 
```{r}
h2 + geom_boxplot() + geom_line(aes(group = TIME), size=0.3, colour=trend_color)
```

- # We can add the a line chart grouped 
```{r}
h2 + geom_boxplot() + geom_smooth(aes(group = 1), method = "lm", se = FALSE, colour=trend_color)
```

- #General trend in unemployment rate
```{r}
ggplot(data) +
  geom_line(aes (TIME, Value, group = LOCATION), lwd = 0.3, show.legend = FALSE, colour = "cyan") +
  labs(title = "World's unemployment rate group by country ") 
```

- #Checking on country
```{r}
ggplot(data) +
  geom_line(aes (TIME, Value, group = LOCATION, color= LOCATION), lwd = 0.3, show.legend = TRUE) +
  scale_color_manual(values=c("#478adb", "#cccccc", "#f20675", "#bcc048", "#1ce3cd","orange","green","#89DE00","#DECA00","#FACA00","#5700A8","#840CF5","#A81998","#F500D9","#E6A55A","#E67C5A","#37E6BB","#E6DD2C","#FFF0F5","#ADD8E6","#FFB6C1","#66CDAA","#48D1CC","#C71585","#F5FFFA","#FFDAB9","#DB7093","#DDA0DD","#CD853F","#F5F5DC","#A52A2A","#5F9EA0","#DEB887","#FF7F50","#D2691E","#6495ED","#FFF8DC","#008B8B","#BDB76B","#8FBC8F")) + 
  labs(title = "Life expectancy has increased worldwide") 
```

- # Zooming in to see only Europe 
```{r}
ggplot(subset(data, LOCATION ==  "FIN")) +
  geom_line(aes(TIME, Value, group = LOCATION), color= "cyan", show.legend = FALSE) +
  labs(title = "unemployment rate in Finland - detecting an outlier")
```

- # Select only Finland in order to understand the outlier
```{r}
finland <- dplyr::filter(data, LOCATION == "FIN")
```

- #We can also show the trend as dots 
```{r}
ggplot(finland, aes(TIME, Value)) +
  geom_point(color="grey", size=2) +
  facet_wrap(~LOCATION) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Changes in unemployment rate in Finland")
```

- #Adding a trend line - defining the method as loss 
```{r}
ggplot() +
  geom_line(data=finland, aes (TIME, Value, group = LOCATION), lwd = 0.3, show.legend = FALSE, color= "cyan") + 
  facet_wrap(~LOCATION, ncol=5, strip.position = "bottom") +
  geom_smooth(data=finland, aes(TIME, Value, group = 1), lwd = 1, method = 'loess', span = 2, se = TRUE, color = trend_color) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Unemployment rate in Finland including trendline")
```






Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
