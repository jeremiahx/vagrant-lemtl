#!/bin/bash

echo "$1"
echo " "
echo "========================================================================"
echo " "
echo "http://$2 ($3)"
echo " "
echo "Railo Server/Web Context Administrators"
echo " "
echo "http://$2/railo-context/admin/server.cfm"
echo "http://$2/railo-context/admin/web.cfm"
echo "Password (for each admin): password"
echo " "
echo " "
echo "Database Sever Connection Info for External Connections (use localhost inside vm)"
echo " "
echo "Server: $4"
echo "Port: 3306"
echo "User: root"
echo "Password: password"
echo " "
echo "========================================================================"
