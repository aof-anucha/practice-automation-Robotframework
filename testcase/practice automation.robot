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
${result_message}    //div[@id="contact-form-1065"]/div[@class='contact-form-submission']

*** Test Cases ***
Test JavaScript Delays
    [Tags]    skip
    # Start Video Recording    alias=test1    name=result
    wait until element is ready then click element    //div[a[text()="JavaScript Delays"]] 
    wait until element is ready then click element    //button[b[text()='Start']] 
    Wait Until Keyword Succeeds    15s    1s    Check Input Value    id=delay    Liftoff!

    ${input_value}   get element attribute    id=delay      value
    Log    ${input_value}
    Capture Element Screenshot    //div[@itemprop="text"]    filename=${TEST_NAME}.png
    # Stop Video Recording

Test Form Fields
    [Tags]    skip
    # Section 1: Test Text Input
    Wait until element is ready then click element    //div[a[text()="Form Fields"]]
    Wait until element is ready then input text    id=name    AOF  
    Textfield Value Should Be    id=name    AOF    
    Checkbox Should Not Be Selected    id=drink1
    Click Element    id=drink1
    Click Element    id=drink3
    Checkbox Should Be Selected    id=drink1
    Scroll Element Into View    //label[text()="#FFC0CB"]

    # Section 2: Test Radio Input
    Radio Button Should Not Be Selected    fav_color
    Select Radio Button    fav_color    Green
    Run Keyword And Continue On Failure    Radio Button Should Be Set To    fav_color    Red
    Radio Button Should Be Set To    fav_color    Green

    # Section 3: Test Dropdown
    Select From List By Value    id=siblings    maybe
    ${selected_option}=    Get Selected List Value    id=siblings
    Should Be Equal As Strings    ${selected_option}    maybe    
    # Click Element    ${radio_id}
    # Radio Button Should Be Selected    ${radio_id}

    # Section 4: Test email Input
    Wait until element is ready then input text    id=email    test@email.com

    # Section 5: Test Text Area
    Input Text    id=message    This is a test comment.
    ${textarea_value}=    Get Value    id=message
    Should Be Equal As Strings    ${textarea_value}    This is a test comment.
    
    # Section 6: Test Submit Button
    Capture Page Screenshot    filename=${TEST_NAME}.png  
    Wait until element is ready then click element    id=submit-btn
    # Wait Until Element Is Visible    id=submit-btn
    # Click Button    id=submit-btn

    # Section 7: Test Alert message
    ${alert_message}    Set Variable    Get Alert Message
    Log    ${alert_message}
    Handle Alert    ACCEPT
 

Test Popups
    [Tags]    skip
    Wait until element is ready then click element    //div[a[text()="Popups"]]
    # Section 1: Test Alert Popups
    # Start Video Recording    alias=test1    name=result
    Alert Should Not Be Present

    Wait until element is ready then click element    id=alert
    Alert Should Be Present    Hi there, pal!    LEAVE
    Handle Alert    ACCEPT
    # Capture Page Screenshot    filename=${TEST_NAME}.png  
    # Stop Video Recording

    # Section 2: Test Confirm Popups
    Alert Should Not Be Present
    Element Should Not Be Visible    id=confirmResult
    Element Text Should Be    id=confirmResult    ${EMPTY}
    Wait until element is ready then click element    id=confirm
    Alert Should Be Present    OK or Cancel, which will it be?    LEAVE
    Handle Alert    ACCEPT
    Element Should Be Visible    id=confirmResult
    Element Text Should Be    id=confirmResult    OK it is!

    # Section 3: Test Prompt Popups
    Alert Should Not Be Present
    
    Element Should Not Be Visible    id=promptResult
    Wait until element is ready then click element    id=prompt
    Input Text Into Alert    AOF    LEAVE
    Handle Alert    ACCEPT
    Element Should Be Visible    id=promptResult
    Element Text Should Be    id=promptResult    Nice to meet you, AOF!
    
