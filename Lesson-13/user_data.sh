#!/bin/bash
yum -y update
yum -y install httpd


myip='curl http://169.254.169.254/latest/meta-data/local-ipv4'

cat <<EOF > var/www/html/index.html
<html>
<body bgcolor="gray">
<h2><font color="gold">Build by Power of <font color="red"> Terraform v1.7</font></h2><br><p>
<font color="green">Server PrivateIP: <font color="blue">$myip<br><br>
<font color="yellow">
<b>Version 3.0</b>
</body>
</html>
EOF

sudo service httpd start
chkconfig httpd on 
