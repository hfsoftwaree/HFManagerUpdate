## HF Manager
Status: Ativo desde 01/2025<br><br><br>

O **HF Manager** é um sistema de gerenciamento de servidores **DayZ**, com suporte para monitoramento de até **3 servidores simultâneos**.

### ✨ Principais diferenciais

- **Gerenciamento centralizado:** monitoramento e administração de até 3 servidores DayZ simultaneamente.
- **Automação de tarefas:** controle de inicialização, reinicialização, encerramento, backups e atualizações de mods e do DayZ.
- **Verificação de integridade:** identificação e restauração de arquivos ausentes ou modificados, com opções de verificação parcial e total.
- **Backup com sincronização na nuvem:** criação de cópias de segurança personalizadas, sincronização com o Google Drive e remoção automática de backups antigos.
- **Gerenciamento inteligente de mods:** comparação entre mods baixados, instalados e configurados no BAT, facilitando a identificação e remoção de mods não utilizados.
- **Integração com Discord:** notificações automatizadas sobre atualizações, reinicializações, eventos, veículos, alterações de IP e logs administrativos.
- **Integração com RCON e BEC:** controle do encerramento e reinicialização dos servidores, além de inicialização e monitoramento do BEC.
- **Preservação de configurações personalizadas:** recursos específicos para evitar alterações indesejadas em arquivos de missões e configurações durante a verificação parcial de integridade e as atualizações do DayZ.
- **Agendamento de configurações:** programação de alterações no arquivo `ServerDZ.cfg` para o próximo reinício, sem necessidade de interromper o servidor imediatamente.
- **Segurança das credenciais:** criptografia das credenciais da Steam para reduzir sua exposição.
- **Organização e gerenciamento de logs:** separação de arquivos por data, definição de políticas de retenção e remoção automática de logs antigos.
---

## INTEGRAÇÕES
- Steam
- Discord
- BEC
- RCON
---

## ADDONS COMPLEMENTARES
- HFMFixMCK.pbo
  
O que ele faz?
- Gera o arquivo HFM_Vehicle_fixMCK_.log, responsável por extrair o nome de classe dos veículos existentes no mapa, além de gerar log de interação com os veículos. O arquivo de log será gerado na pasta "profile"

Por que ele é necessário?
- Sem ele não é possiível utilizar a função: "Não mostrar veículos da lista" disponível em: Configurações > Webhook > Car in map (MCK)
- Também não é possível enviar qualquer log ao discord referente a veículos

Instalação
- A adição ou remoção deste "pbo" ocorre de forma automática desde que utilizado o sistema para adicionar ou remover mod's do arquivo "BAT". Este "pbo" é somente lado servidor e será copiado para a pasta "Addons" do servidor.

Nota:

- Este "pbo" possuí dependência do mod "MuchCarKey", portanto se remover o "MuchCarKey" do seu arquivo "BAT" de forma manual, remova também este ".pbo" da pasta "Addons" do seu servidor
---

TAREFAS EXECUTADAS
---

### MONITORAMENTO
   - Monitora se o servidor está ativo e, caso tenha caído, o inicia novamente;

### BACKUP
   - Desligamento automático em horário predefinido para realização de backup;
   - Realiza backup em local definido pelo usuário;
   - Realiza o backup de qualquer arquivo ou pasta selecionada;
   - Sincronização do backup na nuvem;
   - Inicialização do servidor após concluir o processo de backup;
   - Remoção de backup antigo de forma automática, de acordo com o configurado.

### RESTART
   - Restart em horário predefinido;
   - Envio de mensagem ao discord informando sobre a aproximação do restart com possíbilidade de informar o
     tempo restante.

### UPDATE DE MOD E DAYZ
   - Envia mensagem ao discord informando sobre atualizações disponíveis e que o servidor será encerrado,
     informando também na mensagem o tempo para desligamento de acordo com o configurado;
   - Envia mensagem ao discord informando quais MODS ou versão do DAYZ houve atualização;
   - Envia mensagem ao discord informando que o processo de atualização terminou e que o servidor será iniciado;
   - Mods que não estão em uso no servidor, serão atualizados de forma silenciosa;
   - Nas atualizações do Dayz, os arquivos da pasta 'mpmission' não são atualizados automaticamente. No entanto,
     quando o Webhook estiver devidamente configurado, o administrador será notificado sobre quais arquivos 
     sofreram alterações. Essa funcionalidade evita sobscrever arquivos modificados em uso no servidor.

