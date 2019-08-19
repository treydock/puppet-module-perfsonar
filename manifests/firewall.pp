# @summary Manage perfSONAR firewall rules
# @api private
class perfsonar::firewall {
  assert_private()

  include ::firewall

  firewall { '100 forward to perfSONAR':
    chain => 'INPUT',
    jump  => 'perfSONAR',
    proto => 'all',
  }

  firewallchain { 'perfSONAR:filter:IPv4':
    ensure => 'present',
    purge  => true,
  }

  $ipv4_firewall_rules = [
    {'name' => 'icmp', 'dport' => undef, 'proto' => ['icmp']},
  ]
  $ipv6_firewall_rules = [
    {'name' => 'icmp', 'dport' => undef, 'proto' => ['ipv6-icmp']},
  ]
  $firewall_rules = [
    {'name' => 'owamp-test', 'dport' => '8760-9960', 'proto' => ['udp','tcp']},
    {'name' => 'owamp-control', 'dport' => '861', 'proto' => ['tcp']},
    {'name' => 'twamp-test', 'dport' => '18760-19960', 'proto' => ['udp','tcp']},
    {'name' => 'twamp-control', 'dport' => '862', 'proto' => ['tcp']},
    {'name' => 'bwctl-control', 'dport' => '4823', 'proto' => ['tcp']},
    {'name' => 'traceroute', 'dport' => '33434-33634', 'proto' => ['udp']},
    {'name' => 'iperf3', 'dport' => '5201', 'proto' => ['tcp','udp']},
    {'name' => 'iperf2', 'dport' => '5001', 'proto' => ['tcp','udp']},
    {'name' => 'nuttcp', 'dport' => ['5000','5101'], 'proto' => ['tcp','udp']},
    {'name' => 'web', 'dport' => ['80','443'], 'proto' => ['tcp']},
    {'name' => 'lookup', 'dport' => '8090', 'proto' => ['tcp']},
    {'name' => 'ndt-test', 'dport' => '3001-3003', 'proto' => ['tcp']},
    {'name' => 'ndt-control', 'dport' => '7123', 'proto' => ['tcp']},
    {'name' => 'ndt-flash', 'dport' => '843', 'proto' => ['tcp']},
  ]

  ($ipv4_firewall_rules + $firewall_rules).each |Integer $index, Hash $rule| {
    $_i = sprintf('%05d', $index)
    $rule['proto'].each |String $proto| {
      firewall { "${_i} ${rule['name']} ${proto} ipv4":
        proto  => $proto,
        dport  => $rule['dport'],
        chain  => 'perfSONAR',
        action => 'accept',
      }
    }
  }

  if $::perfsonar::with_ipv6 {
    firewall { '100 forward to perfSONAR ipv6':
      chain    => 'INPUT',
      jump     => 'perfSONAR',
      provider => 'ip6tables',
    }

    firewallchain { 'perfSONAR:filter:IPv6':
      ensure => 'present',
      purge  => true,
    }

    ($ipv6_firewall_rules + $firewall_rules).each |Integer $index, Hash $rule| {
      $_i = sprintf('%05d', $index)
      $rule['proto'].each |String $proto| {
        firewall { "${_i} ${rule['name']} ${proto} ipv6":
          proto    => $proto,
          dport    => $rule['dport'],
          chain    => 'perfSONAR',
          action   => 'accept',
          provider => 'ip6tables',
        }
      }
    }
  }

}
