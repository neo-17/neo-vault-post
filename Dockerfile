FROM plexinc/pms-docker:plexpass

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python3 git build-essential libargtable2-dev autoconf automake libtool \
    libtool-bin ffmpeg libsdl1.2-dev libavutil-dev libavformat-dev libavcodec-dev vim mkvtoolnix ssmtp && \
    
# Clone Comskip
    cd /opt && \
    git clone git://github.com/erikkaashoek/Comskip && \
    cd Comskip && \
    ./autogen.sh && \
    ./configure && \
    make && \

# Clone PlexComskip
    cd /opt && \
    git clone https://github.com/ekim1337/PlexComskip.git && \
    chmod -R 777 /opt/ /tmp/ /root/ && \
    touch /var/log/PlexComskip.log && \
    chmod 777 /var/log/PlexComskip.log && \

# Cleanup
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

ADD ./PlexComskip.conf /opt/PlexComskip/PlexComskip.conf
