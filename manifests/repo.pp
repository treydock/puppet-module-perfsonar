# @summary Manage perfsonar repo
# @api private
class perfsonar::repo {
  assert_private()

  if $facts['os']['family'] == 'RedHat' {
    if $perfsonar::manage_epel {
      contain 'epel'
    }
    yumrepo { 'perfSONAR':
      descr      => 'perfSONAR RPM Repository - software.internet2.edu - main',
      mirrorlist => "http://software.internet2.edu/rpms/el${facts['os']['release']['major']}/mirrors-Toolkit-Internet2",
      enabled    => '1',
      protect    => '0',
      gpgkey     => 'http://software.internet2.edu/rpms/RPM-GPG-KEY-perfSONAR',
      gpgcheck   => '1',
    }
  }

  if $facts['os']['family'] == 'Debian' {
    apt::source { 'perfsonar-release':
      ensure   => 'present',
      location => 'http://downloads.perfsonar.net/debian/',
      repos    => 'main',
      release  => 'perfsonar-release',
      include  => {
        'src' => true,
      },
      key      => {
        'id'     => '5A507954F531B92300DA2068351ED8279AFA4E0A',
        'source' => 'http://downloads.perfsonar.net/debian/perfsonar-debian-official.gpg.key',
      },
    }
  }
}
