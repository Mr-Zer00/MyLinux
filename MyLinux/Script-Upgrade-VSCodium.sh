#!/bin/bash

# URL da página de lançamentos do VSCodium
RELEASES_URL="https://github.com/VSCodium/vscodium/releases"

# Nome do pacote
PACKAGE_NAME="codium_amd64.deb"

# Verificar a versão atual instalada
CURRENT_VERSION=$(dpkg-query --showformat='${Version}' --show codium 2>/dev/null)

# Obter a URL da última versão do VSCodium
LATEST_URL=$(curl -s "$RELEASES_URL" | grep -oP 'href="\K[^"]*codium_[^"]*amd64.deb' | head -n 1 | sed "s|^|https://github.com|")

# Verificar se a URL foi encontrada
if [ -z "$LATEST_URL" ]; then
    echo "Erro ao encontrar a URL da versão mais recente."
    exit 1
fi

# Fazer o download do pacote
echo "Baixando de: $LATEST_URL"
wget -O "$PACKAGE_NAME" "$LATEST_URL"

# Verificar se o download foi bem-sucedido
if [ ! -f "$PACKAGE_NAME" ]; then
    echo "Erro ao baixar o pacote."
    exit 1
fi

# Verificar a versão do pacote baixado
NEW_VERSION=$(dpkg-deb --info "$PACKAGE_NAME" | grep Version | awk '{print $2}')

# Comparar as versões e atualizar se necessário
if [ "$CURRENT_VERSION" != "$NEW_VERSION" ]; then
    echo "Atualizando VSCodium de $CURRENT_VERSION para $NEW_VERSION..."
    sudo dpkg -i "$PACKAGE_NAME"

    # Verificar se a instalação foi bem-sucedida
    if [ $? -eq 0 ]; then
        echo "Atualização concluída."
    else
        echo "Erro ao instalar a nova versão do VSCodium."
    fi
else
    echo "VSCodium já está na versão mais recente: $CURRENT_VERSION."
fi

# Limpar o pacote baixado
rm -f "$PACKAGE_NAME"
