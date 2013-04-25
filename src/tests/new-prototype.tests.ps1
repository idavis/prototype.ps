﻿$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".tests.", ".")
. "$here\_Common.ps1"
. "$here\..\functions\$sut"

Describe "Ensure-PrototypesHaveTheProperBaseObject" {
  It "should use null if nothing is supplied" {
    [object]::ReferenceEquals($null,(new-prototype).ImmediateBaseObject) | Should Be $true
  }
  It "should use the supplied base object" {
    $baseobject = @{item="1"}
    $prototype = new-prototype($baseobject)
    ($prototype.psobject.ImmediateBaseObject.Prototype) | Should Be $baseobject
  }
    It "should use the supplied prototype object" {
    $baseobject = @{item="1"}
    $prototype = new-prototype($baseobject)
    ($prototype.psobject.ImmediateBaseObject) | Should Be $prototype
  }
  
  It "should not add properties on the fly" {
    $prototype = new-prototype
    try {$prototype.foo = 5} catch { $true | Should Be $true; return} 
    $false | Should Be $true
  }
}

Describe "Ensure-HashBasedPrototypesHaveHashBehavior" {
  It "should add properties on the fly" {
    $prototype = new-prototype @{}
    $prototype.foo = 5
    $prototype.foo | Should Be 5
  }
}

Describe "Ensure-ExpandoObjectBasedPrototypesHaveHashBehavior" {
  It "should add properties on the fly" {
    $prototype = new-prototype (new-object Dynamic.ExpandoObject)
    $prototype.foo = 5
    $prototype.foo | Should Be 5
  }
}