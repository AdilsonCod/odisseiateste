#!/bin/bash

echo "==================================="
echo "  DEPLOY MANUAL - ODISSEIA"
echo "==================================="
echo ""

# 1. Remover pasta antiga se existir
echo "1. Limpando instalação anterior..."
rm -rf ~/public_html/odisseia
mkdir -p ~/public_html/odisseia

# 2. Clonar repositório
echo "2. Clonando repositório do GitHub..."
cd ~/public_html
git clone https://github.com/AdilsonCod/odisseiateste.git odisseia

# 3. Entrar na pasta
cd odisseia

# 4. Criar .env
echo "3. Criando arquivo .env..."
cp .env.example .env

# 5. Configurar .env
echo "4. Configurando .env..."
cat > .env << 'EOF'
APP_NAME=Odisseia
APP_ENV=production
APP_KEY=
APP_DEBUG=false
APP_TIMEZONE=America/Sao_Paulo
APP_URL=https://seudominio.com

APP_LOCALE=pt_BR
APP_FALLBACK_LOCALE=pt_BR
APP_FAKER_LOCALE=pt_BR

DB_CONNECTION=mysql
DB_HOST=69.6.213.100
DB_PORT=3306
DB_DATABASE=hg1c7475_testeodisseia
DB_USERNAME=hg1c7475_escala
DB_PASSWORD=Juliana211!

CACHE_STORE=database
SESSION_DRIVER=database
SESSION_LIFETIME=120

QUEUE_CONNECTION=database

LOG_CHANNEL=daily
LOG_LEVEL=error
EOF

# 6. Instalar dependências
echo "5. Instalando dependências do Composer..."
composer install --optimize-autoloader --no-dev

# 7. Gerar APP_KEY
echo "6. Gerando APP_KEY..."
php artisan key:generate

# 8. Configurar permissões
echo "7. Configurando permissões..."
chmod -R 775 storage
chmod -R 775 bootstrap/cache

# 9. Otimizar Laravel
echo "8. Otimizando Laravel..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

# 10. Finalizar
echo ""
echo "==================================="
echo "  DEPLOY CONCLUÍDO!"
echo "==================================="
echo ""
echo "Próximos passos:"
echo "1. Configure o Document Root para: ~/public_html/odisseia/public"
echo "2. Compile os assets (npm run build) ou envie via FTP"
echo "3. Acesse: https://seudominio.com/login"
echo "4. Login: admin@odisseia.com / admin123"
echo ""
