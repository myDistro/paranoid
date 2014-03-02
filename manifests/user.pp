define paranoid_browser::user (
  $user = undef,
){
  file { "${user}-sudoconfig" :
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('paranoid_user/user_sudo.erb'),
    require => [ Package['sudo'], Class[Paranoid_browser], ],
  }
}
