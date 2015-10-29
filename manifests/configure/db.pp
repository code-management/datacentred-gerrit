# == Class: gerrit::configure::db
#
# Configure gerrit for the requested database
#
class gerrit::configure::db {

  case $gerrit::db_provider {

    'MYSQL': {

      $init_jar = "${gerrit::dir}/gerrit-${gerrit::version}.war"
      $init_args = "init -d ${gerrit::app} --batch --no-auto-start"

      file { "${gerrit::app}/lib/mysql.jar":
        ensure => link,
        target => '/usr/share/java/mysql.jar',
      } ~>

      exec { 'gerrit init mysql':
        path => '/usr/bin',
        command     => "java -jar ${init_jar} ${init_args}",
        user        => $gerrit::user,
        refreshonly => true,
      }

    }

    'H2': {
      # Nothing to do
    }

    default: {
      err('gerrit::configure::db: unsupported database provider')
    }

  }

}
