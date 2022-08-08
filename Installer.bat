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

