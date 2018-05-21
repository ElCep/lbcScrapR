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
  guess_encoding(read_html(HTML_Cible))
  
  # Structure de ma page Web ...
  Web_Read <- HTML_Cible %>% read_html(encoding = "ISO-8859-1")
  
  # Vérification de l'extraction de la liste des continents de la page Web...
  Continents <- Web_Read %>% html_nodes("a") %>%
    html_attr("title")
  return(region <- Continents[34:59])
}