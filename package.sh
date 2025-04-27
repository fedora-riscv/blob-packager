#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <directory> <package_name> <version>"
    exit 1
fi

DIRECTORY=$1
PACKAGE_NAME=$2
VERSION=$3
RELEASE=1
TOPDIR="$PWD/rpmbuild"
if [ ! -d "$DIRECTORY" ]; then
    echo "Directory $DIRECTORY does not exist."
    exit 1
fi

mkdir -p ${TOPDIR}/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
tar -czf ${TOPDIR}/SOURCES/${PACKAGE_NAME}-${VERSION}.tar.gz -C "$(dirname "$DIRECTORY")" "$(basename "$DIRECTORY")"
cat <<EOF > ${TOPDIR}/SPECS/${PACKAGE_NAME}.spec
Name:           ${PACKAGE_NAME}
Version:        ${VERSION}
Release:        ${RELEASE}%{?dist}
Summary:        ${PACKAGE_NAME} RPM Package

License:        CUSTOM
Source0:        %{name}-%{version}.tar.gz

BuildArch:      riscv64

%global debug_package %{nil}
%global __brp_check_rpaths %{nil}

%description
This is a RPM package for ${PACKAGE_NAME}.

%prep
%autosetup

%build

%install
mkdir -p %{buildroot}
cp -r * %{buildroot}/

%files
EOF
find "$DIRECTORY" -type f -o -type l | sed "s|^$DIRECTORY||" >> ${TOPDIR}/SPECS/${PACKAGE_NAME}.spec
cat <<EOF >> ${TOPDIR}/SPECS/${PACKAGE_NAME}.spec

%changelog
* $(date +"%a %b %d %Y") Fedora Packager <example@example.com> - ${VERSION}-${RELEASE}
- Initial package
EOF

rpmbuild --define "_topdir ${TOPDIR}" -ba ${TOPDIR}/SPECS/${PACKAGE_NAME}.spec
RPM_PACKAGE=$(find ${TOPDIR}/RPMS -name "${PACKAGE_NAME}-${VERSION}-${RELEASE}*.rpm")
echo "RPM package created at: ${RPM_PACKAGE}"

