# ansible-elasticsearch

**THIS ROLE IS FOR 6.x, 5.x. FOR 2.x SUPPORT PLEASE USE THE 2.x BRANCH.**

Ansible role for 6.x/5.x Elasticsearch.  Currently this works on Debian and RedHat based linux systems. Tested platforms are:

* Ubuntu 14.04
* Ubuntu 16.04
* Debian 8
* CentOS 7

The latest Elasticsearch versions of 6.x and 5.x are actively tested.  **Only Ansible versions > 2.4.3.0 are supported, as this is currently the only version tested.**

##### Dependency
This role uses the json_query filter which [requires jmespath](https://github.com/ansible/ansible/issues/24319) on the local machine.

## Usage

Create your Ansible playbook with your own tasks, and include the role elasticsearch. You will have to have this repository accessible within the context of playbook.


Then create your playbook yaml adding the role elasticsearch. By default, the user is only required to specify a unique es_instance_name per role application.  This should be unique per node.
The application of the elasticsearch role results in the installation of a node on a host.


The above installs a single node 'node1' on the hosts 'localhost'.

This role also uses [Ansible tags](http://docs.ansible.com/ansible/playbooks_tags.html). Run your playbook with the `--list-tasks` flag for more information.
```yml
- hosts: elasticsearch_master_nodes
  remote_user: ubuntu
  sudo: True
  roles:
    - { role: elasticsearch,
        es_config: {
            cluster.name: "test-cluster",
            discovery.zen.ping.unicast.hosts: "node01, node02, node03",
            network.host: "_eth0_, _local_",
            discovery.zen.minimum_master_nodes: 2,
            http.port: 9200,
            transport.tcp.port: 9300,
            node.data: false,
            node.master: true
             }
         }
  vars:
    es_instance_name: "node1"
    es_node_name: node01
    es_config:
      es_heap_size: "2g"
      cluster.name: "test-cluster"
    "node_1": "13.232.xxx.xxx node01"           #for /etc/hosts file entry
    "node_2": "13.127.xxx.xxx node02"            #for /etc/hosts file entry
    "node_3": "13.232.xxx.xxx node03"           #for /etc/hosts file entry


- hosts: elasticsearch_master_data_nodes
  roles:
    - { role: elasticsearch,
        es_instance_name: "node1",
        es_config: {
            cluster.name: "test-cluster",
            discovery.zen.ping.unicast.hosts: "node01, node02, node03",
            network.host: "_eth0_, _local_",
            discovery.zen.minimum_master_nodes: 2,
            http.port: 9200,
            transport.tcp.port: 9300,
            node.data: true,
            node.master: true
            }
            }
  vars:
    es_node_name: node02
    es_instance_name: "node1"
    es_config:
      es_heap_size: "2g"
      cluster.name: "test-cluster"
    "node_1": "13.232.xxx.xxx node01"             #for /etc/hosts file entry
    "node_2": "13.127.xxx.xxx node02"              #for /etc/hosts file entry
    "node_3": "13.232.xxx.xxx node03"             #for /etc/hosts file entry

- hosts: elasticsearch_data_nodes
  roles:
    - { role: elasticsearch,
        es_instance_name: "node1",
        es_config: {
            cluster.name: "test-cluster",
            discovery.zen.ping.unicast.hosts: "node01, node02, node03",
            network.host: "_eth0_, _local_",
            discovery.zen.minimum_master_nodes: 2,
            http.port: 9200,
            transport.tcp.port: 9300,
            node.data: true,
            node.master: false
            }
            }
  vars:
    es_node_name: node03
    es_instance_name: "node1"
    es_config:
      cluster.name: "test-cluster"
    "node_1": "13.232.xxx.xxx node01"           #for /etc/hosts file entry
    "node_2": "13.127.xxx.xxx node02"            #for /etc/hosts file entry
    "node_3": "13.232.xxx.xxx node03"           #for /etc/hosts file entry
```


## USAGE:
```
ansible-playbook -i inventory/elasticsearch.ini main.yml
```
