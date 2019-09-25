class buildtools::packageerror{
  
  file{ "/tmp/_non_standard_os":
    ensure => present,
  }
  
  notify{ "Build tools could not be installed as this OS is not supported" : }
}
