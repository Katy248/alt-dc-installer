domain=base # -> base
realm=$domain.alt # -> base.ito
hostname=dc.$realm # -> dc.base.ito

password='Pa$$word'

sh ./scripts/disable-and-stop-services.sh
sh ./scripts/install-samba-dc.sh
sh ./scripts/remove-configs.sh

# set hostname of current machine
sh ./scripts/set-hostname.sh $hostname

samba-tool domain provision \
    --realm=$realm \
    --domain $domain \
    --adminpass=$password \
    --dns-backend=SAMBA_INTERNAL \
    --server-role=dc

# copy generated config
cp /var/lib/samba/private/krb5.conf /etc/krb5.conf

systemctl enable --now samba

samba-tool domain info 127.0.0.1
