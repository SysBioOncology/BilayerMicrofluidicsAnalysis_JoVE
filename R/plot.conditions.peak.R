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
#' @param conditions  data separated by conditions as output of the detect.conditions functions
#' @param peaks extracted peaks info using detect.peaks function
plot.conditions.peaks <- function(raw.data, conditions, peaks){
  
  plot.raw.peak.data(raw.data)
  
  start.end <- lapply(conditions, function(condition){
    c(condition$Frames[1], condition$Frames[length(condition$Frames)])
  })

  abline(v=unlist(start.end), col="blue")

  plot.statistics <- lapply(names(conditions), function(x){
    condition <- conditions[[x]]
    start <- condition$Frames[1]
    end <- condition$Frames[length(condition$Frames)]
    
    # compute statistics considering always the first 4 peaks per condition 
    mean.peaks <- mean(peaks[[x]][1:4,1])
    median.peaks <- median(peaks[[x]][1:4,1])
    sd <- std(peaks[[x]][1:4,1])
    sd <- std_err(peaks[[x]][1:4,1])
    
    lines(x = c(start, end), c(mean.peaks, mean.peaks), col="red", lwd=2)
    lines(x = c(start, end), c(mean.peaks+sd, mean.peaks+sd), col="red", lty=2)
    lines(x = c(start, end), c(mean.peaks-sd, mean.peaks-sd), col="red", lty=2)
  })
  
}
