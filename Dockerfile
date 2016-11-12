FROM ubuntu:14.04

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update
RUN apt-get install wget vim git --assume-yes

# install RVM
RUN apt-get install build-essential curl --assume-yes
RUN command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN curl -L https://get.rvm.io | bash -s stable
RUN echo 'source /etc/profile.d/rvm.sh' >> ~/.bashrc
RUN /usr/local/rvm/bin/rvm-shell -c "rvm requirements"

# install Ruby
RUN /bin/bash -l -c "rvm autolibs enable"
RUN /bin/bash -l -c "rvm install 2.1.2"

# install Rails
RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc
RUN /bin/bash -l -c "gem install rails -v 4.1.5"

# install nodeJS
RUN sudo apt-get install nodejs --assume-yes

# Install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
RUN apt-get update
RUN apt-get install -y mongodb-org

RUN apt-get install -y git
RUN git clone https://github.com/locomotivecms/engine.git /root/engine

# Installing a fix for ruby
RUN apt-get install libqt4-dev libqtwebkit-dev

WORKDIR "/root/engine"
RUN bundle install

EXPOSE 3000
