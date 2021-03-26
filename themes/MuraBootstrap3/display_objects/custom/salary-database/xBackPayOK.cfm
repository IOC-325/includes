<link href='/ledger/includes/themes/TheLedger/css/pageloading.css' rel='stylesheet' type='text/css'/>
<link href='/comptroller/includes/themes/MuraBootstrap3/assets/datatable/css/jquery.dataTables.min.css' rel='stylesheet'
      type='text/css'>
      
      <cfquery datasource='BackPay' name='BackPay'>

SELECT PY.PAYROLL.ISSUE_DATE, PY.PAYROLL.AGENCY, Sum(PY.PAYROLL.GROSS) AS SumOfGROSS
FROM PY.PAYROLL
GROUP BY AGENCY_NAMES.AGENCY_NAME, PY.PAYROLL.PAYROLL_AGENCY, PY.PAYROLL.PAYROLL_DIVISION, PY.PAYROLL.VOUCHER_NUMBER, PY.PAYROLL.ISSUE_DATE, PY.PAYROLL.FISCAL_YEAR, PY.PAYROLL.FUND, PY.PAYROLL.AGENCY, PY.PAYROLL.ORGANZIATION, PY.PAYROLL.APPROPRIATION, PY.PAYROLL.OBJECT
HAVING (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='227') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='228') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='229') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='230') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='231') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='232') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='233') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='234') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='235') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='236') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='237') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='238') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='239') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='240') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='241') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='242') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='243') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='244') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='245') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='246') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='247') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='248') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='249') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='250') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='251') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='252') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='253') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='011') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='12') AND ((PY.PAYROLL.PAYROLL_DIVISION)='119') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='12') AND ((PY.PAYROLL.PAYROLL_DIVISION)='419') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='13') AND ((PY.PAYROLL.PAYROLL_DIVISION)='101') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='13') AND ((PY.PAYROLL.PAYROLL_DIVISION)='301') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='13') AND ((PY.PAYROLL.PAYROLL_DIVISION)='401') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='13') AND ((PY.PAYROLL.PAYROLL_DIVISION)='501') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='13') AND ((PY.PAYROLL.PAYROLL_DIVISION)='601') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='14') AND ((PY.PAYROLL.PAYROLL_DIVISION)='017') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='14') AND ((PY.PAYROLL.PAYROLL_DIVISION)='021') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='14') AND ((PY.PAYROLL.PAYROLL_DIVISION)='023') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='14') AND ((PY.PAYROLL.PAYROLL_DIVISION)='105') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='14') AND ((PY.PAYROLL.PAYROLL_DIVISION)='206') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='14') AND ((PY.PAYROLL.PAYROLL_DIVISION)='300') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='14') AND ((PY.PAYROLL.PAYROLL_DIVISION)='405') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='15') AND ((PY.PAYROLL.PAYROLL_DIVISION)='103') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='15') AND ((PY.PAYROLL.PAYROLL_DIVISION)='104') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='15') AND ((PY.PAYROLL.PAYROLL_DIVISION)='105') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='16') AND ((PY.PAYROLL.PAYROLL_DIVISION)='050') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='16') AND ((PY.PAYROLL.PAYROLL_DIVISION)='051') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='19') AND ((PY.PAYROLL.PAYROLL_DIVISION)='200') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='20') AND ((PY.PAYROLL.PAYROLL_DIVISION)='022') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='20') AND ((PY.PAYROLL.PAYROLL_DIVISION)='026') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='21') AND ((PY.PAYROLL.PAYROLL_DIVISION)='099') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='23') AND ((PY.PAYROLL.PAYROLL_DIVISION)='100') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='23') AND ((PY.PAYROLL.PAYROLL_DIVISION)='111') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='23') AND ((PY.PAYROLL.PAYROLL_DIVISION)='112') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='23') AND ((PY.PAYROLL.PAYROLL_DIVISION)='114') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='25') AND ((PY.PAYROLL.PAYROLL_DIVISION)='801') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='25') AND ((PY.PAYROLL.PAYROLL_DIVISION)='803') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='25') AND ((PY.PAYROLL.PAYROLL_DIVISION)='804') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='27') AND ((PY.PAYROLL.PAYROLL_DIVISION)='111') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='29') AND ((PY.PAYROLL.PAYROLL_DIVISION)='111') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='31') AND ((PY.PAYROLL.PAYROLL_DIVISION)='018') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='31') AND ((PY.PAYROLL.PAYROLL_DIVISION)='019') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='31') AND ((PY.PAYROLL.PAYROLL_DIVISION)='510') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='050') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='051') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='052') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='053') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='054') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='055') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='056') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='057') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='058') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='059') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='060') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='061') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='062') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='063') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='064') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='065') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='066') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='067') AND ((PY.PAYROLL.FISCAL_YEAR)=2019))
<!--- 2 --->
 (((PY.PAYROLL.PAYROLL_AGENCY)='35') AND ((PY.PAYROLL.PAYROLL_DIVISION)='300') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='35') AND ((PY.PAYROLL.PAYROLL_DIVISION)='301') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='37') AND ((PY.PAYROLL.PAYROLL_DIVISION)='698') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='42') AND ((PY.PAYROLL.PAYROLL_DIVISION)='003') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='44') AND ((PY.PAYROLL.PAYROLL_DIVISION)='025') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='44') AND ((PY.PAYROLL.PAYROLL_DIVISION)='027') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='45') AND ((PY.PAYROLL.PAYROLL_DIVISION)='001') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='45') AND ((PY.PAYROLL.PAYROLL_DIVISION)='003') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='150') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='151') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='157') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='158') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='159') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='160') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='161') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='162') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='163') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='164') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='165') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='166') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='167') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='168') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='169') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='170') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='171') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='172') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='174') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='174') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='175') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='176') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='177') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='178') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='179') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='180') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='181') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='182') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='183') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='184') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='185') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='186') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='187') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='188') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='189') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='47') AND ((PY.PAYROLL.PAYROLL_DIVISION)='777') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='49') AND ((PY.PAYROLL.PAYROLL_DIVISION)='102') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='49') AND ((PY.PAYROLL.PAYROLL_DIVISION)='103') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='49') AND ((PY.PAYROLL.PAYROLL_DIVISION)='104') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='251') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='161') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='655') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='040') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='176') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='387') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='388') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='327') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='121') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='135') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='335') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='336') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='613') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='087') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='088') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='132') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='133') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='134') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='809') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='274') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='275') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='276') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='277') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='278') AND ((PY.PAYROLL.FISCAL_YEAR)=2019));

