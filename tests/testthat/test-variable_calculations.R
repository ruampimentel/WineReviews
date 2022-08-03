
test_that("fill_na_mean fills the NA with 3", {
  actual <- fill_na_mean(c(2, 2, NA, 5, 3, NA))
  expected <- c(2, 2, 3, 5, 3, 3)
  expect_equal(actual, expected)
})
