param (
	[switch]$help = $false
)

$global:texCmd="pdflatex.exe"
$global:sourceDirectory=(Get-Location).path
$global:testOutputDirectory="$sourceDirectory\target"
$global:templateDirectory="$sourceDirectory\LatexTemplateCVs"
$global:libDirectory="$sourceDirectory\lib"
$global:localTexDirectory="C:\Users\kafet\AppData\Roaming\MiKTeX\tex\latex"
$global:texCmdErrorPattern="Fatal error occurred,"

function show-help {
	Write-Output "Parameters
* -h : shows this help
* clean : removes the target directory
* compile : compiles the document

E.g
.\build.ps1 -h
.\build.ps1 clean compile
.\build.ps1 clean compile clean
"
}

function log
{
	Param($logLine)
	Write-Output "$(get-date -Format 'yyyy-MM-dd HH:mm:ss') : $logLine"
}

function clean {
	log "Cleaning $testOutputDirectory folder."
	if (Test-Path -Path $testOutputDirectory)
	{
		Get-ChildItem $testOutputDirectory -Recurse | Remove-Item -Force -Recurse
		Remove-Item $testOutputDirectory -Force
	}
}

function compile {
	if (!(Test-Path -Path $testOutputDirectory))  
	{
		log "Creating $testOutputDirectory folder."
		New-Item -ItemType Directory -Name $(Split-Path $testOutputDirectory -Leaf)
	}

	Copy-Item "$libDirectory\CVSoftwareEngineer.cls" "$(Split-Path $testOutputDirectory -Leaf)"
	Get-ChildItem -Exclude "$(Split-Path $libDirectory -Leaf),$(Split-Path $templateDirectory -Leaf),$(Split-Path $testOutputDirectory -Leaf)" |
		Where-Object {$_.extension -eq ".tex"} |
		Foreach-Object {
			$f = $_.Name

			log "Compiling file $f."

			Copy-Item "$sourceDirectory\$f" "$(Split-Path $testOutputDirectory -Leaf)\$f"
			
			$allArgs = @(
				"-halt-on-error",
				"-time-statistics",
				"-interaction=nonstopmode",
				"--output-directory=$testOutputDirectory",
				"--output-format=pdf",
				"$(Split-Path $testOutputDirectory -Leaf)\$f"
			)

			try {
				Invoke-Expression "$texCMD $allArgs" | Out-String -OutVariable cmdOut
			} catch {
				log "Failed to compile file $f."
			}

			$cmdErrors = (Select-String -InputObject $cmdOut -Pattern $texCmdErrorPattern).Matches
			if ($cmdErrors.Count -gt 0) {
				log "Failed to compile file $f."
				exit 1
			}
	}
}

# -----------------------------------------------------------------------------
# Actual script
# -----------------------------------------------------------------------------

if ($help) {
	show-help
	exit 0
}

# Dealing with the non switch based parameters.
for ( $i = 0; $i -lt $args.count; $i++ ) {
	log "Processing stage = $($args[$i])."
	Invoke-Expression $($args[$i])
}

log "Finished."
