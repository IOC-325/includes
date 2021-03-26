<!-- CSS -->
<style type="text/css">
    .form-group.required label:after {
        content: "*";
        color: red;
        margin-left: 5px;
    }

    .red {
        color: red;
    }

    @media print {
        #logo {
            display: none;
        }

        #logo-2 {
            display: block;
            height: 20%;
        }

        body {
            background-color: #FFFFFF;
            background-image: none;
            color: #000000
        }

        #ad {
            display: none;
        }

        .nav-header {
            display: none;
        }

        .feed-wrapper {
            display: none;
        }

        .footerTop {
            display: none;
        }

        .footer-bottom {
            display: none;
        }

        /*.alert-success{ display:none;}*/
        .alert-info {
            display: none;
        }

        .alert-warning {
            display: none;
        }

        .noprint {
            display: none;
        }

        #leftbar {
            display: none;
        }

        #contentarea {
            width: 100%;
        }

        .content h2 {
            display: none;
        }

        .footerSocialIcons {
            display: none;
        }
    }


</style>

<CFSET variables.dispForm = "0">

<cfif isDefined("form.submit")>

    <cfif Trim(form.comments) NEQ "">
        <CFSET variables.CleanComments = Trim(form.comments)>
    </cfif>

<!--- Send Email based on type --->
    <CFSET variables.ToEmailAddress = #application.StateDebtProtestFormEmailTo#>

    <CFSET ApprovedFileList = "pdf,png,jpg,jpeg">
    <CFSET variables.FileOneUploadErrorCode = 0>
    <CFSET variables.FileTwoUploadErrorCode = 0>
    <CFSET variables.FileThreeUploadErrorCode = 0>
    <CFSET variables.FileFourUploadErrorCode = 0>
    <CFSET variables.FileFiveUploadErrorCode = 0>
    <CFSET variables.UploadMessage = "">
    <CFSET variables.pdfFileCount = 0>
    <CFSET variables.imgFileCount = 1>
    <CFSET variables.DocumnetFileCount = 1>
    <cfset variables.iwNumberArray = ArrayNew(1)>
    <cfset ArrayAppend(variables.iwNumberArray, form.iwNumber)>
    <cfif isDefined("form.iwNumber2") && form.iwNumber2 NEQ "">
        <cfset ArrayAppend(variables.iwNumberArray, form.iwNumber2)>
    </cfif>
    <cfif isDefined("form.iwNumber3") && form.iwNumber3 NEQ "">
        <cfset ArrayAppend(variables.iwNumberArray, form.iwNumber3)>
    </cfif>
    <cfif isDefined("form.iwNumber4") && form.iwNumber4 NEQ "">
        <cfset ArrayAppend(variables.iwNumberArray, form.iwNumber4)>
    </cfif>
    <cfif isDefined("form.iwNumber5") && form.iwNumber5 NEQ "">
        <cfset ArrayAppend(variables.iwNumberArray, form.iwNumber5)>
    </cfif>

    <cfset variables.WebFormFileName = ArrayNew(1)>
    <cfset variables.WebFormAttachmentFileName = ArrayNew(1)>
    <cfset variables.MultiPDFFileName = ArrayNew(1)>
    <cfset variables.SinglePDFFileName = ArrayNew(1)>
    <cfset variables.ImageFileName = ArrayNew(1)>
    <cfset variables.FileOneFileServerPath = ArrayNew(1)>
    <cfset variables.FileTwoFileServerPath = ArrayNew(1)>
    <cfset variables.FileThreeFileServerPath = ArrayNew(1)>
    <cfset variables.FileFourFileServerPath = ArrayNew(1)>
    <cfset variables.FileFiveFileServerPath = ArrayNew(1)>
    <CFSET variables.UniqueId = DateFormat(now(), "YYYYMMDD") & "_" & TimeFormat(now(), "HHMMSS")>
    <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
        <CFSET ArrayAppend(variables.WebFormFileName, variables.iwNumberArray[iwNum] & "_" & variables.UniqueId & "_" & ReReplace(form.lastName, "[^a-zA-Z0-9]", "", "ALL") & "_Receipt")>
        <CFSET ArrayAppend(variables.WebFormAttachmentFileName, variables.iwNumberArray[iwNum] & "_" & variables.UniqueId & "_" & ReReplace(form.lastName, "[^a-zA-Z0-9]", "", "ALL") & "_Receipt.pdf")>
        <CFSET ArrayAppend(variables.MultiPDFFileName, variables.iwNumberArray[iwNum] & "_" & variables.UniqueId & "_" & ReReplace(form.lastName, "[^a-zA-Z0-9]", "", "ALL") & "_PDFMulFile.pdf")>
        <CFSET ArrayAppend(variables.SinglePDFFileName, variables.iwNumberArray[iwNum] & "_" & variables.UniqueId & "_" & ReReplace(form.lastName, "[^a-zA-Z0-9]", "", "ALL") & "_PDFFile.pdf")>
        <CFSET ArrayAppend(variables.ImageFileName, variables.iwNumberArray[iwNum] & "_" & variables.UniqueId & "_" & ReReplace(form.lastName, "[^a-zA-Z0-9]", "", "ALL") & "_img")>
    </cfloop>

    <CFIF IsDefined("form.file1upload") AND form.file1upload IS NOT "">
        <cffile action="upload" destination="#ExpandPath('/TempFileUploadPath')#" filefield="form.file1upload" nameconflict="makeunique">
        <CFIF listfindnocase(ApprovedFileList, file.ServerFileExt) GT 0>
            <CFSET variables.FileOneUploadErrorCode = 0>
            <cfif UCASE(file.ServerFileExt) NEQ "PDF">
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                    <cfset ArrayAppend(variables.FileOneFileServerPath, expandpath('/TempFileUploadPath/StateProtest') & "/" & variables.ImageFileName[iwNum] & variables.imgFileCount & "." & file.ServerFileExt)>
                </cfloop>
                <cfset variables.imgFileCount = variables.imgFileCount + 1>
            <cfelse>
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                    <cfset ArrayAppend(variables.FileOneFileServerPath, expandpath('/TempFileUploadPath/StateProtest') & "/" & variables.iwNumberArray[iwNum] & "_" & variables.UniqueId & ReReplace(form.lastName, "[^a-zA-Z0-9]", "", "ALL") & "_DOCUMENT" & variables.DocumnetFileCount & "." & file.ServerFileExt)>
                </cfloop>
                <cfset variables.DocumnetFileCount = variables.DocumnetFileCount + 1>
            </cfif>
            <cfloop index="iwNum" from="1" to="#arraylen(variables.FileOneFileServerPath)#">
                <cfif iwNum IS 1>
                    <cffile action="rename"
                            source="#expandpath('/TempFileUploadPath')#/#file.ServerFile#"
                            destination="#variables.FileOneFileServerPath[iwNum]#">
                <cfelse>
                    <cffile action="copy"
                            source="#variables.FileOneFileServerPath[iwNum - 1]#"
                            destination="#variables.FileOneFileServerPath[iwNum]#">
                </cfif>
            </cfloop>
            <cfif UCASE(file.ServerFileExt) EQ "PDF">
                <cfset variables.pdfFileCount = variables.pdfFileCount + 1>
            </cfif>
        <cfelse>
            <cffile action="delete" file="#expandpath('/TempFileUploadPath')#/#file.ServerFile#">
            <CFSET variables.FileOneUploadErrorCode = 1>
            <CFSET variables.UploadMessage = "Document 1 Invalid File format">
        </cfif>
    </cfif>
    <CFIF IsDefined("form.file2upload") AND form.file2upload IS NOT "">
        <cffile action="upload" destination="#ExpandPath('/TempFileUploadPath')#" filefield="form.file2upload" nameconflict="makeunique">
        <CFIF listfindnocase(ApprovedFileList, file.ServerFileExt) GT 0>
            <CFSET variables.FileTwoUploadErrorCode = 0>

            <cfif UCASE(file.ServerFileExt) NEQ "PDF">
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                    <cfset ArrayAppend(variables.FileTwoFileServerPath, expandpath('/TempFileUploadPath/StateProtest') & "/" & variables.ImageFileName[iwNum] & variables.imgFileCount & "." & file.ServerFileExt)>
                </cfloop>
                <cfset variables.imgFileCount = variables.imgFileCount + 1>
            <cfelse>
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                    <cfset ArrayAppend(variables.FileTwoFileServerPath, expandpath('/TempFileUploadPath/StateProtest') & "/" & variables.iwNumberArray[iwNum] & "_" & variables.UniqueId & ReReplace(form.lastName, "[^a-zA-Z0-9]", "", "ALL") & "_DOCUMENT" & variables.DocumnetFileCount & "." & file.ServerFileExt)>
                </cfloop>
                <cfset variables.DocumnetFileCount = variables.DocumnetFileCount + 1>
            </cfif>
            <cfloop index="iwNum" from="1" to="#arraylen(variables.FileTwoFileServerPath)#">
                <cfif iwNum IS 1>
                    <cffile action="rename"
                            source="#expandpath('/TempFileUploadPath')#/#file.ServerFile#"
                            destination="#variables.FileTwoFileServerPath[iwNum]#">
                <cfelse>
                    <cffile action="copy"
                            source="#variables.FileTwoFileServerPath[iwNum - 1]#"
                            destination="#variables.FileTwoFileServerPath[iwNum]#">
                </cfif>
            </cfloop>
            <cfif UCASE(file.ServerFileExt) EQ "PDF">
                <cfset variables.pdfFileCount = variables.pdfFileCount + 1>
            </cfif>
        <cfelse>
            <cffile action="delete" file="#expandpath('/TempFileUploadPath')#/#file.ServerFile#">
            <CFSET variables.FileTwoUploadErrorCode = 1>
            <cfif variables.UploadMessage NEQ "">
                <CFSET variables.UploadMessage = variables.UploadMessage & ", " & "Document 2 Invalid File format">
            <cfelse>
                <CFSET variables.UploadMessage = "Document 2 Invalid File format">
            </cfif>
        </cfif>
    </cfif>
    <CFIF IsDefined("form.file3upload") AND form.file3upload IS NOT "">
        <cffile action="upload" destination="#ExpandPath('/TempFileUploadPath')#" filefield="form.file3upload" nameconflict="makeunique">
        <CFIF listfindnocase(ApprovedFileList, file.ServerFileExt) GT 0>
            <CFSET variables.FileThreeUploadErrorCode = 0>
            <cfif UCASE(file.ServerFileExt) NEQ "PDF">
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                    <cfset ArrayAppend(variables.FileThreeFileServerPath, expandpath('/TempFileUploadPath/StateProtest') & "/" & variables.ImageFileName[iwNum] & variables.imgFileCount & "." & file.ServerFileExt)>
                </cfloop>
                <cfset variables.imgFileCount = variables.imgFileCount + 1>
            <cfelse>
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                    <cfset ArrayAppend(variables.FileThreeFileServerPath, expandpath('/TempFileUploadPath/StateProtest') & "/" & variables.iwNumberArray[iwNum] & "_" & variables.UniqueId & ReReplace(form.lastName, "[^a-zA-Z0-9]", "", "ALL") & "_DOCUMENT" & variables.DocumnetFileCount & "." & file.ServerFileExt)>
                </cfloop>
                <cfset variables.DocumnetFileCount = variables.DocumnetFileCount + 1>
            </cfif>
            <cfloop index="iwNum" from="1" to="#arraylen(variables.FileThreeFileServerPath)#">
                <cfif iwNum IS 1>
                    <cffile action="rename"
                            source="#expandpath('/TempFileUploadPath')#/#file.ServerFile#"
                            destination="#variables.FileThreeFileServerPath[iwNum]#">
                <cfelse>
                    <cffile action="copy"
                            source="#variables.FileThreeFileServerPath[iwNum - 1]#"
                            destination="#variables.FileThreeFileServerPath[iwNum]#">
                </cfif>
            </cfloop>
            <cfif UCASE(file.ServerFileExt) EQ "PDF">
                <cfset variables.pdfFileCount = variables.pdfFileCount + 1>
            </cfif>
        <cfelse>
            <cffile action="delete" file="#expandpath('/TempFileUploadPath')#/#file.ServerFile#">
            <CFSET variables.FileThreeUploadErrorCode = 1>
            <cfif variables.UploadMessage NEQ "">
                <CFSET variables.UploadMessage = variables.UploadMessage & ", " & "Document 3 Invalid File format">
            <cfelse>
                <CFSET variables.UploadMessage = "Document 3 Invalid File format">
            </cfif>
        </cfif>
    </cfif>
    <CFIF IsDefined("form.file4upload") AND form.file4upload IS NOT "">
        <cffile action="upload" destination="#ExpandPath('/TempFileUploadPath')#" filefield="form.file4upload" nameconflict="makeunique">
        <CFIF listfindnocase(ApprovedFileList, file.ServerFileExt) GT 0>
            <CFSET variables.FileFourUploadErrorCode = 0>
            <cfif UCASE(file.ServerFileExt) NEQ "PDF">
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                    <cfset ArrayAppend(variables.FileFourFileServerPath, expandpath('/TempFileUploadPath/StateProtest') & "/" & variables.ImageFileName[iwNum] & variables.imgFileCount & "." & file.ServerFileExt)>
                </cfloop>
                <cfset variables.imgFileCount = variables.imgFileCount + 1>
            <cfelse>
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                    <cfset ArrayAppend(variables.FileFourFileServerPath, expandpath('/TempFileUploadPath/StateProtest') & "/" & variables.iwNumberArray[iwNum] & "_" & variables.UniqueId & ReReplace(form.lastName, "[^a-zA-Z0-9]", "", "ALL") & "_DOCUMENT" & variables.DocumnetFileCount & "." & file.ServerFileExt)>
                </cfloop>
                <cfset variables.DocumnetFileCount = variables.DocumnetFileCount + 1>
            </cfif>
            <cfloop index="iwNum" from="1" to="#arraylen(variables.FileFourFileServerPath)#">
                <cfif iwNum IS 1>
                    <cffile action="rename"
                            source="#expandpath('/TempFileUploadPath')#/#file.ServerFile#"
                            destination="#variables.FileFourFileServerPath[iwNum]#">
                <cfelse>
                    <cffile action="copy"
                            source="#variables.FileFourFileServerPath[iwNum - 1]#"
                            destination="#variables.FileFourFileServerPath[iwNum]#">
                </cfif>
            </cfloop>
            <cfif UCASE(file.ServerFileExt) EQ "PDF">
                <cfset variables.pdfFileCount = variables.pdfFileCount + 1>
            </cfif>
        <cfelse>
            <cffile action="delete" file="#expandpath('/TempFileUploadPath')#/#file.ServerFile#">
            <CFSET variables.FileFourUploadErrorCode = 1>
            <cfif variables.UploadMessage NEQ "">
                <CFSET variables.UploadMessage = variables.UploadMessage & ", " & "Document 4 Invalid File format">
            <cfelse>
                <CFSET variables.UploadMessage = "Document 4 Invalid File format">
            </cfif>
        </cfif>
    </cfif>
    <CFIF IsDefined("form.file5upload") AND form.file5upload IS NOT "">
        <cffile action="upload" destination="#ExpandPath('/TempFileUploadPath')#" filefield="form.file5upload" nameconflict="makeunique">
        <CFIF listfindnocase(ApprovedFileList, file.ServerFileExt) GT 0>
            <CFSET variables.FileFiveUploadErrorCode = 0>
            <cfif UCASE(file.ServerFileExt) NEQ "PDF">
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                    <cfset ArrayAppend(variables.FileFiveFileServerPath, expandpath('/TempFileUploadPath/StateProtest') & "/" & variables.ImageFileName[iwNum] & variables.imgFileCount & "." & file.ServerFileExt)>
                </cfloop>
                <cfset variables.imgFileCount = variables.imgFileCount + 1>
            <cfelse>
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                    <cfset ArrayAppend(variables.FileFiveFileServerPath, expandpath('/TempFileUploadPath/StateProtest') & "/" & variables.iwNumberArray[iwNum] & "_" & variables.UniqueId & ReReplace(form.lastName, "[^a-zA-Z0-9]", "", "ALL") & "_DOCUMENT" & variables.DocumnetFileCount & "." & file.ServerFileExt)>
                </cfloop>
                <cfset variables.DocumnetFileCount = variables.DocumnetFileCount + 1>
            </cfif>
            <cfloop index="iwNum" from="1" to="#arraylen(variables.FileFiveFileServerPath)#">
                <cfif iwNum IS 1>
                    <cffile action="rename"
                            source="#expandpath('/TempFileUploadPath')#/#file.ServerFile#"
                            destination="#variables.FileFiveFileServerPath[iwNum]#">
                <cfelse>
                    <cffile action="copy"
                            source="#variables.FileFiveFileServerPath[iwNum - 1]#"
                            destination="#variables.FileFiveFileServerPath[iwNum]#">
                </cfif>
            </cfloop>
            <cfif UCASE(file.ServerFileExt) EQ "PDF">
                <cfset variables.pdfFileCount = variables.pdfFileCount + 1>
            </cfif>
        <cfelse>
            <cffile action="delete" file="#expandpath('/TempFileUploadPath')#/#file.ServerFile#">
            <CFSET variables.FileFiveUploadErrorCode = 1>
            <cfif variables.UploadMessage NEQ "">
                <CFSET variables.UploadMessage = variables.UploadMessage & ", " & "Document 5 Invalid File format">
            <cfelse>
                <CFSET variables.UploadMessage = "Document 5 Invalid File format">
            </cfif>
        </cfif>
    </cfif>

    <cfif variables.FileOneUploadErrorCode EQ 0 &&
    variables.FileTwoUploadErrorCode EQ 0 &&
    variables.FileThreeUploadErrorCode EQ 0 &&
    variables.FileFourUploadErrorCode EQ 0 &&
    variables.FileFiveUploadErrorCode EQ 0>
