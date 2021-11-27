@set app=0

@if exist "config\gamemode.cfg" (
    @type "config\gamemode.cfg">"result.txt"    
    @set app=1
)

@if exist "config\script.txt" (
    @if %app% == 1 (
        @echo. >>"result.txt"
        @type "config\script.txt">>"result.txt"
    ) else (
        @type "config\script.txt">"result.txt"
    )
)
