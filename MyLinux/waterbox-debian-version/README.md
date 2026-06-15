# Waterbox para Debian 13 (Trixie)

Sandbox seguro para executar agentes CLI (como o **Claude Code**) usando **systemd‑nspawn**, adaptado para Debian 13.

Este script é uma adaptação do [waterbox original](https://github.com/morkin1792) criado por **morkin1792**, modificado para funcionar perfeitamente em distribuições baseadas em Debian (sem necessidade de ajustes manuais pós‑instalação).

---

### O que é o Waterbox?

Um contêiner **isolado por namespaces e rede**, que oferece um terminal interativo completo (ZSH + tmux) com todas as ferramentas de desenvolvimento já instaladas. Ideal para:

- Rodar agentes de IA com permissões elevadas **sem expor o sistema host**.
- Testar scripts ou comandos potencialmente perigosos.
- Compartilhar apenas diretórios específicos do host de forma controlada.

---

### Diferenças em relação ao original

- **Base Debian**: utiliza `debootstrap` em vez de `pacstrap`.
- Pacotes adaptados para repositórios Debian.
- **Correções automáticas**: caminhos de plugins ZSH, ordem do `PATH`, permissões do `npm` e dependências (`unzip`, `jq`) tratadas no bootstrap.
- **Claude Code** e **Oh My Posh** instalados no ambiente do usuário, sem conflitos.

---

### Dependências (no host)

Antes de usar, instale no Debian:

```bash
sudo apt update
sudo apt install debootstrap systemd-container curl iptables
```
---

<a>
<br><br>

# Instalação do script

Clone este repositório:

```bash
git clone https://github.com/Mr-Zer00/MyLinux/tree/main/MyLinux/waterbox-debian-version
cd waterbox-debian
```

Copie o script para um diretório do PATH e torne executável:

```bash
sudo cp waterbox /usr/bin/waterbox
sudo chmod +x /usr/bin/waterbox
```

Executar:

```bash
waterbox start
```

Na primeira execução, o bootstrap criará um sistema Debian mínimo dentro de ~/.waterbox/root. Esse processo pode levar alguns minutos, dependendo da conexão.

Quando finalizar, você dentro de uma sessão tmux com o prompt [water@box ~/workspace]$.

---

<br>
<br>

# Uso

| Comando | Descrição |
| ----- | ----- |
| waterbox start | Inicia o contêiner e anexa uma sessão tmux. Se já estiver rodando, mostra um menu para anexar ou criar nova sessão. |
| waterbox stop | Desliga o contêiner graciosamente (preserva os dados). |
| waterbox restart | Para e inicia novamente (necessário após share add). |
| waterbox status | Exibe se o contêiner está ativo. |
| waterbox reset | Apaga completamente o ambiente e reconstrói do zero. |
| waterbox share add <caminho> | Compartilha uma pasta do host dentro do workspace do contêiner. |
| waterbox share del <caminho> | Remove um compartilhamento (ao vivo, sem necessidade de reiniciar). |
| waterbox share list | Lista as pastas atualmente compartilhadas. |
| waterbox help | Mostra esta ajuda. |
