# @summary Manage perfsonar repo
# @api private
class perfsonar::repo {
  assert_private()

  if $facts['os']['family'] == 'RedHat' {
    if $perfsonar::manage_epel {
      contain 'epel'
    }
    if versioncmp($facts['os']['release']['major'], '8') >= 0 {
      $gpgkey_path = '/etc/pki/rpm-gpg/RPM-GPG-KEY-perfSONAR'
      $gpgkey = "file://${gpgkey_path}"
      exec { 'RPM-GPG-KEY-Globus':
        path    => '/usr/bin:/bin:/usr/sbin:/sbin',
        command => "wget -qO- ${perfsonar::release_url} | rpm2cpio - | cpio -i --quiet --to-stdout .${gpgkey_path} > ${gpgkey_path}",
        creates => $gpgkey_path,
        before  => Yumrepo['perfSONAR'],
      }
    } else {
      $gpgkey = 'http://software.internet2.edu/rpms/RPM-GPG-KEY-perfSONAR'
    }
    yumrepo { 'perfSONAR':
      descr      => 'perfSONAR RPM Repository - software.internet2.edu - main',
      mirrorlist => "http://software.internet2.edu/rpms/el${facts['os']['release']['major']}/mirrors-Toolkit-Internet2",
      enabled    => '1',
      protect    => '0',
      gpgkey     => $gpgkey,
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
