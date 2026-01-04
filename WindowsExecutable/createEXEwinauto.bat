@echo off
REM Überprüfen und Löschen der Datei "plotSPEwinauto.py"
if exist "plotSPEwinauto.py" (
    del "plotSPEwinauto.py"
    echo "Bestehende Datei 'plotSPEwinauto.py' wurde gelöscht."
)

REM Löschen des gesamten Inhalts des Ordners /build
if exist "build\" (
    rmdir /s /q "build"
    echo "Der Ordner '/build' wurde geleert."
)

REM Überprüfen, ob "plotSPEwinauto.exe" im Ordner /dist existiert
if exist "dist\plotSPEwinauto.exe" (
    echo "Die Datei 'plotSPEwinauto.exe' existiert im Ordner '/dist'."
    REM Überprüfen, ob "plotSPEwinauto.exe.old" existiert
    if exist "dist\plotSPEwinauto.exe.old" (
        del "dist\plotSPEwinauto.exe.old"
        echo "Die alte Datei 'plotSPEwinauto.exe.old' wurde gelöscht."
    )
    REM Umbenennen der Datei "plotSPEwinauto.exe" in "plotSPEwinauto.exe.old"
    ren "dist\plotSPEwinauto.exe" "plotSPEwinauto.exe.old"
    echo "Die Datei 'plotSPEwinauto.exe' wurde in 'plotSPEwinauto.exe.old' umbenannt."
)

REM Kopieren und Ausführen der Skripte
copy plotSPE.py plotSPEwinauto.py
python changePlotSPE.py plotSPEwinauto.py --replace1 --replace3
python changePlotSPE.py plotSPEwinauto.py --replace2

REM Erstellen der ausführbaren Datei mit PyInstaller
pyinstaller --onefile --noconsole --add-data "plotSPE.py;." --add-data "gnuplot;gnuplot" --icon=gnuplotter.ico plotSPEwinauto.py

echo "Batch-Datei abgeschlossen. Oeffnen-Mit Programm liegt in /dist, wahrscheinlich."
pause
