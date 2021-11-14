# RPM Packaging

- [x] create a new spec file
- [x] build RPM package from source
- [x] tag RPM package
- [ ] publish and release rpm package
- [ ] auto-generate changelog file
- [ ] configure copr-cli

```
rpmdev-setuptree
rpmdev-newspec git-insight
```

[rpm macros documentation](https://docs.fedoraproject.org/en-US/packaging-guidelines/RPMMacros/)
[rpm scriptlets to handle systemd service](https://docs.fedoraproject.org/en-US/packaging-guidelines/Scriptlets/)

## Building packages

build from latest committedd source, uncommited source will not be picked

```
rpmlint git-insight.spec
tito build --rpm --test
```

### Verify

```
rpm -ql /tmp/tito/noarch/git-insight-0.0.1-1.git.2.a0a31dd.fc35.noarch.rpm
sudo dnf install --refresh git-insight
```

## Architecture

Extra Packages for Enterprise Linux (EPEL) - Fedora Docs

### Resources

- [spec file help](https://rpm-packaging-guide.github.io/#what-is-a-spec-file)
- [official spec file macros](https://rpm-software-management.github.io/rpm/manual/spec.html)
- [linux FHS](https://refspecs.linuxfoundation.org/FHS_3.0/fhs-3.0.html)
- [linux FHS /use/share/\* explained](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch04s11.html)

## Questions

- How to access calendar from your APP ? [calDAV standard](https://en.wikipedia.org/wiki/CalDAV)

| Command   | Meaning                                                                                                        |
| --------- | -------------------------------------------------------------------------------------------------------------- |
| chmod 400 | file To protect a file against accidental overwriting.                                                         |
| chmod 500 | directory To protect yourself from accidentally removing, renaming or moving files from this directory.        |
| chmod 600 | file A private file only changeable by the user who entered this command.                                      |
| chmod 644 | file A publicly readable file that can only be changed by the issuing user.                                    |
| chmod 660 | file Users belonging to your group can change this file, others don't have any access to it at all.            |
| chmod 700 | file Protects a file against any access from other users, while the issuing user still has full access.        |
| chmod 755 | directory For files that should be readable and executable by others, but only changeable by the issuing user. |
| chmod 775 | file Standard file sharing mode for a group.                                                                   |
| chmod 777 | file Everybody can do everything to this file.                                                                 |
