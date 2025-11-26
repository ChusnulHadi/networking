# format address into iso address
# example local address is 192.168.1.1 will be converted into 192 168 001 001
# 192168001001 will split with . every 4 digits like 1921.6800.1001
#
# [area].[formatted-ip].00
#
# for example we using area 51
#
# the iso address will be 51.1921.6800.1001.00
#

edit interface ge-0/0/0 unit 0
set family inet addresss 192.168.1.1/24
set family iso address 51.1921.6800.1001.00
