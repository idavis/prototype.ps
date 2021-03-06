﻿<#
.SYNOPSIS

Adds a new property to an item supplied by the pipe without needing a getter/setter.

.DESCRIPTION

Adds a property with a hidden backing field given a property name and value

.PARAMETER name 

The name of the new property to be added.

.PARAMETER value 

The initial value of the property. This can be left out and the property will be null.

.PARAMETER options

A ScopedItemOptions constant that identifies how the property can be used.

.PARAMETER attributes

The attributes of the property.

.EXAMPLE

Create a simple property with an integer value:

>$prototype = New-Prototype
>$prototype | Add-Property BuildNumber 42

>$prototype.BuildNumber
42

.EXAMPLE

Create a simple property with no initial value:

>$prototype = New-Prototype
>$prototype | Add-Property BuildNumber

>$prototype.BuildNumber
>$prototype.BuildNumber = 42
>$prototype.BuildNumber
42

.NOTES

#>
function Add-Property {
  param(
    [string]$name, 
    [object]$value = $null,
    [System.Management.Automation.ScopedItemOptions]$options = [System.Management.Automation.ScopedItemOptions]::None,
    [Attribute[]]$attributes = $null
  )
  process {
    $variable = new-object System.Management.Automation.PSVariable $name, $value, $options, $attributes
    $property = new-object System.Management.Automation.PSVariableProperty $variable
    $_.psobject.properties.remove($name)
    $_.psobject.properties.add($property)
  }
}