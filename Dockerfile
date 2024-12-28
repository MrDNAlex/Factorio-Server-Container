FROM ubuntu:20.04

# Set the Factorio Server Version
ENV FACTORIO_VERSION=2.0.28

# Add the Factorio Executable to the Path
ENV PATH="/bin:/usr/bin:/usr/local/bin:/Factorio/factorio/bin/x64:${PATH}"

# Install packages and dependencies for steamcmd
RUN apt-get update && apt-get install -y \
    software-properties-common \
    sudo \
    wget \
    nano \
    expect \
    dash \
    lib32gcc-s1 \
    lib32stdc++6 \
    lib32z1 \
    curl \
    xdg-user-dirs \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Add Steam user and group and Sudo it for SteamCMD
RUN adduser --disabled-password --gecos "" factorio \
&& usermod -aG sudo factorio && \
adduser factorio sudo && \
echo 'factorio ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Create a Folder to host the Factorio Server Executable and Give Ownership of the Factorio Account Directory to the Factorio User
RUN sudo mkdir /Factorio \
&& sudo chown -R factorio:factorio /Factorio \
&& chmod -R 755 /Factorio

# Change the Working Directory
WORKDIR /Factorio

# Download the Factorio Server Files
RUN wget https://factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64 -O factorioserver.tar.xz

# Copy the Factorio Server Bot Files
#COPY ./ /Factorio

# Copy the file from the Project Directory to the Factorio Directory and remove the old one
#RUN cp /Factorio/factorio_headless_linux_2.0.23.tar.xz /home/factorio/factorioserver.tar.xz \
#&& rm -rf /FactorioBot/factorio_headless_linux_2.0.23.tar.xz

# Extract the Server Files and Remove the Tar File
RUN tar -xvf factorioserver.tar.xz \
&& rm -rf factorioserver.tar.xz

# Change to the Home Directory
WORKDIR /home/factorio