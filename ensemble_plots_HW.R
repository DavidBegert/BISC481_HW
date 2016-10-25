######################################
# 01.10.2016
# Emsemble plots example
# BISC 481
######################################

# Initialization
library(DNAshapeR)

# Extract sample sequences

fnUnbound <- "/Users/davidbegert/dev/BioInformatics/BISC481/CTCF/unbound_500.fa"
fnBound <- "/Users/davidbegert/dev/BioInformatics/BISC481/CTCF/bound_500.fa"

# Predict DNA shapes
predUnbound <- getShape(fnUnbound)
predBound <- getShape(fnBound)

# Generate ensemble plots
# Comment/Uncomment depending on which you want to plot
plotShape(predUnbound$MGW)
plotShape(predUnbound$ProT)
plotShape(predUnbound$Roll)
plotShape(predUnbound$HelT)
plotShape(predBound$MGW)
plotShape(predBound$ProT)
plotShape(predBound$Roll)
plotShape(predBound$HelT)

