*** Settings ***
Library    SSHLibrary
Library    OperatingSystem
Library    String
Library    Collections
Library    DateTime
*** Variables ***
${IP}    135.250.138.217
${Port}    22
${Username}    aortest
${Password}    aortest

${DB}    tra
${DBIp}    10.99.19.171
${DBUsername}    aordbremote
${DBPassword}    invinci8le_REM
*** Test Cases ***
Telnet to simulator server and send events
        #${TestData}    OperatingSystem.Get File     C:\\Users\\tmanjuna\\eclipse-workspace\\TestData\\TRA\\SCN_1\\TestData.txt
    #Wait Until Keyword Succeeds	10    1s    SSHLibrary.Open Connection    ${IP}    ${Port}
    #Wait Until Keyword Succeeds	10    1s    SSHLibrary.Login    ${Username}    ${Password}
    #SSHLibrary.Get File    /home/aortest/Automation/Data/TRA/SCN_1/TestData.txt     C:\\Users\\tmanjuna\\eclipse-workspace\\TestData\\TRA\\SCN_1\\
    #Close Connection
    ${TestData}    OperatingSystem.Get File     C:\\Users\\tmanjuna\\eclipse-workspace\\TestData\\TRA\\SCN_1\\TestData.txt
    ${DATE}=    Get Current Date    result_format=%Y-%m-%dT%H:%M:%S+530
    ${RandInt}=    Generate Random String    4    [NUMBERS]
    ${UpdatedTestData}    Replace String Using Regexp    ${TestData}    <DATE_TIME>    ${DATE}
    ${UpdatedTestData}    Replace String Using Regexp    ${UpdatedTestData}    <RAND_INT>    ${RandInt}
    Set Suite Variable    ${UpdatedTestData}  
    Log   ${UpdatedTestData}
    Wait Until Keyword Succeeds	10    1s    SSHLibrary.Open Connection    ${IP}    ${Port}
    Wait Until Keyword Succeeds	10    1s    SSHLibrary.Login    ${Username}    ${Password}
    SSHLibrary.Write    telnet 10.99.19.178 9898
    SSHLibrary.Read Until    '^]'.
    SSHLibrary.Write    ${UpdatedTestData}
    #Close Connection
Validate EOA
    
    

*** Keywords ***

