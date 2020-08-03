SHELL := /bin/sh
PROJECT := banabus

DEV_SETTINGS = config.settings.development
PROD_SETTINGS = config.settings.production
TEST_SETTINGS = config.settings.test
BASE_DIR = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PMP = python3 manage.py


# target: all - Default target. Does nothing.
all:
	@echo "Nothing to do by default. Try 'make help'"

# target: help - Show list of targets + description
help:
	@egrep "^# target:" [Mm]akefile

# target: init - Install that a dev needs to get up and running.
init: bootstrap.sh
	# cd $(BASE_DIR) && sudo ./bootstrap.sh

# target: clean - remove all useless files
clean: clean-pyc clean-build

# target: clean-pyc - remove all auto generated files
clean-pyc:
	find . -name '*.pyc' -exec rm --force {} +
	find . -name '*.pyo' -exec rm --force {} +
	find . -name '*~' -exec rm --force  {} +
	find . -name '*pycache*' -exec rm -rf --force {} +

# target: clean-build - remove all auto generated folders
clean-build:
	-rm --force --recursive build/
	-rm --force --recursive dist/
	-rm --force --recursive htmlcov
	-rm --force --recursive .coverage
	-rm --force --recursive *.egg-info

# target: translate - calls the "makemessages" django command
translate:
	cd $(BASE_DIR) && $(PMP) makemessages --settings=$(DEV_SETTINGS) -a

# target: test - calls the "test" django command
test:
	$(PMP) test --settings=$(TEST_SETTINGS)

# target: run - calls the "runserver" django command
rundev:
	$(PMP) runserver --settings=$(DEV_SETTINGS) 10.145.205.165:8000

runprod:
	$(PMP) runserver --settings=$(PROD_SETTINGS)

# target: install - install pip3 requirements
install:
	pip3 install -r $(BASE_DIR)/requirements/development.txt

# target: update - install (and update) pip3 requirements
update:
	pip3 install -U -r $(BASE_DIR)/requirements/development.txt

# target: collect - calls the "collectstatic" django command
collect:
	$(PMP) collectstatic --settings=$(DEV_SETTINGS) --noinput

# target: rebuild - rebuild tables from models
migrate:
	$(PMP) makemigrations --settings=$(DEV_SETTINGS) && \
	$(PMP) migrate --settings=$(DEV_SETTINGS)

# target: deploy - let's make take care of deployment
deploy:
	# Should I call fabric here?

# target: check - check deployment is secure and safe
check:
	DJANGO_READ_DOT_ENV_FILE=1 $(PMP) check --deploy --settings=$(PROD_SETTINGS)


.ONESHELL:
.PHONY: all help translate test clean update collect migrate rundev runprod clean-pyc clean-build clean init install check