<!--- Save singe file or Muti File --->
        <cfif variables.pdfFileCount GTE 2>
            <cfloop index="iwNum" from="1" to="#arraylen(variables.MultiPDFFileName)#">
                <cfpdf action="merge" destination="#expandpath('/TempFileUploadPath/StateProtest')#/#variables.MultiPDFFileName[iwNum]#">
                <cfif IsDefined("variables.FileOneFileServerPath") && arraylen(variables.FileOneFileServerPath) NEQ 0 && variables.FileOneFileServerPath[iwNum] NEQ "" && UCASE(Right(variables.FileOneFileServerPath[iwNum], 3)) EQ "PDF">
                    <cfpdfparam source="#variables.FileOneFileServerPath[iwNum]#"/>
                </cfif>
                <cfif IsDefined("variables.FileTwoFileServerPath") && arraylen(variables.FileTwoFileServerPath) NEQ 0 && variables.FileTwoFileServerPath[iwNum] NEQ "" && UCASE(Right(variables.FileTwoFileServerPath[iwNum], 3)) EQ "PDF">
                    <cfpdfparam source="#variables.FileTwoFileServerPath[iwNum]#"/>
                </cfif>
                <cfif IsDefined("variables.FileThreeFileServerPath") && arraylen(variables.FileThreeFileServerPath) NEQ 0 && variables.FileThreeFileServerPath[iwNum] NEQ "" && UCASE(Right(variables.FileThreeFileServerPath[iwNum], 3)) EQ "PDF">
                    <cfpdfparam source="#variables.FileThreeFileServerPath[iwNum]#"/>
                </cfif>
                <cfif IsDefined("variables.FileFourFileServerPath") && arraylen(variables.FileFourFileServerPath) NEQ 0 && variables.FileFourFileServerPath[iwNum] NEQ "" && UCASE(Right(variables.FileFourFileServerPath[iwNum], 3)) EQ "PDF">
                    <cfpdfparam source="#variables.FileFourFileServerPath[iwNum]#"/>
                </cfif>
                <cfif IsDefined("variables.FileFiveFileServerPath") && arraylen(variables.FileFiveFileServerPath) NEQ 0 && variables.FileFiveFileServerPath[iwNum] NEQ "" && UCASE(Right(variables.FileFiveFileServerPath[iwNum], 3)) EQ "PDF">
                    <cfpdfparam source="#variables.FileFiveFileServerPath[iwNum]#"/>
                </cfif>
            </cfpdf>
            </cfloop>
            <cfelseif variables.pdfFileCount EQ 1>
            <cfloop index="iwNum" from="1" to="#arraylen(variables.SinglePDFFileName)#">
                <cfpdf action="merge" destination="#expandpath('/TempFileUploadPath/StateProtest')#/#variables.SinglePDFFileName[iwNum]#">
                <cfif IsDefined("variables.FileOneFileServerPath") && arraylen(variables.FileOneFileServerPath) NEQ 0 && variables.FileOneFileServerPath[iwNum] NEQ "" && UCASE(Right(variables.FileOneFileServerPath[iwNum], 3)) EQ "PDF">
                    <cfpdfparam source="#variables.FileOneFileServerPath[iwNum]#"/>
                </cfif>
                <cfif IsDefined("variables.FileTwoFileServerPath") && arraylen(variables.FileTwoFileServerPath) NEQ 0 && variables.FileTwoFileServerPath[iwNum] NEQ "" && UCASE(Right(variables.FileTwoFileServerPath[iwNum], 3)) EQ "PDF">
                    <cfpdfparam source="#variables.FileTwoFileServerPath[iwNum]#"/>
                </cfif>
                <cfif IsDefined("variables.FileThreeFileServerPath") && arraylen(variables.FileThreeFileServerPath) NEQ 0 && variables.FileThreeFileServerPath[iwNum] NEQ "" && UCASE(Right(variables.FileThreeFileServerPath[iwNum], 3)) EQ "PDF">
                    <cfpdfparam source="#variables.FileThreeFileServerPath[iwNum]#"/>
                </cfif>
                <cfif IsDefined("variables.FileFourFileServerPath") && arraylen(variables.FileFourFileServerPath) NEQ 0 && variables.FileFourFileServerPath[iwNum] NEQ "" && UCASE(Right(variables.FileFourFileServerPath[iwNum], 3)) EQ "PDF">
                    <cfpdfparam source="#variables.FileFourFileServerPath#"/>
                </cfif>
                <cfif IsDefined("variables.FileFiveFileServerPath") && arraylen(variables.FileFiveFileServerPath) NEQ 0 && variables.FileFiveFileServerPath[iwNum] NEQ "" && UCASE(Right(variables.FileFiveFileServerPath[iwNum], 3)) EQ "PDF">
                    <cfpdfparam source="#variables.FileFiveFileServerPath#"/>
                </cfif>
            </cfpdf>
            </cfloop>
        </cfif>

        <cfquery name="qSP" datasource="#application.GeneralDSN#">
            INSERT INTO dbo.tblStateProtest
            ([FirstName],[MiddleName],[LastName],[PhoneNumber],[BusinessName],[IdentificationNumber],[IWNumber],[IWNumber2],[IWNumber3],[IWNumber4],[IWNumber5],[CurrentStreeAddress],[CurrentStreeAddress2],[City],[State],[ZipCode],[Document1],[Document2],[Document3],[Document4],[Document5],[Signature],[Comments],[RecordInsertedDate],[RecordInsertedBy])

            VALUES (
            <cfif isDefined("form.Firstname") && form.Firstname NEQ "">
                <cfqueryparam value="#form.Firstname#" cfsqltype="cf_sql_varchar">,
            <cfelse>
                <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
            </cfif>
            <cfif isDefined("form.MiddleName") && form.MiddleName NEQ "">
                <cfqueryparam value="#form.MiddleName#" cfsqltype="cf_sql_varchar">,
            <cfelse>
                <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
            </cfif>
            <cfif isDefined("form.Lastname") && form.Lastname NEQ "">
                <cfqueryparam value="#form.Lastname#" cfsqltype="cf_sql_varchar">,
            <cfelse>
                <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
            </cfif>
            <cfqueryparam value="#form.phonenumber#" cfsqltype="cf_sql_varchar">,
            <cfif isDefined("form.businessName") && form.businessName NEQ "">
                <cfqueryparam value="#form.businessName#" cfsqltype="cf_sql_varchar">,
            <cfelse>
                <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
            </cfif>
            <cfqueryparam value="#form.ssnfein#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.iwNumber#" cfsqltype="cf_sql_varchar">,
            <cfif isDefined("form.iwNumber2") && form.iwNumber2 NEQ "">
                <cfqueryparam value="#form.iwNumber2#" cfsqltype="cf_sql_varchar">,
            <cfelse>
                <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
            </cfif>
            <cfif isDefined("form.iwNumber3") && form.iwNumber3 NEQ "">
                <cfqueryparam value="#form.iwNumber3#" cfsqltype="cf_sql_varchar">,
            <cfelse>
                <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
            </cfif>
            <cfif isDefined("form.iwNumber4") && form.iwNumber4 NEQ "">
                <cfqueryparam value="#form.iwNumber4#" cfsqltype="cf_sql_varchar">,
            <cfelse>
                <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
            </cfif>
            <cfif isDefined("form.iwNumber5") && form.iwNumber5 NEQ "">
                <cfqueryparam value="#form.iwNumber5#" cfsqltype="cf_sql_varchar">,
            <cfelse>
                <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
            </cfif>
            <cfqueryparam value="#form.cStreetaddress#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.cStreetaddress2#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(form.cStreetaddress2))#">,
            <cfqueryparam value="#form.cCity#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.cState#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#form.cZip#" cfsqltype="cf_sql_varchar">,
            <cfif arraylen(variables.FileOneFileServerPath) NEQ 0>
                <cfqueryparam value="#variables.FileOneFileServerPath[1]#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(variables.FileOneFileServerPath[1]))#">,
            <cfelse>
                <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
            </cfif>
            <cfif arraylen(variables.FileTwoFileServerPath) NEQ 0>
                <cfqueryparam value="#variables.FileTwoFileServerPath[1]#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(variables.FileTwoFileServerPath[1]))#">,
            <cfelse>
                <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
            </cfif>
            <cfif arraylen(variables.FileThreeFileServerPath) NEQ 0>
                <cfqueryparam value="#variables.FileThreeFileServerPath[1]#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(variables.FileThreeFileServerPath[1]))#">,
            <cfelse>
                <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
            </cfif>
            <cfif arraylen(variables.FileFourFileServerPath) NEQ 0>
                <cfqueryparam value="#variables.FileFourFileServerPath[1]#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(variables.FileFourFileServerPath[1]))#">,
            <cfelse>
                <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
            </cfif>
            <cfif arraylen(variables.FileFiveFileServerPath) NEQ 0>
                <cfqueryparam value="#variables.FileFiveFileServerPath[1]#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(variables.FileFiveFileServerPath[1]))#">,
            <cfelse>
                <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
            </cfif>
            <cfqueryparam value="1" cfsqltype="CF_SQL_BIT">,
            <cfqueryparam value="#form.comments#" cfsqltype="cf_sql_varchar">,
            <cfqueryparam value="#NOW()#" cfsqltype="cf_sql_timestamp">,
            <cfqueryparam value="WebForm" cfsqltype="cf_sql_varchar">
            )
        </cfquery>
        <cfsavecontent variable="sectionOneContent">
            <cfoutput>
                <div>
                <p>Today's date : #DateFormat(Now(), "mm/dd/yyyy")# - #TimeFormat(now(), "HH:MM:SS")#</p>
                <cfif form.Firstname NEQ "">
                        <p>First Name : #form.Firstname#</p>
                </cfif>
                <cfif form.MiddleName NEQ "">
                        <p>Middle Initial : #form.MiddleName#</p>
                </cfif>
                <cfif form.Lastname NEQ "">
                        <p>Last Name : #form.Lastname#</p>
                </cfif>
                <p>Phone Number : #form.phonenumber#</p>
            <p>Social Security Number (SSN) / FEIN Number : #form.ssnfein#</p>
                <cfif form.businessName NEQ "">
                        <p>Business Name : #form.businessName#</p>
                </cfif>
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                        <p>IW Number#iwNum# : #variables.iwNumberArray[iwNum]#</p>
                </cfloop>
                    <p>Current Address : #form.cStreetaddress#</p>
                <cfif form.cStreetaddress2 NEQ "">
                        <p>Current Street Address 2 : #form.cStreetaddress2#</p>
                </cfif>
                <p>City : #form.cCity#</p>
            <p>State : #form.cState#</p>
            <p>ZIP code : #form.cZip#</p>
            <p>
                <cfset variables.TotalFileCount = (variables.imgFileCount - 1) + variables.pdfFileCount>
                    Attachments : <cfif variables.TotalFileCount EQ 0> <em>None</em>
            <cfelse><em>#variables.TotalFileCount#</em></cfif>
                </p>
                <cfif form.comments NEQ "">
                        <p>Reason for Protest : #variables.CleanComments#</p>
                </cfif>
                    <p>By submitting this form, you acknowledge that the content is truthful and accurate to the best of
                        your knowledge.You further acknowledge that it is your intent that submission acts as your
                        digital signature in place of your manual signature and that your digital signature has the same
                        legal effect as your manual signature.</p>
                </div>
            </cfoutput>
        </cfsavecontent>
        <cfloop index="iwNum" from="1" to="#arraylen(variables.WebFormFileName)#">
            <cfset TempName = variables.WebFormFileName[iwNum]>
            <cfdocument format="PDF" name="TempName">
                <cfoutput>#sectionOneContent#</cfoutput></cfdocument>
            <cfmail
                    to="#variables.ToEmailAddress#"
                    from="DoNotReply@IllinoisComptroller.Gov"
                    subject="New StateProtest Form Submission"
                    type="html">

                <p>Dear Admin,</p>

                <p>
                    A Debt Protest form has been submitted to the Illinois Comptroller's Office. The details are below.
                </p>

                <p>#sectionOneContent#</p>

                <cfif IsDefined("variables.FileOneFileServerPath") && arraylen(variables.FileOneFileServerPath) NEQ 0 && variables.FileOneFileServerPath[iwNum] NEQ "" && UCASE(Right(variables.FileOneFileServerPath[iwNum], 3)) NEQ "PDF">
