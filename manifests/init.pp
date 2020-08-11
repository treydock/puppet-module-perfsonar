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
# @param web_admin_username
#   User name used to log into perfSONAR web interface
# @param web_admin_password
#   Password for perfSONAR web login
# @param remove_root_prompt
#   Boolean that determines if file should be removed that
#   provides a prompt for setup when root logs in.
# @param apache_group
#   Group used by Apache
# @param manage_apache
#   Boolean that sets if Apache should be managed
# @param ssl_cert
#   The path to Apache SSL certificate
# @param ssl_key
#   The path to Apache SSL private key
# @param ssl_chain_file
#   The path to Apache SSL chain file
# @param apache_ssl_conf
#   The path to Apache SSL configuration file
# @param apache_service
#   The Apache service name
# @param primary_interface
#   The primary interface of host
# @param manage_pscheduler_agent
#   Weather or not the pscheduler-agent daemon should be managed
# @param pscheduler_agent_config
#   Configuration to convert to json and write to pscheduler-agent.json
class perfsonar (
  Boolean $manage_repo = true,
  Boolean $manage_epel = true,
  Enum['perfsonar-tools','perfsonar-testpoint','perfsonar-core','perfsonare-centralmanagement','perfsonar-toolkit']
    $bundle = 'perfsonar-toolkit',
  Array $optional_packages = [],
  Boolean $manage_firewall = true,
  Boolean $with_ipv6 = false,
  String $web_admin_username = 'admin',
  Optional[String] $web_admin_password = undef,
  Boolean $remove_root_prompt = false,
  # Apache
  String $apache_group = 'apache',
  Boolean $manage_apache = false,
  Stdlib::Absolutepath $ssl_cert = '/etc/pki/tls/certs/localhost.crt',
  Stdlib::Absolutepath $ssl_key = '/etc/pki/tls/private/localhost.key',
  Optional[Stdlib::Absolutepath] $ssl_chain_file = undef,
  Stdlib::Absolutepath $apache_ssl_conf = '/etc/httpd/conf.d/ssl.conf',
  String $apache_service = 'httpd',
  # Interfaces
  Optional[String] $primary_interface = $facts.dig('networking','primary'),
  # pscheduler-agent
  Boolean $manage_pscheduler_agent = false,
  Optional[Hash] $pscheduler_agent_config = undef,
) {

  if $manage_repo {
    contain 'perfsonar::repo'
    Class['perfsonar::repo'] -> Class['perfsonar::install']
  }

  if $manage_firewall {
    contain 'perfsonar::firewall'
  }

  if $manage_pscheduler_agent {
    contain 'perfsonar::pscheduler::agent'

    Class['perfsonar::install']
    -> Class['perfsonar::pscheduler::agent']
  }

  contain 'perfsonar::install'
  contain 'perfsonar::config'

  Class['perfsonar::install']
  -> Class['perfsonar::config']

}
