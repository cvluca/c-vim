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
  $NvimDataPath = "$HOME\AppData\Local\nvim-data"

  if (Test-Path -Path $NvimPath) {
    [IO.Directory]::Delete("$HOME\AppData\Local\nvim.old")
    Rename-Item -Path $NvimPath -NewName "nvim.old"
    Write-Host "backup nvim folder nvim.old"
  }
  New-Item -ItemType Junction -Path $NvimPath -Target $CurrentDir

  if (Test-Path -Path $NvimDataPath) {
    [IO.Directory]::Delete("$HOME\AppData\Local\nvim-data.old")
    Rename-Item -Path $NvimDataPath -NewName "nvim-data.old"
    Write-Host "backup nvim-data folder nvim-data.old"
  }
  New-Item -ItemType Junction -Path $NvimDataPath -Target $CurrentDir
}

function Install-Vim
{
  Write-Host "Install c-vim for vim ..."
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
