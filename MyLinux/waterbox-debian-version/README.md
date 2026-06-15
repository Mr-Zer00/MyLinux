# Waterbox para Debian 13 (Trixie)

Sandbox seguro para executar agentes CLI (como o **Claude Code**) usando **systemd‑nspawn**, adaptado para Debian 13.

Este script é uma adaptação do [waterbox original](https://github.com/morkin1792) criado por **morkin1792**, modificado para funcionar perfeitamente em distribuições baseadas em Debian (Trixie, sem necessidade de ajustes manuais pós‑instalação).

---

## 🛡️ O que é o Waterbox?

Um contêiner **isolado por namespaces e rede**, que oferece um terminal interativo completo (ZSH + tmux) com todas as ferramentas de desenvolvimento já instaladas. Ideal para:

- Rodar agentes de IA com permissões elevadas **sem expor o sistema host**.
- Testar scripts ou comandos potencialmente perigosos.
- Compartilhar apenas diretórios específicos do host de forma controlada.

---

## 🔧 Diferenças em relação ao original

- **Base Debian**: utiliza `debootstrap` em vez de `pacstrap`.
- Pacotes adaptados para repositórios Debian.
- **Correções automáticas**: caminhos de plugins ZSH, ordem do `PATH`, permissões do `npm` e dependências (`unzip`, `jq`) tratadas no bootstrap.
- **Claude Code** e **Oh My Posh** instalados no ambiente do usuário, sem conflitos.

---

## 📦 Dependências (no host)

Antes de usar, instale no Debian:

```bash
sudo apt update
sudo apt install debootstrap systemd-container curl iptables
