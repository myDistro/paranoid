define paranoid::user ( 
  $master,
  $puppet,
  $binaries     = [],
  $managePuppet = false,

) {

  file { "sudoconfig-${master}-${puppet}" :
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    content => template('paranoid/sudo_user.erb'),
    path    => "/etc/sudoers.d/paranoid_${master}_${puppet}",
    require => [Package['sudo'],User[$puppet],User[$master]],
  }

  if( $managePuppet == true ) {
    user { $puppet:
      ensure  => present,
      comment => 'Paranoid Puppet,,,',
      managehome => true,
      groups => ['audio'],
      password => '!',
    }
    group { $puppet:
      ensure => present,
    }
    file { "/home/${puppet}":
      ensure => 'directory',
      group  => $puppet,
      mode   => '777',
      owner  => $puppet,
      require => [User[$puppet],Group[$puppet]]
    }
  }
}
