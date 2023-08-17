#
#
#  Copyright (c) 2023 TU Eindhoven
#
#  File author(s): Federica Eduati (f.eduati@tue.nl)
#
#  Distributed under the GPLv3 License.
#  See accompanying file LICENSE.txt or copy at
#      http://www.gnu.org/licenses/gpl-3.0.html
#
# --------------------------------------------------------
#
#' define different experimental conditions using smoothing function to identify groups of peaks
#' 
#' \code{detect.peaks}  .
#' 
#' 
#' 
#' @param conditions data separated by conditions as output of the detect.conditions functions
#' @param spar smoothing parameter for the smooth.spline function
detect.peaks <- function(conditions, spar){
  
  peaks <- lapply(names(conditions), function(x){
    condition <- conditions[[x]]
    lowpass.spline <- smooth.spline(condition$Frames, condition$Average.Intensity, spar = 0.3)
    samples.smooth <- predict(lowpass.spline, raw.data$Frames)
    # plot.raw.peak.data(condition, main = x)
    # lines(samples.smooth$x, samples.smooth$y, col = "red", lwd = 2)
    peaks.cond <- findpeaks(samples.smooth$y, minpeakdistance = 20, npeaks = 5)
    colnames(peaks.cond) <- c("max", "max.x", "start", "end")
    return(peaks.cond)
    # points(samples.smooth$x[peaks[,2]], peaks[,1], pch=16, col="red")
      })
  names(peaks) <- names(conditions)
# 
  
# run this to plot raw data divided by condition and detected peaks
# pdf("../figures/plotConditions.pdf")
# for (x in names(conditions)){
#     condition <- conditions[[x]]
#     lowpass.spline <- smooth.spline(condition$Frames, condition$Average.Intensity, spar = 0.3)
#     samples.smooth <- predict(lowpass.spline, raw.data$Frames)
#     plot.raw.peak.data(condition, main = x)
#     lines(samples.smooth$x, samples.smooth$y, col = "red", lwd = 2)
#     peaks <- findpeaks(samples.smooth$y, minpeakdistance = 20, npeaks = 5)
#     points(samples.smooth$x[peaks[,2]], peaks[,1], pch=16, col="red")
#     start <- condition$Frames[1]
#     end <- condition$Frames[length(condition$Frames)]
#     mean.peaks <- mean(peaks[,1])
#     median.peaks <- median(peaks[,1])
#     sd <- std(peaks[,1])
#     lines(x = c(start, end), c(mean.peaks, mean.peaks), col="red")
#     lines(x = c(start, end), c(median.peaks, median.peaks), col="green")
#     # readline(prompt = "Press [enter] to continue.")
#     abline(h=42)
# }
# dev.off()
#   
  return(peaks)
}
