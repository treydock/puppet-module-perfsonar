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
  }

  if $::perfsonar::remove_root_prompt {
    file { '/etc/profile.d/add_psadmin_pssudo.sh':
      ensure => 'absent',
    }
  }
}
