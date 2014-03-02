# == Class: paranoid-browser
#
# Full description of class paranoid-browser here.
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
#  class { paranoid-browser:
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
class paranoid-browser (
  $user      = $paranoid-browser::params::user,
  $group     = $paranoid-browser::params::group,
  $user_home = $paranoid-browser::params::user_home,

) inherits paranoid-browser::params {
  user { $user: 
    ensure  => present,
    comment => 'Paranoid Browser,,,',
    managehome => true,
    groups => ['audio'],
    password => '!',
  }
  file { $user_home:
    ensure => 'directory',
    group  => $group,
    mode   => '777',
    owner  => $user,
    require => [User[$user],Group[$group]]
  }
  # create define for that to make it possible to use it for more 
  # than one user
  file { "${user}-sudoers":
    path    => '/etc/sudoers',
    source  => 'puppet:///modules/paranoid-browser/sudoers',
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
