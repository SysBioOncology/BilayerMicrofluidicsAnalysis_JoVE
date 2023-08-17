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
#' plot the raw data and the peak data overlapped 
#' 
#' \code{plot.raw.peak.data}  .
#' 
#' 
#' 
#' @param raw.data raw data extracted from images from the microfluidics platform
#' @param peak.data  extracted peak info
#' @param start.frame end frame
#' @param end.frame end frame
plot.raw.peak.data <- function(raw.data, peak.data=NA, start.frame=NA, end.frame=NA, main="", showPeaks=F){
  
  raw.data <- cut.data(raw.data, start.frame, end.frame)
  if (is.na(peak.data)){
    plot(raw.data$Frames, raw.data$Average.Intensity, type="l", main=main, xlab="Frames", ylab="Intensity")
  }else{
    peak.data <- cut.data(peak.data, start.frame, end.frame)
    y.max <- max(c(raw.data$Average.Intensity, peak.data$Height.of.peak, peak.data$Width.heights))
    y.min <- min(c(raw.data$Average.Intensity, peak.data$Height.of.peak, peak.data$Width.heights))
    plot(raw.data$Frames, raw.data$Average.Intensity, type="l", ylim=c(y.min, y.max), main=main, xlab="Frames", ylab="Intensity")
    if (showPeaks==T){
      points(peak.data$Peak.locations..index., peak.data$Height.of.peak, pch=16, col="red")
      points(peak.data$Peak.locations..index., peak.data$Width.heights, pch=16, col="blue")
    }
  }


  # abline(h=140)
  # abline(h=140/3*2)
  # abline(h=140/3)
  
}
