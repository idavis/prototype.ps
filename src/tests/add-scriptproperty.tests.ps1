$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".tests.", ".")
. "$here\_Common.ps1"
. "$here\..\functions\$sut"

$source = @"
public class TestPerson {
  public TestPerson():this(0) {}
  public TestPerson(int age) { _Age = age; }
  private int _Age;
  public int Age {get {return _Age;} set{_Age = value;}}
}
"@

Add-Type -TypeDefinition $source

function new-dummy {
  param($age = 3)
  $prototype = new-object psobject (new-object TestPerson $age)
  $prototype | Add-ScriptProperty AgeProxy { $this.Age } {param([String]$value); $this.Age = $value}
  $prototype | Add-ScriptProperty Radius {3}
  $prototype | Add-ScriptProperty Diameter {$this.Radius * 2}
  $prototype
}

Describe "Ensure-ReadOnlyPropertiesAreResolved" {
  It "should use the supplied scriptblock to access the value for a property" {
    (new-dummy).Radius | Should Be 3
  }
  It "should be able to self reference proxied variables and the prototype object" {
   (new-dummy).Diameter | Should Be 6
  }
}

Describe "Ensure-ReadWritePropertiesOnTheBaseAreResolved" {
  It "should use the default value when not set" {
    (new-dummy).Age | Should Be 3
  }
  It "should use the value passed into the base" {
    (new-dummy 42).Age | Should Be 42
  }
  It "should use the value passed into the setter" {
    $dummy = (new-dummy 42)
	$dummy.Age = 24
	$dummy.Age | Should Be 24
  }
}

Describe "Ensure-ReadWritePropertiesOnThePrototypeAreResolved" {
  It "should use the default value when not set" {
    (new-dummy).AgeProxy | Should Be 3
  }
  It "should use the value passed into the base" {
    (new-dummy 42).AgeProxy | Should Be 42
  }
  It "should use the value passed into the setter" {
    $dummy = (new-dummy 42)
	$dummy.AgeProxy = 24 
	$dummy.AgeProxy | Should Be 24
  }
}