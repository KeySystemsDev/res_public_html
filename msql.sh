#!/bin/sh
#
# Este programa es software libre. Puede redistribuirlo y/o
# modificarlo bajo los términos de la Licencia Pública General
# de GNU según es publicada por la Free Software Foundation,
# bien de la versión 2 de dicha Licencia o bien (según su
# elección) de cualquier versión posterior.
#
# Este programa se distribuye con la esperanza de que sea
# útil, pero SIN NINGUNA GARANTÍA, incluso sin la garantía
# MERCANTIL implícita o sin garantizar la CONVENIENCIA PARA UN
# PROPÓSITO PARTICULAR. Para más detalles, véase la Licencia
# Pública General de GNU.
#
# Copyleft 2012
# Autor: Linuxman inguanzo@gmail.com http://linuxmanr4.com
# versión 2.0
echo $(date)

NAME="MySQL Backup"                                                                     # Nombre script.
                                                                                                        # Descripción: Script para hacer un respaldo de todas las bases de datos de un servidor MySQL.
: ${DATE:=$(date +'%Y-%m-%d')}                                          # Variable para Fecha.
: ${TIME:=$(date +'%R')}                                                        # Variable para Hora.
: ${WORK_DIR:=/home/keypan6/Mysql_Res/}      # Directorio de trabajo.
: ${IP_SERVIDOR_MYSQL:=localhost}           # Dirección del servidor MySQL.
: ${USUARIO:=keypan6_manuel}                                                                      # Usuario con privilegios a la base de datos. Ej. root
: ${DB_PASS:=sistema}                                                       # La contraseña de root de nuestro servidor MySQL.


# Antes de respaldar optimizamos y reparamos las bases de datos.
clear
echo "Revisando y reparando las bases de datos."
echo "========================================="
mysqlcheck -c -A --auto-repair -h $IP_SERVIDOR_MYSQL -u $USUARIO --password=$DB_PASS

echo#!/bin/sh
#
# Este programa es software libre. Puede redistribuirlo y/o
# modificarlo bajo los términos de la Licencia Pública General
# de GNU según es publicada por la Free Software Foundation,
# bien de la versión 2 de dicha Licencia o bien (según su
# elección) de cualquier versión posterior.
#
# Este programa se distribuye con la esperanza de que sea
# útil, pero SIN NINGUNA GARANTÍA, incluso sin la garantía
# MERCANTIL implícita o sin garantizar la CONVENIENCIA PARA UN
# PROPÓSITO PARTICULAR. Para más detalles, véase la Licencia
# Pública General de GNU.
#
# Copyleft 2012
# Autor: Linuxman inguanzo@gmail.com http://linuxmanr4.com
# versión 2.0

NAME="MySQL Backup"                                                                     # Nombre script.
                                                                                                        # Descripción: Script para hacer un respaldo de todas las bases de datos de un servidor MySQL.
: ${DATE:=$(date +'%Y-%m-%d')}                                          # Variable para Fecha.
: ${TIME:=$(date +'%R')}                                                        # Variable para Hora.
: ${WORK_DIR:=/home/usuario/directorioderespaldo/}      # Directorio de trabajo.
: ${IP_SERVIDOR_MYSQL:=IP_DEL_SERVIDOR_MYSQL}           # Dirección del servidor MySQL.
: ${USUARIO:=root}                                                                      # Usuario con privilegios a la base de datos. Ej. root
: ${DB_PASS:=CONTRASEÑA}                                                       # La contraseña de root de nuestro servidor MySQL.


# Antes de respaldar optimizamos y reparamos las bases de datos.
clear
echo "Revisando y reparando las bases de datos."
echo "========================================="
mysqlcheck -c -A --auto-repair -h $IP_SERVIDOR_MYSQL -u $USUARIO --password=$DB_PASS

echo
echo "Optimizando las bases de datos."
echo "========================================="
mysqlcheck -A -o -h $IP_SERVIDOR_MYSQL -u $USUARIO --password=$DB_PASS

# Cambiamos a nuestro directorio de trabajo
cd $WORK_DIR

echo
echo "Iniciando el vaciado de todas las bases de datos."
echo "================================================="

# Iniciamos un vaciado de todas las bases de datos del servidor.
TABLES=`mysql -h $IP_SERVIDOR_MYSQL -u$USUARIO --password=$DB_PASS --execute="SHOW DATABASES;" |awk '{print($1)}' |grep -v "Database" |grep -v "information_schema"`
for table in $TABLES; do
        echo "Respaldando la tabla $table..."
        file=$table.respaldo_`date +%Y%m%d`.sql
        mysqldump  -h $IP_SERVIDOR_MYSQL -u"$USUARIO" -p"$DB_PASS" $table > $file
        echo "Comprimiendo $file ..."
        gzip $file
done

echo
echo "RESPALDO TERMINADO!!!"
echo "Optimizando las bases de datos."
echo "========================================="
mysqlcheck -A -o -h $IP_SERVIDOR_MYSQL -u $USUARIO --password=$DB_PASS

# Cambiamos a nuestro directorio de trabajo
cd $WORK_DIR

echo
echo "Iniciando el vaciado de todas las bases de datos."
echo "================================================="

# Iniciamos un vaciado de todas las bases de datos del servidor.
TABLES=`mysql -h $IP_SERVIDOR_MYSQL -u$USUARIO --password=$DB_PASS --execute="SHOW DATABASES;" |awk '{print($1)}' |grep -v "Database" |grep -v "information_schema"`
mkdir $(date +%F)
cd $(date +%F)
for table in $TABLES; do
        echo "Respaldando la tabla $table..."
        file=$table.respaldo_`date +%Y%m%d`.sql
        mysqldump  -h $IP_SERVIDOR_MYSQL -u"$USUARIO" -p"$DB_PASS" $table > $file
        echo "Comprimiendo $file ..."
        gzip $file
done
cd ../
rm -rf *.gz

echo
echo "RESPALDO TERMINADO!!!"
