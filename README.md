# Web Application Security Research 2021
The project involves securing web based applications with defense mechanims that will prevent injection attacks. Topics: Software Security, Web Application Security, Web Browser Security, Privacy.

## Overview:
- We are manually setting up and running docker containers to simplfiy the process of setting up environments to test PHP web applications.
- Worked on bash scripts, these can be added to execute a seqeunce of command line commands, they can be called in the docker-compose.yaml file to make things easier.
- Setting up a container lets you use multiple command prompts, giving you more freedom in what you want to do.
- We are connecting databases to each of the web applications because we will also be testing content that is stored.
- How to connect those PHP apps to the container and interacting with it on the localhost in my browser.
- Cross Site Scripting(XSS) \- when malicious code is sent through a web app to attack a user. There are many types, we will be looking at CLient XSS and Stored XSS. 
    - Client XSS occurs when the the attacker uses a JS call as part of the HTML code. 
    - Stored XSS occurs when the user is trying to store to the database of the web app, but sees different information, which could be potentionally malicious.
- Learning to finding exploits in php code, inspecting the lifecycle of variables, and identifying explotiable global variable calls with the use of filter(intval()...etc) functions.
- Confirming the paths as breaches listed by the exploit-finding application.

## Tasks and Steps Taken:

#### TASK#1: Setup and interact with [**PHP Gurukul Hospital Management System**](https://phpgurukul.com/hospital-management-system-in-php/) and [**PHP Gurukul Shopping**](https://phpgurukul.com/shopping-portal-free-download/) using bash scripts and docker compose.

#### TASK#1:
1. Create a folder called Research on your desktop. Extract [Starter Files.zip](https://github.com/NirajSalunkhe/Research2021/files/6524173/Starter.Files.zip) in to Research.
2. Inside Research, make a folder called Apps. Extract the two zips(PHP applications) into Apps.
3. Insert the following commands in the command prompt after switching to the local directiory holding Research folder:
    1. Include the filepath to your directory, the ports that you will be using, and the name of the image `docker run -v C:/Users/niraj/Research/:/newDir/ -v C:/Users/niraj/Research/Apps/:/var/www/html -p 80:80 -it research:latest bash`
    2. Once inside the container, switch to the directory holding contents from Research.
    3. Start the services apache2 and mysql, they are needed to interact with the database and browser. `service apache2 start` and `service mysql start`.
    4. Insert following SQL commands in order `mysql -u root -p`(enters mysql shell), `create user 'user1'@'localhost' identified by 'user';`(new user needed because I needed to modified the user information in the config.php in both apps to be username = user1 and password = user for testing purposes), `grant all privileges on * . * to 'user1'@'localhost';`(lets me use commands without any barriers),`select user from mysql.user;`(sets the user to be user1 instead of the default user),`flush priviliges;`(applies changes to user immediately),`create database hms;` OR `create database shopping;`(these are the names of the databases listed in each of the apps, use the one for the specific instance), `use hms;` OR `use shopping;`(depends on previous selection), `source /newDir/Apps/Hospital Management System Project/SQL File/hms.sql;` OR 
`source /newDir/Apps/Online Shopping Portal Project/SQL File/shopping.sql;` (depends on previous selection, specifiy the database file directory in the container, not local machine).
    4. Pressing "ctrl + D" should exit out to the container command shell.
4. After opening `localhost` in browser, the two applications should be visible.

Time to put everything into a bash script(basically inserts command prompt commands for you!) and then specifiy the bash script in a .yaml file.
1. Create a file called shopping.sh for the Online Shopping Portal app. Inside, enter:
    1. `#!/bin/bash`: First line is the shebang statement, # = she, ! = bang, the shebang statement lets the OS know which interpreter, in our case Bash, to parse the file. 
    2. `service mysql start` and `service apache2 start`.
    3. Insert code below, sleep 9999 makes sure that the container can run the script for a very long time, until we are done using it.
       ```
         mysql --password= --user=root -e "create user 'user1'@'localhost' identified by 'user'" 
         mysql --password= --user=root -e "create user 'user1'@'localhost' identified by 'user'"
         mysql --password= --user=root -e "grant all privileges on * . * to 'user1'@'localhost'"
         # mysql --password= --user=root -e "select user from mysql.user" 
         mysql --password= --user=root -e "flush privileges"
         mysql --password= --user=root -e "create database shopping"
         mysql --password= --user=root -e "use shopping"
         mysql --database=shopping --password= --user=root -e "source /newDir/Apps/Online Shopping Portal Project/SQL File/shopping.sql" 
         sleep 9999
       ```
2. Repeat the steps for a script file called hms.sh with the file path and database name for the Hospital Management System app.
3. Inside of the container and correct directory, enter `sed -i -e 's/\r$//' shopping.sh hms.sh`. This gives permissions to these scripts to do what they have to.
4. Next, I have to modify docker-compose.yaml to match my system:
    1. Change the entrypoint line in the docker-compose.yaml file to `entrypoint: /newDir/shopping.sh`. This specifies of the script that we want executed once the docker container runs. Will have to manually switch script names for now...
    2. Make sure that the code in volume also matches your system, \ for windows and / for mac and linux.
        ``` 
        volumes:
        - .:/newDir
        - .\Apps:/var/www/html
        ``` 
5. Make sure MYSQL80 service is stopped, in my case it was taking up port 3306 so I had to stop it.
6. Insert command ```docker compose up``` on local host in the correct directory. This will now automate the entire setup and run the specified script.

#### TASK#1 Additional Notes ####
- `docker images` lets you view the images on your system.
- Once the compose file is running, you can open a new command prompt, and enter `docker ps` to access the container id. With that information, entering `docker exec -it <container ID> /bin/bash` will let you access the container and modify it while the container is running.

#### TASK#2: Understand and record the security breaches in the PHP Applications, locations to where these breaches are can be found in paths listed in [Satpaths.zip](https://github.com/NirajSalunkhe/Research2021/files/6542755/Satpaths.zip).

#### TASK#2:
1. Open the .json folder, check the file path that is listed in each of the .json files. The line number of the breaches is written below the file paths.
2. The security breaches can be classified as false positive and positives. We are basically identifying the credibility of the exploit-finding algorithm, false positives indicate that the algorithm incorrectly found an \'exploit\' while positives confirm the exploit.
3. Wherever it is applicable, use dev tools through inspect element to inject javascript code:  into the location that is listed as an exploit. `<script>alert(1)</script>
` If 1 is printed, its exploitable.
4. Go through and record the findings. Shopping Data and Hospital Data.