</cfquery>



 <cfquery datasource='BackPay' name='SumTotalBackPay' >

SELECT  Sum(PY.PAYROLL.GROSS) AS BackPayTotal
FROM PY.PAYROLL INNER JOIN WH.AGENCY ON PY.PAYROLL.AGENCY = WH.AGENCY.AGENCY
WHERE (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='227') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='228') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='229') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='230') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='231') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='232') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='233') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='234') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='235') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='236') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='237') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='238') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='239') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='240') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='241') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='242') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='243') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='244') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='245') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='246') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='247') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='248') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='249') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='250') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='251') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='252') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='253') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='11') AND ((PY.PAYROLL.PAYROLL_DIVISION)='011') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='12') AND ((PY.PAYROLL.PAYROLL_DIVISION)='119') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='12') AND ((PY.PAYROLL.PAYROLL_DIVISION)='419') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='13') AND ((PY.PAYROLL.PAYROLL_DIVISION)='101') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='13') AND ((PY.PAYROLL.PAYROLL_DIVISION)='301') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='13') AND ((PY.PAYROLL.PAYROLL_DIVISION)='401') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='13') AND ((PY.PAYROLL.PAYROLL_DIVISION)='501') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='13') AND ((PY.PAYROLL.PAYROLL_DIVISION)='601') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='14') AND ((PY.PAYROLL.PAYROLL_DIVISION)='017') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='14') AND ((PY.PAYROLL.PAYROLL_DIVISION)='021') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='14') AND ((PY.PAYROLL.PAYROLL_DIVISION)='023') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='14') AND ((PY.PAYROLL.PAYROLL_DIVISION)='105') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='14') AND ((PY.PAYROLL.PAYROLL_DIVISION)='206') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='14') AND ((PY.PAYROLL.PAYROLL_DIVISION)='300') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='14') AND ((PY.PAYROLL.PAYROLL_DIVISION)='405') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='15') AND ((PY.PAYROLL.PAYROLL_DIVISION)='103') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='15') AND ((PY.PAYROLL.PAYROLL_DIVISION)='104') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='15') AND ((PY.PAYROLL.PAYROLL_DIVISION)='105') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='16') AND ((PY.PAYROLL.PAYROLL_DIVISION)='050') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='16') AND ((PY.PAYROLL.PAYROLL_DIVISION)='051') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='19') AND ((PY.PAYROLL.PAYROLL_DIVISION)='200') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='20') AND ((PY.PAYROLL.PAYROLL_DIVISION)='022') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='20') AND ((PY.PAYROLL.PAYROLL_DIVISION)='026') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='21') AND ((PY.PAYROLL.PAYROLL_DIVISION)='099') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='23') AND ((PY.PAYROLL.PAYROLL_DIVISION)='100') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='23') AND ((PY.PAYROLL.PAYROLL_DIVISION)='111') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='23') AND ((PY.PAYROLL.PAYROLL_DIVISION)='112') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='23') AND ((PY.PAYROLL.PAYROLL_DIVISION)='114') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='25') AND ((PY.PAYROLL.PAYROLL_DIVISION)='801') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='25') AND ((PY.PAYROLL.PAYROLL_DIVISION)='803') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='25') AND ((PY.PAYROLL.PAYROLL_DIVISION)='804') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='27') AND ((PY.PAYROLL.PAYROLL_DIVISION)='111') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='29') AND ((PY.PAYROLL.PAYROLL_DIVISION)='111') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='31') AND ((PY.PAYROLL.PAYROLL_DIVISION)='018') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='31') AND ((PY.PAYROLL.PAYROLL_DIVISION)='019') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='31') AND ((PY.PAYROLL.PAYROLL_DIVISION)='510') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='050') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) 
OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='051') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='052') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='053') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='054') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='055') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='056') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='057') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='058') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='059') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='060') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='061') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='062') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='063') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='064') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='065') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='066') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='33') AND ((PY.PAYROLL.PAYROLL_DIVISION)='067') AND ((PY.PAYROLL.FISCAL_YEAR)=2019))

