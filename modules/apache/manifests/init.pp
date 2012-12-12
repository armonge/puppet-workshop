class apache{
    package{'apache2':
        ensure  => present,
    }
    service{'apache2':
        ensure  => running,
        enable  => true,
    }
    file{'/var/www':
	ensure => directory,
	owner  => 'www-data',
	require => Package['apache2'],
    }
}
