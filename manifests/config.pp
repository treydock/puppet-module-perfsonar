# @summary Manage perfSONAR configs
# @api private
class perfsonar::config {
  assert_private()

  if $::perfsonar::web_admin_password {
    httpauth { 'psadmin':
      ensure    => 'present',
      username  => $::perfsonar::web_admin_username,
      password  => $::perfsonar::web_admin_password,
      file      => '/etc/perfsonar/toolkit/psadmin.htpasswd',
      mechanism => 'basic',
    }
    -> file { '/etc/perfsonar/toolkit/psadmin.htpasswd':
      ensure => 'file',
      owner  => 'root',
      group  => $::perfsonar::apache_group,
      mode   => '0640',
    }
  }

  if $::perfsonar::remove_root_prompt {
    file { '/etc/profile.d/add_psadmin_pssudo.sh':
      ensure => 'absent',
    }
  }

  if $::perfsonar::manage_apache {
    if $::perfsonar::ssl_chain_file {
      $ssl_chain_file_change = "set /*[self::directive = 'SSLCertificateChainFile']/arg ${::perfsonar::ssl_chain_file}"
    } else {
      $ssl_chain_file_change = 'rm /*[self::directive = "SSLCertificateChainFile"]'
    }
    $ssl_changes = [
      "set /*[self::directive = 'SSLCertificateFile']/arg ${::perfsonar::ssl_cert}",
      "set /*[self::directive = 'SSLCertificateKeyFile']/arg ${::perfsonar::ssl_key}",
      $ssl_chain_file_change,
    ]

    augeas { 'apache-perfsonar-ssl':
      incl    => $::perfsonar::apache_ssl_conf,
      lens    => 'Httpd.lns',
      changes => $ssl_changes,
      notify  => Service['httpd'],
    }

    service { 'httpd':
      ensure => 'running',
      enable => true,
      name   => $::perfsonar::apache_service,
    }
  }
}
