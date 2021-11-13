FROM fedora

RUN dnf install -y 'dnf-command(copr)' && \
  dnf copr enable -y avimehenwal/git-insight
RUN dnf -y --refresh update
RUN dnf install -y tito pandoc make man

WORKDIR /SOURCES
VOLUME /SOURCES

ADD ./entrypoint.sh .
COPY . .

# this is what I need to test
# RUN dnf install -v git-insight

CMD ["./entrypoint.sh"]