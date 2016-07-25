#!/bin/bash

set -xe

rm -v *deb || true

dpkg-deb --build kitteh1 kitteh_1.deb
dpkg-deb --build kitteh2 kitteh_2.deb
dpkg-deb --build meows meows_1.deb

rm -v Packages* || true
dpkg-scanpackages -m . /dev/null | gzip -9c > Packages.gz

cat <<- EOF > Release
Origin: origin
Label: label
Codename: xx
Architectures: amd64
Components: main
Description: description"
EOF
echo -e "Date: `LANG=C date -R`" >> Release
echo -e 'MD5Sum:' >> Release
printf ' '$(md5sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(md5sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release
echo -e '\nSHA256:' >> Release
printf ' '$(sha256sum Packages.gz | cut --delimiter=' ' --fields=1)' %16d Packages.gz' $(wc --bytes Packages.gz | cut --delimiter=' ' --fields=1) >> Release
printf '\n '$(sha256sum Packages | cut --delimiter=' ' --fields=1)' %16d Packages' $(wc --bytes Packages | cut --delimiter=' ' --fields=1) >> Release

echo "''''"
echo "deb file://${PWD} /"
