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
    # Read list from JSON file
    # For each item/webpage/target price
    #      Open the appropriate keyword for the site where the product is found and price is checked
    #      Save the results to another json: If price of item is below target, flag it somehow
    # If there are items whose price is lower than target, create a report just for those
    # Display that report    

    @{LIST_OF_PRODUCTS}    Read Json File    ${PRODUCT_JSON}
    Open Browser    about:blank    ${DefaultBrowser}
    :FOR    ${product}    IN     @{LIST_OF_PRODUCTS}
    \    Log    ${product}
    \    Log    ${product}[Price Target]
    # \    @{pages_to_check}=    Fetch The Pages That Should Be Checked    ${product}
    # \    Log    ${pages_to_check}
    # \    @{current_prices}=    Fetch The Prices From The Pages    @{pages_to_check}
    # \    Log    @{current_prices}
    # \    @{target_price_met}=    Check What Prices Match Target    @{current_prices}    ${product}['Price Target']
    # \    Save Information To File    ${product}    ${current_prices}    ${target_price_met}



    #\    Log    ${product}[Product Model]
    #\    ${model}    Set Variable    ${product}[Product Model]
    #\    @{pages}    Set Variable    ${product}[Pages to Check]
    # \    Open Page   ${product}

    # For each product:
    #   Extract the list of pages where it is going to be checked
    #   For each page, get the price of the article
    #   Store the price in a Variable
    #   Compare the price with the target

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
    \    Run Keyword If    '${address}[Title]' == 'Gigantti'    Gigantti    ${address}    ${model}
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
    ${Is_match}=    Compare Price    ${product}[Price Target]    ${Element_text}
    ${Success}=    Save Report    ${product}    ${address}    ${Is_match}    ${Element_text}    ${PROD_REPORT}
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
    Wait Until Element Is Visible    ${PO_PRODUCT}    timeout=5
    ${Element_text}=    Get Text    ${PO_PRODUCT}
    ${Result}=    String Matches    ${model}    ${Element_text}
    Run Keyword If    '${Result}' == 'True'    Click Element    ${PO_PRODUCT}
    Wait Until Element Is Visible    ${PO_PRODUCT_PRICE}    timeout=5
    ${Element_text}=    Get Text    ${PO_PRODUCT_PRICE}
    Run Keyword If    '${Element_text}' != '${EMPTY}'    Log    ${Element_text}
    #Sleep    5
