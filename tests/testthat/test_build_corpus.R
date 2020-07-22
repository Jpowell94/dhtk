context("Testing corpus builder function")

  test_that("Whether corpus builder function returns the object that it should", {

  test_corpus <- dhtk_build_corpus(readtext::readtext("~/codeprojects/Rprojects/FreaksReviewsSentimentAnalysis/*.txt"))

  check_corpus <- VCorpus(VectorSource(test_corpus))

  expect_equal(class(test_corpus), class(check_corpus))
})
