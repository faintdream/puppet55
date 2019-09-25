class buildtools::centos {
  notice("CENTOS MACHINE")
  package { ["make" ,"autoconf" ,"gcc", "glibc"]:
    ensure => latest,
  }
}
