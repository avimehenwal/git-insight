NAME = git-insight
PANDOC := $(shell command -v pandoc 2> /dev/null)

ARTIFACT_DIR ?= build
MANSECTION ?= 1
MANPAGE.md = $(PANDOC) --standalone $(PANDOCFLAGS) --to man
MANPAGE = $(ARTIFACT_DIR)/$(NAME).$(MANSECTION)

%.$(MANSECTION): %.$(MANSECTION).md
	$(MANPAGE.md) $< -o $@

all: man

pre:
	@echo PRE
	test -d $(ARTIFACT_DIR) || mkdir -v $(ARTIFACT_DIR)

compress:
	tar -czvf ${HOME}/rpmbuild/SOURCES/git-insight-0.0.1.tar.gz ./src

build:
	docker build -t avi/fedora . && docker images

# docker run -it --rm -v ${PWD}:/SOURCES/:z avi/fedora bash
run:
	docker run -it --rm avi/fedora bash

# ifDev
# man --local-file src/man/git-insight.1
man: pre
ifdef PANDOC
	pandoc --standalone --to man src/man/git-insight.1.md -o $(MANPAGE)
else
	@echo "pandoc is not installed, skipping manpages generation"
endif

local: man
	./entrypoint.sh

pypi:
	pyp2rpm termgraph -t fedora --srpm -b 3 -p 3 -d ./pyDEPS
	mock -r fedora-35-x86_64 ./pyDEPS/*.src.rpm
	tree ./pyDEPS

# Wrote: /builddir/build/RPMS/python3-termgraph-0.5.3-1.fc35.noarch.rpm

clean:
	rm -rvf $(MANPAGE) pyDEPS