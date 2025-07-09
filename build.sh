#!/bin/bash

IMAGE_NAME="discovery-server-atendeia"
VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

echo "➡️ Versão detectada no pom.xml: $VERSION"

# Build da imagem com tags
docker build -t $IMAGE_NAME:$VERSION -t $IMAGE_NAME:latest .

# Remove container antigo (se existir)
docker rm -f discovery-server 2>/dev/null

# Define a URL do Config Server como variável de ambiente
CONFIG_SERVER_URL="http://config-server:8888"

# Sobe o container com a variável de ambiente
docker run -d -p 8761:8761 \
  -e CONFIG_SERVER_URL=$CONFIG_SERVER_URL \
  --name discovery-server \
  $IMAGE_NAME:$VERSION

# Detecta o IP local com fallback para localhost
HOST_IP=$(hostname -I | awk '{print $1}')
if [ -z "$HOST_IP" ]; then
  HOST_IP="localhost"
fi

echo "✅ Imagem do Discovery criada e container iniciado!"
echo "🌐 Eureka disponível em: http://$HOST_IP:8761"
echo "📌 Substitua $HOST_IP por 'localhost' se estiver acessando da mesma máquina."
