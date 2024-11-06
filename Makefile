CMAKE_SOURCE_DIR := $(shell pwd)
OUT := $(shell pwd)/build

CONFIG ?= Release

.PHONY: all
all: help
	@false

.PHONY: help
help:	## show help message
	@echo "Usage: make COMMAND [CONFIG=Debug|Release]"
	@echo ""
	@echo "	CONFIG	Enable debug or release build [default: Debug]"
	@echo ""

.PHONY: up
up:	## Create a container
	docker compose up -d

.PHONY: down
down:	## Stop and remove a container
	docker compose down

.PHONY: _shell
_shell:
	docker compose exec --user ${user} develop bash

.PHONY:	shell
shell:	user := $(shell id -u):$(shell id -g)
shell:	_shell 	## Allocate a terminal to a running container

.PHONY:	rootshell
rootshell:	user := 0:0
rootshell:	_shell	## Allocate a terminal to a running container as root

.PHONY:	cmake
cmake:	## Run cmake
	mkdir -p $(OUT)
	cd $(OUT) && cmake -DCMAKE_BUILD_TYPE=$(CONFIG) $(CMAKE_SOURCE_DIR)

.PHONY:	build
build:	cmake	## Compile
	cmake --build $(OUT) -- -l $(shell nproc) -j $(shell nproc)

.PHONY:	clean
clean:	## Remove all files generated on a build
	cmake --build $(OUT) --target clean

.PHONY:	install
install:
	cmake --install $(OUT)
