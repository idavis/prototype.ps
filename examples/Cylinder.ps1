﻿function new-cylinder {
  [CmdletBinding()]
  param(
    [Parameter(Position=0,Mandatory=0)][double]$radius = 3,
    [Parameter(Position=1,Mandatory=0)][double]$height = 4
  )
  $prototype = new-circle($radius)
  $prototype | new-autoproperty Height $height
  $prototype | new-property LateralArea {$this.Radius * $this.Radius * $this.Pi}
  # override/replace Area
  $prototype | new-property Area {2 * $this.LateralArea + 2 * $this.Pi * $this.Radius * $this.Height}
  $prototype
}

$cylinder = new-cylinder -radius 5.0 -height 4.0
$cylinder.Radius
$cylinder.Diameter
$cylinder.Height
$cylinder.Circumference
$cylinder.LateralArea
$cylinder.Area