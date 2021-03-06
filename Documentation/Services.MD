### Liste des services qui sont désactiver
```
systemctl list-units --all --type=service | grep systemd | grep dead | cut -c1-36 ;
systemctl list-unit-files --state=disabled | cut -c1-41
systemctl list-unit-files --state=enabled  | cut -c1-36
```

```
systemd-ask-password-console              # Dispatch Password Requests to Console
systemd-ask-password-wall                 # Forward Password Requests to Wall
systemd-binfmt                            # set Up Additional Binary Formats
systemd-boot-system-token                 # store a System Token in an EFI Variable
systemd-firstboot                         # First Boot Wizard
systemd-homed-activate                    # Home Area Activation
systemd-homed                             # ome Area Manager
systemd-hwdb-update                       # Rebuild Hardware Database
systemd-journal-catalog-update            # Rebuild Journal Catalog
systemd-machine-id-commit                 # Commit a transient machine-id on disk
systemd-quotacheck                        # File System Quota Check
systemd-repart                            # Repartition Root Disk
systemd-rfkill                            # Load/Save RF Kill Switch Status
systemd-sysusers                          # Create System Users
systemd-tmpfiles-clean                    # Cleanup of Temporary Directories
systemd-udev-settle                       # Wait for udev To Complete Device Initialization
systemd-update-done                       # Update is Completed
systemd-userdbd                           # User Database Manager
systemd-vconsole-setup                    # setup Virtual Console
```


```
proc-sys-fs-binfmt_misc.mount             #
auditd.service                            # Security Auditing Service
avahi-daemon.service                      # Avahi mDNS/DNS-SD Stack
avahi-dnsconfd.service                    # Avahi DNS Configuration Daemon
blk-availability.service                  # Availability of block devices
canberra-system-bootup.service            # Play Bootup Sound
canberra-system-shutdown-reboot.service   # Play Reboot Sound
canberra-system-shutdown.service          # Play Shutdown Sound
console-getty.service                     # Console Getty (???)
debug-shell.service                       # Early root shell on /dev/tty9 FOR DEBUGGING ONLY
dhcpcd.service                            # dhcpcd on all interfaces
dmraid.service                            # Assemble FakeRAID arrays
e2scrub_reap.service                      # Remove Stale Online ext4 Metadata Check Snapshots
ead.service                               # Ethernet service (ExecStart=/usr/lib/iwd/ead)
fancontrol.service                        # Start fan control, if configured
gpm.service                               # Virtual console mouse server
healthd.service                           # A daemon which can be used to alert you in the event of a hardware health monitoring alarm
ip6tables.service                         # IPv6 Packet Filtering Framework
iptables.service                          # IPv4 Packet Filtering Framework
iwd.service                               # ireless service
krb5-kadmind.service                      # Kerberos 5 administration server
krb5-kdc.service                          # Kerberos 5 KDC
krb5-kpropd.service                       # Kerberos 5 propagation server
lm_sensors.service                        # Initialize hardware monitoring sensors
ndctl-monitor.service                     # Ndctl Monitor Daemon
netctl-sleep.service                      # netctl sleep hook
netctl-wait-online.service                # Wait for the enabled netctl profiles to come online
netctl.service                            # (Re)store the netctl profile state
ninfod.service                            # Respond to IPv6 Node Information Queries
nscd.service                              # Name Service Cache Daemon
ntpd.service                              # Network Time Service
ntpdate.service                           # One-Shot Network Time Service
rdisc.service                             # Network Router Discovery Daemon
reflector.service                         # Refresh Pacman mirrorlist with Reflector.
rtkit-daemon.service                      # RealtimeKit Scheduling Policy Service
sensord.service                           # Log hardware monitoring dat
sudo_logsrvd.service                      # Sudo central log server
systemd-boot-check-no-failures.service    # Check if Any System Units Failed
systemd-journal-upload.service            # Journal Remote Upload Service
systemd-network-generator.service         # Generate network units from Kernel command line
systemd-oomd.service                      # Userspace Out-Of-Memory (OOM) Killer
systemd-pstore.service                    # Platform Persistent Storage Archival
systemd-sysext.service                    # Merge System Extension Images into /usr/ and /opt/
systemd-time-wait-sync.service            # Wait Until Kernel Time Synchronized
udisks2.service                           # Disk Manager
upower.service                            # Daemon for power management
nmb.service                               # Samba NMB Daemon
samba.service                             # Samba AD Daemon
smb.service                               # Samba SMB Daemon
winbind.service                           # Samba Winbind Daemon
wpa_supplicant.service                    #
e2scrub_all.timer                         #
fstrim.timer                              #
paccache.timer                            #
reflector.timer                           #
xfs_scrub_all.timer                       #


btrfs-scrub@.timer                        #
rarpd@.service                            #
rfkill-block@.service                     #
rfkill-unblock@.service                   #
systemd-nspawn@.service                   #
serial-getty@.service                     #
wpa_supplicant-nl80211@.service           #
wpa_supplicant-wired@.service             #
```
