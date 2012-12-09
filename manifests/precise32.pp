file{'resolv.conf':
    path    => '/etc/resolv.conf',
    ensure  =>  file,
    content =>  'nameserver 8.8.8.8',
    mode    =>  '0644',
    owner   =>  'root',
}

package{'vim':
    ensure  =>  present,
}

File['resolv.conf'] -> Package <| |>
include apache
apache::vhost{'agent.armonge.info':}
file{'/var/www/agent.armonge.info/public_html/index.html':
    ensure  => file,
    content => '<h1>agent.armonge.info</h1>',
    owner   => 'www-data',
    require => Apache::Vhost['agent.armonge.info'],
}
