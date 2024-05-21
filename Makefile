install_trunk:
	$(eval trunk_installed=$(shell trunk --version > /dev/null 2>&1 ; echo $$? ))
ifneq (${trunk_installed},0)
	$(eval OS_NAME=$(shell uname -s | tr A-Z a-z))
	curl https://get.trunk.io -fsSL | bash
endif

uninstall_trunk:
	sudo rm -if `which trunk`
	rm -ifr ${HOME}/.cache/trunk

share_trunk:
	trunk init

setup_with_pyenv:
	- pyenv deactivate
	pyenv virtualenv 3.9 REPO_NAME
	pyenv activate REPO_NAME
	poetry install

install_git_hooks: install_trunk
	trunk init
	trunk actions run configure-pyright

check:
	trunk fmt
	trunk check
