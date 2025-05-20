FROM fedora:latest

# Install necessary packages
RUN dnf update -y && \
    dnf install -y openssh-server sudo coreutils bash && \
    dnf clean all

# Setup SSHD
RUN mkdir -p /var/run/sshd && \
    ssh-keygen -A && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'root:root' | chpasswd

# Create users and set passwords
RUN for i in $(seq 1 8); do \
    useradd -m -s /bin/bash level$i; \
    echo "level$i:pass$i" | chpasswd; \
done

# LEVEL 1
RUN echo -e "Welcome to Level 1!\nUse the \`cat\` command to read password.txt and move to the next level.\n\nLearn: https://www.gnu.org/software/coreutils/manual/html_node/cat-invocation.html" > /home/level1/README && \
    echo "pass2" > /home/level1/password.txt && \
    chown -R level1:level1 /home/level1

# LEVEL 2
RUN echo -e "Welcome to Level 2!\nUse \`ls -al\` to find the hidden file.\n\nLearn: https://linux.die.net/man/1/ls" > /home/level2/README && \
    echo "pass3" > /home/level2/.secret && \
    chown -R level2:level2 /home/level2

# LEVEL 3
RUN echo -e "Welcome to Level 3!\nUse \`more\` to search inside a big file.\n\nLearn: https://linux.die.net/man/1/more" > /home/level3/README && \
    base64 /dev/urandom | head -c 50000 > /home/level3/data && \
    echo "pass4" >> /home/level3/data && \
    chown -R level3:level3 /home/level3

# LEVEL 4
RUN echo -e "Welcome to Level 4!\nRun the bash script to get the password.\n\nLearn: https://tldp.org/LDP/Bash-Beginners-Guide/html/" > /home/level4/README && \
    echo -e '#!/bin/bash\necho "pass5"' > /home/level4/reveal.sh && \
    chmod +x /home/level4/reveal.sh && \
    chown -R level4:level4 /home/level4

# LEVEL 5
RUN echo -e "Welcome to Level 5!\nCreate a directory named 'unlockme' to get the password.\n\nLearn: https://linuxize.com/post/how-to-create-directory-in-linux/" > /home/level5/README && \
    echo -e '#!/bin/bash\nif [ -d "$HOME/unlockme" ]; then echo "pass6"; else echo "Make unlockme dir"; fi' > /home/level5/check.sh && \
    chmod +x /home/level5/check.sh && \
    chown -R level5:level5 /home/level5 && \
    chmod 750 /home/level5

# LEVEL 6
RUN echo -e "Welcome to Level 6!\nDelete the 'blockme' directory to get the password.\n\nLearn: https://linuxize.com/post/how-to-remove-directory-in-linux/" > /home/level6/README && \
    mkdir /home/level6/blockme && \
    echo -e '#!/bin/bash\nif [ ! -d "$HOME/blockme" ]; then echo "pass7"; else echo "Delete blockme dir"; fi' > /home/level6/unlock.sh && \
    chmod +x /home/level6/unlock.sh && \
    chown -R level6:level6 /home/level6 && \
    chmod 750 /home/level6

# LEVEL 7
RUN echo -e "Welcome to Level 7!\nFix file permissions to access the password.\n\nLearn: https://linux.die.net/man/1/chmod" > /home/level7/README && \
    echo "pass8" > /home/level7/secret.txt && \
    chmod 000 /home/level7/secret.txt && \
    chown -R level7:level7 /home/level7 && \
    chmod 750 /home/level7

# LEVEL 8
RUN echo -e "Welcome to Level 8!\nUse everything you’ve learned to solve this level.\nIt includes hidden files, large files, and permission challenges." > /home/level8/README && \
    base64 /dev/urandom | head -c 10000 > /home/level8/obscure && \
    echo "Final password: winner" > /home/level8/.hidden_hint && \
    chmod 400 /home/level8/.hidden_hint && \
    chown -R level8:level8 /home/level8 && \
    chmod 750 /home/level8


EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

