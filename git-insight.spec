Name:           git-insight
Version:        1.1.5
Release:        1%{?dist}
Summary:        get browser like colorful insights about a git repository on terminal
License:        MIT
URL:            https://github.com/avimehenwal/git-insight
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

BuildRequires:  pandoc make pyp2rpm
Requires:       bash >= 5.1.8
Requires:       coreutils sed git fzf
Requires:       python3-termgraph


%description
%{Summary}

Use it inside any directory

%prep
# 1. unzip, unpacking sources
# 2. apply patches
%autosetup

%pre

%build
make man

%install
mkdir -p %{buildroot}/%{_bindir}
install --mode=755 -v src/main.sh %{buildroot}%{_bindir}/%{name}
install -D --mode=644 -v build/%{name}.1 %{buildroot}%{_mandir}/man1/%{name}.1
install -D --mode=644 -v src/_completion %{buildroot}/usr/local/share/zsh/site-functions/_%{name}

%files
%{_bindir}/%{name}
%{_mandir}/man1/%{name}.1.gz
/usr/local/share/zsh/site-functions/_%{name}

%changelog
* Tue Nov 16 2021 avimehenwal <avi.mehanwal@gmail.com> 1.1.5-1
- feat(linux): :coffin: enable syslog (avi.mehanwal@gmail.com)
- fix: :lock: run only in GIT enabled directories (avi.mehanwal@gmail.com)

* Tue Nov 16 2021 avimehenwal <avi.mehanwal@gmail.com> 1.1.4-1
- fix: :bug: make it work on openSUSE (avi.mehanwal@gmail.com)
- docs: :speech_balloon: add badge (avi.mehanwal@gmail.com)

* Mon Nov 15 2021 avimehenwal <avi.mehanwal@gmail.com> 1.1.3-1
- feat(completion): :dizzy: add help to completion (avi.mehanwal@gmail.com)
- feat: :tada: accept arguments for subcommands (avi.mehanwal@gmail.com)
- feat: :bookmark: add help option to usage API (avi.mehanwal@gmail.com)
- docs: :ambulance: readme (avi.mehanwal@gmail.com)

* Sun Nov 14 2021 avimehenwal <avi.mehanwal@gmail.com> 1.1.2-1
- feat(zsh): :fire: add auto completions (avi.mehanwal@gmail.com)
- docs: :memo: sales pitch (avi.mehanwal@gmail.com)

* Sun Nov 14 2021 avimehenwal <avi.mehanwal@gmail.com> 1.1.1-1
- feat(graph): :sparkles: total 6 graphs (avi.mehanwal@gmail.com)

* Sun Nov 14 2021 avimehenwal <avi.mehanwal@gmail.com> 1.1.0-1
- feat(graph): :zap: git commit trend calendar (avi.mehanwal@gmail.com)

* Sat Nov 13 2021 avimehenwal <avi.mehanwal@gmail.com> 1.0.0-1
- feat(graph): :art: add add/del stacked graph (avi.mehanwal@gmail.com)

* Sat Nov 13 2021 avimehenwal <avi.mehanwal@gmail.com> 0.0.3-1
- feat(rpm): :memo: add manpage (avi.mehanwal@gmail.com)
- test(rpm): :test_tube: build and install rpm into a docker fedora image
  (avi.mehanwal@gmail.com)
- build(rpm): :package: remove group from preamble (avi.mehanwal@gmail.com)
- fix: install it on docker fedora (avi.mehanwal@gmail.com)

* Sat Nov 13 2021 avimehenwal <avi.mehanwal@gmail.com> 0.0.2-1
- build: :bug: use py3 instead of py2 (avi.mehanwal@gmail.com)
- build(rpm): remove awk from Requires (avi.mehanwal@gmail.com)
- Automatic commit of package [git-insight] release [0.0.1-1].
  (avi.mehanwal@gmail.com)

* Sat Nov 13 2021 avimehenwal <avi.mehanwal@gmail.com> 0.0.1-1
- new package built with tito

* Sat Nov 13 2021 avimehenwal <avi.mehanwal@gmail.com> 0.0.1-1
- new package built with tito