<!--- Attach the file. --->
                    <cfmailparam
                            file="#variables.FileOneFileServerPath[iwNum]#"/>
                </cfif>
                <cfif IsDefined("variables.FileTwoFileServerPath") && arraylen(variables.FileTwoFileServerPath) NEQ 0 && variables.FileTwoFileServerPath[iwNum] NEQ "" && UCASE(Right(variables.FileTwoFileServerPath[iwNum], 3)) NEQ "PDF">
<!--- Attach the file. --->
                    <cfmailparam
                            file="#variables.FileTwoFileServerPath[iwNum]#"/>
                </cfif>
                <cfif IsDefined("variables.FileThreeFileServerPath") && arraylen(variables.FileThreeFileServerPath) NEQ 0 && variables.FileThreeFileServerPath[iwNum] NEQ "" && UCASE(Right(variables.FileThreeFileServerPath[iwNum], 3)) NEQ "PDF">
<!--- Attach the file. --->
                    <cfmailparam
                            file="#variables.FileThreeFileServerPath[iwNum]#"/>
                </cfif>
                <cfif IsDefined("variables.FileFourFileServerPath") && arraylen(variables.FileFourFileServerPath) NEQ 0 && variables.FileFourFileServerPath[iwNum] NEQ "" && UCASE(Right(variables.FileFourFileServerPath[iwNum], 3)) NEQ "PDF">
