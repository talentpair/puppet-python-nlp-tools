#
# if you update the packages here you should rebuild the containerbase and containerscientistbase images as outlined here:
# https://talentpair.atlassian.net/wiki/display/DEV/Deploys
#
# things start to get slow otherwise
#

class tools {
  include tpapt

  apt::source { 'apt.postgresql.org':
    location    => 'http://apt.postgresql.org/pub/repos/apt/',
    release     => "trusty-pgdg",
    repos       => "main 9.4",
    key         => 'B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8',
    key_source  => 'https://www.postgresql.org/media/keys/ACCC4CF8.asc',
    include_src => false,
  }

  $toolspackages = [
    "curl",
    "wget",
    "vim-gtk",  # vim-gtk has +clipboard support
    "tmux",
    "emacs",
    "git",
    'default-jre',

    # added for scikit and scipy
    "build-essential",
    "libblas-dev",
    "liblapack-dev",
    "libatlas-dev",
    "libatlas3gf-base",
    "python-setuptools",
    "gfortran",

    # added for secure requests
    "libffi-dev",
    "libssl-dev",

    "python-dev",
    "python-pip",
    "fabric",
    "htop",
    "zip",
    "unzip",
    "colordiff",
    "libxml2-dev",
    "libxslt1-dev",
    "abiword",
    "postgresql-client-common",
    "postgresql-client-9.4",
    "redis-tools",
    "libjpeg-dev",
    "libpng12-dev",
    "libpq-dev",

    # required for latest matplotlib on 14.04 Ubuntu
    "pkg-config",
    "libfreetype6-dev",
    "tk-dev",
    "python-tk",
  ]

  # install packages
  package { $toolspackages:
    ensure => present,
    require => [ Exec["apt_update"], Apt::Source['apt.postgresql.org'] ]
  }

  #
  # data analysis tools
  #
  $dataanlysistools = [
    "cmake",
    "qt4-dev-tools",
    "qt4-qmake",
    "python-sip",
    "python-qt4",
    "python-qt4-dev",
    "python-pyside",
  ]

  package { $dataanlysistools:
    ensure => present,
    require => [ Exec["apt_update"], Apt::Source['apt.postgresql.org'], Package[$toolspackages] ]
  }

  exec {"install_setuptools":
    command => "pip install -U setuptools",
    require => Package['python-pip']
  }

  exec {"install_pip":
    command => "pip install -U pip",
    require => [ Package['python-pip'], Exec["install_setuptools"] ]
  }

  file {"/etc/tutorial.requirements.txt":
      ensure => present,
      mode => '0644',
      source => "puppet:///modules/tools/tutorial.requirements.txt"
  }

  exec { "pip_requirements_install":
      command => "sudo pip install -r /etc/tutorial.requirements.txt && python -m nltk.downloader -d /usr/share/nltk_data punkt && python -m nltk.downloader -d /usr/share/nltk_data stopwords",
      timeout     => 18000,
      require => [ Exec["install_pip"], Package[$dataanlysistools], File['/etc/tutorial.requirements.txt'] ]
  }
}
