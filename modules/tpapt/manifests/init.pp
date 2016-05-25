class tpapt {
  class { 'apt':
    # TODO: string comparison is broken in the newest version of puppet, lets just update every time for now
    # Error: Evaluation Error: Comparison of: String < Integer, is not possible.
    # Caused by 'A String is not comparable to a non String'.
    # at /home/ubuntu/puppet/modules/apt/manifests/update.pp:20:41 on node utility2.us-west-2.compute.internal
    always_apt_update    => false,
    apt_update_frequency => 'reluctantly',
    disable_keys         => undef,
    proxy_host           => false,
    proxy_port           => '8080',
    purge_sources_list   => false,
    purge_sources_list_d => false,
    purge_preferences_d  => false,
    update_timeout       => undef,
    fancy_progress       => undef
  }
}