<!--- Attach the file. --->
                    <cfmailparam
                            file="#variables.FileFourFileServerPath[iwNum]#"/>
                </cfif>
                <cfif IsDefined("variables.FileFiveFileServerPath") && arraylen(variables.FileFiveFileServerPath) NEQ 0 && variables.FileFiveFileServerPath[iwNum] NEQ "" && UCASE(Right(variables.FileFiveFileServerPath[iwNum], 3)) NEQ "PDF">
<!--- Attach the file. --->
                    <cfmailparam
                            file="#variables.FileFiveFileServerPath[iwNum]#"/>
                </cfif>
                <CFIF variables.pdfFileCount GTE 2>
                    <cfmailparam file="#expandpath('/TempFileUploadPath/StateProtest')#/#variables.MultiPDFFileName[iwNum]#"/>
                    <cfelseif variables.pdfFileCount EQ 1>
                    <cfmailparam file="#expandpath('/TempFileUploadPath/StateProtest')#/#variables.SinglePDFFileName[iwNum]#"/>
                </CFIF>
                <cfmailparam file="#variables.WebFormAttachmentFileName[iwNum]#" content="#TempName#">
            </cfmail>
        </cfloop>


    </cfif>
</cfif>

<cfif isDefined("variables.FileOneUploadErrorCode") || isDefined("variables.FileTwoUploadErrorCode") || isDefined("variables.FileThreeUploadErrorCode") || isDefined("variables.FileFourUploadErrorCode") || isDefined("variables.FileFiveUploadErrorCode")>
    <cfif variables.FileOneUploadErrorCode EQ 1 || variables.FileTwoUploadErrorCode EQ 1 || variables.FileThreeUploadErrorCode EQ 1 || variables.FileFourUploadErrorCode EQ 1 || variables.FileFiveUploadErrorCode EQ 1>
        <cfoutput>
            <div class="alert alert-danger">#variables.UploadMessage#.</div>
        </cfoutput>
    <cfelse>
        <cfset variables.dispForm = "1">
        <cfoutput>
            <p class="noprint" align="center" style="padding-top: 20px;">
                <input type="button" class="btn btn-success" onclick="window.print()" value="Print This Page">
                <a class="btn btn-danger" href="/stateprotest/stateprotestform/" data-toggle="tooltip"
                   data-placement="right" title="Return to Select your reason for protest"> Return </a>
            </p>
            <div>
                <h3 class="text-center">STATE DEBT PROTEST ONLINE RECEIPT</h3><br/>
            <cfif form.Firstname NEQ "">
                    <p>NAME: #form.Firstname# #form.Lastname#</p>
            <cfelse>
                    <p>BUSINESS NAME: #form.businessName#</p>
            </cfif>
            <p>DATE: #DateFormat(Now(), "mm/dd/yyyy")# #TimeFormat(now(), "HH:MM:SS")#</p>
        <p>IW Number: #ArrayToList(variables.iwNumberArray, ",")#</p><br/><br/>
        <p> Dear:
            <cfif form.Firstname NEQ ""> #form.Firstname# #form.Lastname#
            <cfelse> #form.businessName# </cfif> </p><br/>
            <p>Thank you for submitting your protest online. Your protest will be processed within 3 to 5 business days
                and in the order it was received. After we process your protest we will mail you a confirmation
                letter. </p><br/>
            <p>If you have any questions, please contact our office during business hours, Monday through Friday 8:30 am
                to 4:30 pm at (217) 782-7525.</p><br/>
            <p>Please save this email for your records.</p><br/><br/>
            <p>State of Illinois Comptroller</p>
            <p>Collections</p>
        </div>

        </div>

        </cfoutput>
    </cfif>
