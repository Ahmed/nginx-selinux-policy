all:
	@echo "Please read README file first"
compile_policy:
	make -f /usr/share/selinux/devel/Makefile
install_policy:
	semodule -i nginx_fe_local.pp

