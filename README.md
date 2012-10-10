carbios
=======

Carbios sends Nagios perfdata to graphite and serves as a replacement for pnp4nagios.

install
-------

RubyGems:

```sh
gem install carbios
```

or source:

```sh
gem install bundler
git clone git://github.com/ideeli/carbios.git
cd carbios
bundle install
```

nagios integration
------------------

in nagios.cfg
```
perfdata_timeout=5
host_perfdata_file=/var/spool/nagios/host-perfdata
service_perfdata_file=/var/spool/nagios/service-perfdata

host_perfdata_file_template=TIMET::$TIMET$\tHOSTNAME::$HOSTNAME$\tHOSTPERFDATA::$HOSTPERFDATA$
service_perfdata_file_template=TIMET::$TIMET$\tHOSTNAME::$HOSTNAME$\tSERVICEDESC::$SERVICEDESC$\tSERVICEPERFDATA::$SERVICEPERFDATA$

host_perfdata_file_mode=a
service_perfdata_file_mode=a

host_perfdata_file_processing_interval=60
service_perfdata_file_processing_interval=60

host_perfdata_file_processing_command=carbios-bulk-host
service_perfdata_file_processing_command=carbios-bulk-service

define command{
  command_name    carbios-bulk-service
  command_line    carbios -c /etc/carbios.yaml /var/spool/pnp4nagios/nagios/service-perfdata
}

define command{
  command_name    carbios-bulk-host
  command_line    carbios -c /etc/carbios.yaml /var/spool/pnp4nagios/nagios/host-perfdata
}
```

gotchas
-------
* You may have to create the /var/spool/nagios directory and make sure that
it is owned by the nagios user.
* command_line in the carbios-bulk-host and carbios-bulk-service commands may 
need to include the fully qualfied path to where the carbios binary is installed.  If
installed from source, it should be `bundle exec carbios` to make sure that the proper
gems are used
