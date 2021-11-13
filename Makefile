PANDOC ?= pandoc
MANSECTION ?= 1
MANPAGE.md = $(PANDOC) --standalone $(PANDOCFLAGS) --to man

%.$(MANSECTION): %.$(MANSECTION).md
	$(MANPAGE.md) $< -o $@

compress:
	tar -czvf ${HOME}/rpmbuild/SOURCES/git-insight-0.0.1.tar.gz ./src

build:
	docker build -t avi/fedora . && docker images

# docker run -it --rm -v ${PWD}:/SOURCES/:z avi/fedora bash
run:
	docker run -it --rm avi/fedora bash
