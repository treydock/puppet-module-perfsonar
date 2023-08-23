# @summary Manage perfSONAR configs
# @api private
class perfsonar::config {
  assert_private()

  if $perfsonar::web_admin_password {
    httpauth { 'psadmin':
      ensure    => 'present',
      username  => $perfsonar::web_admin_username,
      password  => $perfsonar::web_admin_password,
      file      => '/etc/perfsonar/toolkit/psadmin.htpasswd',
      mechanism => 'basic',
      owner     => 'root',
      group     => $perfsonar::apache_group,
      mode      => '0640',
    }
  }

  if $perfsonar::remove_root_prompt {
    file { '/etc/profile.d/add_psadmin_pssudo.sh':
      ensure => 'absent',
    }
  }

  if $perfsonar::manage_apache {
    if $facts['os']['family'] == 'Debian' {
      $ssl_change_prefix = 'IfModule/VirtualHost'
    } else {
      $ssl_change_prefix = 'VirtualHost'
    }
    if $perfsonar::ssl_chain_file {
      $ssl_chain_file_change = "set ${ssl_change_prefix}/*[self::directive = 'SSLCertificateChainFile']/arg ${perfsonar::ssl_chain_file}"
    } else {
      $ssl_chain_file_change = "rm ${ssl_change_prefix}/*[self::directive = 'SSLCertificateChainFile']"
    }
    $ssl_changes = [
      "set ${ssl_change_prefix}/*[self::directive = 'SSLCertificateFile']/arg ${perfsonar::ssl_cert}",
      "set ${ssl_change_prefix}/*[self::directive = 'SSLCertificateKeyFile']/arg ${perfsonar::ssl_key}",
      $ssl_chain_file_change,
    ]

    augeas { 'apache-perfsonar-ssl':
      incl    => $perfsonar::apache_ssl_conf,
      lens    => 'Httpd.lns',
      changes => $ssl_changes,
      notify  => Service['httpd'],
    }

    service { 'httpd':
      ensure => 'running',
      enable => true,
      name   => $perfsonar::apache_service,
    }
  }

  if $perfsonar::bundle == 'perfsonar-toolkit' and $perfsonar::primary_interface {
    file_line { 'web_admin-primary_interface':
      path  => '/etc/perfsonar/toolkit/web/web_admin.conf',
      line  => "primary_interface ${perfsonar::primary_interface}",
      match => '^primary_interface',
    }
  }
}
