# Uso: .\setup.ps1
# Cria o ambiente virtual, instala as dependências e prepara a estrutura do projeto.

$ErrorActionPreference = "Stop"

Write-Host "Criando ambiente virtual (.venv)..."
python -m venv .venv

Write-Host "Ativando e atualizando o pip..."
& .\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip

Write-Host "Instalando dependências..."
pip install -r requirements.txt

Write-Host "Registrando o kernel do Jupyter..."
python -m ipykernel install --user --name tcc --display-name "Python (TCC)"

Write-Host "Criando estrutura de pastas..."
$pastas = @("data\raw", "data\interim", "data\processed", "notebooks", "src", "figures")
foreach ($p in $pastas) { New-Item -ItemType Directory -Force -Path $p | Out-Null }

if (Test-Path .git) {
    Write-Host "Configurando nbstripout no Git..."
    nbstripout --install
} else {
    Write-Host "Aviso: rode 'git init' e depois 'nbstripout --install' para limpar saídas dos notebooks."
}

Write-Host ""
Write-Host "Pronto. No VS Code: Ctrl+Shift+P > 'Python: Select Interpreter' > escolha .venv"