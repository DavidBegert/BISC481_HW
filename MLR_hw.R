######################################
# 12.10.2016
# Multiple Linear Regression (MLR) example
# BISC 481
######################################

## Install packages
# Bioconductor
source("https://bioconductor.org/biocLite.R")
biocLite()
# DNAshapeR
biocLite("DNAshapeR")
# Caret
install.packages("caret")
install.packages("colorspace")
install.packages("ggplot2")

## Initialization
library(ggplot2)
library(DNAshapeR)
library(caret)
workingPath <- "/Users/davidbegert/dev/BioInformatics/BISC481/gcPBM/"

## Predict DNA shapes. Uncomment and comment lines below depending on which data set used.
fn_fasta <- paste0(workingPath, "Max.txt.fa")
#fn_fasta <- paste0(workingPath, "Myc.txt.fa")
#fn_fasta <- paste0(workingPath, "Mad.txt.fa")


pred <- getShape(fn_fasta)

## Encode feature vectors. Line below trains on 1-mer and 1-shape
featureType <- c("1-mer", "1-shape")
#only running 1-mer gives worse R^2 value! Uncomment line below to only use 1-mer
#featureType <- c("1-mer") 
featureVector <- encodeSeqShape(fn_fasta, pred, featureType)
head(featureVector)

## Build MLR model by using Caret
# Data preparation. Uncomment/Comment lines below depending on which dataset used.
fn_exp <- paste0(workingPath, "Max.txt")
#fn_exp <- paste0(workingPath, "Myc.txt")
#fn_exp <- paste0(workingPath, "Mad.txt")

exp_data <- read.table(fn_exp)
df <- data.frame(affinity=exp_data$V2, featureVector)

# Arguments setting for Caret
trainControl <- trainControl(method = "cv", number = 10, savePredictions = TRUE)

# Prediction without L2-regularized
model <- train (affinity~ ., data = df, trControl=trainControl, 
                method = "lm", preProcess=NULL)
summary(model)

# Prediction with L2-regularized
model2 <- train(affinity~., data = df, trControl=trainControl, 
               method = "glmnet", tuneGrid = data.frame(alpha = 0, lambda = c(2^c(-15:15))))
model2
result <- model2$results$Rsquared[1]
