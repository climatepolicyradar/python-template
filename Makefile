install_trunk:
	$(eval trunk_installed=$(shell trunk --version > /dev/null 2>&1 ; echo $$? ))
ifneq (${trunk_installed},0)
	$(eval OS_NAME=$(shell uname -s | tr A-Z a-z))
	curl https://get.trunk.io -fsSL | bash
endif

uninstall_trunk:
	sudo rm -if `which trunk`
	rm -ifr ${HOME}/.cache/trunk