class tppuppet {
    include tpapt

    apt::source { 'puppetlabs':
      location    => 'http://apt.puppetlabs.com',
      repos       => 'main dependencies',
      key         => '47B320EB4C7C375AA9DAE1A01054B7A24BD6EC30',
      key_server  => 'pgp.mit.edu',
      include_src => false,
    }

    # install latest version of puppet!
    package {'puppet':
      ensure  => latest,
      require => Apt::Source['puppetlabs']
    }

    # add hiera conf
    file { "/etc/puppet/hiera.yaml" :
        mode => '0644',
        source => 'puppet:///modules/tppuppet/hiera.yaml'
    }

    # silence puppet and vagrant annoyance about the puppet group
    group { 'puppet':
        ensure => 'present'
    }

    file {"/home/ubuntu/.screenrc":
        ensure => present,
        owner => 'ubuntu',
        group => 'ubuntu',
        mode => '0644',
        source => "puppet:///modules/tppuppet/screenrc",
    }
}
