[![Build Status](https://travis-ci.org/tumf/ansible-role-systemd-service.svg)](https://travis-ci.org/tumf/ansible-role-systemd-service)

systemd-service - Ansible role
===============

Register services to systemd.

> **Japanese Manual is here**
> http://qiita.com/tumf/items/9d5ac6853685ba53214d


Install
-------

    $ ansible-galaxy install tumf.systemd-service


Role Variables
--------------

|name                |type    |default|description
|--------------------|--------|-------|-------------
|systemd_service_root_dir|String|""|directory prefix
|systemd_service_default_dir|String|"/etc/default"|envs file paht
|systemd_service_systemd_dir|String|"/etc/systemd/system"|systemd path
|systemd_service_name*|String||service name
|systemd_service_envs|Array|[]|envs (/etc/default/:name)
|systemd_service_Unit_Description|String||[Unit]Description
|systemd_service_Unit_Requires|String||[Unit]Requires
|systemd_service_Unit_After|String||[Unit]After
|systemd_service_Service_Type|String|"simple"|[Service]Type
|systemd_service_Service_ExecStartPre|Array||[Service]ExecStartPre
|systemd_service_Service_ExecStart★|String||[Service]ExecStart
|systemd_service_Service_ExecStartPost|Array||[Service]ExecStartPost
|systemd_service_Install_WantedBy|String|"multi-user.target"|[Install]WantedBy

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
