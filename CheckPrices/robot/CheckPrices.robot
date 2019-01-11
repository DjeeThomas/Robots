*** Settings ***

Suite Setup    Test suite setup
Suite Teardown    Test suite teardown
Test Setup    Setup
Test Teardown    Teardown

Library    SeleniumLibrary
Library    OperatingSystem
Library    Collections

Resource   ../resources/setup_and_teardown.robot
#Resource   ../resources/checkprices_variables.robot

*** Variables ***
${WORKDIR}    ${CURDIR}


*** Tasks ***
Price Checking
    Open Browser    ${DefaultBrowser}