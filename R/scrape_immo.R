#' scrape all real estate advertisementsreal estate advertisements
#' of a specific research in leboincoin.fr
#'
#' This function take parameter to scrape all advertisements of a specifique page
#'
#' @param region a string from `region.lbc()`
#' @param page on witch page the search is run
#' @param querry specified research
#' @param location a string with the specific commune in france
#' @param prix_max a number from 1 to n corresponding to the order of price bunton
#' @param nb_pieces_mini the minimum number of room you are looking for
#' @return a charactere vector within frensh regions from leboncoin
#' @examples
#' scape_immo(my.region,1, "Montpellier", 5, 3)
#' @export
scape_immo <- function(region,page, querry,localisation, prix_max,nb_pieces_min){
  HTML_Cible <- paste0("https://www.leboncoin.fr/ventes_immobilieres/offres/",region,"/?o=",page,
                       "&q=",querry,
                       "&location=",localisation,
                       "&pe=", prix_max,
                       "&ros=",nb_pieces_min)

  rvest::guess_encoding(xml2::read_html(HTML_Cible))## Verif. encodage de la page
  # Structure de ma page Web ...
  Web_Read <- HTML_Cible %>% xml2::read_html(encoding = "ISO-8859-1")# deux liste header + body



  lien.v <- Web_Read %>%
    rvest::html_nodes(".list_item") %>%
    rvest::html_attr("href")
  lien.v <- stringr::str_sub(lien.v, start = 3, end = -1)

  title.v <- Web_Read %>%
    rvest::html_nodes(".list_item") %>%
    rvest::html_attr("title")

  ## Recuperer le prix dans un bon format
  price <- Web_Read %>% rvest::html_nodes("h3.item_price") %>%
    rvest::html_text()
  a <- regmatches(price, gregexpr("[[:digit:]]+", price)) ## suprime tout ce qui n'est pas numeric
  ###assemble les listes
  prices.v <- NULL
  for(z in 1:length(a)){
    tmp <- paste0(a[[z]][[1]],a[[z]][[2]])
    prices.v <- c(prices.v,tmp)
  }

  return(data.frame(titre=title.v[1:35], prix=prices.v, url=lien.v[1:35]))
}
