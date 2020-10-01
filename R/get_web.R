#' @title get_web
#'
#' @description one-liner for scraping text data from the web
#' @param x a url
#' @param y a css selector
#'
#' @return character string
#'
#' @importFrom xml2 read_html
#' @importFrom rvest html_node
#' @importFrom rvest html_text
#' @importFrom magrittr "%>%"
#'
#' @export
#'
#' @examples
#' get_web("http://classics.mit.edu/Homer/iliad.23.xxiii.html", "blockquote")
get_web <- function(x, y) {

  read_html(x) %>%
  html_node(y) %>%
  html_text()
}
