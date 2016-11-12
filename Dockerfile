FROM ubuntu
ADD https://raw.githubusercontent.com/TCMG412-Team-1/docker-setup/master/project_setup.rb /root/chef.rb 
CMD "bin/bash"
