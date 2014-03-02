define paranoid_browser::user (
  $user = undef,
){
  file { "${user}-sudoconfig" :
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    content => template('paranoid_browser/sudo_user.erb'),
    path    => "/etc/sudoers.d/paranoid_browser_user_${user}",
    require => [ Package['sudo'], Class[Paranoid_browser], ],
  }
}
