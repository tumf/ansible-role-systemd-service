systemd-service
===============

Register services to systemd.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:


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