Test Sliders
    [Tags]    skip
    Wait until element is ready then click element    //div[a[text()="Sliders"]]
    Element Attribute Value Should Be    id=slideMe    value    25
    # Drag And Drop By Offset    id=slideMe    50    0
    Drag And Drop By Offset    id=slideMe    150    0    #value 61
    Drag And Drop By Offset    id=slideMe    -150    0    #value 39
    Element Attribute Value Should Be    id=slideMe    value    39
    Element Text Should Be    id=value    39
    Capture Page Screenshot    filename=${TEST_NAME}.png 

Test Calendars
    [Tags]    skip
    Wait until element is ready then click element    //div[a[text()="Calendars"]]
    Wait until element is ready then click element    id=g1065-selectorenteradate
    Wait until element is ready then click element    //td[@data-month="6"]/a[@data-date="17"]
    Textfield Value Should Be    id=g1065-selectorenteradate    2024-07-17
    # Sleep    1s
    Wait Until Element Is Visible    //button[@type="submit" and text()='Submit']
    click element    //button[@type="submit" and text()='Submit']
    
    Element Should Contain    ${result_message}    Your message has been sent
    Element Should Contain    ${result_message}    Select or enter a date:
    Element Should Contain    ${result_message}    2024-07-17
    Capture Page Screenshot    filename=${TEST_NAME}.png 

Test Modals
    [Tags]    skip

    Wait until element is ready then click element    //div[a[text()="Modals"]]
    # 1 : simpleModal
    Wait until element is ready then click element    id=simpleModal
    Wait Until Element Is Visible    id=popmake-1318
    Element Should Contain    id=popmake-1318    Simple Modal
    ${popmake_content}    Get Text    //div[@id="popmake-1318"]/div[@class="pum-content popmake-content"]/p[text()="Hi, I’m a simple modal."]
    Should Be Equal As Strings    ${popmake_content}    Hi, I’m a simple modal.
    Wait until element is ready then click element    //div[@id="popmake-1318"]/button[@type="button" and @aria-label="Close"]

    # 2 : formModal
    Wait until element is ready then click element    id=formModal
    Element Should Contain    id=popmake-674    Modal Containing A Form
    Element Should Contain    id=popmake-674    Please enter your contact info below.

    Input Text    name=g1051-name    Anucha
    Input Text    name=g1051-email    test@email.com
    Input Text    id=contact-form-comment-g1051-message    Test text area.
    Textarea Value Should Be    id=contact-form-comment-g1051-message    Test text area.
    Click Element    //*[@id="contact-form-1051"]/form/p[1]/button    #Submit

Test Iframes
    Wait until element is ready then click element    //div[a[text()="Iframes"]]
    Scroll Element Into View    id=iframe-1
    Select Frame    id=iframe-1
    Scroll Element Into View    //img[@alt="Browsers (Chromium, Firefox, WebKit)"]
    Capture Page Screenshot    filename=${TEST_NAME}_1.png
    Scroll Element Into View    //div[@class="col col--12 logosColumn_GJVT"]
    Capture Page Screenshot    filename=${TEST_NAME}_2.png
    Unselect Frame
    Scroll Element Into View    id=iframe-2
    Select Frame    id=iframe-2
    Wait until element is ready then click element    //div[@class="dropdown"]/a[@role="button"]
    Wait until element is ready then click element    //a[@class="dropdown-item" and text()="中文简体"]
    Scroll Element Into View    //div[@class="row justify-content-around pt-4 pb-5 px-5"][2]
    Capture Element Screenshot    //div[@class="row justify-content-around pt-4 pb-5 px-5"][2]    filename=${TEST_NAME}_3.png  
    Unselect Frame

*** Keywords ***
Set Slider Value
    [Arguments]    ${locator}    ${value}
    Execute JavaScript    document.getElementById("${locator.split('=')[1]}").value = ${value};
    Execute JavaScript    document.getElementById("${locator.split('=')[1]}").dispatchEvent(new Event('input'));


    






