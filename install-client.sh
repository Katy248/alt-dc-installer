domain=school.alt
work_group=school
host=host-15

host_ip_address='192.168.1.2'
dc_ip_address='8.8.8.8'

password='Pa$$word'

hostnamectl set-hostname $host.$domain

connection=$(nmcli --fields NAME --terse connection show active)

nmcli \
    connection modify $connection \
    ipv4.dns $dc_ip_address

systemctl restart NetworkManager

bash scripts/install-packages.sh task-auth-ad-sssd

system-auth write ad \
    $domain $host $work_group \
    'administrator' $password \
    --gpo
