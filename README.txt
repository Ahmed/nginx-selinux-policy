nginx-selinux-policy
====================

This is a fork from https://github.com/heinoja9/selinux/tree/master/nginx_fe_local

Mr.Jani has a nice nignx policy for selinux. However, he doesn't provide anything to help you install it and configure it to work with your system (CentOS6.x/RHEL6.x).

I decided to create a Makefile for this, and have a small tutorial to help you configure your application.

I use this with django web applications. This might not work for you. 
------------------------------------------------------------------------------------


First, put your selinux on permissive mode

# vim /etc/selinux/config # and make SELINUX equal to the following value. 

SELINUX=permissive

Save and reboot.



Second, download this directory from github and run the following commands:

# make compile_policy

That will compile the policy

# make install_policy

That will install it the policy to your system.




Third, reboot the system, and check for any warnings in your /var/log/audit/audit.log file.

In order to do that, run the following command:

# sealert -a /var/log/audit/audit.log

This will give you a list of errors and solutions that will happen if you put your selinux in enforcing mode.

Example:

[root@laqeny ~]# sealert -a /var/log/audit/audit.log
100% donefound 1 alerts in /var/log/audit/audit.log
--------------------------------------------------------------------------------

SELinux is preventing /usr/sbin/nginx from write access on the sock_file /home/django/envo/app/laqeny.sock.

*****  Plugin catchall (100. confidence) suggests  ***************************

If you believe that nginx should be allowed write access on the laqeny.sock sock_file by default.
Then you should report this as a bug.
You can generate a local policy module to allow this access.
Do
allow this access for now by executing:
# grep nginx /var/log/audit/audit.log | audit2allow -M mypol
# semodule -i mypol.pp


[root@laqeny ~]# grep nginx /var/log/audit/audit.log | audit2allow -M laqeny.selinux
******************** IMPORTANT ***********************
To make this policy package active, execute:

semodule -i laqeny.selinux.pp

[root@laqeny ~]# semodule -i laqeny.selinux.pp


Finally, sealert will tell you exactly what you should do. Run any commands that will tell you to run to
generate a policy to allow it.

Put your selinux in enforcing mode and reboot.

