﻿$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".tests.", ".")
. "$here\_Common.ps1"
. "$here\..\functions\$sut"

function new-dummy {
  $prototype = (new-object psobject)
  $prototype | Add-Function HasRetVal { 5 }
  $prototype | Add-Function CanPassParameters {param($foo) $foo }
  $prototype
}

Describe "Ensure-FunctionsAreAdded" {
  It "should add functions with return values" {
    (new-dummy).HasRetVal() | Should Be 5
  }
  It "should add functions that take parameters" {
    (new-dummy).CanPassParameters(4) | Should Be 4
  }
}

# Swapping the functions, their names won't match, but this is the easiest impl for the test.
function new-dummy2 {
  $prototype = new-dummy
  $prototype | Add-Function HasRetVal {param($foo) $foo }
  $prototype | Add-Function CanPassParameters { 5 }
  $prototype
}

Describe "Ensure-FunctionsCanBeReplaced" {
  It "should replace methods with the same name but different parameters" {
    (new-dummy2).CanPassParameters() | Should Be 5
  }
  It "should use null when no property value is supplied" {
    (new-dummy2).HasRetVal(4) | Should Be 4
  }
}