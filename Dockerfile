# ##############################################################
# Define a imagem do Docker com todas as dependência necessárias
# ##############################################################
#
# sudo docker build -t niobio:1.0.0 .
# sudo docker run -dit -p 8000:8000 --name my-container -v /path/to/niobio:/var/www niobio:1.0.0 /bin/bash
#
# Observação: Verifique se ao usar o comando "docker run" na versão atual do backend é necessário acrescentar link com outros containers, importar variáveis de ambiente, entre outros.
#
# - Em caso de erro na criação da tag no comando docker build (Tive problemas no Windows 10), siga:
#
# sudo docker images
# sudo docker tag <ID_IMAGE> niobio:1.0.0
# sudo docker run <...> (Conforme acima)
#
# - Acessar a máquina com bash:
#
# sudo docker exec -it my-container bash

FROM php:7.3.3

WORKDIR /var/www

# Define o autor da imagem
LABEL authors="Herberts Cruz <herbertscruz@gmail.com>"

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

ENV TZ=America/Sao_Paulo

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Porta(s) padrão liberadas para fora
EXPOSE 8000
