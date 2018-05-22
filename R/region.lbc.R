#' Take region avalable list
#'
#' This function tacke the home page from 'leboncoin.fr'
#' en return a vector with all frensh region
#'
#' @param nothing
#' @return a charactere vector within frensh regions from leboncoin
#' @examples
#' my.region <- region.lbc()[7]
#' @export
region.lbc <- function(){
  # Page Web à scraper
  HTML_Cible <- "https://www.leboncoin.fr/"

  # Encoding de la pagee Web...
  readr::guess_encoding(rvest::read_html(HTML_Cible))

  # Structure de ma page Web ...
  Web_Read <- HTML_Cible %>% rvest::read_html(encoding = "ISO-8859-1")

  # Vérification de l'extraction de la liste des continents de la page Web...
  Continents <- Web_Read %>% rvest::html_nodes("a") %>%
    rvest::html_attr("title")
  return(region <- Continents[34:59])
}
