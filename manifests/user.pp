define paranoid_browser::user (
  $user = undef,
){
  file { "${user}-sudoconfig" :
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => template('paranoid_user/user_sudo.erb'),
    path    => "/etc/sudoers.d/paranoid_browser_user_${user}",
    require => [ Package['sudo'], Class[Paranoid_browser], ],
  }
}
