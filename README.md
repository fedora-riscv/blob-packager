首先进入 riscv64 mock shell 环境，全程必须在 riscv64 架构下进行

确保 package.sh 和即将打包的目录处于同一级，目录结构如下
```
.
├── examplepkg-1.0
│   ├── etc
│   │   └── ld.so.conf
│   └── usr
│       └── lib64
│           └── libm.so
└── package.sh
```


使用格式如下
```
./package.sh <directory> <package_name> <version>
```

并且请确保文件夹名为 <package_name>-<version>，如
```
./package.sh examplepkg-1.0 examplepkg 1.0
```

最终 srpm 和 rpm 会生成在 rpmbuild/SRPMS 与 rpmbuild/RPMS 下
```
Wrote: /builddir/rpmbuild/SRPMS/examplepkg-1.0-1.fc41.src.rpm
Wrote: /builddir/rpmbuild/RPMS/examplepkg-1.0-1.fc41.riscv64.rpm
Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.d4v4aL
+ umask 022
+ cd /builddir/rpmbuild/BUILD
+ cd examplepkg-1.0
+ /usr/bin/rm -rf /builddir/rpmbuild/BUILDROOT/examplepkg-1.0-1.fc41.riscv64
+ RPM_EC=0
++ jobs -p
+ exit 0
Executing(rmbuild): /bin/sh -e /var/tmp/rpm-tmp.eS5Uji
+ umask 022
+ cd /builddir/rpmbuild/BUILD
+ rm -rf /builddir/rpmbuild/BUILD/examplepkg-1.0-SPECPARTS
+ rm -rf examplepkg-1.0 examplepkg-1.0.gemspec
+ RPM_EC=0
++ jobs -p
+ exit 0
RPM package created at: /builddir/rpmbuild/RPMS/examplepkg-1.0-1.fc41.riscv64.rpm
```