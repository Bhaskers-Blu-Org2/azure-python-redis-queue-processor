yum install -y wget
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py

pip install azure-storage
pip install azure-keyvault
pip install cryptography
pip install rq

tar -xzf schedulerscripts.tar.gz

echo "* * * * * python validator.py --redisHost $1 --redisPort 6379 >/dev/null 2>&1" > crontab
/sbin/service crond start

python schedulerconfiguration.py
python scheduler-unencrypted.py data/data.encrypted --redisHost $1 --redisPort 6379

