FROM pehowell/arch-tiny-init
LABEL maintainer="Paul Howell <paul.howell@gmail.com>"

ENV TERM xterm

RUN set -euxo pipefail && \
	echo 'Server = http://mirror.rise.ph/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist && \
	echo $'[archlinuxfr]\n\
	SigLevel = Never\n\
	Server = http://repo.archlinux.fr/$arch\n' >> /etc/pacman.conf && \
  pacman-key -u --refresh-keys

ENV TEMP_PKG "autoconf binutils fakeroot file gcc gzip make patch shadow sudo yaourt"
ENV NEEDED_PKG "awk which gnu-netcat"

COPY start.sh /home/ib/start.sh
COPY jts.ini /home/ib/jts.ini

RUN set -euxo pipefail && \
  pacman -Syyuw --noconfirm ${TEMP_PKG} ${NEEDED_PKG} && \
  rm /etc/ssl/certs/ca-certificates.crt && \
	pacman -Su --noconfirm ${TEMP_PKG} ${NEEDED_PKG} && \
  useradd -G wheel ib && \
  chown -R ib:ib /home/ib && \
  chmod +x /home/ib/start.sh && \
	sed -i 's/^# \(.*\)NOPASSWD\(.*\)$/\1NOPASSWD\2/' /etc/sudoers && \
	sudo -u ib yaourt --m-arg --skipchecksums -S --noconfirm --nocolor ib-tws && \
  sudo -u ib yaourt -S --noconfirm --nocolor ib-controller && \
  sudo -u ib yaourt --noconfirm -S localepurge && \
 	pacman -Runs --noconfirm $(pacman -Qtdq) && \
  # pacman -Rdd --noconfirm cracklib gtk2 guile icu llvm-libs mesa perl systemd ttf-dejavu xorg-fonts-misc wayland ${TEMP_PKG} && \
  mkdir -p /var/run/xvfb && \
  find /usr/share/locale/ -mindepth 1 -maxdepth 1 -not -name en_US | xargs rm -rf && \
  rm -rf /usr/share/man/* && \
  rm -rf /usr/share/doc/*

VOLUME /home/ib/config
WORKDIR /home/ib

EXPOSE 4001
# HEALTHCHECK --interval=5s --timeout=3s CMD nc -z localhost 4001
CMD ["/bin/bash", "/home/ib/start.sh"]
