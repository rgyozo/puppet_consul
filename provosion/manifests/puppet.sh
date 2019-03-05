echo "Adding puppet repo"
sudo rpm -ivh https://yum.puppet.com/puppet6/puppet6-release-el-7.noarch.rpm
echo "installing puppet"
sudo yum install git wget unzip puppetserver -y
cd /var/tmp
wget https://releases.hashicorp.com/consul/1.0.2/consul_1.0.2_linux_amd64.zip
unzip consul_1.0.2_linux_amd64.zip
mv /var/tmp/consul /usr/local/bin/
adduser consul
mkdir /etc/consul
chown -R consul:consul /etc/consul/
mkdir /var/consul
chown -R consul:consul /var/consul
cd /etc/puppetlabs/code/environments/ && git clone https://github.com/rgyozo/puppet_consul
sudo /opt/puppetlabs/bin/puppet resource cron puppet-apply ensure=present user=root minute=1 command='cd /etc/puppetlabs/code/environments/ && git pull https://github.com/rgyozo/puppet_consul && /opt/puppetlabs/bin/puppet apply manifestsi --environment=puppet_consul/'
