# == Class: paranoid_browser
#
# Full description of class paranoid_browser here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { paranoid_browser:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
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
