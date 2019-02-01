*** Settings ***

Suite Setup    Test suite setup
Suite Teardown    Test suite teardown
Test Setup    Setup
Test Teardown    Teardown

Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections
Library    ../libraries/JsonHandling.py
Library    ../libraries/HelperFunctions.py

Resource   ../resources/setup_and_teardown.robot
Resource   ../resources/checkprices_variables.robot

*** Variables ***
#${url}    https://www.verkkokauppa.com

*** Tasks ***
Price Checking
    @{LIST_OF_PRODUCTS}    Read Json File    ${PRODUCT_JSON}
    Open Browser    about:blank    ${DefaultBrowser}
    :FOR    ${product}    IN     @{LIST_OF_PRODUCTS}
    #\    Log    ${product}
    #\    Log    ${product}[Pages to Check]
    #\    Log    ${product}[Product Model]
    #\    ${model}    Set Variable    ${product}[Product Model]
    #\    @{pages}    Set Variable    ${product}[Pages to Check]
    \    Open Page   ${product}

*** Keywords ***
Open Page
    #[Arguments]    ${model}    ${pages}
    [Arguments]    ${product}
    @{pages}    Set Variable    ${product}[Pages to Check]
    ${model}    Set Variable    ${product}[Product Model]
    #Log    ${pages}
    :FOR    ${address}    IN    @{pages}
    #\    Log    ${address}[Address]
    #\    Run Keyword If    '${address}[Title]' == 'Verkkokauppa'    Verkkokauppa    ${address}    ${model}
    \    Run Keyword If    '${address}[Title]' == 'Verkkokauppa'    Verkkokauppa    ${address}    ${product}
    #\    Run Keyword If    '${address}[Title]' == 'Gigantti'    Gigantti    ${address}    ${model}
    #\    Run Keyword If    '${address}[Title]' == 'Power'    Power    ${address}    ${model}


Verkkokauppa
    [Arguments]    ${address}    ${product}
    Go To    ${address}[Address]
    # If the cookies pop up is shown, dismiss it
    Sleep    2
    ${model}    Set Variable    ${product}[Product Model]
    ${count} =    Get Element Count    ${VK_ALLOW_COOKIES}
    Run Keyword If    ${count} > 0    Click Button    ${VK_ALLOW_COOKIES}
    Input Text    ${VK_SEARCH_INPUT}    ${model} 
    Click Button    ${VK_SEARCH_BUTTON}
    Wait Until Element Is Visible    ${VK_CLICK_PRODUCT}    timeout=5
    Click Link    ${VK_CLICK_PRODUCT}
    Wait Until Element Is Visible    ${VK_PRODUCT_PRICE}    timeout=5  
    ${Element_text}=    Get Text    ${VK_PRODUCT_PRICE}
    Run Keyword If    '${Element_text}' != '${EMPTY}'    Log    ${Element_text}
    Compare Price    ${product}    ${Element_text}
    #Sleep    5

Gigantti
    [Arguments]    ${address}    ${model}
    Go To    ${address}[Address]
    Input Text    ${GG_SEARCH_INPUT}    ${model} 
    Click Button    ${GG_SEARCH_BUTTON}
    Wait Until Element Is Visible    ${GG_PRODUCT_PRICE}    timeout=5
    ${Element_text}=    Get Text    ${GG_PRODUCT_PRICE}
    Run Keyword If    '${Element_text}' != '${EMPTY}'    Log    ${Element_text}
    #Sleep    5

Power
    [Arguments]    ${address}    ${model}
    Go To    ${address}[Address]
    ${count} =    Get Element Count    ${PO_ALLOW_COOKIES}
    Run Keyword If    ${count} > 0    Click Button    ${PO_ALLOW_COOKIES}
    Input Text    ${PO_SEARCH_INPUT}    ${model}
    Click Button    ${PO_SEARCH_BUTTON}
    Sleep    3
    Click Element    ${PO_PROMO_POPUP_OPEN}
    Click Element    ${PO_PROMO_POPUP_CLOSE}
    ${Element_text}=    Get Text    ${PO_PRODUCT}
    ${Result}=    String Matches    ${model}    ${Element_text}
    Run Keyword If    '${Result}' == 'True'    Click Element    ${PO_PRODUCT}
    Wait Until Element Is Visible    ${PO_PRODUCT_PRICE}    timeout=5
    ${Element_text}=    Get Text    ${PO_PRODUCT_PRICE}
    Run Keyword If    '${Element_text}' != '${EMPTY}'    Log    ${Element_text}
    #Sleep    5
