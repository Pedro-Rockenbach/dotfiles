# =============================================================================
# Histórico (Otimizado)
# =============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt APPEND_HISTORY          # Adiciona ao histórico em vez de sobrescrever
setopt SHARE_HISTORY          # Compartilha o histórico entre abas abertas
setopt HIST_IGNORE_ALL_DUPS    # Remove duplicatas antigas ao salvar novas
setopt HIST_REDUCE_BLANKS     # Remove espaços desnecessários dos comandos
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt CORRECT
setopt AUTOCD
# =============================================================================
# Variáveis de Ambiente
# =============================================================================
export EDITOR='nvim'
export VISUAL='nvim'
export PATH="$HOME/.local/bin:$PATH"
# Autocompletar avançado
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
# =============================================================================
# Estilização do FZF (Ctrl + R e CDI)
# =============================================================================
# Deixa a busca interativa com visual moderno, bordas e preview
export FZF_DEFAULT_OPTS="
  --height 40% 
  --layout=reverse 
  --border 
  --inline-info"

# =============================================================================
# Aliases Essenciais
# =============================================================================
# Editors / Dev
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'

alias ls="eza --icons"
alias ll="eza -l --icons"
alias la="eza -la --icons"
alias tree="eza --tree --icons"

# Visualização de arquivos
alias cat="bat"

# Sistema e Redes
alias update="sudo pacman -Syu"

# Desenvolvimento e Edição
alias v="nvim"
alias sv="sudo nvim"

# Atalhos práticos de diretórios
alias ..="cd .."
alias ...="cd ../.."
alias c="clear"
# =============================================================================
# Plugins & Integrações (Carregamento Seguro)
# =============================================================================
# Sugestões e Syntax Highlighting
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Configurações do FZF (Ctrl+T para arquivos, Ctrl+R para histórico, Alt+C para diretórios)
source /usr/share/fzf/key-bindings.zsh 2>/dev/null
source /usr/share/fzf/completion.zsh 2>/dev/null

# Prompt do Starship
eval "$(starship init zsh)"

# Zoxide (Busca de diretórios)
eval "$(zoxide init zsh)"

# Função manual para garantir o funcionamento do cdi
cdi() {
  local dir
  dir="$(zoxide query -i -- "$@")" && cd "$dir"
}
# Busca um texto em todos os arquivos da pasta e abre o resultado no editor
alias findtext="rg --line-number --no-heading --color=always --smart-case '' | fzf -d ':' -n 2.. --ansi --no-sort --preview-window 'down:50%:+{2}' --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' | awk -F ':' '{print \"+ \"\$2\" \"\$1}' | xargs -r nvim"

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

