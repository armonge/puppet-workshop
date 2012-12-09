define apache::vhost(
    $interface = '*',
    $port = '80',
    $server_name = $title,
    $server_alias = '',
    $site_root = "/var/www/${title}",
    $log_dir = "/var/log/apache2/${title}",
    $site_enabled = true,
){
    file{"/etc/apache2/sites-available/${name}":
        ensure  => file,
        content => template('apache/vhost.erb'),
    }

    if $site_enabled {
        file{"/etc/apache2/sites-enabled/${name}":
            ensure  => link,
            target  => "/etc/apache2/sites-available/${name}",
            notify  => Service['apache2'],
        }
    }
    else{
        file{"/etc/apache2/sites-enabled/${name}":
            ensure  => absent,
            notify  => Service['apache2'],
        }
    }


    file{$site_root:
        ensure  => directory,
        owner   => 'www-data',
    }
    file{"${site_root}/public_html":
        ensure  => directory,
        owner   => 'www-data',
    }
    file{$log_dir:
        ensure  => directory,
        owner   => 'www-data',
    }
}
