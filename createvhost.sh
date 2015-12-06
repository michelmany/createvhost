# Criado por Michel Many <nitdesign.com.br>                #
#                                                         #
# 05/12/2015                                              #
###########################################################
#                                                         #
# Script para criar um virtual host no apache e adicionar #
# o nome do host no arquivo hosts                         #
#                                                         #
###########################################################
#!/bin/bash
 
echo "Informe a url do site (Ex.: seusite.app):"
read vhost
 
echo "Criando configuração de VHost para o servidor"

#aqui é criado o arquivo de virtual host para o domínio e 
#é feita a escrita das configurações no arquivo
echo "<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        ServerName $vhost
        ServerAlias www.$vhost 
        DocumentRoot /var/www/$vhost
     <Directory /var/www/$vhost>
            Options Indexes FollowSymLinks MultiViews
            AllowOverride All
            Order allow,deny
            Allow from all
         </Directory>
</VirtualHost>" > /etc/apache2/sites-available/$vhost.conf

#ativa-se o o virtual host para que o serviço possa reconhecê-lo
echo "Ativando VHOST $vhost"
a2ensite $vhost.conf

#escreve no arquivo de hosts do linux
echo "Atualizando arquivo hosts"
echo "127.0.1.1   $vhost www.$vhost" >> /etc/hosts

#renicia-se o servidor apache para aplicar as configurações
echo "Reiniciando Apache";
service apache2 restart
 
echo "VHOST criado";