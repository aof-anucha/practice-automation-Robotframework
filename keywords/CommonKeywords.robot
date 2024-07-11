*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Wait until element is ready then click element
    [Arguments]    ${locator}
    Wait Until Keyword Succeeds    5x    2s    Click Element    ${locator}

Wait until element is ready then input text
    [Arguments]    ${locator}    ${text}
    Wait Until Keyword Succeeds    5x    2s    Input Text    ${locator}    ${text}

Wait until page contains element then verify text
    [Arguments]    ${expected_text}
    Wait Until Keyword Succeeds    5x    2s    Page Should Contain         ${expected_text}

Check Input Value
    [Arguments]    ${locator}    ${expected_value}
    ${actual_value}=    Get Value    ${locator}
    Should Be Equal    ${actual_value}    ${expected_value}

Open Chrome Browser
    [Arguments]    ${URL}
    Open Browser    ${URL}    chrome    
    Maximize Browser Window
    # Set Window Size    ${BROWSER_WIDTH}    ${BROWSER_HEIGHT}
    # Set Window Position    0    0

Go To Homepage
    [Arguments]    ${HOMEPAGE_URL}
    Go To    ${HOMEPAGE_URL}