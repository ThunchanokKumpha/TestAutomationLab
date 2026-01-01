*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chrome-win64${/}chrome.exe
${CHROME_DRIVER_PATH}     ${EXECDIR}${/}ChromeForTesting${/}chromedriver-win64${/}chromedriver.exe
${SERVER}                 localhost:7272
${URL}                    http://${SERVER}/Lab4/Registration.html
${FIRSTNAME}              Somyod
${LASTNAME}               Sodsai
${ORG}                    CS KKU
${EMAIL}                  somyod@kkumail.com
${PHONE}                  091-001-1234

*** Keywords ***
Open Chrome For Testing
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Evaluate    setattr($options, "binary_location", r"${CHROME_BROWSER_PATH}")
    ${service}=    Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}")    sys
    Create Webdriver    Chrome    options=${options}    service=${service}
Open Workshop Registration Page
    Open Chrome For Testing
    Go To    ${URL}

*** Test Cases ***
Open Workshop Registration Page
    Open Workshop Registration Page
    Capture Page Screenshot    docs/Open_Regis_Success.png
    Close Browser

Register Success
    Open Workshop Registration Page
     # กรอกฟอร์ม
    Input Text    id=firstname       ${FIRSTNAME}
    Input Text    id=lastname        ${LASTNAME}
    Input Text    id=organization    ${ORG}
    Input Text    id=email           ${EMAIL}
    Input Text    id=phone           ${PHONE}
    
    Click Button  id=registerButton  
    Title Should Be    Success
    Page Should Contain    Thank you for registering with us.
    Page Should Contain    We will send a confirmation to your email soon.
    Capture Page Screenshot    docs/Register_Success.png


Register Success No Organization Info
    Open Workshop Registration Page
    # กรอกฟอร์ม
    Input Text    id=firstname       ${FIRSTNAME}
    Input Text    id=lastname        ${LASTNAME}
    Input Text    id=email           ${EMAIL}
    Input Text    id=phone           ${PHONE}
    
    Click Button  id=registerButton  
    Title Should Be    Success
    Page Should Contain    Thank you for registering with us.
    Page Should Contain    We will send a confirmation to your email soon.
    Capture Page Screenshot    docs/No_ORG_Success.png