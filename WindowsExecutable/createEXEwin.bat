@echo off
REM Überprüfen und Löschen der Datei "plotSPEwin.py"
if exist "plotSPEwin.py" (
    del "plotSPEwin.py"
    echo "Bestehende Datei 'plotSPEwin.py' wurde gelöscht."
)

REM Löschen des gesamten Inhalts des Ordners /build
if exist "build\" (
    rmdir /s /q "build"
    echo "Der Ordner '/build' wurde geleert."
)

REM Überprüfen, ob "plotSPEwin.exe" im Ordner /dist existiert
if exist "dist\plotSPEwin.exe" (
    echo "Die Datei 'plotSPEwin.exe' existiert im Ordner '/dist'."
    REM Überprüfen, ob "plotSPEwin.exe.old" existiert
    if exist "dist\plotSPEwin.exe.old" (
        del "dist\plotSPEwin.exe.old"
        echo "Die alte Datei 'plotSPEwin.exe.old' wurde gelöscht."
    )
    REM Umbenennen der Datei "plotSPEwin.exe" in "plotSPEwin.exe.old"
    ren "dist\plotSPEwin.exe" "plotSPEwin.exe.old"
    echo "Die Datei 'plotSPEwin.exe' wurde in 'plotSPEwin.exe.old' umbenannt."
)

REM Kopieren und Ausführen der Skripte
copy plotSPE.py plotSPEwin.py
python changePlotSPE.py plotSPEwin.py --replace3

REM Erstellen der ausführbaren Datei mit PyInstaller
pyinstaller --onefile --noconsole --add-data "plotSPE.py;." --add-data "gnuplot;gnuplot" --icon=gnuplotter.ico plotSPEwin.py

echo "Batch-Datei abgeschlossen. Ausfuehrbare Datei liegt in /dist - vielleicht."
pause
