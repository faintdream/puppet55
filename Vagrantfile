Vagrant.configure("2") do |config|
  config.vm.box_check_update = false

  config.vm.define "puppet" do |puppet|                                                                       
    puppet.vm.box="centos/7"                                                                             
    puppet.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "3096"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
    end
    puppet.vm.network "private_network", ip:"192.168.33.10" 
    puppet.vm.provision "shell", inline: <<-MASTER
      yum install --nogpgcheck https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm -y
      yum install git -y --nogpgcheck
      yum install -y puppetserver --nogpgcheck
      echo '127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
      ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
      192.168.33.10  puppet.example.com puppet
      192.168.33.21 ubuntu
      192.168.33.20 node' > /etc/hosts
      echo "puppet" >/etc/hostname
      sudo hostname puppet.example.com
      systemctl enable puppetserver
      systemctl start puppetserver
      echo 'export PATH=$PATH:/opt/puppetlabs/puppet/bin' >> ~/.bashrc
      /opt/puppetlabs/puppet/bin/gem install r10k
      mkdir /etc/puppetlabs/r10k
      echo '---' > /etc/puppetlabs/r10k/r10k.yaml
      echo '  :cachedir: /var/cache/r10k' >> /etc/puppetlabs/r10k/r10k.yaml
      echo '  :sources:' >> /etc/puppetlabs/r10k/r10k.yaml 
      echo '    :local:' >> /etc/puppetlabs/r10k/r10k.yaml  
      echo '      remote: https://github.com/faintdream/r10k-site' >> /etc/puppetlabs/r10k/r10k.yaml
      echo '      basedir: /etc/puppetlabs/code/environments' >> /etc/puppetlabs/r10k/r10k.yaml
      export PATH=$PATH:/opt/puppetlabs/puppet/bin
      r10k deploy environment -pv
      puppet agent -t
    MASTER
  end 

  config.vm.define "node" do |node|                                                                       
    node.vm.box="centos/7"      
    node.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end
    node.vm.network "private_network", ip:"192.168.33.20" 
    node.vm.provision "shell", inline: <<-NODE
      yum install --nogpgcheck https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm -y
      yum install git -y --nogpgcheck
      yum install -y puppet --nogpgcheck
      echo '127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
      ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
      192.168.33.20 node
      192.168.33.21 ubuntu
      192.168.33.10 puppet.example.com puppet' > /etc/hosts
      echo "node" >/etc/hostname
      sudo hostname node.example.com
    NODE
  end 
  config.vm.define "ubuntu" do |ubuntu|                                                                       
    ubuntu.vm.box="bento/ubuntu-18.04"      
    ubuntu.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end
    ubuntu.vm.network "private_network", ip:"192.168.33.21" 
    ubuntu.vm.provision "shell", inline: <<-UBUNTU
      export DEBIAN_FRONTEND=noninteractive
      apt-get install wget --allow-unauthenticated
      wget --quiet install https://apt.puppetlabs.com/puppet5-release-bionic.deb 
      dpkg -i puppet5-release-bionic.deb
      apt-get update
      apt-get install puppet -y --allow-unauthenticated
      apt-get install git -y --allow-unauthenticated
      echo '127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
      ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
      192.168.33.21 ubuntu
      192.168.33.20 node
      192.168.33.10 puppet.example.com puppet' > /etc/hosts
      echo "ubuntu" >/etc/hostname
      sudo hostname ubuntu.example.com
    UBUNTU
  end 

end 