</cfif>
<cfif variables.dispForm EQ "0">
    <h2>Online Protest Form</h2>
    <div>
        <p>Fill out the form below to file your protest. Please note that you must complete all the required fields<span
                class="red"> (*) </span> in order for your protest to be accepted. If you plan to submit supporting
            documentation, it must be submitted with this form. Allow 3 to 5 business days for processing. </p>
        <p>Carefully review the form before submitting it to ensure that all the information, including supporting
            documentation, is complete and accurate. The information you submit will be used by the claiming agency to
            adjudicate your protest.</p>
        <p>Protests are public records which are subject to the Freedom of Information Act (FOIA), just like other
            public records. If we receive a request for copies of protests and supporting documents, we may be required
            to provide a copy of your protest to the requestor. However, information that would reveal your identity as
            a protestor is exempt from disclosure and will be redacted from copies that we provide, allowing the
            requestor to read your protest without compromising your privacy.</p>
    </div>

    <div id="messageHolderTop" class="hide"></div>
<!--- The order is not same as value because this is last minute change and developer is not sure if this is final change --->
    <cfform id="OnlineForm" name="OnlineForm" enctype="multipart/form-data" method="post">

        <div class="row margintop">
        <cfquery name="stateList" datasource="#application.GeneralDSN#">
                SELECT [State]
                ,[ShortName]
                FROM [dbo].[States]
                WHERE [countryID] = 1
                ORDER BY [State]
        </cfquery>

        <div class="col-xs-12 col-sm-6">
        <div class="form-group firstName-container hide">
            <label for="firstName">First Name</label>
                <input id="firstName" name="firstName" class="form-control" type="text" placeholder="First Name"
        <cfif IsDefined("form.firstName")>
            <cfoutput>value="#form.firstName#"</cfoutput>
        <cfelse>value=""</cfif> data-required="true" maxlength="80">
    </div>
    </div>
    <div class="col-xs-12 col-sm-6">
    <div class="form-group middleName-container hide">
        <label for="middleName">Middle Initial</label>
            <input id="middleName" name="middleName" class="form-control" type="text" placeholder="Middle Initial"
        <cfif IsDefined("form.middleName")>
            <cfoutput>value="#form.middleName#"</cfoutput>
        <cfelse>value=""</cfif> data-required="true" maxlength="40">
    </div>
    </div>
    <div class="col-xs-12 col-sm-6">
    <div class="form-group lastName-container hide">
        <label for="lastName">Last Name</label>
            <input id="lastName" name="lastName" class="form-control" type="text" placeholder="Last Name"
        <cfif IsDefined("form.lastName")>
            <cfoutput>value="#form.lastName#"</cfoutput>
        <cfelse>value=""</cfif> data-required="true" maxlength="80">
    </div>
    </div>
    <div class="col-xs-12 col-sm-6">
    <div class="form-group phonenumber-container hide">
        <label for="phonenumber">Phone Number</label>
            <input id="phonenumber" name="phonenumber" class="form-control" type="text" placeholder="Phone Number"
        <cfif IsDefined("form.phonenumber")>
            <cfoutput>value="#form.phonenumber#"</cfoutput>
        <cfelse>value=""</cfif> data-required="true" maxlength="15">
    </div>
    </div>
    <div class="col-xs-12 col-sm-6">
    <div class="form-group businessName-container hide">
        <label for="businessName">Business Name</label>
            <input id="businessName" name="businessName" class="form-control" type="text" placeholder="Business Name"
        <cfif IsDefined("form.businessName")>
            <cfoutput>value="#form.businessName#"</cfoutput>
        <cfelse>value=""</cfif> data-required="true" maxlength="80">
    </div>
    </div>
    <div class="col-xs-12 col-sm-6">
        <div class="form-group">
        <label for="ssn">Social Security Number (SSN)/FEIN Number (Last 4 digits)<span
                class="red">&nbsp;*</span></label>
    <div class="input-group">
            <input name="ssnfein" type="password" maxlength="4" id="ssnfein" data-required="true"
                   class="form-control numeric" autocomplete="off"
                   placeholder="Last Four Digits of SSN/FEIN Number" <cfif IsDefined("form.ssnfein")>
        <cfoutput>value="#form.ssnfein#"</cfoutput></cfif>>
        <label class="input-group-addon">
            <input type="checkbox" style="display:none" onclick="(function(e, el){
									 document.getElementById('ssnfein').type = el.checked ? 'text' : 'password';
									  el.parentNode.lastElementChild.innerHTML = el.checked ? '<i class=\'glyphicon glyphicon-eye-close\'>' : '<i class=\'glyphicon glyphicon-eye-open\'>';
									  })(event, this)">
            <span><i class="glyphicon glyphicon-eye-open"></i></span>
        </label>
    </div>
