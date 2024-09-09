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

move_workflows:
	mv workflows .github/workflows

init: move_workflows share_trunk

add_venv_key:
	@echo "Adding venv key to [tool.pyright] section in pyproject.toml"
	@awk 'BEGIN { in_section=0 } \
	/^\[tool.pyright\]/ { in_section=1 } \
	in_section && /^\[.*\]/ && !/^\[tool.pyright\]/ { in_section=0 } \
	{ print } \
	in_section && !/^\[.*\]/ { last_line=NR } \
	END { if (last_line) { for (i=1; i<=NR; i++) { if (i == last_line) { print "venv = \"REPO_NAME\"" } } } }' pyproject.toml > tmpfile && mv tmpfile pyproject.toml

setup_with_pyenv: add_venv_key
	pyenv virtualenv 3.10 REPO_NAME
	pyenv activate REPO_NAME
	poetry install

install_git_hooks: install_trunk
	trunk init
	trunk actions run configure-pyright

check:
	trunk fmt
	trunk check
