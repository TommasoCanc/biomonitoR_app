###############
# default_val #
###############

default_val <- function(x, value) {
  if (isTruthy(x)) {
    x
  } else {
    value
  }
}