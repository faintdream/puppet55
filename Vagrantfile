Vagrant.configure("2") do |config|
  config.vm.box_check_update = false

  config.vm.define "puppet" do |puppet|                                                                       
    puppet.vm.box="centos/7"                                                                             
    puppet.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "3096"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
    end
    puppet.vm.network "private_network", ip:"192.168.33.10" 
    puppet.vm.provision "shell", inline: <<-ANOTHERONE
      yum install --nogpgcheck https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm -y
      yum install -y puppetserver
      echo '127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
      ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
      192.168.33.10  puppet.example.com puppet
      192.168.33.21 ubuntu
      192.168.33.20 node' > /etc/hosts
      echo "puppet" >/etc/hostname
      sudo hostname puppet.example.com
      systemctl enable puppetserver
      systemctl start puppetserver
    ANOTHERONE
  end 

  config.vm.define "node" do |node|                                                                       
    node.vm.box="centos/7"      
    node.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end
    node.vm.network "private_network", ip:"192.168.33.20" 
    node.vm.provision "shell", inline: <<-ANOTHERONE
      yum install --nogpgcheck https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm -y
      yum install -y puppet
      echo '127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
      ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
      192.168.33.20 node
      192.168.33.21 ubuntu
      192.168.33.10 puppet.example.com puppet' > /etc/hosts
      echo "node" >/etc/hostname
      sudo hostname node.example.com
    ANOTHERONE
  end 
  config.vm.define "ubuntu" do |ubuntu|                                                                       
    ubuntu.vm.box="bento/ubuntu-18.04"      
    ubuntu.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end
    ubuntu.vm.network "private_network", ip:"192.168.33.21" 
    ubuntu.vm.provision "shell", inline: <<-ANOTHERONE
      apt-get install wget
      wget https://apt.puppetlabs.com/puppet5-release-bionic.deb
      apt-get install puppet5-release-bionic.deb -y
      apt-get update
      apt-get install puppet -y
      echo '127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
      ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
      192.168.33.21 ubuntu
      192.168.33.20 node
      192.168.33.10 puppet.example.com puppet' > /etc/hosts
      echo "ubuntu" >/etc/hostname
      sudo hostname ubuntu.example.com
    ANOTHERONE
  end 

end 
