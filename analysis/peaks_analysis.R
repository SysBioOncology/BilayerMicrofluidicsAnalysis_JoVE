# #########################################################################################################
# Script to analyse fuorescent data extracted from the AVI file using the Python script
# #########################################################################################################

# ****************
# packages
library(pracma)
library(reshape2)
library(ggplot2)
library(tidyverse)

# ****************
# working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


# ****************
# functions
source("../R/cut.data.R")
source("../R/plot.raw.peak.data.R")
source("../R/detect.conditions.R")
source("../R/detect.peaks.R")
source("../R/plot.conditions.peak.R")


# ****************
# load data 
raw.data <- read.csv("../data/Data_0727_Raw Data_Analysis5x5.csv", row.names = 1)
raw.data <- cut.data(raw.data, start.frame = 2700, end.frame=26000)

# detect conditions and peaks
conditions <-  detect.conditions(raw.data, spar = 0.2)
peaks <- detect.peaks(conditions)

# plot raw data separated by conditions along wiith mean and sd for each condition (Figure 7a)
plot.conditions.peaks(raw.data, conditions, peaks)

# plot statistics (boxplots) for each condition
peaks.m <- melt(peaks, id.vars="max")
peaks.m <- subset(peaks.m, subset = (Var2=="max" & Var1 != 5))
peaks.m$L1 <- as.factor(as.numeric(gsub(pattern = "X", replacement = "", x = peaks.m$L1)))
baseline <- min(raw.data$Average.Intensity)
peaks.m$value <- peaks.m$value - baseline
colnames(peaks.m) <- c("peak.id", "Var2", "Hight", "Condition")
peaks.m$Composition <- "fluo-water-water"
peaks.m$Composition[peaks.m$Condition %in% 13:30] <- "fluo-fluo-water"
peaks.m$Composition[peaks.m$Condition %in% 31:34] <- "fluo-fluo-fluo"
peaks.m$Composition <- factor(peaks.m$Composition, levels=c("fluo-water-water", "fluo-fluo-water", "fluo-fluo-fluo"))

ggplot(peaks.m, aes(x=Condition, y=Hight, fill=Composition)) + scale_fill_brewer(palette="Greens") + 
  geom_boxplot() + geom_dotplot(binaxis='y', stackdir='center', dotsize=0.2) + theme_minimal()

# compute average and sd by composition
peaks.m %>%
  group_by(Composition) %>%
  summarise(
    count = n(),
    mean_hight = mean(Hight),
    sd_hight = std(Hight)
  )