<!--- KATIES QUERY 2 --->
OR (((PY.PAYROLL.PAYROLL_AGENCY)='35') AND ((PY.PAYROLL.PAYROLL_DIVISION)='300') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='35') AND ((PY.PAYROLL.PAYROLL_DIVISION)='301') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='37') AND ((PY.PAYROLL.PAYROLL_DIVISION)='698') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='42') AND ((PY.PAYROLL.PAYROLL_DIVISION)='003') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='44') AND ((PY.PAYROLL.PAYROLL_DIVISION)='025') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='44') AND ((PY.PAYROLL.PAYROLL_DIVISION)='027') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='45') AND ((PY.PAYROLL.PAYROLL_DIVISION)='001') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='45') AND ((PY.PAYROLL.PAYROLL_DIVISION)='003') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='150') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='151') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='157') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='158') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='159') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='160') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='161') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='162') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='163') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='164') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='165') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='166') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='167') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='168') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='169') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='170') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='171') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='172') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='174') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='174') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='175') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='176') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='177') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='178') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='179') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='180') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='181') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='182') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='183') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='184') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='185') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='186') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='187') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='188') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='46') AND ((PY.PAYROLL.PAYROLL_DIVISION)='189') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='47') AND ((PY.PAYROLL.PAYROLL_DIVISION)='777') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='49') AND ((PY.PAYROLL.PAYROLL_DIVISION)='102') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='49') AND ((PY.PAYROLL.PAYROLL_DIVISION)='103') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='49') AND ((PY.PAYROLL.PAYROLL_DIVISION)='104') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='251') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='161') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='655') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='040') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='176') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='387') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='388') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='327') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='121') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='135') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='335') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='336') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='613') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='087') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='088') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='132') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='133') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='134') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='809') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='274') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='275') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='276') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='277') AND ((PY.PAYROLL.FISCAL_YEAR)=2019)) OR (((PY.PAYROLL.PAYROLL_AGENCY)='50') AND ((PY.PAYROLL.PAYROLL_DIVISION)='278') AND ((PY.PAYROLL.FISCAL_YEAR)=2019))

</cfquery>

<table class='table'>
    <tbody>
        <tr>
            <th>AGENCY NAME</th>
            <th>ISSUE DATE</th>
            <th class='text-right'>AMOUNT</th>
        </tr>
        <cfoutput query='BackPay'>
        <tr>
            <td>#Name#</td>
            <td>#dateformat(ISSUE_DATE,'m/d/yyyy')#</td>
            <td class='text-right'>#DollarFormat(SumOfGross)#</td>
        </tr>
        </cfoutput>
        <tr>
            <td></td>
            <td><b></b></td>
            <td class='text-right'><b>Total: <cfoutput>#Dollarformat(SumTotalBackPay.BackPayTotal)#</cfoutput></b></td>
        </tr>
    </tbody>
</table>