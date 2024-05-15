# Instalação no Debian 11 (Apenas)

apt install -y git

git clone https://github.com/davigalucio/anbox.git

sh anbox/INSTALL.SH

# Instalação do PlayStore (Necessário iniciar o Anbox antes de instalar o PlayStore)

sh /opt/INSTALL-PlayStore.SH

# Instalação do WhatsApp (Necessário iniciar o Anbox antes de instalar o WhatsApp)

sh /opt/INSTALL-WhatsApp.SH

# Para acessar o Anbox, acesse via conexão RDP na portão padrão IP_DO_HOST:3389

