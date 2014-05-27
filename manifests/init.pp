/*
 == Class: paranoid

 creates a sudo configuration for firefox, chrome, google-chrome.
 So you can run these programms as another user

 === Parameters

 Document parameters here.


 === Examples

  class { paranoid: }

 === Authors

 Ingolf Wagner <palipalo9@gmail.com>

 === Copyright

 Copyright 2014 Ingolf Wagner.

*/
class paranoid {
  # create define for that to make it possible to use it for more 
  # than one user
  file { "sudoers":
    path    => '/etc/sudoers',
    source  => 'puppet:///modules/paranoid/sudoers',
    owner => "root",
    group => "root",
    mode  => 440,
    require => Package['sudo']
  }
}
