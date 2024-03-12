#!/bin/bash
for service in smb nmb krb5kdc slapd bind
do 
    systemctl disable $service
    systemctl stop $service 
done
