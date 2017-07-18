[![Build Status](https://travis-ci.org/tumf/ansible-role-systemd-service.svg)](https://travis-ci.org/tumf/ansible-role-systemd-service)
[![Ansible Galaxy](http://img.shields.io/badge/ansible--galaxy-systemd--service-blue.svg)](https://galaxy.ansible.com/tumf/systemd-service/)

systemd-service - Ansible role
===============

Register services to systemd.

> **Japanese ver**
> http://qiita.com/tumf/items/9d5ac6853685ba53214d


Install
-------

    $ ansible-galaxy install tumf.systemd-service


Role Variables
--------------

|name                |type    |default|description
|--------------------|--------|-------|-------------
|`systemd_service_default_dir`|String|"/etc/default"|envs file path
|`systemd_service_systemd_dir`|String|"/etc/systemd/system"|systemd path
|`systemd_service_name` * |String||service name
|`systemd_service_envs`|String,List,MapList|[]|envs (/etc/default/:name)

> **Note**
> `systemd_service_root_dir` is obsolate.


### [Unit]


|name                |type    |default|description
|--------------------|--------|-------|-------------
|`systemd_service_Unit_Description`|String||[Unit]Description
|`systemd_service_Unit_Documentation`|String||[Unit]Documentation
|`systemd_service_Unit_Requires`|String,List||[Unit]Requires
|`systemd_service_Unit_Wants`|String,List||[Unit]Wants
|`systemd_service_Unit_ConditionPathExists`|String||[Unit]ConditionPathExists
|`systemd_service_Unit_After`|String,List||[Unit]After
|`systemd_service_Unit_Before`|String,List||[Unit]Before


### [Service]


|name                |type    |default|description
|--------------------|--------|-------|-------------
|`systemd_service_Service_Type`|String|"simple"|[Service]Type
|`systemd_service_Service_ExecStartPre`|String,List||[Service]ExecStartPre
|`systemd_service_Service_ExecStart` * |String||[Service]ExecStart
|`systemd_service_Service_ExecStartPost`|String,List||[Service]ExecStartPost
|`systemd_service_Service_Restart`|String|"no"| [Service]Restart "no" or "always" or "on-success" or "on-failure"
|`systemd_service_Service_RestartSec`|Integer|| [Service]RestartSec
|`systemd_service_Service_ExecReload`|String|| [Service]ExecReload
|`systemd_service_Service_ExecStop`|String|| [Service]ExecStop
|`systemd_service_Service_KillMode`|String|| [Service]KillMode
|`systemd_service_Service_ExecStopPost`|String,List|| [Service]ExecStopPost
|`systemd_service_Service_PIDFile`|String|| [Service]PIDFile
|`systemd_service_Service_BusName`|String|| [Service]BusName
|`systemd_service_Service_PrivateTmp`|String|| [Service]PrivateTmp
|`systemd_service_Service_LimitNOFILE`|String|| [Service]LimitNOFILE
|`systemd_service_Service_User`|String|| [Service]User
|`systemd_service_Service_Group`|String|| [Service]Group
|`systemd_service_Service_WorkingDirectory`|String|| [Service]WorkingDirectory



### [Install]

|name                |type    |default|description
|--------------------|--------|-------|-------------
|`systemd_service_Install_WantedBy`|String|[Install]WantedBy "multi-user.target"|[Install]WantedBy
|`systemd_service_Install_RequiredBy`|String||[Install]RequiredBy
|`systemd_service_Install_Also`|String||[Install]Also
|`systemd_service_Install_Alias`|String||[Install]Alias


> * Required

Example Playbook
----------------

    - hosts: servers
      roles:
        - role: systemd-service
          systemd_service_name: "swarm-manager"
          systemd_service_envs:
              - "DOCKER_HOST=tcp://127.0.0.1:2375"
          systemd_service_Unit_Description: Docker Swarm Manager
          systemd_service_Unit_Requires: docker.service
          systemd_service_Unit_After: docker.service
          systemd_service_Service_ExecStartPre:
              - -/usr/bin/docker stop swarm-manager
              - -/usr/bin/docker rm swarm-manager
              - /usr/bin/docker pull swarm
          systemd_service_Service_ExecStart: /usr/bin/docker run -p 2377:2375 --name swarm-manager swarm manage

License
-------

MIT

Author Information
------------------

> @tumf
