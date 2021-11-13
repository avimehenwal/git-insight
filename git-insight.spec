Name:           git-insight
Version:        0.0.2
Release:        1%{?dist}
Summary:        beautiful graphical insights about a git repository
License:        MIT
URL:            https://github.com/avimehenwal/git-insight
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

BuildRequires:  pandoc make
Requires:       bash >= 5.1.8
Requires:       coreutils sed
Requires:       python3-pip

%description
Use it inside any directory
beautiful graphical insights about a git repository.

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
* Sat Nov 13 2021 avimehenwal <avi.mehanwal@gmail.com> 0.0.2-1
- build: :bug: use py3 instead of py2 (avi.mehanwal@gmail.com)
- build(rpm): remove awk from Requires (avi.mehanwal@gmail.com)
- Automatic commit of package [git-insight] release [0.0.1-1].
  (avi.mehanwal@gmail.com)

* Sat Nov 13 2021 avimehenwal <avi.mehanwal@gmail.com> 0.0.1-1
- new package built with tito

* Sat Nov 13 2021 avimehenwal <avi.mehanwal@gmail.com> 0.0.1-1
- new package built with tito