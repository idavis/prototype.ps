$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".tests.", ".")
. "$here\_Common.ps1"
. "$here\..\functions\new-prototype.ps1"

$TryInvokeMemberMissingCallback =  { 
  param([Dynamic.InvokeMemberBinder]$binder, [object[]] $args, [ref][object] $result)
  Write-Host "Method Missing: Attempted to call $($binder.Name) with $($args -join ', ' )"
  $result=$null
  $true
}
$TryGetMemberMissing = {
  param([Dynamic.GetMemberBinder]$binder, [ref] $result)
  Write-Host $binder
  Write-Host "Method Missing: Attempted to get property $($binder.Name)"
  $result=$null
  $true
}
$TrySetMemberMissingCallback = {
  param([Dynamic.SetMemberBinder]$binder, $value)
  Write-Host $binder
  Write-Host "Method Missing: Attempted to set property $($binder.Name) to $($value|Out-String)"
  $true
}

#$dispatcher.TryInvokeMemberMissing = $TryInvokeMemberMissingCallback
#$dispatcher.TryGetMemberMissing = $TryGetMemberMissing
#$dispatcher.TrySetMemberMissing = $TrySetMemberMissingCallback