
### Installation de Vmware-Tools
```bash
pacman -Sy --noconfirm base-devel asp;

for x in {0..6}; do mkdir -p /etc/init.d/rc${x}.d; done
tar xf /run/media/marc/VMware\ Tools/VMwareTools-10.3.23-16594550.tar.gz /root
perl /root/vmware-tools-distrib/vmware-install.pl;
```


```
su - marc
cd /tmp;
asp checkout open-vm-tools;
cd open-vm-tools/repos/community-x86_64/
(echo "o"; echo "o") | makepkg -s --asdeps;
cp vm* /usr/lib/systemd/system
```

```
echo "
[Unit]
Description=VMWare Tools daemon

[Service]
ExecStart=/etc/init.d/vmware-tools start
ExecStop=/etc/init.d/vmware-tools stop
PIDFile=/var/lock/subsys/vmware
TimeoutSec=0
RemainAfterExit=yes
 
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/vmwaretools.service;
```

systemctl start vmwaretools
systemctl enable --now vmwaretools

