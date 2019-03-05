include ::systemd::daemon_reload

class systemd::daemon_reload {
  exec { '/usr/bin/systemctl daemon-reload':
    refreshonly => true,
  }
}


file { '/etc/systemd/system/consul.service':
  content => epp('/etc/puppetlabs/code/environments/production/templates/consul.service.epp',
    {
	bind_address 	=> lookup('bind_address'),
    }
  ),
  notify => Class['systemd::daemon_reload'],
}

file { '/etc/consul/config.json':
  content => epp('/etc/puppetlabs/code/environments/production/templates/config.json.epp',
   {
      datacenter_name   => lookup('datacenter_name'),
      join_ips 		=> lookup('join_ips'),
   }
  ),
}

service {'consul':
 require => Class['systemd::daemon_reload'],
}
