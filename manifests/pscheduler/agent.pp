# @summary Manage pschedular-agent service
# @api private
class perfsonar::pscheduler::agent {
  assert_private()

  $config_path = '/etc/perfsonar/psconfig/pscheduler-agent.json'

  service { 'psconfig-pscheduler-agent':
    ensure => running,
    enable => true,
  }

  if $perfsonar::pscheduler_agent_config {
    file { $config_path:
      ensure  => file,
      owner   => 'perfsonar',
      group   => 'perfsonar',
      mode    => '0644',
      content => stdlib::to_json_pretty($perfsonar::pscheduler_agent_config),
      notify  => Service['psconfig-pscheduler-agent'],
    }
  }
}
