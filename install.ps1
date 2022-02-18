param
(
  [string] $Install,
  [switch] $Uninstall
)

$CurrentDir = Get-Location

function Uninstall
{
  # TODO
  Write-Host "Uninstall c-vim ..."
}

function Install-Neovim
{
  Write-Host "Install c-vim for neovim ..."
  $NvimPath = "$HOME\AppData\Local\nvim"
  $NvimBackupPath = "$NvimPath.old"
  $NvimDataPath = "$HOME\AppData\Local\nvim-data"
  $NvimDataBackupPath = "$NvimDataPath.old"

  if (Test-Path -Path $NvimPath) {
    if (Test-Path -Path $NvimBackupPath) {
      [IO.Directory]::Delete($NvimBackupPath)
    }
    Rename-Item -Path $NvimPath -NewName "nvim.old"
    Write-Host "backup nvim folder to nvim.old"
  }
  New-Item -ItemType Junction -Path $NvimPath -Target $CurrentDir

  if (Test-Path -Path $NvimDataPath) {
    if (Test-Path -Path $NvimDataBackupPath) {
      [IO.Directory]::Delete($NvimDataBackupPath)
    }
    Rename-Item -Path $NvimDataPath -NewName "nvim-data.old"
    Write-Host "backup nvim-data folder to nvim-data.old"
  }
  New-Item -ItemType Junction -Path $NvimDataPath -Target $CurrentDir

  Write-Host "Installed c-vim for neovim" -ForegroundColor Green

  if (-Not (Test-Path -Path "$CurrentDir\plugged")) {
    nvim +PlugInstall! +PlugClean! +qall
    Write-Host "Installed plugins" -ForegroundColor Green
  }
}

function Install-Vim
{
  Write-Host "Install c-vim for vim ..."
  $VimrcPath = "$HOME\_vimrc"
  $VimrcBackupPath = "$VimrcPath.old"
  $VimfilesPath = "$HOME\vimfiles"
  $VimfilesBackupPath = "$VimfilesPath.old"

  if (Test-Path -Path $VimrcPath) {
    if (Test-Path -Path $VimrcBackupPath) {
      Remove-Item $VimrcBackupPath
    }
    Rename-Item -Path $VimrcPath -NewName "_vimrc.old"
    Write-Host "backup _vimrc file to _vimrc.old"
  }
  New-Item -ItemType SymbolicLink -Path $VimrcPath -Target $CurrentDir\vimrc

  if (Test-Path -Path $VimfilesPath) {
    if (Test-Path -Path $VimfilesBackupPath) {
      [IO.Directory]::Delete($VimfilesBackupPath)
    }
    Rename-Item -Path $VimfilesPath -NewName "vimfiles.old"
    Write-Host "backup vimfiles folder to vimfiles.old"
  }
  New-Item -ItemType Junction -Path $VimfilesPath -Target $CurrentDir

  Write-Host "Installed c-vim for vim" -ForegroundColor Green

  if (-Not (Test-Path -Path "$CurrentDir\plugged")) {
    vim +PlugInstall! +PlugClean! +qall
    Write-Host "Installed plugins" -ForegroundColor Green
  }
}

if ($Uninstall)
{
  Uninstall
  return
}

if ($Install -eq "neovim")
{
  Install-Neovim
}
elseif ($Install -eq "vim")
{
  Install-Vim
}
elseif ($Install -eq "")
{
  Install-Neovim
  Install-Vim
}
else
{
  Write-Error "Unknown: $Install"
}
