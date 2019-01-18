*** Settings ***

Suite Setup    Test suite setup
Suite Teardown    Test suite teardown
Test Setup    Setup
Test Teardown    Teardown

Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections
Library    ../libraries/JsonHandling.py

Resource   ../resources/setup_and_teardown.robot
Resource   ../resources/checkprices_variables.robot

*** Variables ***
#${WORKDIR}    ${CURDIR}
${url}    https://www.verkkokauppa.com

*** Tasks ***
Price Checking
    @{LIST_OF_PRODUCTS}    Read Json File    ${PRODUCT_JSON}
    Open Browser    about:blank    ${DefaultBrowser}
    #Log    ${LIST_OF_PRODUCTS}
    :FOR    ${product}    IN     @{LIST_OF_PRODUCTS}
    \    Log    ${product}
    \    Log    ${product}[Pages to Check]
    #\    @{Product_Pages}    @{product}[Pages to Check]
    \    Open Page   ${product}[Pages to Check]


    #Go To ${url}

    
    # Go To    ${url}
    # # If the cookies pop up is shown, dismiss it
    # Sleep    2
    # ${ELEMENT}=    Get WebElement    ${VK_ALLOW_COOKIES}
    # Log    ${ELEMENT}
    # Run Keyword If    '${ELEMENT}' != '${EMPTY}'    Click Button    ${VK_ALLOW_COOKIES}
    # Input Text    ${SEARCH_INPUT}    ${STOVE_MODEL}
    # Click Button    ${SEARCH_BUTTON}
    # Click Link    ${CLICK_PRODUCT}
    # Sleep    2
    # @{List_of_Elements}=    Get WebElements    ${VK_PRODUCT_PRICE}
    # #Run Keyword If    '${List_of_Elements}' != '${EMPTY}'    
    # ${Element_text}=    Get Text    ${VK_PRODUCT_PRICE}
    # Log    ${List_of_Elements}
    # Log    ${Element_text}
    #Sleep     5

*** Keywords ***
Open Page
    [Arguments]    ${Product_Pages}
    Log    ${Product_Pages}
    :FOR    ${address}    IN    @{Product_Pages}
    \    Log    ${address}[Address]
    \    Run Keyword If    '${address}[Title]' == 'Verkkokauppa'    Verkkokauppa    ${address}
    \    Run Keyword If    '${address}[Title]' == 'Gigantti'    Gigantti    ${address}
    \    Run Keyword If    '${address}[Title]' == 'Power'    Power    ${address}


Verkkokauppa
    [Arguments]    ${address}
    Go To    ${address}[Address]
    Sleep    5

Gigantti
    [Arguments]    ${address}
    Go To    ${address}[Address]
    Sleep    5

Power
    [Arguments]    ${address}
    Go To    ${address}[Address]
    Sleep    5
