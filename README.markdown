This is the paranoid module.
It's basically the blog-post of [calium.org](http://calum.org/) :
[running firefox as another user using sudo](http://calum.org/posts/running-firefox-as-another-user-using-sudo).

It configures sudo so you can run the commons like firefox, chromium, google-chrome or skype as another user.
You can use the class paranoid to set up the sudoers file, but you don't have to.
If you don't use the paranoid class, you have to make sudo load the files in /etc/sudoers.d/ folder.

## Usage


To run firefox and thunderbird as the user browser you can do the same thing.

    /* 
      not really necessary 
      creates only good sudoers file
    */
    class { 'paranoid': } 
    
    /*
      create a sudo file to run firefox and thunderbird
      as user browser
    */
    paranoid::user { 'browsing': 
        master   => 'my_name' ,
        puppet   => 'browser',
        binaries => ['/usr/bin/firefox',
                     '/usr/bin/thunderbird'],
    }

Make sure you run a xhost for programs (like firefox) that need X.
For example put in you ~/.xsession
    
    xhost +

Now you can run firefox as user browser with the command
    
    sudo -u browser -H /usr/bin/firefox

Or 

    sudo -u browser -H firefox
    



## Links

* [Puppet Forge](https://forge.puppetlabs.com/myDistro/paranoid)
* [Github](http://github.com/myDistro/paranoid)
* [myDistro](http://myDistro.github.io)
