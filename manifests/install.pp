# @summary Manage perfsonar packages
# @api private
class perfsonar::install {
  assert_private()

  package { $::perfsonar::bundle:
    ensure => 'installed',
  }

  $::perfsonar::optional_packages.each |$package| {
    package { $package:
      ensure => 'installed',
    }
  }
}