<!--- <div class="form-group ssnfein-container hide">
    <label for="ssnfein">Social Security Number (SSN) / FEIN Number (Last 4 digits)</label>
    <input id="ssnfein" name="ssnfein" autocomplete="off" class="form-control numeric" type="password" placeholder="SSN / FEIN (Last 4 digits)"
    <cfif IsDefined("form.ssnfein")><cfoutput>value="#form.ssnfein#"</cfoutput><cfelse>value=""</cfif> data-required="true" maxlength="4">
</div> --->
        </div>
        </div>

<!--- SR 18101 Changed iwNumber max length to 14 and editted placeholder --->
        <div class="col-xs-12 col-sm-12 col-md-6">
        <div class="form-group iwNumber-container hide">
            <label for="iwNumber">IW Number</label>
                <input class="form-control alpha-numeric" id="iwNumber"
                       placeholder="14 digit IW Number" name="iwNumber"
                       data-required="true" maxlength="14" <cfif IsDefined("form.iwNumber")>
        <cfoutput>value="#form.iwNumber#"</cfoutput></cfif>>
    </div>
    </div>
        <div class="col-xs-12 col-sm-12 col-md-6 padt24">
            <div class="form-group iwNumber-container hide">
                <div class="text-center">
                    <button class="add_field_button btn btn-success form-btn">Add ANOTHER IW Number(s) (Max 4)</button>
                </div>
            </div>
        </div>
        <div id="input_fields_wrap" class="clearfix">
        </div>

        <div class="col-xs-12 col-sm-12">
            <div class="form-group caddress-container hide">
                <label for="faddress">
                    <ins>Current Address</ins>
                </label>
            </div>
        </div>

    <div class="col-xs-12 col-sm-6">
    <div class="form-group cStreetaddress-container hide">
        <label for="cStreetaddress">Street Address</label>
            <input class="form-control" name="cStreetaddress" id="cStreetaddress"
                   placeholder="Street Address" <cfif IsDefined("form.cStreetaddress")>
        <cfoutput>value="#form.cStreetaddress#"</cfoutput></cfif>  maxlength="40">
    </div>
    </div>
    <div class="col-xs-12 col-sm-6">
    <div class="form-group cStreetaddress2-container hide">
        <label for="cStreetaddress2">Street Address 2 (Optional)</label>
            <input class="form-control" name="cStreetaddress2" id="cStreetaddress2"
                   placeholder="Street Address 2 (Optional)" <cfif IsDefined("form.cStreetaddress2")>
        <cfoutput>value="#form.cStreetaddress2#"</cfoutput></cfif>  maxlength="40">
    </div>
    </div>

    <div class="col-xs-12 col-sm-4">
    <div class="form-group cCity-container hide">
        <label for="cCity">City</label>
            <input class="form-control" name="cCity" id="cCity" placeholder="City" <cfif IsDefined("form.cCity")>
        <cfoutput>value="#form.cCity#"</cfoutput></cfif>  maxlength="40">
    </div>
    </div>
    <div class="col-xs-12 col-sm-4">
    <div class="form-group cState-container hide">
        <label for="cState">State</label>
    <select id="cState" name="cState" class="form-control">
        <option value="0" selected>Select State</option>
        <cfloop query="stateList">
            <cfoutput>
                    <option value="#stateList.ShortName#" <cfif IsDefined("form.cState")>
                    <cfif stateList.ShortName eq form.cState>selected</cfif></cfif>>#stateList.State#</option></cfoutput>
        </cfloop>
        </select>
