# == Class: gerrit::install::app
#
# Install the base gerrit binary
#
class gerrit::install::app {

  include ::gerrit

  wget::fetch { "${gerrit::war_url}":
    destination => $gerrit::jar,
  }

}
