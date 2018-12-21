#!/bin/bash
set -e

llvm_version=7.0.0
llvm_archive="clang+llvm-${llvm_version}-x86_64-apple-darwin"
llvm_url_for_macos="http://releases.llvm.org/${llvm_version}/${llvm_archive}.tar.xz"
toolchain_dir="LLVM_${llvm_version}.xctoolchain"

echo checking "${llvm_archive}.tar.xz"

if [ ! -f "${llvm_archive}.tar.xz" ];
then
	echo not found, downloading...
	curl -o ${llvm_archive}.tar.xz ${llvm_url_for_macos} 
fi

tar xvJf ${llvm_archive}.tar.xz

if [ -d "${toolchain_dir}" ];
then
	rm -rf ${toolchain_dir}
fi

mkdir ${toolchain_dir}

mv ${llvm_archive} ${toolchain_dir}/usr

toolchain_info="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
	<key>DisplayName</key>
	<string>LLVM ${llvm_version}</string>
	<key>CFBundleIdentifier</key>
	<string>org.llvm.releases.${llvm_version}</string>
</dict>
</plist>"
echo ${toolchain_info} > ${toolchain_dir}/ToolchainInfo.plist

echo make ${toolchain_dir} done.

exit 0
