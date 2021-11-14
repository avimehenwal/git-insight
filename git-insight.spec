Name:           git-insight
Version:        1.1.1
Release:        1%{?dist}
Summary:        get browser like colorful insights about a git repository on terminal
License:        MIT
URL:            https://github.com/avimehenwal/git-insight
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

BuildRequires:  pandoc make
Requires:       bash >= 5.1.8
Requires:       coreutils sed git fzf
Requires:       python3-pip

%description
%{Summary}

Use it inside any directory

%prep
# 1. unzip, unpacking sources
# 2. apply patches
%autosetup

%pre
python3 -m pip install --user termgraph

%build
make man

%install
mkdir -p %{buildroot}/%{_bindir}
install --mode=755 -v src/main.sh %{buildroot}%{_bindir}/%{name}
install -D --mode=644 -v build/%{name}.1 %{buildroot}%{_mandir}/man1/%{name}.1

%files
%{_bindir}/%{name}
%{_mandir}/man1/%{name}.1.gz

%changelog
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