### VERIFICAÇÃO DE INTEGRIDADE DE ARQUIVOS DO DAYZ
   - Verificação parcial dos arquivos do DayZ, utilizando uma lista de arquivos e pastas autorizados, preservando 
     configurações personalizadas do servidor;
   - Verificação total dos arquivos do DayZ, comparando os arquivos da instalação de origem com os arquivos do 
     servidor;
   - Identificação de arquivos ausentes ou modificados, com restauração automática a partir dos arquivos da origem;
   - Opção de seleção entre verificação parcial e total, permitindo adequar o procedimento ao tipo de servidor;
   - Verificação do estado do servidor antes de iniciar o procedimento, impedindo a execução enquanto o servidor estiver 
     ativo.

   NOTA:
     A verificação parcial é indicada para servidores PvE com configurações personalizadas, pois não será alterado, 
     modificado ou substituido nenhum arquivo da pasta MPMISSIONS e PROFILE . 
     A verificação total é indicada para servidores vanilla e pode substituir arquivos de configuração modificados da pasta
     MPMISSIONS e PROFILE.

### STEAM
   - Integração com a Steam para: Baixar, atualizar e monitorar atualizações de mod de forma automática;
   - Login e senha da steam são criptografados, evitando sua exposição e mantendo a segurança dos dados.

### GERENCIADOR DE MOD INSTALADO
   - Exibe em uma única tela os seguintes dados
        - Todos os mod baixados da steam;
        - Todos os mod na pasta do servidor;
        - Todos os mod em uso no BAT.
        - Possíbilidade de remover mod da pasta da steam, da raiz do servidor e também em uso com um único 
          clique, evitando acumulo de mod baixado sem estarem em uso;
        - Possíbilidade de veríficar quais MODS não estão em uso no servidor, através de comparativo entre:
          pasta da steam | raiz do servidor | listados no bat  
        - Possíbilidade de Editar/Vizualizar o arquivo bat sem precisar navegar até a pasta do servidor

### BEC
   - Opção para inicialização e monitoramento de forma automática;

### SERVERDZ.CFG
   - Possíbilidade de agendamento de alteração deste arquivo para o próximo restart do servidor, com isso não é
     necessário parar o servidor ou ficar aguardando restart para realizar tais alterações.

### PARAMETRO UPDATE
   - Opção para definir o tempo de intervalo para:
     - Monitoramento de atualizações de MOD e DAYZ;
     - Tempo para encerrar o servidor após detectar atualizações.	 

### VEÍCULOS
   - Integração com MOD: MCK
     - Ao iniciar o servidor, será enviado ao discord, log dos veículos encontrados no mapa e sua respectiva 
       localização. Há possíbilidade de informar quais veículos não devem ser informado a localização;
     - Quando um veículo for destruído, será enviado ao discord, log informando o veículo e sua localização;
     - Quando um veículo for para garavem virtual, será enviado ao discord, log informando o veículo e sua
       localização.

### KOTH
   - Integração com MZ KOTH
      - Monitora spaw do KOTH e envia a hora de inicio do evento para o discord;
      - Com este procedimento, resolve-se o problema do player não saber se dará tempo de ir ao KOTH;

### LOGS DIVERSOS
   - Move arquivos de log da pasta "Profile" para a pasta "log" na raiz do servidor, organizando-os por data
     sempre que o servidor reiniciar;
   - Opção apra definir quais logs serão movidos da pasta profile para logs;
   - Opção para definir a Política de logs, permitindo definir quais logs serão mantidos e por quanto tempo.

### LOGS ADM
   - Possibilidade de envio do arquivo "crash" para o discord;
   - Possibilidade de envio do arquivo "serverconsole" para o discord;
        
