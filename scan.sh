#!/bin/bash

# Script rápido para auditoria de rede Wi-Fi (para uso de mhwg)
echo "[*] Iniciando Scan de Rede (mhwg)..."
echo "[*] Data: $(date)"

# 1. Descobrir a rede automaticamente (ex: 192.168.1.0/24)
SUBNET=$(ip route | grep 'src' | awk '{print $1}' | head -n 1)

if [ -z "$SUBNET" ]; then
  echo "[ERRO] Não foi possível encontrar a rede. Conecte-se ao Wi-Fi primeiro."
  exit 1
fi

echo "[+] Rede encontrada: $SUBNET"
echo "[*] Iniciando Nmap (Isso pode demorar)..."

# 2. Rodar o Nmap e salvar o resultado
# -sV: Detecta versão dos serviços
# -O: Tenta adivinhar o Sistema Operacional
# -T4: Acelera o scan
# -oN: Salva o output em um arquivo de texto
nmap -sV -O -T4 $SUBNET -oN relatorio_tecnico.txt

echo "[SUCESSO] Scan concluído!"
echo "[*] O relatório técnico foi salvo em: relatorio_tecnico.txt"
echo "[*] Próximo passo: Traduzir este arquivo para o Relatório-Modelo."
