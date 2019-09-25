class buildtools::ubuntu {

  package { "build-essential":
    ensure => latest,
  }
}
