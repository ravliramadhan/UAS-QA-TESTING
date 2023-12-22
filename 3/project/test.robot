*** Settings ***
Library           SeleniumLibrary

*** variables ***
${BROWSER}     edge
${HOST}   http://localhost/absenkaryawan/

${EMAIL}    admin
${PASS-1}    admin    # correct password
${PASS-2}    kadall    # wrong password

${NIDN}    1818
${NAMA_DOSEN}    Ravli Ramadhan

*** Test Cases ***

# login - positive test
testcase-1
    Login Success
    Close Browser    

# login - negative test
testcase-2
    Login Failure
    Close Browser 

# logout
testcase-3
    Login Success
    Click Element     xpath://button[@id='logout']
    Alert Should Be Present    text=Anda telah berhasil logout
    Close Browser 

# add data dosen
testcase-4
    Login Success
    Click Element     xpath://a[@href='dosen/index.php']
    Click Element     xpath://a[@href='tampil_add.php']
    Page Should Contain Element   xpath://input[@name='nidn']
    Input Text        name:nidn       ${NIDN}
    Input Text        name:nama_dosen       ${NAMA_DOSEN}
    Click Element     xpath://input[@type='submit']
    Alert Should Be Present    text=Record berhasil berubah
    Close Browser 

# delete data dosen
testcase-5
    Login Success
    Click Element     xpath://a[@href='dosen/index.php']
    Click Element     xpath://a[@href='delete.php?id=1818']
    Alert Should Be Present    text=Record berhasil berubah
    Close Browser
    
*** Keywords ***

Login Success
    Open Browser    ${HOST}    ${BROWSER}
    Page Should Contain Element   xpath://input[@name='username']
    input text        name:username       ${EMAIL}
    input text        name:password    ${PASS-1}
    Click Element     xpath://input[@type='submit']
    Page Should Contain Element   xpath://a[@href='logout.php']

Login Failure
    Open Browser    ${HOST}    ${BROWSER}
    Page Should Contain Element   xpath://input[@name='username']
    input text        name:username       ${EMAIL}
    input text        name:password    ${PASS-2}
    Click Element     xpath://input[@type='submit']
    Alert Should Be Present    text=Login gagal! username dan password salah!
