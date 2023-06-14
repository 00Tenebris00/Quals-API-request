@echo off
setlocal enabledelayedexpansion

REM Prompt for username and password
set /p username="Enter your Qualys API username: "
set /p password="Enter your Qualys API password: "

REM Escape the password value
set "escaped_password=!password:"=^"!"

REM Define the API endpoints
set api_endpoint0="https://qualysapi.qg2.apps.qualys.com/api/2.0/fo/asset/host/?action=list"
set api_endpoint1="https://qualysapi.qg2.apps.qualys.com/api/2.0/fo/scan/?action=fetch&echo_request=1&mode=extended"
set api_endpoint2="https://qualysapi.qg2.apps.qualys.com/api/2.0/fo/scan/?action=list&echo_request=1&show_ags=1&show_op=1&date_type=COMPLETED&date_relative=LAST_N_DAYS&date_from=-7&date_to=-4&cisa_memo_enabled=1&status=FIXED"
set api_endpoint3="https://qualysapi.qg2.apps.qualys.com/api/2.0/fo/scan/?action=list&echo_request=1&state=FIXED&date_type=FIXED_DATE&date_from=-7&date_to=-4"

REM Build the curl commands with variable values
set curl_command0=curl -X GET -u "%username%:^!escaped_password^!" -H "X-Requested-With: Curl" -o "hosts.xml" %api_endpoint0%
set curl_command1=curl -X GET -u "%username%:^!escaped_password^!" -H "X-Requested-With: Curl" -o "TotalVulnerabilities.xml" %api_endpoint1%
set curl_command2=curl -X GET -u "%username%:^!escaped_password^!" -H "X-Requested-With: Curl" -o "CISA7DaysFixed.xml" %api_endpoint2%
set curl_command3=curl -X GET -u "%username%:^!escaped_password^!" -H "X-Requested-With: Curl" -o "7Daysfixed.xml" %api_endpoint3%

%curl_command0%
%curl_command1%
%curl_command2%
%curl_command3%

endlocal
exit /b
