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
# Copyleft 2017
# Autor: Carkis Espinoza carlosarmikhael@gmail.com
# versión 0.1
echo $(date)

NAME="Public HTML Backup"         

: ${DATE:=$(date +'%Y-%m-%d')}                  # Variable para Fecha.
: ${TIME:=$(date +'%R')}                        # Variable para Hora.
: ${WORK_DIR:=/home/keypan6/bat/}               # Directorio de trabajo.
: ${WORK_HTML:=/home/keypan6/public_html/}      # Directorio de HTML.

mkdir $(date +%F)
cd $(date +%F)
cp -r $WORK_HTML $WORK_DIR

tar -czvf public_html.tar.gz public_html        #tar -xvf paquete.tar.gz
rm -rf public_html

echo
echo "RESPALDO TERMINADO!!!"