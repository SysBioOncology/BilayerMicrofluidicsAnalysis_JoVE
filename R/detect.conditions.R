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
#' \code{detect.conditions}  .
#' 
#' 
#' 
#' @param raw.data raw data extracted from images from the microfluidics platform
#' @param spar smoothing parameter for the smooth.spline function
detect.conditions <- function(raw.data, spar){
  
  plot.raw.peak.data(raw.data)
  lowpass.spline <- smooth.spline(raw.data$Frames, raw.data$Average.Intensity, spar = spar)
  samples.smooth <- predict(lowpass.spline, raw.data$Frames)
  # lines(samples.smooth$x, samples.smooth$y, col = "red", lwd = 2)
  peaks <- findpeaks(samples.smooth$y)
  # points(samples.smooth$x[peaks[,2]], peaks[,1], pch=16, col="red")
  abline(v=samples.smooth$x[peaks[,3]], col="blue")
  abline(v=samples.smooth$x[peaks[,4]], col="forestgreen")

  peaks <- as.list(data.frame(t(peaks)))
  print(paste0("Number of detected conditions = ", length(peaks)))
  conditions <- lapply(peaks, function(x){
    return(raw.data[x[3]:x[4],])
  })
  
  return(conditions)
}
