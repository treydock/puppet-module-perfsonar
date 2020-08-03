# @summary Manage pschedular-agent service
# @api private
class perfsonar::pscheduler::agent {
  assert_private()

  if $::perfsonar::pscheduler_agent_config {
    file { '/etc/perfsonar/psconfig/pscheduler-agent.json':
      ensure  => file,
      owner   => 'perfsonar',
      group   => 'perfsonar',
      mode    => '0644',
      content => to_json_pretty($::perfsonar::pscheduler_agent_config),
    }
  }
}
