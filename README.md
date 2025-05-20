# MY-CTF-FOR-BASIC-LINUX

# CTF in Docker

The Flag (CTF) environment using Docker and SSH. Each user (level) has a specific Linux challenge to solve. Passwords are stored in creative ways, and each level hints at common Linux commands, scripting, or permission usage.
## The Dockerfile is attached 
[Dockerfile](https://github.com/Huzaimzaoraiz/MY-CTF-FOR-BASIC-LINUX/blob/main/Dockerfile)
## How to Build and Run

```bash
docker build -t bandit_ctf .
docker run -it -p 2222:22 bandit_ctf

SSH Access

Use SSH to connect to each level:

ssh level1@localhost -p 2222
# Password: pass1

Level Details
	•	Level 1: Read password.txt using cat.
	•	Level 2: Use ls -al to find a hidden file .secret.
	•	Level 3: Use more to scroll and search in a large file.
	•	Level 4: Run a bash script reveal.sh to get the password.
	•	Level 5: Create a directory unlockme and run check.sh.
	•	Level 6: Delete the blockme directory and run unlock.sh.
	•	Level 7: Change file permissions to read secret.txt.
	•	Level 8: Final level combining hidden files, large file noise, and permission manipulation.

User Credentials

User	Password
level1	pass1
level2	pass2
level3	pass3
level4	pass4
level5	pass5
level6	pass6
level7	pass7
level8	pass8

Root user is also enabled for debugging:
	•	root:root

Notes
	•	Fedora base image
	•	SSH runs on port 22 (mapped to 2222)
	•	SSHD configured with password authentication
	•	Each level user has their own /home/levelX folder
	•	Challenges are based on Linux command-line fundamentals

