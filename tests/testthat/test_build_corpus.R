context("Testing corpus builder function")

  test_that("Whether corpus builder function returns the object that it should", {

  test_text <- data.frame("this is the test text")

  test_corpus <- dhtk_build_corpus(test_text)

  check_corpus <- VCorpus(VectorSource(test_corpus))

  expect_equal(class(test_corpus), class(check_corpus))
})
