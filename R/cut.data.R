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
#' cut the raw data or the peak data from microfluidics file.
#' 
#' \code{cut.data}  .
#' 
#' 
#' 
#' @param data raw data extracted from images from the microfluidics platform extracted peak info
#' @param start.frame start frame
#' @param end.frame end frame
cut.data <- function(data, start.frame=NA, end.frame=NA){
  
  if (is.na(start.frame)){
    start.cut=1
  }else{
    start.cut=which(data[,1]>=start.frame)[1]
    }
  if (is.na(end.frame)){
    end.cut=dim(data)[1]
  }else{
    end.cut=which(data[,1]>=end.frame)[1]
  }
  
  data.cut <- data[start.cut:end.cut,]
  
  return(data.cut)
}
