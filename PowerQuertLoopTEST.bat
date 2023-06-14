@echo off
setlocal enabledelayedexpansion

REM Prompt for username and password
set /p username="Enter your Qualys API username: "
set /p password="Enter your Qualys API password: "

REM Define the API endpoints
set api_endpoints[0]="https://qualysapi.qg2.apps.qualys.com/api/2.0/fo/asset/host/?action=list"
set api_endpoints[1]="https://qualysapi.qg2.apps.qualys.com/api/2.0/fo/scan/?action=list&echo_request=1&show_ags=1&show_op=1"
set api_endpoints[2]="https://qualysapi.qg2.apps.qualys.com/api/2.0/fo/scan/?action=list&echo_request=1&show_ags=1&show_op=1&date_type=COMPLETED&date_relative=LAST_N_DAYS&date_from=-7&date_to=-4&cisa_memo_enabled=1&status=FIXED"
set api_endpoints[3]="https://qualysapi.qg2.apps.qualys.com/api/2.0/fo/vulnerability/?action=list&echo_request=1&state=FIXED&date_type=FIXED_DATE&date_from=-7&date_to=-4"

REM Escape the password value
set "escaped_password=!password:"=^"!"

REM Iterate over the API endpoints using a for loop
for /L %%i in (0,1,3) do (
  set "api_endpoint=!api_endpoints[%%i]!"

  REM Build the curl command with variable values
  set curl_command=curl -X GET -u "%username%:^!escaped_password^!" -H "X-Requested-With: Curl" -o "output%%i.xml" !api_endpoint!

  REM Echo the curl command
  echo !curl_command!

  REM Execute the curl command
  !curl_command!
)

endlocal
exit /b