### IP
   - Monitora mudanças no IP e, caso ocorram, envia uma mensagem para o Discord informando sobre a alteração.

### LOGS GERADOS PELO SISTEMA
   - Remoção de log antigo de forma automática;

### SHUTDOWN
   - Criação do arquivo "shutdown.bat" de forma automática;

### RCON
Encerramento e Restart realizados, por padrão, via comando RCON, executando os seguintes procedimentos:
   - Bloqueia o servidor para novas conexões;
   - Envia uma mensagem in-game informando sobre o encerramento/restart;
   - Expulsa todos os jogadores antes do encerramento;
   - Salva todo o progresso do jogo;
   - Encerra o servidor.

NOTA:<br>
Caso algo falhe, o sistema continuará realizando o encerramento/restart via BAT, caso esteja configurado dessa forma

### DISCORD
Integração com envio de dados para as seguintes tarefas:
   - Update de MOD e DAYZ;
   - Car in Map;
   - Car Destroyed;
   - Car Virtualized;
   - KOTH;
   - Crash.log;
   - Serverconsole.log;
   - Restart
     
---
<br>

- Discord: https://discord.gg/Sfvm9TMRur
- Instalador: https://github.com/hfsoftwaree/HFManagerUpdate/releases/download/installer/hfmanager.exe (Video desatualizado, mas ainda válido)
- Como configurar: https://www.youtube.com/watch?v=sF_Hs_HkSzE&t=186s
<br><br>
Tela de monitoramento do sistema:<br>
![Tela do Sistema](Tela.png)<br><br>
Tela de configuração de diretórios:<br>
![Tela do Sistema](Diretorio.png)<br><br>
Tela de configuração para atualização de MOD:<br>
![Tela do Sistema](ConfigUpdateMod.png)<br><br>
Tela de configuração para atualização do DAYZ:<br>
![Tela do Sistema](ConfigUpdateDayz.png)<br><br>
Tela de configuração do webhook Update Mod e Dayz:<br>
![Tela do Sistema](DiscordUpdateModDayz.png)<br><br>
Tela de configuração do webhook para Car Finder:<br>
![Tela do Sistema](DiscordCarFinder.png)<br><br>
Tela de configuração do webhook para Car Destroyed:<br>
![Tela do Sistema](CarDestroyed.png)<br><br>
Tela de configuração do webhook para Car Deleted:<br>
![Tela do Sistema](CarDeleted.png)<br><br>
Tela de configuração do webhook para KOTH:<br>
![Tela do Sistema](DiscordKOTH.png)<br><br>
Tela de configuração do webhook para Crash.log:<br>
![Tela do Sistema](DiscordCrashLog.png)<br><br>
Tela de configuração do webhook para Serverconsole.log:<br>
![Tela do Sistema](DiscordServerconsoleLog.png)<br><br>
Tela de configuração do webhook para Restart.log:<br>
![Tela do Sistema](WebhookRestart.png)<br><br>
Tela de configuração do Backup:<br>
![Tela do Sistema](Backup.png)<br><br>
Tela de configuração do Restart:<br>
![Tela do Sistema](Restart.png)<br><br>
Tela de configuração da integração com BEC:<br>
![Tela do Sistema](BEC.png)<br><br>
Tela de configuração da integração com Steam - Credenciais:<br>
![Tela do Sistema](SteamCredenciais.png)<br><br>
Tela de configuração da integração com Steam - Baixar MOD:<br>
![Tela do Sistema](SteamBaixarMod.png)<br><br>
Tela de configuração da integração com Steam - Gerenciar MOD:<br>
![Tela do Sistema](SteamGerenciarMod.png)<br><br>
Tela de configuração do arquivo ServerDZ.cfg:<br>
![Tela do Sistema](editcfg.png)<br><br>
Tela de configuração de parametros:<br>
![Tela do Sistema](painelcontrol.png)<br><br>
Tela de configuração de Politica de Logs:<br>
![Tela do Sistema](PoliticaLogs.png)<br><br>
Tela de configuração de RCON:<br>
![Tela do Sistema](Rcon.png)<br><br>


