function Import-PrototypalObject {
  param()
  if(@(try{[Archetype.PrototypalObject]}catch{}).Length -eq 0 ) {
    if(Test-Path "$here\Archetype.dll") {
      Add-Type -Path "$here\Archetype.dll" -ReferencedAssemblies @("System.Core", "Microsoft.CSharp")
    } else {
      Add-Type -Path "$here\Prototype.cs" -ReferencedAssemblies @("System.Core", "Microsoft.CSharp")
    }
  }
}