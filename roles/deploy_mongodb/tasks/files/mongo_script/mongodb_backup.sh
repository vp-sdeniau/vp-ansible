#!/bin/bash

# Variables and init
#===================================================
APP_NAME="REPLICAT_SET_NAME"
MONGODUMP_PATH="/usr/bin/mongodump"
MONGO_HOST={{ ansible_default_ipv4.address }}
MONGO_PORT="27017"
TIMESTAMP=`date +%F-%H%M`
BACKUP_PATH="/var/lib/mongo_backup/"$APP_NAME"_"$TIMESTAMP
DB_NAME=

# Arborescence Creachone
#==================================================
echo $BACKUP_PATH
mkdir -p $BACKUP_PATH

#  Delete backups older than 3 days
#=================================================
echo `date +%F-%H%M%S` "     Recherche des backups obsolètes (>3j)"
find /var/lib/mongo_backup/ -type d -name $APP_NAME'_*' -ctime +2 -exec rm -rf {} +
echo `date +%F-%H%M%S` "     Backups obsolètes supprimés"

# Force file syncronization and lock writes
#=================================================
echo `date +%F-%H%M%S` "     Début freeze EveryOne"
mongo $MONGO_HOST --eval "printjson(db.fsyncLock())"

# Create backup(s)
#=================================================
if [ -z $DB_NAME ]
then
  echo `date +%F-%H%M%S` "     db_name null : Backup global"
  $MONGODUMP_PATH --host $MONGO_HOST:$MONGO_PORT --out $BACKUP_PATH --forceTableScan --oplog
else
  echo `date +%F-%H%M%S` "     db_name renseignée : Backup mono-base [" $DB_NAME "]"
  $MONGODUMP_PATH --host $MONGO_HOST:$MONGO_PORT --db $DB_NAME --out $BACKUP_PATH
fi

# End of Chantier
#=================================================
echo `date +%F-%H%M%S` "     Fin bakup(s) "

# Unlock database writes
#================================================
echo `date +%F-%H%M%S` "     UnFreeze EveryOne "
mongo $MONGO_HOST --eval "printjson(db.fsyncUnlock())"
