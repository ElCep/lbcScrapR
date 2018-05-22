#' scrape all real estate advertisementsreal estate advertisements
#' of a specific research in leboincoin.fr
#'
#' This function take parameter to scrape all advertisements of a specifique page
#'
#' @param a data.frame from `scrape_immo()`
#' @return a vector composed with NA and price when price is detecte
#' @examples
#' lbc_surf(df.from.scrape_immo)
#' @export
lbc_surf <- function(data.df){
  func.v <- data.frame()
  for(i in 1:length(data.df[,1])){
    if(!is.na(stringr::str_locate(data.df$titre[i], "m²"))){
      pos <- stringr::str_locate(data.df$titre[i], "m²")
      v <- stringr::str_sub(data.df$titre[i],start = pos[,1]-6, end =  pos[,1]-1)
      surface.v <- as.numeric(unlist(regmatches(v, gregexpr("[[:digit:]]+", v))))
      func.v <- c(func.v, surface.v)
    }else{
      func.v <- c(func.v, NA)
    }

  }
  return(as.numeric(unlist(func.v)))

}
