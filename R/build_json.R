#' @title build_json
#'
#' @description Builds a json object for online visualizations
#'
#' @param x a topic model object from topicmodels package
#' @param y a corpus object from tm package
#' @param z a document term matrix object from tm package
#'
#' @return json object
#'
#' @importFrom magrittr "%>%"
#' @importFrom topicmodels posterior
#' @importFrom stringi stri_count
#' @importFrom LDAvis createJSON
#' @export
build_json <- function(x, y, z) {


    # Find required quantities
    phi <- posterior(x)$terms %>% as.matrix()
    theta <- posterior(x)$topics %>% as.matrix()
    vocab <- colnames(phi)
    doc_length <- vector()
    for (i in seq_len(y)) {
        temp <- paste(y[[i]]$content, collapse = " ")
        doc_length <- c(doc_length, stri_count(temp, regex = "\\S+"))
    }
    temp_frequency <- as.matrix(z)
    freq_matrix <- data.frame(ST = colnames(temp_frequency),
                              Freq = colSums(temp_frequency)
    )

    rm(temp_frequency)
    # Convert to json
    json_lda <- createJSON(phi = phi,
                                   theta = theta,
                                   vocab = vocab,
                                   doc.length = doc_length,
                                   term.frequency = freq_matrix$Freq
    )

    return(json_lda)
}
