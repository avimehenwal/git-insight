# Todo

- [x] man pages
- [ ] application data /opt, /var or FHS specific place
- [ ] test
- [x] proper logs in /var/logs
- [ ] shell completions
- [ ] [zsh autoloading functions](https://unix.stackexchange.com/a/33898/32890)
- [ ] coloured echoed console logs

## Man pages

```
$PREFIX/share/man/man$SECTION/$NAME.$SECTION
pandoc --standalone --to man hello.1.md -o hello.1
man --local-file sample.1
```

[sample man-page in markdown format](https://gist.githubusercontent.com/eddieantonio/55752dd76a003fefb562/raw/38f6eb9de250feef22ff80da124b0f439fba432d/hello.1.md)

### Other ideas

[list which docs are available in html format on my machine?](https://superuser.com/questions/157996/utilities-for-find-open-linux-usr-share-docs)

firefox $(find /usr/share/doc -type f -name 'index.html' -print | sed '52q;d')
