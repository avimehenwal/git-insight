Name:           git-insight
Version:        0.0.1
Release:        1%{?dist}
Summary:        beautiful graphical insights about a git repository
Group:          Development/Tools
License:        MIT
URL:            https://github.com/avimehenwal/git-insight
Source0:        %{name}-%{version}.tar.gz
BuildArch:      noarch

Requires:       bash coreutils sed
Requires:       python-pip

%description
Use it inside any directory
beautiful graphical insights about a git repository.

%prep
# 1. unzip, unpacking sources
# 2. apply patches
%autosetup

%pre
pip-python install termgraph

%build

%install
mkdir -p %{buildroot}/%{_bindir}
install --mode=755 -v src/main.sh %{buildroot}/%{_bindir}/git-insight

%files
# license LICENSE
# doc README.md
%{_bindir}/git-insight

%changelog
* Sat Nov 13 2021 avimehenwal <avi.mehanwal@gmail.com> 0.0.1-1
- new package built with tito

* Sat Nov 13 2021 avimehenwal <avi.mehanwal@gmail.com> 0.0.1-1
- new package built with tito