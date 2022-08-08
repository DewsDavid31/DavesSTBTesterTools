@echo off
cd .\configs\
:MENU
echo Select and installation method:
echo 1. DISH install
echo 2. Demo install
echo 3. Make my own config
set /p selection= enter number of your selection: 
IF %selection% EQU 1 GOTO :DISH
IF %selection% EQU 2 GOTO :DEMO
IF %selection% EQU 3 GOTO :CUSTOM
echo invalid selection, try again...
GOTO :MENU
:DISH
set file=dish
echo installing supported DISH config file...
start 'https://doc-04-2c-docs.googleusercontent.com/docs/securesc/vq0vpf5te81khc8omlhdqtvbu0i359nf/u752gcevg76aqp7j2ti8pb8o82ntgfb7/1659968250000/07482902293360636346/07482902293360636346/1rNfKJSdmFws0pBUaGPbl0SjeQEJ4RqO_?e=download&ax=AI9vYm50akfKglmXrYyD8t7R9iniJDwBHfKw9IXiDg5Ga_-vfRiwNDy7-z1dnUziZWO3-0CFzsvUZA7BMPMRQ9MZOF5j31q1fBRELVOZudF3jzfx0axs_Q7qsYcGICcgI4Au6Co84VopIOYkiGiWpmvHLD_0OMU59U40dn4x1PJ5xq0zh3Z8pUWJNCgFVw_P0OQa4Ssy2R1N2ZnqRlNpAVQx18QDAu4yoKxbxcQ0fzPb7i_Ijjr_7X3ML1MsfQkFgVbhwGrNdwcChnlyUzjQ_two7Ce4GSbh5gWKK0NN7RRn1WQUNkA5Z57Ec5xRo7FtvrhouJhwBuNh9Wq5yjj2FpRd3EA8ukeiVn1wO1BGP1WfRe-Ctg4xd58fNIgvKOm0uL8IpeCiqsLO-pQNgGTs48C_x_M82827gnZybaStrx1nx1-E0Ud5g1KFhbkI_fdR0m4G0ZGfWtxHx60JjvTnPfyjU5gYLlFmEyEgsHAHS2JurwRC5QOVZ0exYOLlVbgFz0sA7mdkX3SJwJKMPe_HroKkYANh9dZV7tb5wJaGNAnx7sP-6ABM737pudBVhHuAb5TuoUjc7r_UcknHfWJ9wvBhKe4-v3OuK35Mxz5I1_E3zc30hVfDREKA0q7kyaDDRUpz44vdijjYHfACXc-ot6dBgJHtjCWeZ8i6FFKTWFNKI-nTa4WOwwNXy1xJC-hwbPfDS7rMIdAyDXVYfA&uuid=fa2ae726-1b73-45a1-b260-ed876c576977&authuser=0&nonce=q564uaeecdtsa&user=07482902293360636346&hash=cd3r05n13jvsj9738c9bdl8ctuco6cbv'
echo move the config file to the configs folder!!!
pause
echo installing BVT converter...
start 'https://doc-00-2c-docs.googleusercontent.com/docs/securesc/vq0vpf5te81khc8omlhdqtvbu0i359nf/s28ajvup8nlmhdaqk9a20plbbema8a2t/1659968850000/07482902293360636346/07482902293360636346/16Sq7_nidZ1HpYTd7XIpIT67Tv3cyLNH8?e=download&ax=AI9vYm7b4UDP28P3bSzmipyVresHcDNmQYvbyzT-kUFW0dBBvFjyCZ-m4LLKIvMLMUmIrOPBFbbgHbAZ48SvZmT0AHBpsq_NTdTXdkqLF-ftKtxrw006_gE4N97Ui-MPFqpUEgDEgZ5J9AhLhyB9i39Tc2l4aJudLFgVyqeiOkGcmvuUOXnBevIiSkKKH82w9ozRNK2qOvxG0KSoBy_WPV70erAakPUAjZnyWrsNIC5Z1-yl7WZYErOC9-Ts77mmu7aIgwL4acINbfxg4gTJ4idRo86xPu7lF5iSBIge5p-RKob9WVCOVY85twJP8Fx31o4TbK4TykZYVxh1v_19xDtnqdU5dtMCSEhHiq07rS68HhIxgN8BQS8z57r3I1-3-cA4H-oHSkcTgLdQoXbm57Jh8BWzK74k67hPLwWXxhoGX1D8eCh4KUbjghL1maRxYDuhkcyKfReIcnHLcCkDGPGot6siGQsF_qs-Hpbfy5UWmSeUb0QKtWCuEhABsfPj0xEilba27eIGLkg7WCmIJ9g_6w5s7MpDj5Ayt3YS7H2FJVztaHzcGw4q56I58q4vPUBIgq9IjlRORjrRe1mWXhjYky4_5fk_nPFEyQWWl1wC5kj9gT-2s5ofuX0NjzdRqRQ4On_dHeNXjya40GGbPqOovgog-rAzqN45gbMRJCCs6j7MPhhBw3br05zZ0nJj5hRR9itNAErnQmNgTw&uuid=a22e2906-ca23-45e5-8725-cda6f2dedd10&authuser=0&nonce=pimgo67ul3kq4&user=07482902293360636346&hash=89risu16gsnoe1rtkasjvkpsekg4221u'
echo move the downloaded ps1 file to the same folder DavesKeyBinder.bat is in...
pause
set index=0
GOTO :AnotherBOX
GOTO :MENU
:DEMO
set file=demo
echo installing Demo config file...
Start https://drive.google.com/u/0/uc?id=1XYm3a9kWeFrPdjTO8--gBt2LYG9tkW2F&export=download
echo move the config file to the configs folder!!!
pause
set index=0
:AnotherBOX
set /p serial=Enter the serial number of a box: 
set /p rcvr=Enter the receiver number of a box: 
echo devicesSerials[%index%]=%serial% >> %file%.config
echo devicesReceiverNum[%index%]=%rcvr% >> %file%.config
set /a "index+=1"
set /p another=Add another box from your rack/cube(y/N): 
if /i %another% EQU y GOTO :DONE
GOTO :AnotherBOX
:DONE
echo installation complete!
pause
exit
:CUSTOM
echo not supported yet...
GOTO :MENU

