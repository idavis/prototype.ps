﻿$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".tests.", ".")
. "$here\_Common.ps1"
. "$here\..\functions\$sut"

function new-person {
  $prototype = (new-object psobject)
  $prototype | Add-Property Name "John Doe"
  $prototype | Add-Property Age
  $prototype
}

Describe "Ensure-AutoPropertiesHaveTheirSuppliedOrDefaultValues" {
  It "should use the supplied value for a property" {
    (new-person).Name | Should Be "John Doe"
  }
  It "should use null when no property value is supplied" {
    (new-person).Age  | Should Be $null
  }
}