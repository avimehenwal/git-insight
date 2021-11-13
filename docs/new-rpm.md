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
```

### Resources

- [spec file help](https://rpm-packaging-guide.github.io/#what-is-a-spec-file)
- [official spec file macros](https://rpm-software-management.github.io/rpm/manual/spec.html)
