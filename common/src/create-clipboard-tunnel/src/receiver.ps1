function Get-Clipboard([switch] $Lines) {
	if($Lines) {
		$cmd = {
			Add-Type -Assembly PresentationCore
			[Windows.Clipboard]::GetText() -replace "`r", '' -split "`n"
		}
	} else {
		$cmd = {
			Add-Type -Assembly PresentationCore
			[Windows.Clipboard]::GetText()
		}
	}
	if([threading.thread]::CurrentThread.GetApartmentState() -eq 'MTA') {
		& powershell -Sta -Command $cmd
	} else {
		& $cmd
	}
}
