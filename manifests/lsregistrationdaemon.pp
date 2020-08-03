# @summary Manage perfsonar-lsregistrationdaemon service
# @api private
class perfsonar::lsregistrationdaemon {
  assert_private()

  service { 'perfsonar-lsregistrationdaemon':
    ensure => $::perfsonar::lsregistrationdaemon_ensure,
    enable => $::perfsonar::lsregistrationdaemon_enable,
  }
}
