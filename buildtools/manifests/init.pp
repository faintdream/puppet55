class buildtools {
  case $operatingsystem {
   'Centos'              : { include buildtools::centos }
   '^/(Debian|Ubuntu)$/' : { include buildtools::ubuntu }
   default               : { include buildtools::packageerror}
  }
}
