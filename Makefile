SHELL=/bin/bash
PHONY=default help generate check

.PHONY: $(PHONY)

default: help

help:
	@echo "Usage: make generate"
	@echo "Usage: make check"

generate:
	@read -p "Enter username: " MAKE_USERNAME; \
	read -s -p "Enter password: " MAKE_PASSWORD; \
	echo ; \
	HTPASSWD=`docker run -it httpd:2.4-alpine htpasswd -nb $$MAKE_USERNAME $$MAKE_PASSWORD`; \
	echo $$HTPASSWD > .htpasswd

check:
	@read -p "Enter username: " MAKE_USERNAME; \
		docker run -v $(PWD)/.htpasswd:/tmp/.htpasswd -it httpd:2.4-alpine htpasswd -v /tmp/.htpasswd $$MAKE_USERNAME


