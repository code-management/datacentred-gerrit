# Class: gerrit::configure::config
#
# Application configuration
#
class gerrit::configure::config {

  include ::gerrit

  gerrit::config { 'gerrit/basePath':
    value => $gerrit::basepath,
  }

  gerrit::config { 'gerrit/canonicalWebUrl':
    value => "${gerrit::weburl}:${gerrit::webport}/",
  }

  gerrit::config { 'database/type':
    value => $gerrit::db_provider,
  }

  gerrit::config { 'database/hostname':
    value => $gerrit::db_hostname,
  }

  gerrit::config { 'database/database':
    value => $gerrit::db_database,
  }

  gerrit::config { 'database/username':
    value => $gerrit::db_username,
  }

  gerrit::config { 'database/password':
    value => $gerrit::db_password,
  }

  gerrit::config { 'index/type':
    value => $gerrit::index_type,
  }

  gerrit::config { 'auth/type':
    value => $gerrit::auth_type,
  }

  if $gerrit::auth_type == 'LDAP' {

    gerrit::config { 'ldap/server':
      value => $gerrit::ldap_server,
    }

    gerrit::config { 'ldap/accountBase':
      value => $gerrit::ldap_account_base,
    }

    gerrit::config { 'ldap/accountPattern':
      value => $gerrit::ldap_account_pattern,
    }

    gerrit::config { 'ldap/accountFullName':
      value => $gerrit::ldap_full_name,
    }

    gerrit::config { 'ldap/accountEmailAddress':
      value => $gerrit::ldap_email_address,
    }

    gerrit::config { 'ldap/groupBase':
      value => $gerrit::ldap_group_base,
    }

    gerrit::config { 'ldap/groupMemeberPattern':
      value => $gerrit::ldap_group_member_pattern,
    }

  }

}
