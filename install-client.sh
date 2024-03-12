domain=school.alt
work_group=school
host=host-15

password='Pa$$word'

# for DNS
dc_ip_address='8.8.8.8'



nmcli_connections=$(nmcli --fields NAME --terse connection show active)
connection=$(sed '2' $nmcli_connections) 

nmcli \
    connection modify $connection \
    ipv4.dns $dc_ip_address

systemctl restart NetworkManager

bash scripts/install-packages.sh task-auth-ad-sssd

system-auth write ad \
    $domain $host $work_group \
    'administrator' $password \
    --gpo
