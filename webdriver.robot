*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chrome-win64${/}chrome.exe
${CHROME_DRIVER_PATH}     ${EXECDIR}${/}ChromeForTesting${/}chromedriver-win64${/}chromedriver.exe
${URL}                    https://www.kku.ac.th

*** Test Cases ***
TC_001 Start Chrome For Testing
    # สร้าง ChromeOptions object
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys

    # ตั้งค่า binary_location (ใช้ setattr)
    Evaluate    setattr($options, "binary_location", r"${CHROME_BROWSER_PATH}")

    # สร้าง Chrome Service พร้อม chromedriver
    ${service}=    Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}")    sys

    # สร้าง WebDriver ใช้ options + service
    Create Webdriver    Chrome    options=${options}    service=${service}

    # เปิดเว็บ
    Go To    ${URL}

    Sleep    5s
    Close Browser
