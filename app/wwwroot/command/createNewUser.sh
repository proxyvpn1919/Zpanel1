#!/bin/bash
sudo adduser $1 --shell /usr/sbin/nologin &
wait
sudo passwd $1 <<!
$2
$2
!