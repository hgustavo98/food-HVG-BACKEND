@echo off

set "http://localhost:5000/checkout"

for /f "tokens=*" %%a in (json_data.txt) do (
  curl -X POST -H "Content-Type: application/json" -d "%%a" "%url%"
)

pause
