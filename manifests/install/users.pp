# == Class: gerrit::install::users
#
# Create the unprivileged gerrit users
#
class gerrit::install::users {

  include ::gerrit

  user { $gerrit::user:
    ensure => present,
    home   => $gerrit::home,
    shell  => '/bin/false',
    system => true,
    groups => $gerrit::user_groups,
  }

}
