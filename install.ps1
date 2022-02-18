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

function Install-Item
{
  param (
    [String] $Name,
    [String] $Type,
    [String] $Dir,
    [String] $Target
  )

  $Path = "$Dir\$Name"
  $BackupPath = "$Path.old"

  if (Test-Path -Path $Path) {
    if (Test-Path -Path $BackupPath) {
      if ($Type -eq "Junction") {
        [IO.Directory]::Delete($BackupPath)
      }
      else {
        Remove-Item $BackupPath
      }
    }
    Rename-Item -Path $Path -NewName "$Name.old"
    Write-Host "backup $Name to $Name.old"
  }

  New-Item -ItemType $Type -Path $Path -Target $Target
}


function Install-Neovim
{
  Write-Host "Install c-vim for neovim ..."
  $Dir = "$Home\AppData\Local"
  Install-Item -Name nvim -Type Junction -Dir $Dir -Target $CurrentDir
  Install-Item -Name "nvim-data" -Type Junction -Dir $Dir -Target $CurrentDir
  Write-Host "Installed c-vim for neovim" -ForegroundColor Green

  if (-Not (Test-Path -Path "$CurrentDir\plugged")) {
    nvim +PlugInstall! +PlugClean! +qall
    Write-Host "Installed plugins" -ForegroundColor Green
  }
}

function Install-Vim
{
  Write-Host "Install c-vim for vim ..."
  Install-Item -Name _vimrc -Type SymbolicLink -Dir $HOME -Target $CurrentDir\vimrc
  Install-Item -Name vimfiles -Type Junction -Dir $HOME -Target $CurrentDir
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
