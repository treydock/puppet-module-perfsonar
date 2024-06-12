# @summary Manage perfSONAR configs
# @api private
class perfsonar::config {
  assert_private()

  if $perfsonar::web_admin_password and versioncmp($puppetversion, '8.0') >= 0 { # lint:ignore:variable_scope
    package { 'webrick':
      ensure   => 'installed',
      provider => 'puppet_gem',
    }
  }

  if $perfsonar::web_admin_password and $facts['webrick_installed'] {
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
    if versioncmp($puppetversion, '8.0') >= 0 { # lint:ignore:variable_scope
      Httpauth['psadmin'] -> Package['webrick']
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

    apache_directive { 'SSLCertificateFile':
      args    => $perfsonar::ssl_cert,
      context => $ssl_change_prefix,
      target  => $perfsonar::apache_ssl_conf,
      notify  => Service['httpd'],
    }
    apache_directive { 'SSLCertificateKeyFile':
      args    => $perfsonar::ssl_key,
      context => $ssl_change_prefix,
      target  => $perfsonar::apache_ssl_conf,
      notify  => Service['httpd'],
    }
    if $perfsonar::ssl_chain_file {
      apache_directive { 'SSLCertificateChainFile':
        args    => $perfsonar::ssl_chain_file,
        context => 'VirtualHost',
        target  => $perfsonar::apache_ssl_conf,
        notify  => Service['httpd'],
      }
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
