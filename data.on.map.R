# ========================================#========================================

# data points mapped on germany / a reproducible example of advanced data visualization 

# ========================================#========================================

# load libraries
library(ggplot2)
library(ggmap)
library(maps)

# ========================================#========================================

# set wd
setwd(dir = "read") # change wd to your wd

# read data
data.on.map <- read.csv(file = "data.on.map.csv", header = TRUE, sep = ";", quote = "\"", dec = ".")
View(data.on.map)

# ========================================#========================================

# print map plot
setwd(dir = "print") # change wd to your wd

png(filename="data.on.map.png", width=576, height=756, units="px")
par(mfrow=c(1,1))

germany <- map_data("world", region = "Germany")
germany <- as.data.frame(germany)

ggplot() +
  geom_polygon(data = germany, aes(x = long, y = lat, group = group), fill = "grey80", color = "grey80") +
  coord_fixed(1.3) +
  
  # modify theme
  theme_void()+
  theme(legend.position = "none") +
  geom_point(data = data, aes(y = lat, x = lng, color = group, fill = group), 
             shape = 21, size = 4, alpha = 0.5, 
             position = position_jitter(width=.1,height=.1)) + # data points are jittered to avoid overplotting
  
  # modify titles and legend
  theme(axis.title=element_blank(), 
        axis.text=element_blank(), 
        axis.ticks=element_blank(), 
        legend.position=c(0.15, 0.9), 
        legend.title = element_blank(),  
        legend.text = element_text(size=16)) + 
  labs(title = "Data points on a map of Germany", 
       subtitle = "Randomly generated data in three groups") + 
  theme(plot.title = element_text(size=18, face = "bold"), 
        plot.subtitle = element_text(size=14)) + 
  
  # modify color and fill
  scale_color_manual(values = c("tomato", "springgreen3", "royalblue2")) + 
  scale_fill_manual(values = c("tomato", "springgreen3", "royalblue2"))

dev.off()

# ========================================#========================================
