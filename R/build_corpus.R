#' @title build_corpus
#'
#' @description  Builds and cleans the corpus to be modeled
#'
#' @param x A list of plain text files
#'
#' @return A clean {\link{VCorpus}} object, ready to be modeled
#'
#' @importFrom magrittr "%>%"
#' @import tm
#' @export
build_corpus <- function(x) {


  temp_corp <- Corpus(VectorSource(x))

  corp_clean <- tm_map(temp_corp, content_transformer(tolower)) %>%
                  tm_map(removeWords, stopwords("english")) %>%
                  tm_map(removeNumbers) %>%
                  tm_map(removePunctuation) %>%
                  tm_map(stripWhitespace)

  rm(temp_corp)

  temp_dtm <- DocumentTermMatrix(corp_clean)

  rm(corp_clean)

  temp_dtm_reduced <- removeSparseTerms(temp_dtm, 0.95)

  rm(temp_dtm)

  temp_rowtotals <- apply(temp_dtm_reduced, 1, sum)

  temp_list_nonzero <- temp_dtm_reduced[temp_rowtotals > 0, ]

  rm(temp_rowtotals, temp_dtm_reduced)

  temp_dtm_scrubbed <- apply(temp_list_nonzero, 1, function(y) {
    paste(rep(names(y), y), collapse = " ")
  })

  rm(temp_list_nonzero)

  scrubbed_corpus <- VCorpus(VectorSource(temp_dtm_scrubbed))

  rm(temp_dtm_scrubbed)

  return(scrubbed_corpus)
}
