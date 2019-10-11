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
      yum install git -y
      yum install -y puppetserver
      rpm -Uvh https://yum.puppet.com/puppet-tools-release-el-7.noarch.rpm
      yum install -y puppet-bolt
      echo '127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
      ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
      192.168.33.10  puppet.example.com puppet
      192.168.33.21 ubuntu
      192.168.33.20 node' > /etc/hosts
      echo "puppet" >/etc/hostname
      sudo hostname puppet.example.com
      systemctl enable puppetserver
      systemctl start puppetserver
      export PATH=$PATH:/opt/puppetlabs/puppet/bin
      mkdir /etc/puppetlabs/r10k
      cat /dev/zero | ssh-keygen -q -N ""
      echo '-----BEGIN RSA PRIVATE KEY-----
      MIIEogIBAAKCAQEAsN3x1XYZQTXn/XMcdcbfC3QsEnlz11GYiL+z6dU+xrsGE/oJ
      amxczx6RMZnQs4avoo6xVTAcQyPjtGpR2OdynMGc21BAdh+u3bYWda3Uo5pQr3S3
      rorEH3T4sAnk+WuZ2drjQqO3lwXwDFs6cyHDXqiIFNHjv08ebnFynWkNGrYXvDTg
      QNxCFEBYwreuFUrHeoUzwkjR/1uQ26rcLIXPJkWh1jVrtxWWx+bnPucn4IxC+x1C
      tRrywnhoIbAzaqiIK36KcYWftFtV1SK+Sk1e1F3fNPVs4AZJz7EgcnPRWQOJrxqL
      JCRdtY6y8O3kJyxvvqSMenDnmIDdMA8znfEFYQIDAQABAoIBACddzyT++1ILaI5+
      H5iLYjvPaLvX8pO7YqMVYDssrqNXH1w07AGXCvVCzXhnzw8WbGNXNVtLsQ60n0sZ
      2wvXQChp47rg2ugv1yEcFVWuEkUz5L+Y0AV2d36072FnYmKts3nNAYZkoElqFer6
      J0FXA4A/LMLNkM6VEqXsdGFa74LBI/gxA5V5zcMaNvUjroAaNEXnAiSfhSnJu+rW
      EnsZ/zxxjjiZBs3+UtbCuklxmO3HttjR6xYWDOzyZBZrY+DT/g6DAesMVR3WIKSm
      s4PNWEnMTzRkVjbfEZ5OzMVbW/+ysdzWhoem4dBj+tNCtfLWjIrOW8LLpGfv7X8o
      kXaNCy0CgYEA5c2TMBH3CZlkUSOTZfE2ZQhuxFtDxNH2nHjnxHJIiX2b68vPh7OT
      KJwpnXv/nihjkTOLmN+5BG96lNSSksjikuAqySFhYBKpuJ482dMhz7QTH9tHubi3
      VMwtUgktF2HdYgYAdixqOhuegU0SZYi3coFgpX5frZ8hWgsiCsPzIw8CgYEAxQeE
      gbhW1ZaJOnmXYVQr5RFHEKg5MiZFWjw5BbNi8h0cKOJhRJucq5yKQJRqt3uZwd0J
      X2wHO6YjIsU3+25fOSaYGrYMn6Bfj18ZRor8hhpd/+drWcS1USBcCXI98fvOHWts
      wL4jhJO/LF7yezRk9aJNNhjFlT2nXxPm4iQYkI8CgYAY0n7Ol3IuuEHsvcIDJe3x
      Ndr5HL6SOPfBaRHn10xchZPdAXPWPaBsp4mbODShOc2fdojip2/Nudjs0JVQg6Bt
      qwcUGKXzAbERfw4lnTeuvs2+CCqUNg6fezp9/P3A49JM70cHfL6wriEN6GxPSVg/
      ZxgwaBkfoOuyVTeFICtYIwKBgFRFneBZ9xIN/A39ucjQVqH4XNv8B9KyWdF5lq4g
      hv6lgsjd4tqUcFNadiufD3IBNMedggfFTeaubbLOhd5N2/62yjIKkaWo05agB1CL
      2+yD1JbC5cCUiTT00UjdCy+4EvW0X+Skrs5i307cIXye8Vu6mqm7uK7XmwHookUx
      SSxzAoGAL7xFixnPytyUOCIApiNIAjhdzt3ncTxuxUnKZDUfA5k9dCfuTHY4iiWT
      X3GjPua9AWG6dgxmvQDs0mUpYbCamlPkiRAIJGjykZo2ZM28mp7Pe9T7SzxtyISs
      uM/Q3RMroEPxA2Harz+sSEtp9MR6IhmeJb4fSv57U289Qs84R6A=
      -----END RSA PRIVATE KEY-----' > ~/.ssh/id_rsa

      chmod 600 ~/.ssh/id_rsa
      echo 'ssh-rsa
      AAAAB3NzaC1yc2EAAAADAQABAAABAQCw3fHVdhlBNef9cxx1xt8LdCwSeXPXUZiIv7Pp1T7GuwYT+glqbFzPHpExmdCzhq+ijrFVMBxDI+O0alHY53KcwZzbUEB2H67dthZ1rdSjmlCvdLeuisQfdPiwCeT5a5nZ2uNCo7eXBfAMWzpzIcNeqIgU0eO/Tx5ucXKdaQ0athe8NOBA3EIUQFjCt64VSsd6hTPCSNH/W5Dbqtwshc8mRaHWNWu3FZbH5uc+5yfgjEL7HUK1GvLCeGghsDNqqIgrfopxhZ+0W1XVIr5KTV7UXd809WzgBknPsSByc9FZA4mvGoskJF21jrLw7eQnLG++pIx6cOeYgN0wDzOd8QVh vagrant@puppet.example.com' > ~/.ssh/id_rsa.pub
      chmod 600 ~/.ssh/id_rsa.pub
      echo '' > ~/.ssh/authorized_keys
      chmod 600 ~/.ssh/authorized_keys
      
      gem install r10k
      echo '---' > /etc/puppetlabs/r10k/r10k.yaml
      echo '  :cachedir: /var/cache/r10k' >> /etc/puppetlabs/r10k/r10k.yaml
      echo '  :sources:' >> /etc/puppetlabs/r10k/r10k.yaml 
      echo '    :local:' >> /etc/puppetlabs/r10k/r10k.yaml  
      echo '      remote: https://github.com/faintdream/r10k-site' >> /etc/puppetlabs/r10k/r10k.yaml
      echo '      basedir: /etc/puppetlabs/code/environments' >> /etc/puppetlabs/r10k/r10k.yaml
      
      r10k deploy environment -pv
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
      yum install git -y
      yum install -y puppet
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
      apt-get install wget
      wget https://apt.puppetlabs.com/puppet5-release-bionic.deb
      apt-get install puppet5-release-bionic.deb -y
      apt-get update
      apt-get install puppet -y
      apt-get install git -y
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
