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
#Library    HelperFunctions

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
    \    Log    ${product}[Product Model]
    \    ${model}    Set Variable    ${product}[Product Model]
    \    @{pages}    Set Variable    ${product}[Pages to Check]
    #\    @{Product_Pages}    @{product}[Pages to Check]
    #\    Open Page   ${product}[Pages to Check]
    \    Open Page   ${model}    ${pages}

    # Add product model (string to search) to a variable
    # Pass the model to the webpage for search


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
    [Arguments]    ${model}    ${pages}
    Log    ${pages}
    :FOR    ${address}    IN    @{pages}
    \    Log    ${address}[Address]
    \    Run Keyword If    '${address}[Title]' == 'Verkkokauppa'    Verkkokauppa    ${address}    ${model}
    \    Run Keyword If    '${address}[Title]' == 'Gigantti'    Gigantti    ${address}    ${model}
    \    Run Keyword If    '${address}[Title]' == 'Power'    Power    ${address}    ${model}


Verkkokauppa
    [Arguments]    ${address}    ${model}
    Go To    ${address}[Address]
    # If the cookies pop up is shown, dismiss it
    Sleep    2
    #Wait Until Element Is Visible    ${VK_ALLOW_COOKIES}    timeout=5
    #${ELEMENT}=    Get WebElement    ${VK_ALLOW_COOKIES}
    #Log    ${ELEMENT}
    ${count} =    Get Element Count    ${VK_ALLOW_COOKIES}
    #Run Keyword If    '${ELEMENT}' != '${EMPTY}'    Click Button    ${VK_ALLOW_COOKIES}
    Run Keyword If    ${count} > 0    Click Button    ${VK_ALLOW_COOKIES}
    Input Text    ${SEARCH_INPUT}    ${model} 
    #${STOVE_MODEL}
    Click Button    ${SEARCH_BUTTON}
    #Sleep    1
    Wait Until Element Is Visible    ${CLICK_PRODUCT}    timeout=5
    Click Link    ${CLICK_PRODUCT}
    #Sleep    2
    Wait Until Element Is Visible    ${VK_PRODUCT_PRICE}    timeout=5
    #@{List_of_Elements}=    Get WebElements    ${VK_PRODUCT_PRICE}
    #Page Should Contain Element    ${VK_PRODUCT_PRICE}
    #Run Keyword If    '${List_of_Elements}' != '${EMPTY}'    
    ${Element_text}=    Get Text    ${VK_PRODUCT_PRICE}
    #Log    ${List_of_Elements}
    Run Keyword If    '${Element_text}' != '${EMPTY}'    Log    ${Element_text}
    Sleep    5

Gigantti
    [Arguments]    ${address}    ${model}
    Go To    ${address}[Address]
    Input Text    ${GG_SEARCH_INPUT}    ${model} 
    #${STOVE_MODEL}
    Click Button    ${GG_SEARCH_BUTTON}
    #Click Link    ${CLICK_PRODUCT}
    #Sleep    2
    Wait Until Element Is Visible    ${GG_PRODUCT_PRICE}    timeout=5
    #@{List_of_Elements}=    Get WebElements    ${GG_PRODUCT_PRICE}
    #Run Keyword Unless    '${List_of_Elements}' == '${EMPTY}'    
    #Page Should Contain Element    ${GG_PRODUCT_PRICE}
    ${Element_text}=    Get Text    ${GG_PRODUCT_PRICE}
    Run Keyword If    '${Element_text}' != '${EMPTY}'    Log    ${Element_text}
    Sleep    5

Power
    [Arguments]    ${address}    ${model}
    Go To    ${address}[Address]
    #Sleep    2
    ${count} =    Get Element Count    ${PO_ALLOW_COOKIES}
    Run Keyword If    ${count} > 0    Click Button    ${PO_ALLOW_COOKIES}
    Input Text    ${PO_SEARCH_INPUT}    ${model}
    Click Button    ${PO_SEARCH_BUTTON}
    Sleep    3
    #Wait Until Element Is Visible    ${PO_PRODUCT}    timeout=10
    #Click Link    ${PO_PRODUCT}
    # ${count} =    Get Element Count    ${PO_PROMO_POPUP_CLOSE}
    # Run Keyword If    ${count} > 0    Click Button    ${PO_PROMO_POPUP_CLOSE}
    Click Element    ${PO_PROMO_POPUP_OPEN}
    Click Element    ${PO_PROMO_POPUP_CLOSE}

    ${Element_text}=    Get Text    ${PO_PRODUCT}
    ${Result}=    String Matches    ${model}    ${Element_text}
    Run Keyword If    '${Result}' == 'True'    Click Element    ${PO_PRODUCT}
    #Run Keyword If    '${Element_text}' != '${EMPTY}'    Click Element    ${PO_PRODUCT}
    Wait Until Element Is Visible    ${PO_PRODUCT_PRICE}    timeout=5
    ${Element_text}=    Get Text    ${PO_PRODUCT_PRICE}
    Run Keyword If    '${Element_text}' != '${EMPTY}'    Log    ${Element_text}
    Sleep    5
