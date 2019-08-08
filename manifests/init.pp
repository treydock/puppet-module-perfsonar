# @summary Manage perfSONAR
#
# @example
#   include perfsonar
#
# @param manage_repo
#   Boolean that determines if perfSONAR repos will be managed.
# @param manage_epel
#   Boolean that determines if EPEL repo is managed.
# @param bundle
#   The perfSONAR bundle package to install
# @param optional_packages
#   Array of optional packages to install
# @param manage_firewall
#   Boolean that determines if firewall rules are managed.
# @param with_ipv6
#   Boolean that determines if IPv6 support should be enabled
class perfsonar (
  Boolean $manage_repo = true,
  Boolean $manage_epel = true,
  Enum['perfsonar-tools','perfsonar-testpoint','perfsonar-core','perfsonare-centralmanagement','perfsonar-toolkit']
    $bundle = 'perfsonar-toolkit',
  Array $optional_packages = [],
  Boolean $manage_firewall = true,
  Boolean $with_ipv6 = false,
) {

  if $manage_repo {
    contain 'perfsonar::repo'
    Class['perfsonar::repo'] -> Class['perfsonar::install']
  }

  if $manage_firewall {
    contain 'perfsonar::firewall'
  }

  contain 'perfsonar::install'

}
