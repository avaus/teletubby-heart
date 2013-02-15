cd ~
git clone git@github.com:Dige/project-teletubby-heart.git
bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
echo '[[ -s "/home/$USER/.rvm/scripts/rvm" ]] && source "/home/$USER/.rvm/scripts/rvm"' >> ~/.bashrc
source ~/.bashrc
source ~/.rvm/scripts/rvm
rvm install 1.9.3
rvm use --default 1.9.3
cd ~/project-teletubby-heart/
gem install bundler
bundle install
