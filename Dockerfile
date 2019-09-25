FROM ubuntu:19.04

ENV TZ=America/Sao_Paulo

RUN echo $TZ > /etc/timezone
 
RUN apt-get update && apt-get install -y \
    tzdata \
    sudo

RUN apt-get install -y \
    curl \
	git \
    vim \
    zsh


# Install Node
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - && \
    sudo apt-get install -y nodejs


# Install Yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
    sudo apt-get update && sudo apt-get install -y yarn


# Install Docker
RUN curl https://get.docker.com | bash && \
    apt-get -y install docker-compose


# Add user for apps that do not support root
RUN useradd tgm && usermod -aG sudo tgm && usermod -aG docker tgm && \
    mkdir /home/tgm && chown -R tgm /home/tgm && \
    echo "ALL            ALL = (ALL) NOPASSWD: ALL" >>/etc/sudoers

USER tgm
WORKDIR /home/tgm

# Install oh-my-zsh
# RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
