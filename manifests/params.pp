# == Class: gerrit::params
#
# Default and OS specific default parameters
#
class gerrit::params {

  $version = '2.9.3'
  $jdk_version = '7'
  $war_url = "http://gerrit-releases.storage.googleapis.com/gerrit-${version}.war"
  $s3_bucket = undef
  $user = 'gerrit2'
  $user_groups = undef
  $home = '/opt/gerrit'
  $service = 'gerrit'
  $base_path = 'git'
  $weburl = "http://${::fqdn}"
  $webport = 8080
  $index_type = 'LUCENE'

  # AUTH
  $auth_type = 'OPENID'

  # LDAP
  $ldap_server = undef
  $ldap_ssl_verify = true
  $ldap_account_base = undef
  $ldap_account_pattern = "(&(objectClass=person)(uid=\${username}))"
  $ldap_full_name = 'displayName'
  $ldap_email_address = 'mail'
  $ldap_group_base = undef
  $ldap_group_member_pattern = "(&(objectClass=group)(member=\${dn}))"
  $ldap_username = undef
  $ldap_password = undef

  # SENDEMAIL
  $sendemail_enable = true
  $sendemail_from = 'MIXED'
  $smtp_server = 'localhost'
  $smtp_server_port = undef
  $smtp_user = undef
  $smtp_pass = undef
  $smtp_ssl_verify = true
  $smtp_encryption = undef

  # DATABASE
  $db_manage = true
  $db_type = 'H2'
  $db_hostname = 'localhost'
  $db_database = 'reviewdb'
  $db_username = 'gerrit2'
  $db_password = 'password'

}
