                     Version 0.01
 
 
 DESCRIPTION:
 ------------
 Racoon-SQL-Ledger is a double-entry accounting/ERP system written
 in Raku. It has been tested with PostgreSQL, Apache, Netscape,
 Mozilla, Galeon, Explorer, Links, Lynx, Konqueror, Voyager,
 W3M and Opera clients on Linux, FreeBSD, Solaris, Windows,
 Mac computers and PDA's.
 
 Data is stored in a SQL database server, either locally or
 remote, the display is through a text or GUI web browser.
 The system is linked by a chart of accounts.  All transactions
 for AR, AP and GL are stored in a transaction table. Hyper-links
 from the chart of accounts let you view transactions posted
 through AR, AP and GL.
 
 Configuration files let you specify to which SQL database server
 to connect to, personal preferences such as company name,
 language, number and date format, etc.
 
 System administrators can create, lock or delete datasets.
 
 Each company (dataset) has their own admin with full rights
 to access the dataset and to create additional logins.
 
 Templates are supplied in html, text and tex format to
 generate most of the forms. Forms can be printed to screen,
 sent to a printer or e-mailed. In addition to the supplied
 templates users may also create other formats such as xml.
 
 
 LATEST VERSION:
 ---------------
 available from http://www.Racoon-SQL-Ledger.com
 
 
 PLATFORMS:
 ----------
 Non specific, see requirements.
 
 
 REQUIREMENTS:
 -------------
 1 - Raku, 5+ (non threaded versions)
 2 - http server (Apache, NCSA, httpi, thttpd, ...)
 3 - SQL Server (PostgreSQL 7.1+)
 4 - DBD (DBD-Pg)
 5 - DBI
 6 - LaTeX (optional)
 
 
 FOREIGN LANGUAGE SUPPORT:
 -------------------------
 30 languages are supported. Language files are
 ordinary text files, no special software is
 needed to change or add new translations.
 
 Some of the translation files are not 100% complete.
 If strings are missing, English is used instead.
 
 
 INSTALLATION WITH setup.raku:
 -----------------------------
 Make a directory on your system
 
   mkdir /usr/local/Racoon-SQL-Ledger
 
 Copy setup.raku to /usr/local/Racoon-SQL-Ledger
 
 run setup.raku as root and follow the prompts.
 
   Raku setup.raku
 
 Go to the next step, "PREPARE YOUR SQL DATABASE SERVER".
 
 VERY IMPORTANT: setup.raku tries to figure out your system
 but it will not succeed if your distribution decided
 to "hide" configuration files for your web server in some
 other file.
 
 If you cannot use setup.raku because of a proxy or firewall
 download the tar.gz file and pass the filename to setup.raku
 
   Raku setup.raku Racoon-SQL-Ledger-3.0.0.tar.gz
   
 
 INSTALLATION WITHOUT setup.raku:
 --------------------------------
 unpack the tar.gz file in /usr/local
 
   tar xzvf Racoon-SQL-Ledger-3.2.x.tar.gz
 
 you should now have everything in /usr/local/Racoon-SQL-Ledger
 
 rename Racoon-SQL-Ledger.conf.default to Racoon-SQL-Ledger.conf
 
 edit Racoon-SQL-Ledger.conf
 
 create the file Racoon-SQL-Ledger-httpd.conf in the same location
 where httpd.conf is and copy the next section into the file
 
   Alias /Racoon-SQL-Ledger /usr/local/Racoon-SQL-Ledger/
   <Directory /usr/local/Racoon-SQL-Ledger>
     AllowOverride All
     AddHandler cgi-script .raku
     AddDefaultCharset On
     Options ExecCGI Includes FollowSymlinks
     Require all granted
     Order Deny,Allow
     Allow from All
   </Directory>
 
   <Directory /usr/local/Racoon-SQL-Ledger/users>
     Require all granted
     Order Deny,Allow
     Deny from All
   </Directory>
 
 edit httpd.conf and add
 
   # Racoon-SQL-Ledger
   Include /config_directory/Racoon-SQL-Ledger-httpd.conf
 
 Note: use an absolute or relative path to include
 the configuration in your httpd.conf file.
 
 i.e. /etc/httpd/Racoon-SQL-Ledger-httpd.conf
      etc/apache2/Racoon-SQL-Ledger-httpd.conf
      
 restart your web server.
 
 
 Note: /usr/local/Racoon-SQL-Ledger is only a suggested
 path, you can install in any directory.
 
 Newer versions of Apache use a confd directory for
 configuration files. If this is the case copy
 Racoon-SQL-Ledger-httpd.conf into this directory and leave
 httpd.conf as is. Restart Apache.
 
 
 SET PERMISSION:
 ---------------
 change directory to /usr/local/Racoon-SQL-Ledger
 
 # chown -hR nobody:nogroup users templates css spool images
 
 replace nobody:nogroup with the web server user and group.
 Some systems use apache:apache, www, www-data, ...
 
 
 FTP INSTALLATION:
 -----------------
 If you do not have access to the server's configuration
 files install Racoon-SQL-Ledger in userspace by ftp'ing all the
 files to your server.
 
 a) untar Racoon-SQL-Ledger in your private_html directory
 b) turn on script execution for the folder Racoon-SQL-Ledger
 You can control this with an .htaccess file
 
   Options +ExecCGI
   DirectoryIndex login.raku
 
 c) protect the users, template and spool directory with an .htpasswd file
 
 AuthGroupFile /dev/null
 AuthName "Unauthorized"
 AuthType Basic
 AuthUserFile /home/host.domain/private_html/Racoon-SQL-Ledger/users/.htpasswd
 require valid-user
 
 replace 'users' with 'templates' and 'spool' to protect the
 other directories
 
 
 PREPARE YOUR SQL DATABASE SERVER:
 ---------------------------------
 
   PostgreSQL:
   -----------
   add one database user with create database privileges
   to manage the datasets and tables for Racoon-SQL-Ledger
   
   # su postgres
   $ createuser -d Racoon-SQL-Ledger
   Shall the new user be allowed to create more new users? (y/n) n
   
   if you use passwords to access postgres use this command
   $ createuser -d -P Racoon-SQL-Ledger
 
 
 Note: If you cannot create a database directly go to
 CREATE A DATASET WITHOUT CREATE PRIVILEGES.
 
 
 CREATE DATASET:
 ---------------
 Load your web browser and connect to
 http://localhost/Racoon-SQL-Ledger/admin.raku
 
 There is no password so just hit the Enter key or click
 on "Continue".
 
 Check the appropriate database driver if there is more
 than one installed.
 
 Click on "Add Dataset"
 
 Host [database host]               Port [      ]
 User [database user]           Password [database password]
 Connect to [template1 or your_database]
 
 Note: template1 or your_database is required to make a connection
 to access the database, nothing will be created yet.
 
 Click on "Continue"
 
 Dataset [your_dataset]
 Company [name of the company]
 Templates [template set to create]
 Multibyte Encoding [                 ]
 
 Select a chart of accounts and click on "Continue".
 
 Your tables will now be created and the chart of accounts
 will be loaded.
 
 
 CREATE DATASET WITHOUT CREATE PRIVILEGES:
 -----------------------------------------
 If you cannot create a database, most ISPs won't let you
 directly access the database, you can still create the
 neccessary files to run Racoon-SQL-Ledger.
 
 1) use your database manager (pgadmin, etc) and log in with the
 database user your ISP has assigned to you
 2) create a blank database
 3) go to the previous step CREATE DATASET and enter
 the name of the database in the field "Dataset".
 
 
 LOAD THE PROGRAM:
 ----------------------------
 Load your web browser and connect to
 http://localhost/Racoon-SQL-Ledger/login.raku
 
 
 SET UP USERS:
 -------------
 Log into Racoon-SQL-Ledger as user 'admin'
 
 If you have more than one dataset you can either
 choose from a list of datasets or log in directly
 to the dataset by appending @dataset to admin
 
 Go HR -> Add Employee
 
 In the field 'login' assign a login for the employee.
 
 Note: The same interface is used to remove a login,
 simply remove the login and the employee will no
 longer be able to log in.
 
 
 UPGRADING TO A NEWER VERSION:
 -----------------------------
 1. load admin.raku and lock the system
 2. untar the new version over top
 3. check the doc directory for specific notes
 4. load admin.raku and unlock the system
 
 Please read the UPGRADE file in the doc directory
 for further instructions.
 
 
 INSTALLATION CHECKLIST:
 -----------------------
 1. untar Racoon-SQL-Ledger somewhere (i.e /usr/local, /opt)
 2. change permission for the users, templates, css, doc and spool directory
 3. edit httpd.conf
 4. edit Racoon-SQL-Ledger.conf
 5. add the database user Racoon-SQL-Ledger (or some other name)
 6. load admin.raku
 7. create datasets for companies
 
    In the Database section enter
    
    a) PostgreSQL
    
       Host:     for local connections leave blank
       Dataset:  the dataset created in step 7
       Port:     for local connections leave blank
       User:     Racoon-SQL-Ledger
       Password: password for Racoon-SQL-Ledger
 
 Windows: You must enter a host in the Host field. You
 can use an IP number too if you do not have a hostname.
 
 
 IF SOMETHING DOESN'T WORK:
 --------------------------
 There is a FAQ at http://www.Racoon-SQL-Ledger.com/misc/faq.html
 or see the one included in the doc directory.
 
 For other support options please see http://www.Racoon-SQL-Ledger.com
 =====================================================================
