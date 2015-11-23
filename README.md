# vagrant-magento2-apache


## Version

1.0.0


## Key Facts:

  - ubuntu/trusty64
  - shell provisioner
  - Magento 2 CE System Requirements
  - Percona Server for MySQL and Configuration by https://tools.percona.com/wizard
  - automatic dynamic configured virtual hosts with vhost_alias
  - shared folder ./servers synced to /home/vagrant/servers (OSX NFS, Windows rsync)
  - phpMyAdmin (http://magento2-phpmyadmin.local/)
  - mailcatcher on port 1080 (http://magento2.local:1080)
  - composer


## Default Configuration

 - APACHE_RUN_USER vagrant
 - APACHE_RUN_GROUP vagrant
 - max_execution_time 300
 - upload_max_filesize and post_max_size 100M


## System Requirements

 - Virtualbox: https://www.virtualbox.org/
 - Vagrant: https://www.vagrantup.com/
 - vagrant-bindfs: https://github.com/gael-ian/vagrant-bindfs

```sh
vagrant plugin install vagrant-bindfs
```


### Get Started

#### Start Guest System

```sh
$ mkdir -p  ~/vagrant
$ git clone [git-repo-url] magento
$ cd magento
$ vagrant up
```

#### Prepare Host System
```sh
$ sudo vi /etc/hosts
```

```sh
10.42.42.43     magento2-phpmyadmin.local
10.42.42.43     magento2.local
```


### SSH-Access to Guest
```sh
$ cd ~/vagrant/magento
$ vagrant ssh
```

or:

```sh
$ ssh vagrant@10.42.42.43
```


### Percona Server for MySQL
user: root
pw: root