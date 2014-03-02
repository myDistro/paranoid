# == Class: paranoid_browser
#
# creates a sudo configuration for firefox, chrome, google-chrome.
# So you can run these programms as another user
#
# === Parameters
#
# Document parameters here.
#
# [*browser_user*]
#   The user who runs the browser for you. default = 'browser'
#
# [*browser_group*]
#   The group of that user which you use to run the browser via sudo.
#
# [*browser_home*]
#   Home of the user who runs the browser
#
# === Examples
#
#  class { paranoid_browser:  }
#  class { paranoid_browser:  
#    browser_user => 'paranoid',
#    browser_home => '/dev/mem'
#  }
#
# === Authors
#
# Ingolf Wagner <palipalo9@gmail.com>
#
# === Copyright
#
# Copyright 2014 Ingolf Wagner.
#
class paranoid_browser (
  $browser_user  = 'browser',
  $browser_group = 'browser',
  $browser_home  = '/home/browser',
) {
  user { $browser_user: 
    ensure  => present,
    comment => 'Paranoid Browser,,,',
    managehome => true,
    groups => ['audio'],
    password => '!',
  }
  file { $browser_home:
    ensure => 'directory',
    group  => $browser_group,
    mode   => '777',
    owner  => $browser_user,
    require => [User[$browser_user],Group[$browser_group]]
  }
  # create define for that to make it possible to use it for more 
  # than one user
  file { "sudoers":
    path    => '/etc/sudoers',
    source  => 'puppet:///modules/paranoid_browser/sudoers',
    owner => "root",
    group => "root",
    mode  => 440,
    require => Package['sudo']
  }
  #file { '/home/palo/downloads':
    #ensure => 'link',
    #group  => '1000',
    #mode   => '777',
    #owner  => '1000',
    #target => '/home/browser/',
  #}
  #file { [ 
    #'/home/palo/.mozilla',
    #'/home/palo/.cache/google-chrome',
    #'/home/palo/.config/google-chrome',
    #'/home/palo/.cache/chromium',
    #'/home/palo/.config/chromium',
  #]:
    #ensure => absent,
    #force => yes,
  #}
  #case $operatingsystem {
    #debian:{
      #package { ['iceweasel','chromium']:
        #ensure => present,
      #}
    #}
    #default:{ 
      #package{ "firefox":
        #ensure  => present,
      #}
    #}
  #}
}
