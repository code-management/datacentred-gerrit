#Gerrit
[![Build Status](https://travis-ci.org/evidex/datacentred-gerrit.svg)](https://travis-ci.org/evidex/datacentred-gerrit)

####Table of Contents

1. [Overview](#overview)
2. [Dependencies](#dependencies)
3. [Module Description - What the module does and why it is useful](#module-description)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)

##Overview

Module to install and configure gerrit code review

##Dependencies

* puppetlabs/puppetlabs-inifile
* puppetlabs/puppetlabs-mysql
* puppetlabs/puppetlabs-stdlib
* maestrodev/puppet-wget

##Module Description

Installs the gerrit server packages and dependencies, optionally manages
a database locally and allows basic configuration and authentication.

##Usage

To install a basic default installation with H2 database, OpenID authentication
into /opt/gerrit/review

```puppet
include ::gerrit
```

To connect to an external database

```puppet
class { 'gerrit':
  db_manage   => true,
  db_provider => 'MYSQL',
  db_hostname => 'db.example.com',
  db_database => 'reviewdb',
  db_username => 'gerrit2',
  db_password => 'Kubhit8Quaut',
}
```

To authenticate against LDAP

```puppet
class { 'gerrit':
  auth_type                 => 'LDAP',
  ldap_server               => 'ldap://ldap.example.com',
  ldap_account_base         => 'ou=People,dc=example,dc-com',
  ldap_account_pattern      => '(&(objectClass=person)(uid=${username}))',
  ldap_full_name            => 'displayName',
  ldap_email_address        => 'mail',
  ldap_group_base           => 'ou=Groups,dc=example,dc=com',
  ldap_group_member_pattern => '(&(objectClass=group)(member=${dn}))',
}
```

##Limitations

Only tested on Ubuntu 14.04

