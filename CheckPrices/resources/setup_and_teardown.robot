*** Settings ***
    
Library    SeleniumLibrary
Library    Screenshot

Resource   ../resources/checkprices_variables.robot
    
*** Keywords ***
    
Setup
    Log    setup
    #Start recording    ${TEST NAME}

Teardown
    #${failure_image_path}=    Get failure image path    ${TEST NAME}
    Run Keyword If Test Failed    Capture Page Screenshot    ${OUTPUTDIR}/selenium-screenshot_${TEST NAME}_{index}.png

    #Stop recording
    
    #${documentation}=    Generate failure documentation    ${TEST_DOCUMENTATION}    ${TEST NAME}
    #Run Keyword If Test Failed    Set test documentation    ${documentation}

Test suite setup
    #${DefaultBrowser}=    Open browser    ${BROWSER}
    Set suite variable    ${DefaultBrowser}    ${BROWSER}

Test suite teardown
    Close all browsers

    