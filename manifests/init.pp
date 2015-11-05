# == Class: gerrit
#
# Installs an instance of gerrit code review
#
# === Parameters
#
# [*version*]
#   Gerrit version to use
#
# [*jdk_version*]
#   JDK version to install
#
# [*user*]
#   Unprivilieged user to run as
#
# [*user_groups*]
#   Groups the $user should belong to
#
# [*home*]
#   Gerrit user's home and install directory
#
# [*service*]
#   Gerrit service name to create for init integration
#
# [*db_manage*]
#   Whether this module manages the database
#
# [*db_type*]
#   What flavour of database to provision
#
# [*db_hostname*]
#   Where the database resides
#
# [*db_database*]
#   Name of the database to connect to
#
# [*db_username*]
#   Name of the user to connect as
#
# [*db_password*]
#   Database user's password
#
# [*base_path*]
#   Base path of the git repository
#
# [*weburl*]
#   Canonical web URL of the instance
#
# [*webport*]
#   Port for the web server to listen on
#
# [*index_type*]
#   Secondary index type
#
# [*auth_type*]
#   Authentication type
#
# [*ldap_server*]
#   LDAP authentication server
#
# [*ldap_account_base*]
#   Base path for account lookups
#
# [*ldap_account_pattern*]
#   Pattern to lookup acount details
#
# [*ldap_full_name*]
#   Field to extract full name from
#
# [*ldap_email_address*]
#   Field to extract email address from
#
# [*ldap_group_base*]
#   Base path for group lookups
#
# [*ldap_group_member_pattern*]
#   Pattern to lookup group memberships
#
# [*ldap_username*]
#   Username to bind to the LDAP server with. If not set, an anonymous 
#   connection to the LDAP server is attempted.
#
# [*ldap_password*]
#   Password for the user identified by $ldap_username. If not set, an 
#   anonymous (or passwordless) connection to the LDAP server is attempted.
#
# [*ldap_ssl_verify*]
#   If false and ldap.server is an ldaps:// style URL, Gerrit will not 
#   verify the server certificate when it connects to perform a query.
#   By default, true, requiring the certificate to be verified.
#
# [*war_url*]
#   URL to use when downloading Gerrit war file
#
# [*s3_bucket*]
#   S3 Bucket from which to download Gerrit war file 
#   If this param is passed, $war_url is ignored. 
#
# [*sendemail_enable*]
#   If false Gerrit will not send email messages, for any reason, and all 
#   other properties of section sendemail are ignored.
#
# [*sendemail_from*]
#   From field for generated emails
#
# [*smtp_server*]
#   SMTP mail server
#
# [*smtp_server_port*]
#   Port to use when contacting SMTP server  
#
# [*smtp_user*]
#   Username for SMTP authentication
#
# [*smtp_pass*]
#   Password for SMTP authentication
#
# [*smtp_sll_verify*]
#   Whether to verify SSL connection if smtp_encryption is used
#
# [*smtp_encryption*]
#   Encryption method to use for SMTP connections
#
class gerrit (
  $version                    = $gerrit::params::version,
  $jdk_version                = $gerrit::params::jdk_version,
  $user                       = $gerrit::params::user,
  $user_groups                = $gerrit::params::user_groups,
  $home                       = $gerrit::params::home,
  $service                    = $gerrit::params::service,
  $db_manage                  = $gerrit::params::db_manage,
  $db_type                    = $gerrit::params::db_type,
  $db_hostname                = $gerrit::params::db_hostname,
  $db_port                    = $gerrit::params::db_port,
  $db_database                = $gerrit::params::db_database,
  $db_username                = $gerrit::params::db_username,
  $db_password                = $gerrit::params::db_password,
  $base_path                  = $gerrit::params::base_path,
  $weburl                     = $gerrit::params::weburl,
  $webport                    = $gerrit::params::webport,
  $index_type                 = $gerrit::params::index_type,
  $auth_type                  = $gerrit::params::auth_type,
  $ldap_server                = $gerrit::params::ldap_server,
  $ldap_account_base          = $gerrit::params::ldap_account_base,
  $ldap_account_pattern       = $gerrit::params::ldap_account_pattern,
  $ldap_full_name             = $gerrit::params::ldap_full_name,
  $ldap_email_address         = $gerrit::params::ldap_email_address,
  $ldap_group_base            = $gerrit::params::ldap_group_base,
  $ldap_group_member_pattern  = $gerrit::params::ldap_group_member_pattern,
  $ldap_username              = $gerrit::params::ldap_username,
  $ldap_password              = $gerrit::params::ldap_password,
  $ldap_ssl_verify            = $gerrit::params::ldap_ssl_verify,
  $war_url                    = $gerrit::params::war_url,
  $s3_bucket                  = $gerrit::params::s3_bucket,
  $sendemail_enable           = $gerrit::params::sendemail_enable,
  $sendemail_from             = $gerrit::params::sendemail_from,
  $smtp_server                = $gerrit::params::smtp_server,
  $smtp_server_port           = $gerrit::params::smtp_server_port,
  $smtp_user                  = $gerrit::params::smtp_user,
  $smtp_pass                  = $gerrit::params::smtp_pass,
  $smtp_ssl_verify            = $gerrit::params::smtp_ssl_verify,
  $smtp_encryption            = $gerrit::params::smtp_encryption,
) inherits gerrit::params {

  $auth_type_array = [
    'OpenID',
    'OpenID_SSO',
    'HTTP',
    'HTTP_LDAP',
    'CLIENT_SSL_CERT_LDAP',
    'LDAP',
    'LDAP_BIND',
  ]
  $auth_type_re = join($auth_type_array, '|')
  $smtp_encryption_array = [
    'ssl',
    'tls'
  ]
  $smtp_encryption_re = join($smtp_encryption_array, '|')
  
  validate_string($version)
  validate_string($jdk_version)
  validate_string($user)
  validate_array($user_groups)
  validate_absolute_path($home)
  validate_string($service)
  validate_bool($db_manage)
  validate_re($db_type, '^POSTGRESQL|H2|MYSQL|JDBC$')
  validate_string($db_hostname)
  validate_integer($db_port)
  validate_string($db_database)
  validate_string($db_username)
  validate_string($db_password)
  validate_string($base_path)
  validate_string($weburl)
  validate_re("${webport}", '^\d+$')
  validate_re("${index_type}", '^LUCENE|SOLR$')
  validate_re("${auth_type}", "^${auth_type_re}$")
  validate_string($ldap_server)
  validate_string($ldap_account_base)
  validate_string($ldap_account_pattern)
  validate_string($ldap_full_name)
  validate_string($ldap_email_address)
  validate_string($ldap_group_base)
  validate_string($ldap_group_member_pattern)
  validate_string($ldap_username)
  validate_string($ldap_password)
  validate_bool($ldap_ssl_verify)
  validate_string($s3_bucket)
  
  if (! (is_domain_name($smtp_server) or is_ip_address($smtp_server))) {
    fail("Failed to validate param smtp_server. [${smtp_server}]")
  }
  validate_integer($smtp_server_port)
  validate_string($smtp_user)
  validate_string($smtp_pass)
  validate_bool($smtp_ssl_verify)
  if ( $smtp_encryption != undef) {
    validate_re("${smtp_encryption}", "^${smtp_encryption_re}$")
  }


  $app = "${home}/review"
  $dir = "${home}/${version}"
  $jar = "${home}/${version}/gerrit-${version}.war"

  include ::gerrit::install
  include ::gerrit::configure
  include ::gerrit::service

  Class['::gerrit::install'] ->
  Class['::gerrit::configure'] ~>
  Class['::gerrit::service']

}
