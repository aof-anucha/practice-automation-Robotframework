*** Settings ***
Library    SeleniumLibrary
Library    ScreenCapLibrary
Library    OperatingSystem 
Resource        ../keywords/CommonKeywords.robot

Suite Setup    Open Chrome Browser  ${URL} 
Task Teardown    Go To Homepage    ${HOMEPAGE_URL} 

*** Variables ***
${BROWSER_WIDTH}    1366
${BROWSER_HEIGHT}    768
${URL}    https://practice-automation.com/
${HOMEPAGE_URL}    https://practice-automation.com/

*** Test Cases ***
Test JavaScript Delays
    [Tags]    skip
    Start Video Recording    alias=test1    name=result
    wait until element is ready then click element    //div[a[text()="JavaScript Delays"]] 
    wait until element is ready then click element    //button[b[text()='Start']] 
    Wait Until Keyword Succeeds    15s    1s    Check Input Value    id=delay    Liftoff!

    ${input_value}   get element attribute    id=delay      value
    Log    ${input_value}
    Capture Element Screenshot    //div[@itemprop="text"]    filename=${TEST_NAME}.png
    Stop Video Recording

Test Form Fields
    Wait until element is ready then click element    //div[a[text()="Form Fields"]]
    Wait until element is ready then input text    id=name    AOF  
    Textfield Value Should Be    id=name    AOF    
    Checkbox Should Not Be Selected    id=drink1
    Click Element    id=drink1
    Click Element    id=drink3
    Checkbox Should Be Selected    id=drink1
    Scroll Element Into View    //label[text()="#FFC0CB"]

    Radio Button Should Not Be Selected    fav_color
    Select Radio Button    fav_color    Green
    Run Keyword And Continue On Failure    Radio Button Should Be Set To    fav_color    Red
    Radio Button Should Be Set To    fav_color    Green

    Select From List By Value    id=siblings    maybe
    ${selected_option}=    Get Selected List Value    id=siblings
    Should Be Equal As Strings    ${selected_option}    maybe    
    # Click Element    ${radio_id}
    # Radio Button Should Be Selected    ${radio_id}

    Wait until element is ready then input text    id=email    test@email.com

    Input Text    id=message    This is a test comment.
    ${textarea_value}=    Get Value    id=message
    Should Be Equal As Strings    ${textarea_value}    This is a test comment.
    
    Wait until element is ready then click element    id=submit-btn
    # Wait Until Element Is Visible    id=submit-btn
    # Click Button    id=submit-btn

    ${alert_message}    Set Variable    Get Alert Message
    Log    ${alert_message}
    Handle Alert    ACCEPT

    Capture Page Screenshot    filename=${TEST_NAME}.png  

*** Keywords ***
Set Slider Value
    [Arguments]    ${locator}    ${value}
    Execute JavaScript    document.getElementById("${locator.split('=')[1]}").value = ${value};
    Execute JavaScript    document.getElementById("${locator.split('=')[1]}").dispatchEvent(new Event('input'));


    






