# == Class: gerrit::configure::app
#
# Configure the gerrit application
#
class gerrit::configure::app {

  include ::gerrit

  $gerrit_site = $gerrit::app
  $init_jar = "${gerrit::app}/bin/gerrit.war"
  $init_args = "init -d ${gerrit::app} --batch --no-auto-start"

  exec { 'gerrit init':
    path => '/usr/bin',
    command => "java -jar ${init_jar} ${init_args}",
    user    => $gerrit::user,
    creates => "${gerrit::app}/bin/gerrit.sh",
    logoutput => true,
    tries => 2,
  } ->

  file { "/etc/init.d/${gerrit::service}":
    ensure => link,
    target => "${gerrit::app}/bin/gerrit.sh",
  } ->

  file { "/etc/rc3.d/99${gerrit::service}":
    ensure => link,
    target => "/etc/init.d/${gerrit::service}",
  } ->

  file { '/etc/default/gerritcodereview':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('gerrit/gerritcodereview.erb'),
  }

}
