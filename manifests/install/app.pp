# == Class: gerrit::install::app
#
# Install the base gerrit binary
#
class gerrit::install::app {

  include ::gerrit

  if $gerrit::s3_bucket {
    # Download WAR file from S3 Bucket
    # Expects AWS CLI tools, and permissions to be already configured
    exec { "aws s3 cp s3://${gerrit::s3_bucket}/gerrit-${gerrit::version}.war $gerrit::jar": 
      path => '/usr/local/bin',
      logoutput => true,
    } -> 
    exec { "chown ${gerrit::user}:${gerrit::user} $gerrit::jar && chmod 774 $gerrit::jar":
      path => '/bin'
    }
    
  } else {
    # Download WAR file using wget
    wget::fetch { "${gerrit::war_url}":
      destination => $gerrit::jar,
    }
  }


}
