*** Settings ***

Suite Setup    Test suite setup
Suite Teardown    Test suite teardown
Test Setup    Setup
Test Teardown    Teardown

Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections

Resource   ../resources/setup_and_teardown.robot
Resource   ../resources/checkprices_variables.robot

*** Variables ***
#${WORKDIR}    ${CURDIR}
${url}    https://www.verkkokauppa.com

*** Tasks ***
Price Checking
    Open Browser    ${url}    ${DefaultBrowser}
    # If the cookies pop up is shown, dismiss it
    Sleep    2
    ${List_of_elements}=    Get WebElement    ${VK_ALLOW_COOKIES}
    Log    ${List_of_elements}
    Run Keyword If    '${List_of_elements}' != '${EMPTY}'    Click Button    ${VK_ALLOW_COOKIES}
    Input Text    ${SEARCH_INPUT}    ${STOVE_MODEL}
    Click Button    ${SEARCH_BUTTON}
    Click Link    ${CLICK_PRODUCT}
    Sleep    5
    Click Element    ${VK_KODINKONEET}
