#' @title dhtk_build_corpus
#'
#' @description  Builds and cleans the corpus to be modeled
#'
#' @param x A list of plain text files
#'
#' @return A clean {\link{VCorpus}} object, ready to be modeled
#'
#' @importFrom magrittr "%>%"
#' @export
dhtk_build_corpus <- function(x) {


  temp_corp <- tm::Corpus(tm::VectorSource(x))

  corp_clean <- tm::tm_map(temp_corp, tm::content_transformer(tolower)) %>%
                  tm::tm_map(tm::removeWords, tm::stopwords("english")) %>%
                  tm::tm_map(tm::removeNumbers) %>%
                  tm::tm_map(tm::removePunctuation) %>%
                  tm::tm_map(tm::stripWhitespace)

  rm(temp_corp)

  temp_dtm <- tm::DocumentTermMatrix(corp_clean)

  rm(corp_clean)

  temp_dtm_reduced <- tm::removeSparseTerms(temp_dtm, 0.95)

  rm(temp_dtm)

  temp_rowtotals <- apply(temp_dtm_reduced, 1, sum)

  temp_list_nonzero <- temp_dtm_reduced[temp_rowtotals > 0, ]

  rm(temp_rowtotals, temp_dtm_reduced)

  temp_dtm_scrubbed <- apply(temp_list_nonzero, 1, function(y) {
    paste(rep(names(y), y), collapse = " ")
  })

  rm(temp_list_nonzero)

  scrubbed_corpus <- tm::VCorpus(tm::VectorSource(temp_dtm_scrubbed))

  rm(temp_dtm_scrubbed)

  return(scrubbed_corpus)
}