<!--- <input class="form-control" name="cState" id="cState" placeholder="State" <cfif IsDefined("form.cState")><cfoutput>value="#form.cState#"</cfoutput></cfif>  maxlength="40"> --->
        </div>
        </div>
        <div class="col-xs-12 col-sm-4">
        <div class="form-group cZip-container hide">
            <label for="cZip">ZIP Code</label>
                <input class="form-control numeric" name="cZip" id="cZip"
                       placeholder="ZIP Code" <cfif IsDefined("form.cZip")>
        <cfoutput>value="#form.cZip#"</cfoutput></cfif>  maxlength="5">
    </div>
    </div>

            <div class="col-xs-12 col-sm-12 reasonProtest <cfif isDefined("variables.FileFiveUploadErrorCode") && variables.FileFiveUploadErrorCode EQ 1>has-error
    <cfelse>hide</cfif>">
    <div class="form-group row required">
        <label for="comments" class="col-sm-3 control-label">Reason for Protest</label>
    <div class="col-sm-9">
        <cftextarea class="form-control" id="comments" name="comments" rows="5" cols="30" placeholder="Type reason for protest (details)"><cfif IsDefined("form.comments")>
            <cfoutput>#form.comments#</cfoutput></cfif></cftextarea>
        </div>
        </div>
        </div>
            <div class="col-xs-12 col-sm-12 margintopbottom filescont hide">
                <div class="alert alert-info"> You may add up to five documents to support your protest. Only pdf, jpg
                    or png file types are accepted. No Microsoft documents (word, excel, etc.) are allowed, but they may
                    be converted to pdf, scanned or photographed. Driver's license, State ID Card, Passport, or other
                    picture identification with signature and date of birth, property deed, court order, or proof of
                    sale, and any other documentation that supports your protest may be uploaded.
                </div>
            </div>

                <div class="col-xs-12 col-sm-12 margintopbottom filescont <cfif isDefined("variables.FileOneUploadErrorCode") && variables.FileOneUploadErrorCode EQ 1>has-error
    <cfelse>hide</cfif>">
    <div class="form-group file1upload-container">
        <label for="file1upload" class="col-sm-2 control-label" align="right">Document 1</label>
    <div class="col-sm-9">
        <cfinput type="file" name="file1upload" id="file1upload" class="myFile" data-size = "1">
            <p class="help-block"><em>Valid file type: .pdf,.png,.jpg,.jpeg (Maximum Size of document allowed is 4
                MB)</em><span class="lblError" style="color: red;"></span>
            </p>
        </div>
        </div>
        </div>
                <div class="col-xs-12 col-sm-12 filescont <cfif isDefined("variables.FileTwoUploadErrorCode") && variables.FileTwoUploadErrorCode EQ 1>has-error
    <cfelse>hide</cfif>">
    <div class="form-group file2upload-container">
        <label for="file2upload" class="col-sm-2 control-label" align="right">Document 2</label>
    <div class="col-sm-9">
        <cfinput type="file" name="file2upload" id="file2upload" class="myFile" data-size = "1">
            <p class="help-block"><em>Valid file type: .pdf,.png,.jpg,.jpeg (Maximum Size of document allowed is 4
                MB)</em><span class="lblError" style="color: red;"></span>
            </p>
        </div>
        </div>
        </div>
                <div class="col-xs-12 col-sm-12 filescont <cfif isDefined("variables.FileThreeUploadErrorCode") && variables.FileThreeUploadErrorCode EQ 1>has-error
    <cfelse>hide</cfif>">
    <div class="form-group file3upload-container">
        <label for="file3upload" class="col-sm-2 control-label" align="right">Document 3</label>
    <div class="col-sm-9">
        <cfinput type="file" name="file3upload" id="file3upload" class="myFile" data-size = "1">
            <p class="help-block"><em>Valid file type: .pdf,.png,.jpg,.jpeg (Maximum Size of document allowed is 4
                MB)</em><span class="lblError" style="color: red;"></span>
            </p>
        </div>
        </div>
        </div>
                <div class="col-xs-12 col-sm-12 filescont <cfif isDefined("variables.FileFourUploadErrorCode") && variables.FileFourUploadErrorCode EQ 1>has-error
    <cfelse>hide</cfif>">
    <div class="form-group file4upload-container">
        <label for="file4upload" class="col-sm-2 control-label" align="right">Document 4</label>
    <div class="col-sm-9">
        <cfinput type="file" name="file4upload" id="file4upload" class="myFile" data-size = "1">
            <p class="help-block"><em>Valid file type: .pdf,.png,.jpg,.jpeg (Maximum Size of document allowed is 4
                MB)</em><span class="lblError" style="color: red;"></span>
            </p>
        </div>
        </div>
        </div>
                <div class="col-xs-12 col-sm-12 filescont <cfif isDefined("variables.FileFiveUploadErrorCode") && variables.FileFiveUploadErrorCode EQ 1>has-error
    <cfelse>hide</cfif>">
    <div class="form-group file5upload-container">
        <label for="file5upload" class="col-sm-2 control-label" align="right">Document 5</label>
    <div class="col-sm-9">
        <cfinput type="file" name="file5upload" id="file5upload" class="myFile" data-size = "1">
            <p class="help-block"><em>Valid file type: .pdf,.png,.jpg,.jpeg (Maximum Size of document allowed is 4
                MB)</em><span class="lblError" style="color: red;"></span>
            </p>
        </div>
        </div>
        </div>

        <div class="form-group">
        <div class="clearfix">
        <div class="col-xs-12 col-sm-12 filescont hide"><input
                type="checkbox" <cfif (isDefined("variables.FileOneUploadErrorCode") || isDefined("variables.FileTwoUploadErrorCode") || isDefined("variables.FileThreeUploadErrorCode") || isDefined("variables.FileFourUploadErrorCode") || isDefined("variables.FileFiveUploadErrorCode") && IsDefined("form.submit")) &&
    (variables.FileOneUploadErrorCode EQ 1 || variables.FileTwoUploadErrorCode EQ 1 || variables.FileThreeUploadErrorCode EQ 1 || variables.FileFourUploadErrorCode EQ 1 || variables.FileFiveUploadErrorCode EQ 1)> </cfif>
                value="Signature" id="Signature" name="Signature"> By submitting this form, you acknowledge that the
                    content is truthful and accurate to the best of your knowledge.You further acknowledge that it is
                    your intent that submission acts as your digital signature in place of your manual signature and
                    that your digital signature has the same legal effect as your manual signature.<span
                        class="red"><sup>*</sup></span> </div>
                </div>
                </div>

                    <div class="form-submit-button hide">
                        <div class="text-center">
                        <a class="btn btn-success" href="/stateprotest/" data-toggle="tooltip" data-placement="top"
                           title="Return to Select your reason for protest">CANCEL</a>
                        <input class="btn btn-primary" data-toggle="tooltip" data-placement="top"
                               title="Send the protest form to the State Offset Unit." type="submit" id="submit"
                               name="submit" value="Submit">
                        </div>
                    </div>

                    <!---<div class="col-sm-offset-2 col-xs-6 col-sm-4" style="padding-bottom: 20px;">
                        <div class="form-submit-button hide">
                            <a class="btn btn-danger btn-block" href="/stateprotest/" data-toggle="tooltip" data-placement="top"
                               title="Return to Select your reason for protest"> CANCEL </a>
                        </div>
                    </div>
                    <div class="col-xs-6 col-sm-4" style="padding-bottom: 20px;">
                        <div class="form-submit-button hide">
                            <input class="btn btn-primary btn-block" data-toggle="tooltip" data-placement="top"
                                   title="Send the protest form to the State Offset Unit." type="submit" id="submit"
                                   name="submit" value="Submit">
                        </div>
                    </div>--->


                </div>
    </cfform>
    <div id="messageHolderBottom" class="hide"></div>
</cfif>

<cfoutput>

    <script src="/comptroller/includes/display_objects/custom/StateProtest/assets/js/jquery.masked-input.js"></script>
    <script src="/comptroller/includes/display_objects/custom/StateProtest/assets/js/jquery.plugin.min.js"></script>
    <script src="/comptroller/includes/display_objects/custom/StateProtest/assets/js/jquery.maxlength.min.js"></script>
    <script src="/comptroller/includes/display_objects/custom/StateProtest/assets/js/Validate.js"></script>


</cfoutput>