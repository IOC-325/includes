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


    /*	input[type='file'] {
            border: 3px dashed #999;
            padding: 140px 50px 10px 50px;
            cursor: move;
            position:relative;
        }
        input[type='file']:before {
            content: "drag & drop your files here";
            display: block;
            position: absolute;
            text-align: center;
            top: 50%;
            left: 50%;
            width: 200px;
            height: 40px;
            margin: -25px 0 0 -100px;
            font-size: 18px;
            font-weight: bold;
            color: #999;
        } */
</style>

<!---<link rel="stylesheet" href="/comptroller/includes/display_objects/custom/DebtProtest/assets/datepicker.css"> --->

<CFSET variables.dispForm = "0">
<cfset variables.protestDesc = ["Did Not Possess or Own Property", "Wrong Person/Jr.Sr./Twins/Siblings/Divorced", "Paid/Settled/Payment Plan/Dismissed", "Improper Notice/Old Address/Never Received Notice", "Deceased", "Bankruptcy", "Other", "Business"]>

<cfif isDefined("form.submit")>

    <cfif Trim(form.comments) NEQ "">
        <CFSET variables.CleanComments = Trim(form.comments)>
<!--- check if last char is not a alphabet then ignore else add a space --->
        <cfset vartempCleanComments = mid(variables.CleanComments, len(variables.CleanComments), len(variables.CleanComments) - 1)>
        <cfset vartempCharCount = 0>
<!--- <CFIF ListFind(ApprovedAccessLevelStatusIDList, i)> --->
        <cfloop index="strLetter" list="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z"
                delimiters=",">
            <cfif UCASE(vartempCleanComments) EQ strLetter>
                <cfset vartempCharCount = 1>
            </cfif>
        </cfloop>
        <cfif vartempCharCount EQ "1">
            <CFSET variables.CleanComments = variables.CleanComments & " ">
        <cfelse>
            <CFSET variables.CleanComments = mid(variables.CleanComments, 1, len(variables.CleanComments) - 1) & " " & vartempCleanComments>
        </cfif>
        <cfquery name="qBWlist" datasource="#application.GeneralDSN#">
            SELECT [BadWord]  FROM [dbo].[FilteredWordList]
        </cfquery>
        <cfloop query="qBWlist">
            <CFSET variables.CleanComments = replace(variables.CleanComments, ' ' & BadWord & ' ', " * ", "All")>
        </cfloop>
    </cfif>

<!--- Send Email based on type --->
    <CFSET variables.ToEmailAddress = #application.LocalDebtProtestFormEmailTo#>
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
                    <cfset ArrayAppend(variables.FileOneFileServerPath, expandpath('/TempFileUploadPath/DebtProtest') & "/" & variables.ImageFileName[iwNum] & variables.imgFileCount & "." & file.ServerFileExt)>
                </cfloop>
                <cfset variables.imgFileCount = variables.imgFileCount + 1>
            <cfelse>
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                    <cfset ArrayAppend(variables.FileOneFileServerPath, expandpath('/TempFileUploadPath/DebtProtest') & "/" & variables.iwNumberArray[iwNum] & "_" & variables.UniqueId & ReReplace(form.lastName, "[^a-zA-Z0-9]", "", "ALL") & "_DOCUMENT" & variables.DocumnetFileCount & "." & file.ServerFileExt)>
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
                    <cfset ArrayAppend(variables.FileTwoFileServerPath, expandpath('/TempFileUploadPath/DebtProtest') & "/" & variables.ImageFileName[iwNum] & variables.imgFileCount & "." & file.ServerFileExt)>
                </cfloop>
                <cfset variables.imgFileCount = variables.imgFileCount + 1>
            <cfelse>
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                    <cfset ArrayAppend(variables.FileTwoFileServerPath, expandpath('/TempFileUploadPath/DebtProtest') & "/" & variables.iwNumberArray[iwNum] & "_" & variables.UniqueId & ReReplace(form.lastName, "[^a-zA-Z0-9]", "", "ALL") & "_DOCUMENT" & variables.DocumnetFileCount & "." & file.ServerFileExt)>
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
                    <cfset ArrayAppend(variables.FileThreeFileServerPath, expandpath('/TempFileUploadPath/DebtProtest') & "/" & variables.ImageFileName[iwNum] & variables.imgFileCount & "." & file.ServerFileExt)>
                </cfloop>
                <cfset variables.imgFileCount = variables.imgFileCount + 1>
            <cfelse>
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                    <cfset ArrayAppend(variables.FileThreeFileServerPath, expandpath('/TempFileUploadPath/DebtProtest') & "/" & variables.iwNumberArray[iwNum] & "_" & variables.UniqueId & ReReplace(form.lastName, "[^a-zA-Z0-9]", "", "ALL") & "_DOCUMENT" & variables.DocumnetFileCount & "." & file.ServerFileExt)>
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
                    <cfset ArrayAppend(variables.FileFourFileServerPath, expandpath('/TempFileUploadPath/DebtProtest') & "/" & variables.ImageFileName[iwNum] & variables.imgFileCount & "." & file.ServerFileExt)>
                </cfloop>
                <cfset variables.imgFileCount = variables.imgFileCount + 1>
            <cfelse>
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                    <cfset ArrayAppend(variables.FileFourFileServerPath, expandpath('/TempFileUploadPath/DebtProtest') & "/" & variables.iwNumberArray[iwNum] & "_" & variables.UniqueId & ReReplace(form.lastName, "[^a-zA-Z0-9]", "", "ALL") & "_DOCUMENT" & variables.DocumnetFileCount & "." & file.ServerFileExt)>
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
                    <cfset ArrayAppend(variables.FileFiveFileServerPath, expandpath('/TempFileUploadPath/DebtProtest') & "/" & variables.ImageFileName[iwNum] & variables.imgFileCount & "." & file.ServerFileExt)>
                </cfloop>
                <cfset variables.imgFileCount = variables.imgFileCount + 1>
            <cfelse>
                <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                    <cfset ArrayAppend(variables.FileFiveFileServerPath, expandpath('/TempFileUploadPath/DebtProtest') & "/" & variables.iwNumberArray[iwNum] & "_" & variables.UniqueId & ReReplace(form.lastName, "[^a-zA-Z0-9]", "", "ALL") & "_DOCUMENT" & variables.DocumnetFileCount & "." & file.ServerFileExt)>
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
                <cfpdf action="merge" destination="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.MultiPDFFileName[iwNum]#">
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
                <cfpdf action="merge" destination="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.SinglePDFFileName[iwNum]#">
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

        <cfif form.reasonstoProtest EQ "1" || form.reasonstoProtest EQ "2" || form.reasonstoProtest EQ "7">
            <cfquery name="qSP" datasource="#application.GeneralDSN#">
                INSERT INTO dbo.tblDebtProtest
                ([ProtestId],[ProtestDesc],[FirstName],[MiddleName],[LastName],[SSNFEIN],[PhoneNumber],[IWNumber],[IWNumber2],[IWNumber3],[IWNumber4],[IWNumber5],[CurrentStreeAddress],[CurrentStreeAddress2],[City],[State],[ZipCode],[DateofBirth],[DriversLicenseOrStaeId],[Document1],[Document2],[Document3],[Document4],[Document5],[Signature],[Comments],[RecordInsertedDate],[RecordInsertedBy])

                VALUES (
                <cfqueryparam value="#form.reasonstoProtest#" cfsqltype="CF_SQL_INTEGER">,
                <cfqueryparam value="#variables.protestDesc[form.reasonstoProtest]#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.Firstname#" cfsqltype="cf_sql_varchar">,
                <cfif isDefined("form.MiddleName") && form.MiddleName NEQ "">
                    <cfqueryparam value="#form.MiddleName#" cfsqltype="cf_sql_varchar">,
                <cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
                </cfif>
                <cfqueryparam value="#form.Lastname#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.ssn#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.phonenumber#" cfsqltype="cf_sql_varchar">,
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
                <cfqueryparam value="#form.dob#" cfsqltype="cf_sql_date">,
                <cfqueryparam value="#form.dlsid#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(form.dlsid))#">,
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
                <p>Reason for protest : #variables.protestDesc[form.reasonstoProtest]#</p>
                <p>First Name : #form.Firstname#</p>
                    <cfif form.MiddleName NEQ "">
                            <p>Middle Initial : #form.MiddleName#</p>
                    </cfif>
                    <p>Last Name : #form.Lastname#</p>
                <p>Phone Number : #form.phonenumber#</p>
                <p>Social Security Number (SSN) / FEIN Number : #form.ssn#</p>
                <p>Date of Birth: #form.dob#</p>
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
                    <cfif form.dlsid NEQ "">
                            <p>Driver's license/State I.D./Other I.D. : #form.dlsid#</p>
                    </cfif>
                        <p>
                        <cfset variables.TotalFileCount = (variables.imgFileCount - 1) + variables.pdfFileCount>
                            Attachments : <cfif variables.TotalFileCount EQ 0> <em>None</em>
                    <cfelse><em>#variables.TotalFileCount#</em></cfif>
                        </p>
                    <cfif form.comments NEQ "">
                            <p>Reason for Protest : #variables.CleanComments#</p>
                    </cfif>
                        <p> In submitting this protest, I declare that I have reviewed the information I have submitted,
                            that it is true to the best of my knowledge, and that I understand that it will be used to
                            adjudicate my protest.</p>
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
                        subject="New DebtProtest Form Submission - #variables.protestDesc[form.reasonstoProtest]#"
                        type="html">

                    <p>Dear Admin,</p>

                    <p>
                        A Debt Protest form has been submitted to the Illinois Comptroller's Office. The details are
                        below.
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
<!--- <tr><td>
    Document :</td><td> #variables.MultiPDFFileName[iwNum]# <em> See attached file</em>
</td></tr> --->
<!--- Attach the file. --->
                        <cfmailparam file="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.MultiPDFFileName[iwNum]#"/>

                        <cfelseif variables.pdfFileCount EQ 1>
<!--- <tr><td>
    Document :</td><td> #variables.SinglePDFFileName[iwNum]# <em> See attached file</em>
</td></tr> --->
<!--- Attach the file. --->
                        <cfmailparam file="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.SinglePDFFileName[iwNum]#"/>
                    </CFIF>
                    <cfmailparam file="#variables.WebFormAttachmentFileName[iwNum]#" content="#TempName#">
                </cfmail>
            </cfloop>
        </cfif>
        <cfif form.reasonstoProtest EQ "3">
            <cfquery name="qSP" datasource="#application.GeneralDSN#">
                INSERT INTO dbo.tblDebtProtest
                ([ProtestId],[ProtestDesc],[FirstName],[MiddleName],[LastName],[SSNFEIN],[PhoneNumber],[IWNumber],[IWNumber2],[IWNumber3],[IWNumber4],[IWNumber5],[CurrentStreeAddress],[CurrentStreeAddress2],[City],[State],[ZipCode],[DateofBirth],[DriversLicenseOrStaeId],[TicketNumber],[PaymentDate],[Document1],[Document2],[Document3],[Document4],[Document5],[Signature],[Comments],[RecordInsertedDate],[RecordInsertedBy])

                VALUES (
                <cfqueryparam value="#form.reasonstoProtest#" cfsqltype="CF_SQL_INTEGER">,
                <cfqueryparam value="#variables.protestDesc[form.reasonstoProtest]#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.Firstname#" cfsqltype="cf_sql_varchar">,
                <cfif isDefined("form.MiddleName") && form.MiddleName NEQ "">
                    <cfqueryparam value="#form.MiddleName#" cfsqltype="cf_sql_varchar">,
                <cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
                </cfif>
                <cfqueryparam value="#form.Lastname#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.ssn#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.phonenumber#" cfsqltype="cf_sql_varchar">,
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
                <cfqueryparam value="#form.dob#" cfsqltype="cf_sql_date">,
                <cfqueryparam value="#form.dlsid#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(form.dlsid))#">,
                <cfqueryparam value="#form.tickNumber#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.pdate#" cfsqltype="cf_sql_date">,
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
            <cfsavecontent variable="sectionThreeContent">
                <cfoutput>
                    <div>
                    <p>Today's date : #DateFormat(Now(), "mm/dd/yyyy")# - #TimeFormat(now(), "HH:MM:SS")#</p>
                <p>Reason for protest : #variables.protestDesc[form.reasonstoProtest]#</p>
                <p>First Name : #form.Firstname#</p>
                    <cfif form.MiddleName NEQ "">
                            <p>Middle Initial : #form.MiddleName#</p>
                    </cfif>
                    <p>Last Name : #form.Lastname#</p>
                <p>Phone Number : #form.phonenumber#</p>
                <p>Social Security Number (SSN) / FEIN Number : #form.ssn#</p>
                <p>Date of Birth : #form.dob#</p>
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
                    <cfif form.dlsid NEQ "">
                            <p>Driver's license/State I.D./Other I.D. : #form.dlsid#</p>
                    </cfif>
                    <p>Ticket Number : #form.tickNumber#</p>
                <p>Payment Date : #form.pdate#</p>
                <p>
                    <cfset variables.TotalFileCount = (variables.imgFileCount - 1) + variables.pdfFileCount>
                        Attachments : <cfif variables.TotalFileCount EQ 0> <em>None</em>
                <cfelse><em>#variables.TotalFileCount#</em></cfif>
                    </p>
                    <cfif form.comments NEQ "">
                            <p>Reason for Protest :</p>
                            <p> #variables.CleanComments#</p>
                    </cfif>
                        <p>In submitting this protest, I declare that I have reviewed the information I have submitted,
                            that it is true to the best of my knowledge, and that I understand that it will be used to
                            adjudicate my protest.</p>
                    </div>
                </cfoutput>
            </cfsavecontent>
            <cfloop index="iwNum" from="1" to="#arraylen(variables.WebFormFileName)#">
                <cfset TempName = variables.WebFormFileName[iwNum]>
                <cfdocument format="PDF" name="TempName">
                    <cfoutput>#sectionThreeContent#</cfoutput></cfdocument>
                <cfmail
                        to="#variables.ToEmailAddress#"
                        from="DoNotReply@IllinoisComptroller.Gov"
                        subject="New DebtProtest Form Submission - #variables.protestDesc[form.reasonstoProtest]#"
                        type="html">

                    <p>Dear Admin,</p>

                    <p>
                        A Debt Protest form has been submitted to the Illinois Comptroller's Office. The details are
                        below.
                    </p>

                    #sectionThreeContent#
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
<!--- <tr><td>
    Document :</td><td> #variables.MultiPDFFileName[iwNum]# <em> See attached file</em>
</td></tr> --->
<!--- Attach the file. --->
                        <cfmailparam file="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.MultiPDFFileName[iwNum]#"/>

                        <cfelseif variables.pdfFileCount EQ 1>
<!--- <tr><td>
    Document :</td><td> #variables.SinglePDFFileName[iwNum]# <em> See attached file</em>
</td></tr> --->
<!--- Attach the file. --->
                        <cfmailparam file="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.SinglePDFFileName[iwNum]#"/>
                    </CFIF>
                    <cfmailparam file="#variables.WebFormAttachmentFileName[iwNum]#" content="#TempName#">
                </cfmail>
            </cfloop>
        </cfif>
        <cfif form.reasonstoProtest EQ "4">
            <cfquery name="qSP" datasource="#application.GeneralDSN#">
                INSERT INTO dbo.tblDebtProtest
                ([ProtestId],[ProtestDesc],[FirstName],[MiddleName],[LastName],[SSNFEIN],[PhoneNumber],[IWNumber],[IWNumber2],[IWNumber3],[IWNumber4],[IWNumber5],[CurrentStreeAddress],[CurrentStreeAddress2],[City],[State],[ZipCode],[DateofBirth],[DriversLicenseOrStaeId],[FormerStreeAddress],[FormerStreeAddress2],[FormerCity],[FormerSate],[FormerZipCode],[Document1],[Document2],[Document3],[Document4],[Document5],[Signature],[Comments],[RecordInsertedDate],[RecordInsertedBy])
                VALUES (
                <cfqueryparam value="#form.reasonstoProtest#" cfsqltype="CF_SQL_INTEGER">,
                <cfqueryparam value="#variables.protestDesc[form.reasonstoProtest]#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.Firstname#" cfsqltype="cf_sql_varchar">,
                <cfif isDefined("form.MiddleName") && form.MiddleName NEQ "">
                    <cfqueryparam value="#form.MiddleName#" cfsqltype="cf_sql_varchar">,
                <cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
                </cfif>
                <cfqueryparam value="#form.Lastname#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.ssn#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.phonenumber#" cfsqltype="cf_sql_varchar">,
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
                <cfqueryparam value="#form.dob#" cfsqltype="cf_sql_date">,
                <cfqueryparam value="#form.dlsid#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(form.dlsid))#">,
                <cfqueryparam value="#form.fStreetaddress#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.fStreetaddress2#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(form.fStreetaddress2))#">,
                <cfqueryparam value="#form.fCity#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.fState#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.fZip#" cfsqltype="cf_sql_varchar">,
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
            <cfsavecontent variable="sectionFourContent">
                <cfoutput>
                    <div>
                    <p>Today's date : #DateFormat(Now(), "mm/dd/yyyy")# - #TimeFormat(now(), "HH:MM:SS")#</p>
                <p>Reason for protest : #variables.protestDesc[form.reasonstoProtest]#</p>
                <p>First Name : #form.Firstname#</p>
                    <cfif form.MiddleName NEQ "">
                            <p>Middle Initial : #form.MiddleName#</p>
                    </cfif>
                    <p>Last Name : #form.Lastname#</p>
                <p>Phone Number : #form.phonenumber#</p>
                <p>Social Security Number (SSN) / FEIN Number : #form.ssn#</p>
                <p>Date of Birth : #form.dob#</p>
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
                    <cfif form.dlsid NEQ "">
                            <p>Driver's license/State I.D./Other I.D. : #form.dlsid#</p>
                    </cfif>
                        <p>Former Address : #form.fStreetaddress#</p>
                    <cfif form.fStreetaddress2 NEQ "">
                            <p>Former Street Address 2 : #form.fStreetaddress2#</p>
                    </cfif>
                    <p>Former City : #form.fCity#</p>
                <p>Former State : #form.fState#</p>
                <p>Former ZIP code : #form.fZip#</p>
                <p>
                    <cfset variables.TotalFileCount = (variables.imgFileCount - 1) + variables.pdfFileCount>
                        Attachments : <cfif variables.TotalFileCount EQ 0> <em>None</em>
                <cfelse><em>#variables.TotalFileCount#</em></cfif>
                    </p>
                    <cfif form.comments NEQ "">
                            <p>Reason for Protest :</p>
                            <p> #variables.CleanComments#</p>
                    </cfif>
                        <p>In submitting this protest, I declare that I have reviewed the information I have submitted,
                            that it is true to the best of my knowledge, and that I understand that it will be used to
                            adjudicate my protest.</p>
                    </div>
                </cfoutput>
            </cfsavecontent>
            <cfloop index="iwNum" from="1" to="#arraylen(variables.WebFormFileName)#">
                <cfset TempName = variables.WebFormFileName[iwNum]>
                <cfdocument format="PDF" name="TempName">
                    <cfoutput>#sectionFourContent#</cfoutput></cfdocument>
                <cfmail
                        to="#variables.ToEmailAddress#"
                        from="DoNotReply@IllinoisComptroller.Gov"
                        subject="New DebtProtest Form Submission - #variables.protestDesc[form.reasonstoProtest]#"
                        type="html">

                    <p>Dear Admin,</p>
                    <p>
                        A Debt Protest form has been submitted to the Illinois Comptroller's Office. The details are
                        below.
                    </p>

                    #sectionFourContent#
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
<!--- <tr><td>
    Document :</td><td> #variables.MultiPDFFileName[iwNum]# <em> See attached file</em>
</td></tr> --->
<!--- Attach the file. --->
                        <cfmailparam file="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.MultiPDFFileName[iwNum]#"/>

                        <cfelseif variables.pdfFileCount EQ 1>
<!--- <tr><td>
    Document :</td><td> #variables.SinglePDFFileName[iwNum]# <em> See attached file</em>
</td></tr> --->
<!--- Attach the file. --->
                        <cfmailparam file="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.SinglePDFFileName[iwNum]#"/>
                    </CFIF>
                    <cfmailparam file="#variables.WebFormAttachmentFileName[iwNum]#" content="#TempName#">
                </cfmail>
            </cfloop>
        </cfif>
        <cfif form.reasonstoProtest EQ "5">
            <cfquery name="qSP" datasource="#application.GeneralDSN#">
                INSERT INTO dbo.tblDebtProtest
                ([ProtestId],[ProtestDesc],[FirstName],[MiddleName],[LastName],[SSNFEIN],[PhoneNumber],[IWNumber],[IWNumber2],[IWNumber3],[IWNumber4],[IWNumber5],[DateofBirth],[DateofDeath],[Executer],[Document1],[Document2],[Document3],[Document4],[Document5],[Signature],[Comments],[RecordInsertedDate],[RecordInsertedBy])

                VALUES (
                <cfqueryparam value="#form.reasonstoProtest#" cfsqltype="CF_SQL_INTEGER">,
                <cfqueryparam value="#variables.protestDesc[form.reasonstoProtest]#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.Firstname#" cfsqltype="cf_sql_varchar">,
                <cfif isDefined("form.MiddleName") && form.MiddleName NEQ "">
                    <cfqueryparam value="#form.MiddleName#" cfsqltype="cf_sql_varchar">,
                <cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
                </cfif>
                <cfqueryparam value="#form.Lastname#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.ssn#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.phonenumber#" cfsqltype="cf_sql_varchar">,
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
                <cfqueryparam value="#form.dob#" cfsqltype="cf_sql_date">,
                <cfqueryparam value="#form.dod#" cfsqltype="cf_sql_date">,
                <cfqueryparam value="#form.executer#" cfsqltype="cf_sql_varchar">,
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
            <cfsavecontent variable="sectionFiveContent">
                <cfoutput>
                    <div>
                    <p>Today's date : #DateFormat(Now(), "mm/dd/yyyy")# - #TimeFormat(now(), "HH:MM:SS")#</p>
                <p>Reason for protest : #variables.protestDesc[form.reasonstoProtest]#</p>
                <p>First Name : #form.Firstname#</p>
                    <cfif form.MiddleName NEQ "">
                            <p>Middle Initial : #form.MiddleName#</p>
                    </cfif>
                    <p>Last Name : #form.Lastname#</p>
                <p>Phone Number : #form.phonenumber#</p>
                <p>Social Security Number (SSN) / FEIN Number : #form.ssn#</p>
                <p>Date of Birth : #form.dob#</p>

                    <cfloop index="iwNum" from="1" to="#arraylen(variables.iwNumberArray)#">
                            <p>IW Number#iwNum# : #variables.iwNumberArray[iwNum]#</p>
                    </cfloop>
                    <p>Date of Death : #form.dod#</p>
                <p>Executer : #form.executer#</p>
                <p>
                    <cfset variables.TotalFileCount = (variables.imgFileCount - 1) + variables.pdfFileCount>
                        Attachments : <cfif variables.TotalFileCount EQ 0> <em>None</em>
                <cfelse><em>#variables.TotalFileCount#</em></cfif>
                    </p>
                    <cfif form.comments NEQ "">
                            <p>Reason for Protest : #variables.CleanComments#</p>
                    </cfif>
                        <p>In submitting this protest, I declare that I have reviewed the information I have submitted,
                            that it is true to the best of my knowledge, and that I understand that it will be used to
                            adjudicate my protest.</p>
                    </div>
                </cfoutput>
            </cfsavecontent>
            <cfloop index="iwNum" from="1" to="#arraylen(variables.WebFormFileName)#">
                <cfset TempName = variables.WebFormFileName[iwNum]>
                <cfdocument format="PDF" name="TempName">
                    <cfoutput>#sectionFiveContent#</cfoutput></cfdocument>
                <cfmail
                        to="#variables.ToEmailAddress#"
                        from="DoNotReply@IllinoisComptroller.Gov"
                        subject="New DebtProtest Form Submission - #variables.protestDesc[form.reasonstoProtest]#"
                        type="html">

                    <p>Dear Admin,</p>
                    <p>
                        A Debt Protest form has been submitted to the Illinois Comptroller's Office. The details are
                        below.
                    </p>

                    #sectionFiveContent#
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
<!--- <tr><td>
    Document :</td><td> #variables.MultiPDFFileName[iwNum]# <em> See attached file</em>
</td></tr> --->
<!--- Attach the file. --->
                        <cfmailparam file="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.MultiPDFFileName[iwNum]#"/>

                        <cfelseif variables.pdfFileCount EQ 1>
<!--- <tr><td>
    Document :</td><td> #variables.SinglePDFFileName[iwNum]# <em> See attached file</em>
</td></tr> --->
<!--- Attach the file. --->
                        <cfmailparam file="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.SinglePDFFileName[iwNum]#"/>
                    </CFIF>
                    <cfmailparam file="#variables.WebFormAttachmentFileName[iwNum]#" content="#TempName#">
                </cfmail>
            </cfloop>
        </cfif>
        <cfif form.reasonstoProtest EQ "6">
            <cfquery name="qSP" datasource="#application.GeneralDSN#">
                INSERT INTO dbo.tblDebtProtest
                ([ProtestId],[ProtestDesc],[FirstName],[MiddleName],[LastName],[SSNFEIN],[PhoneNumber],[IWNumber],[IWNumber2],[IWNumber3],[IWNumber4],[IWNumber5],[CurrentStreeAddress],[CurrentStreeAddress2],[City],[State],[ZipCode],[DateofBirth],[DriversLicenseOrStaeId],[BankruptcyCaseNumber],[Document1],[Document2],[Document3],[Document4],[Document5],[Signature],[Comments],[RecordInsertedDate],[RecordInsertedBy])

                VALUES (
                <cfqueryparam value="#form.reasonstoProtest#" cfsqltype="CF_SQL_INTEGER">,
                <cfqueryparam value="#variables.protestDesc[form.reasonstoProtest]#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.Firstname#" cfsqltype="cf_sql_varchar">,
                <cfif isDefined("form.MiddleName") && form.MiddleName NEQ "">
                    <cfqueryparam value="#form.MiddleName#" cfsqltype="cf_sql_varchar">,
                <cfelse>
                    <cfqueryparam cfsqltype="cf_sql_varchar" null="yes">,
                </cfif>
                <cfqueryparam value="#form.Lastname#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.ssn#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.phonenumber#" cfsqltype="cf_sql_varchar">,
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
                <cfqueryparam value="#form.dob#" cfsqltype="cf_sql_date">,
                <cfqueryparam value="#form.dlsid#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(form.dlsid))#">,
                <cfqueryparam value="#form.bcaseNum#" cfsqltype="cf_sql_varchar">,
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
            <cfsavecontent variable="sectionSixContent">
                <cfoutput>
                    <div>
                    <p>Today's date : #DateFormat(Now(), "mm/dd/yyyy")# - #TimeFormat(now(), "HH:MM:SS")#</p>
                <p>Reason for protest : #variables.protestDesc[form.reasonstoProtest]#</p>
                <p>First Name : #form.Firstname#</p>
                    <cfif form.MiddleName NEQ "">
                            <p>Middle Initial : #form.MiddleName#</p>
                    </cfif>
                    <p>Last Name : #form.Lastname#</p>
                <p>Phone Number : #form.phonenumber#</p>
                <p>Social Security Number (SSN) / FEIN Number : #form.ssn#</p>
                <p>Date of Birth : #form.dob#</p>
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
                    <cfif form.dlsid NEQ "">
                            <p>Driver's license/State I.D./Other I.D. : #form.dlsid#</p>
                    </cfif>
                    <p>Bankruptcy Case Number : #form.bcaseNum#</p>
                <p>
                    <cfset variables.TotalFileCount = (variables.imgFileCount - 1) + variables.pdfFileCount>
                        Attachments : <cfif variables.TotalFileCount EQ 0> <em>None</em>
                <cfelse><em>#variables.TotalFileCount#</em></cfif>
                    </p>
                    <cfif form.comments NEQ "">
                            <p>Reason for Protest : #variables.CleanComments#</p>
                    </cfif>
                        <p>In submitting this protest, I declare that I have reviewed the information I have submitted,
                            that it is true to the best of my knowledge, and that I understand that it will be used to
                            adjudicate my protest.</p>
                    </div>
                </cfoutput>
            </cfsavecontent>
            <cfloop index="iwNum" from="1" to="#arraylen(variables.WebFormFileName)#">
                <cfset TempName = variables.WebFormFileName[iwNum]>
                <cfdocument format="PDF" name="TempName">
                    <cfoutput>#sectionSixContent#</cfoutput></cfdocument>
                <cfmail
                        to="#variables.ToEmailAddress#"
                        from="DoNotReply@IllinoisComptroller.Gov"
                        subject="New DebtProtest Form Submission - #variables.protestDesc[form.reasonstoProtest]#"
                        type="html">

                    <p>Dear Admin,</p>
                    <p>
                        A Debt Protest form has been submitted to the Illinois Comptroller's Office. The details are
                        below.
                    </p>

                    #sectionSixContent#
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
<!--- <tr><td>
    Document :</td><td> #variables.MultiPDFFileName[iwNum]# <em> See attached file</em>
</td></tr> --->
<!--- Attach the file. --->
                        <cfmailparam file="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.MultiPDFFileName[iwNum]#"/>

                        <cfelseif variables.pdfFileCount EQ 1>
<!--- <tr><td>
    Document :</td><td> #variables.SinglePDFFileName[iwNum]# <em> See attached file</em>
</td></tr> --->
<!--- Attach the file. --->
                        <cfmailparam file="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.SinglePDFFileName[iwNum]#"/>
                    </CFIF>
                    <cfmailparam file="#variables.WebFormAttachmentFileName[iwNum]#" content="#TempName#">
                </cfmail>
            </cfloop>
        </cfif>
        <cfif form.reasonstoProtest EQ "8">
            <cfquery name="qSP" datasource="#application.GeneralDSN#">
                INSERT INTO dbo.tblDebtProtest
                ([ProtestId],[ProtestDesc],[BusinessName],[SSNFEIN],[PhoneNumber],[IWNumber],[IWNumber2],[IWNumber3],[IWNumber4],[IWNumber5],[CurrentStreeAddress],[CurrentStreeAddress2],[City],[State],[ZipCode],[DateofBirth],[DriversLicenseOrStaeId],[Document1],[Document2],[Document3],[Document4],[Document5],[Signature],[Comments],[RecordInsertedDate],[RecordInsertedBy])

                VALUES (
                <cfqueryparam value="#form.reasonstoProtest#" cfsqltype="CF_SQL_INTEGER">,
                <cfqueryparam value="#variables.protestDesc[form.reasonstoProtest]#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.businessName#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.ssn#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#form.phonenumber#" cfsqltype="cf_sql_varchar">,
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
                <cfqueryparam value="#form.dob#" cfsqltype="cf_sql_date">,
                <cfqueryparam value="#form.dlsid#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(form.dlsid))#">,
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
                <p>Reason for protest : #variables.protestDesc[form.reasonstoProtest]#</p>
                <p>Business Name : #form.businessName#</p>
                <p>Phone Number : #form.phonenumber#</p>
                <p>Social Security Number (SSN) / FEIN Number : #form.ssn#</p>
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
                    <cfif form.dlsid NEQ "">
                            <p>Driver's license/State I.D./Other I.D. : #form.dlsid#</p>
                    </cfif>
                        <p>
                        <cfset variables.TotalFileCount = (variables.imgFileCount - 1) + variables.pdfFileCount>
                            Attachments : <cfif variables.TotalFileCount EQ 0> <em>None</em>
                    <cfelse><em>#variables.TotalFileCount#</em></cfif>
                        </p>
                    <cfif form.comments NEQ "">
                            <p>Reason for Protest : #variables.CleanComments#</p>
                    </cfif>
                        <p>In submitting this protest, I declare that I have reviewed the information I have submitted,
                            that it is true to the best of my knowledge, and that I understand that it will be used to
                            adjudicate my protest.</p>
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
                        subject="New DebtProtest Form Submission - #variables.protestDesc[form.reasonstoProtest]#"
                        type="html">

                    <p>Dear Admin,</p>

                    <p>
                        A Debt Protest form has been submitted to the Illinois Comptroller's Office. The details are
                        below.
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
<!--- <tr><td>
    Document :</td><td> #variables.MultiPDFFileName[iwNum]# <em> See attached file</em>
</td></tr> --->
<!--- Attach the file. --->
                        <cfmailparam file="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.MultiPDFFileName[iwNum]#"/>

                        <cfelseif variables.pdfFileCount EQ 1>
<!--- <tr><td>
    Document :</td><td> #variables.SinglePDFFileName[iwNum]# <em> See attached file</em>
</td></tr> --->
<!--- Attach the file. --->
                        <cfmailparam file="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.SinglePDFFileName[iwNum]#"/>
                    </CFIF>
                    <cfmailparam file="#variables.WebFormAttachmentFileName[iwNum]#" content="#TempName#">
                </cfmail>
            </cfloop>
        </cfif>
    </cfif>
</cfif>

<!--- Delete Multi / Single File --->
<!--- <cfif variables.pdfFileCount GTE 2>
    <cffile action="delete" file="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.MultiPDFFileName#">
<cfelseif variables.pdfFileCount EQ 1>
    <cffile action="delete" file="#expandpath('/TempFileUploadPath/DebtProtest')#/#variables.SinglePDFFileName#">
</cfif> --->

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
                    <a class="btn btn-danger" href="/debtprotest/debtprotestform/" data-toggle="tooltip"
                       data-placement="right" title="Return to Select your reason for protest"> Return </a>
                </p>
            <div>
                <h3 class="text-center">LOCAL DEBT RECOVERY PROTEST ONLINE RECEIPT</h3><br/>
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
            <p> Thank you for submitting your protest online. Please note, your protest will be processed within one (1)
                business day and in the order it was received. If you have submitted the protest after 4:30 P.M. (CST)
                it will be processed the following business day. If the debt is found to be invalid, the amount withheld
                will be returned to you within approximately ten (10) business days from the decision date. If the debt
                is found to be valid, it will be sent to the local governmental entity(ies). You will be informed of the
                decision by mail.</p><br/>
            <p>If you have any questions, please contact our office during business hours, Monday through Friday 8:30
                a.m. to 4:30 p.m. at (855) 881-2301.</p><br/>
            <p>Please print this receipt for your records.</p><br/><br/>
            <p>State of Illinois Comptroller</p>
            <p>Local Debt Recovery Program</p>
        </div>

        </div>
        </cfoutput>
    </cfif>
</cfif>
<cfif variables.dispForm EQ "0">
    <h2>Online Protest Form</h2>
    <div>
        <p id="InformationSection">Select the reason for your protest below and click on the continue button to file
            your protest with our office. Note that you must complete all the required fields<span
                    class="red"> (*) </span> in order for your protest to be processed. Once you complete the form and
            have attached any additional supporting document(s) that you may have, you may submit the form. Please have
            the document(s) prepared before you fill out this form if you plan to attach them.</p>
        <p>The information you submit will only be used to adjudicate your protest. Carefully review the form before
            submitting it to ensure that all of the information requested, including supporting documentation is
            correct.</p>
        <p>Protest are public records, which are subject to the Freedom of Information Act (FOIA) just like other public
            records. If we receive a request for copies of protest and supporting document(s) that include your protest,
            we may be required to provide a copy of your protest to the requestor. However, information that would
            reveal your identity as a protestor is exempt from disclosure and will be redacted from copies that we
            provide, allowing the requestor to read your protest without compromising your privacy.</p>
    </div>

    <div id="messageHolderTop" class="hide"></div>
<!--- The order is not same as value because this is last minute change and developer is not sure if this is final change --->
    <cfform id="OnlineForm" name="OnlineForm" enctype="multipart/form-data" method="post">
        <div class="row margintop">
            <div class="col-xs-12 col-md-8">
                <div class="form-group reasonstoProtest-container">
                <label for="reasonstoProtest">Select your reason for protest</label>
            <select name="reasonstoProtest" id="reasonstoProtest" class="form-control custom-select">
                    <option
            <cfif IsDefined("form.reasonstoProtest") and form.reasonstoProtest EQ "0">selected</cfif>
            value="0">-- Select any option --</option>
                    <option
            <cfif IsDefined("form.reasonstoProtest") and form.reasonstoProtest EQ "2">selected</cfif>
            value="2">Wrong Person/Jr.Sr./Twins/Siblings/Divorced </option>
                    <option
            <cfif IsDefined("form.reasonstoProtest") and form.reasonstoProtest EQ "6">selected</cfif>
            value="6">Bankruptcy</option>
                    <option
            <cfif IsDefined("form.reasonstoProtest") and form.reasonstoProtest EQ "3">selected</cfif>
            value="3">Paid/Settled/Payment Plan/Dismissed</option>
                    <option
            <cfif IsDefined("form.reasonstoProtest") and form.reasonstoProtest EQ "4">selected</cfif>
            value="4">Improper Notice/Old Address/Never Received Notice</option>
                    <option
            <cfif IsDefined("form.reasonstoProtest") and form.reasonstoProtest EQ "1">selected</cfif>
            value="1">Did Not Possess or Own Property</option>
                    <option
            <cfif IsDefined("form.reasonstoProtest") and form.reasonstoProtest EQ "5">selected</cfif>
            value="5">Deceased</option>
                    <option
            <cfif IsDefined("form.reasonstoProtest") and form.reasonstoProtest EQ "8">selected</cfif>
            value="8">Business</option>
                    <option
            <cfif IsDefined("form.reasonstoProtest") and form.reasonstoProtest EQ "7">selected</cfif>
            value="7">Other</option>
            </select>
            </div>
            </div>
            <div class="col-xs-12 col-md-4 nxtBtn-container">
                <div class="form-group padt24 text-center">
                    <button type="button" id="nxtBtn" class="btn btn-success form-btn">Click here to Continue</button>
                </div>
            </div>
        </div>
        <div class="clearfix">
            <div id="infomationMsg1" class="alert alert-info hide"><p>
                Select <strong>"Did Not Possess or Own Property"</strong> option if you were not in possession or did
                not own the property at the time of the violation. <br/>
                To help with the processing of your claim, you may submit a copy of your Driver's License, State ID
                Card, Passport, or other picture identification with signature and date of birth, property deed, court
                order or proof of sale, and anything else that supports your protest, up to a maximum of five documents.
            </p>
            </div>
            <div id="infomationMsg2" class="alert alert-info hide"><p>
                Select <strong>"Wrong Person or Jr./Sr. or Twins or Siblings or Divorced"</strong> option if you are not
                the correct person responsible for the debt.<br/>
                To help with the processing of your claim, you may submit a copy of your Driver's License, State ID
                Card, Passport, or other picture identification with signature and date of birth, divorce decree, and
                anything else that supports your protest, up to a maximum of five documents.
            </p>
            </div>
            <div id="infomationMsg3" class="alert alert-info hide"><p>
                Select <strong>"Paid or Settled or Payment Plan or Dismissed"</strong> option if you paid the debt in
                full, settled the debt, entered into a payment plan, or the debt was dismissed. <br/>
                To help with the processing of your claim, you may submit a copy of your Driver's License, State ID
                Card, Passport, or other picture identification with signature and date of birth, receipt or proof of
                payment, settlement agreement, payment plan, dismissal order or proof, and anything else that supports
                your protest, up to a maximum of five documents.
            </p>
            </div>
            <div id="infomationMsg4" class="alert alert-info hide"><p>
                Select <strong>"Improper Notice or Old Address or Never Received Notice"</strong> option if you did not
                receive notification of the debt or the notification went to an old address. <br/>
                To help with the processing of your claim, you may submit a copy of your Driver's License, State ID
                Card, Passport, or other picture identification with signature and date of birth, two forms of proof of
                old address (such as mortgage, lease, or utility bill), and anything else that supports your protest, up
                to a maximum of five documents.
            </p>
            </div>
            <div id="infomationMsg5" class="alert alert-info hide"><p>
                Select <strong>"Deceased"</strong> option if the person responsible for the debt is deceased. <br/>
                To help with the processing of your claim, you may submit a copy of your Driver's license of Executor,
                death certificate or obituary, and anything else that supports your protest, up to a maximum of five
                documents.
            </p>
            </div>
            <div id="infomationMsg6" class="alert alert-info hide"><p>
                Select <strong>"Bankruptcy"</strong> option if you are currently in bankruptcy, or if your previous
                bankruptcy discharged the debt. <br/>
                To help with the processing of your claim, you may submit a copy of your Driver's License, State ID
                Card, Passport, or other picture identification with signature and date of birth, filing petition or
                discharge order, and anything else that supports your protest, up to a maximum of five documents.
            </p>
            </div>
            <div id="infomationMsg7" class="alert alert-info hide"><p>
                Select <strong>"Other"</strong> option if the other options do not adequately identify your protest
                response. Please explain, in detail, your response in the space provided below. <br/>
                To help with the processing of your claim, you may submit a copy of your Driver's License, State ID
                Card, Passport, or other picture identification with signature and date of birth, and anything else that
                supports your protest, up to a maximum of five documents.
            </p>
            </div>
            <div id="infomationMsg8" class="alert alert-info hide"><p>
                Select <strong>"Business"</strong> option if you are not the correct Business responsible for the
                debt.<br/>
                To help with the processing of your claim, you may submit a copy of your Driver's License, State ID
                Card, Passport, or other picture identification with signature and date of birth, and anything else that
                supports your protest, up to a maximum of five documents.
            </p>
            </div>
        </div>
        <div class="row">
        <cfquery name="stateList" datasource="#application.GeneralDSN#">
                SELECT [State]
                ,[ShortName]
                FROM [dbo].[States]
                WHERE [countryID] = 1
                ORDER BY [State]
        </cfquery>
        <div class="col-xs-12 col-sm-12 businessName-colClass">
        <div class="form-group businessName-container hide">
            <label for="businessName">Business Name</label>
                <input id="businessName" name="businessName" class="form-control" type="text"
                       placeholder="Business Name"
        <cfif IsDefined("form.businessName")>
            <cfoutput>value="#form.businessName#"</cfoutput>
        <cfelse>value=""</cfif> data-required="true" maxlength="80">
    </div>
    </div>
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

    <div class="col-xs-6 col-sm-6">
        <div class="form-group">
        <label for="ssn" class="ssn-label-container hide">Social Security Number (SSN)/FEIN Number (Last 4 digits)<span
                class="red">&nbsp;*</span></label>
    <div class="input-group ssn-container hide">
            <input name="ssn" type="password" maxlength="4" id="ssn" data-required="true" class="form-control numeric"
                   autocomplete="off" placeholder="Last Four Digits of SSN/FEIN Number"
        <cfif IsDefined("form.ssn")>
            <cfoutput>value="#form.ssn#"</cfoutput></cfif>>
        <label class="input-group-addon">
            <input type="checkbox" style="display:none" onclick="(function(e, el){
			                                 document.getElementById('ssn').type = el.checked ? 'text' : 'password';
			                                  el.parentNode.lastElementChild.innerHTML = el.checked ? '<i class=\'glyphicon glyphicon-eye-close\'>' : '<i class=\'glyphicon glyphicon-eye-open\'>';
			                                  })(event, this)">
            <span><i class="glyphicon glyphicon-eye-open"></i></span>
        </label>
    </div>
    </div>
    </div>
    <div class="col-xs-6 col-sm-6">
    <div class="form-group dob-container hide">
        <label for="dob">Date of Birth</label>
            <input class="form-control" placeholder="mm/dd/yyyy" name="dob" id="dob"
                   <cfif IsDefined("form.dob")>value="<cfoutput>#form.dob#</cfoutput>"</cfif>
                   type="text" maxlength="10">
                   </div>
                   </div>

                   <div class="col-xs-12 col-sm-12 col-md-6">
                   <div class="form-group iwNumber-container hide">
                       <label for="iwNumber">IW Number</label>
                           <input class="form-control alpha-numeric" id="iwNumber"
                                  placeholder="14 digit IW Number"
                                  name="iwNumber" data-required="true" maxlength="14"
        <cfif IsDefined("form.iwNumber")>
            <cfoutput>value="#form.iwNumber#"</cfoutput></cfif>>
    </div>
    </div>
        <div class="col-xs-12 col-sm-12 col-md-6 padt24">
            <div class="form-group iwNumber-container hide">
                <div class="text-center">
                    <button class="add_field_button btn btn-success form-btn">Add ANOTHER IW Number(S) (Max 4)</button>
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
            <input class="form-control" name="cStreetaddress" id="cStreetaddress" placeholder="Street Address"
        <cfif IsDefined("form.cStreetaddress")>
            <cfoutput>value="#form.cStreetaddress#"</cfoutput></cfif> maxlength="40">
    </div>
    </div>
    <div class="col-xs-12 col-sm-6">
    <div class="form-group cStreetaddress2-container hide">
        <label for="cStreetaddress2">Street Address 2 (Optional)</label>
            <input class="form-control" name="cStreetaddress2" id="cStreetaddress2"
                   placeholder="Street Address 2 (Optional)"
        <cfif IsDefined("form.cStreetaddress2")>
            <cfoutput>value="#form.cStreetaddress2#"</cfoutput></cfif> maxlength="40">
    </div>
    </div>

    <div class="col-xs-12 col-sm-4">
    <div class="form-group cCity-container hide">
        <label for="cCity">City</label>
            <input class="form-control" name="cCity" id="cCity" placeholder="City"
        <cfif IsDefined("form.cCity")>
            <cfoutput>value="#form.cCity#"</cfoutput></cfif> maxlength="40">
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
                <input class="form-control numeric" name="cZip" id="cZip" placeholder="ZIP Code"
        <cfif IsDefined("form.cZip")>
            <cfoutput>value="#form.cZip#"</cfoutput></cfif> maxlength="5">
    </div>
    </div>

    <div class="col-xs-12 col-sm-12">
    <div class="form-group dod-container hide">
        <label for="dod">Date of Death</label>
            <input class="form-control date-picker datepicerval" placeholder="mm/dd/yyyy" name="dod" id="dod"
                   <cfif IsDefined("form.dod")>value="<cfoutput>#form.dod#</cfoutput>"</cfif>
                   data-date-autoclose="true" type="text" maxlength="10">
                   </div>
                   </div>

                   <div class="col-xs-12 col-sm-12">
                   <div class="form-group dlsid-container hide">
                       <label for="dlsid">Driver's License/State I.D./Other I.D.</label>
                           <input id="dlsid" name="dlsid" class="form-control drivers-license" type="text"
                                  placeholder="Driver's License/State I.D./Other I.D."
        <cfif IsDefined("form.dlsid")>
            <cfoutput>value="#form.dlsid#"</cfoutput>
        <cfelse>value=""</cfif> data-required="true" maxlength="14">
    </div>
    </div>
    <div class="col-xs-12 col-sm-12">
    <div class="form-group tickNumber-container hide">
        <label for="tickNumber">Ticket Number</label>
            <input id="tickNumber" name="tickNumber" class="form-control alpha-numeric" type="text"
                   placeholder="Ticket Number"
        <cfif IsDefined("form.tickNumber")>
            <cfoutput>value="#form.tickNumber#"</cfoutput>
        <cfelse>value=""</cfif> data-required="true" maxlength="10">
    </div>
    </div>
    <div class="col-xs-12 col-sm-12">
    <div class="form-group bcaseNum-container hide">
        <label for="bcaseNum">Bankruptcy Case Number</label>
            <input id="bcaseNum" name="bcaseNum" class="form-control numeric" type="text"
                   placeholder="Bankruptcy Case Number"
        <cfif IsDefined("form.bcaseNum")>
            <cfoutput>value="#form.bcaseNum#"</cfoutput>
        <cfelse>value=""</cfif> data-required="true" maxlength="7">
    </div>
    </div>

    <div class="col-xs-12 col-sm-12">
    <div class="form-group pdate-container hide">
        <label for="pdate">Payment Date</label>
            <input class="form-control date-picker datepicerval" placeholder="mm/dd/yyyy" name="pdate" id="pdate"
                   <cfif IsDefined("form.pdate")>value="<cfoutput>#form.pdate#</cfoutput>"</cfif>
                   data-date-autoclose="true" type="text" maxlength="10">
                   </div>
                   </div>


                       <div class="col-xs-12 col-sm-12">
                           <div class="form-group faddress-container hide">
                               <label for="faddress">
                                   <ins>Former Address</ins>
                               </label>
                           </div>
                       </div>

                   <div class="col-xs-12 col-sm-6">
                   <div class="form-group fStreetaddress-container hide">
                       <label for="fStreetaddress">Street Address</label>
                           <input class="form-control" name="fStreetaddress" id="fStreetaddress"
                                  placeholder="Street Address"
        <cfif IsDefined("form.fStreetaddress")>
            <cfoutput>value="#form.fStreetaddress#"</cfoutput></cfif> maxlength="40">
    </div>
    </div>
    <div class="col-xs-12 col-sm-6">
    <div class="form-group fStreetaddress2-container hide">
        <label for="fStreetaddress2">Street Address 2 (Optional)</label>
            <input class="form-control" name="fStreetaddress2" id="fStreetaddress2"
                   placeholder="Street Address 2 (Optional)"
        <cfif IsDefined("form.fStreetaddress2")>
            <cfoutput>value="#form.fStreetaddress2#"</cfoutput></cfif> maxlength="40">
    </div>
    </div>

    <div class="col-xs-12 col-sm-4">
    <div class="form-group fCity-container hide">
        <label for="fCity">City</label>
            <input class="form-control" name="fCity" id="fCity" placeholder="City"
        <cfif IsDefined("form.fCity")>
            <cfoutput>value="#form.fCity#"</cfoutput></cfif> maxlength="40">
    </div>
    </div>
    <div class="col-xs-12 col-sm-4">
    <div class="form-group fState-container hide">
        <label for="fState">State</label>
    <select id="fState" name="fState" class="form-control">
        <option value="0" selected>Select State</option>
        <cfloop query="stateList">
            <cfoutput>
                    <option value="#stateList.ShortName#" <cfif IsDefined("form.fState")>
                    <cfif stateList.ShortName eq form.fState>selected</cfif></cfif>>#stateList.State#</option></cfoutput>
        </cfloop>
        </select>
<!--- <input class="form-control" name="fState" id="fState" placeholder="State" <cfif IsDefined("form.fState")><cfoutput>value="#form.fState#"</cfoutput></cfif> maxlength="40"> --->
        </div>
        </div>
        <div class="col-xs-12 col-sm-4">
        <div class="form-group fZip-container hide">
            <label for="fZip">ZIP Code</label>
                <input class="form-control" name="fZip" id="fZip" placeholder="ZIP Code"
        <cfif IsDefined("form.fZip")>
            <cfoutput>value="#form.fZip#"</cfoutput></cfif> maxlength="5">
    </div>
    </div>

    <div class="col-xs-12 col-sm-12">
    <div class="form-group executer-container hide">
        <label for="executer">Executor</label>
            <input id="executer" name="executer" class="form-control" type="text" placeholder="Executor"
        <cfif IsDefined("form.executer")>
            <cfoutput>value="#form.executer#"</cfoutput>
        <cfelse>value=""</cfif> data-required="true" maxlength="80">
    </div>
    </div>
            <div class="col-xs-12 col-sm-12 reasonProtest
        <cfif isDefined("variables.FileFiveUploadErrorCode") && variables.FileFiveUploadErrorCode EQ 1>has-error
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

                <div class="col-xs-12 col-sm-12 margintopbottom filescont
        <cfif isDefined("variables.FileOneUploadErrorCode") && variables.FileOneUploadErrorCode EQ 1>has-error
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
                <div class="col-xs-12 col-sm-12 filescont
        <cfif isDefined("variables.FileTwoUploadErrorCode") && variables.FileTwoUploadErrorCode EQ 1>has-error
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
                <div class="col-xs-12 col-sm-12 filescont
        <cfif isDefined("variables.FileThreeUploadErrorCode") && variables.FileThreeUploadErrorCode EQ 1>has-error
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
                <div class="col-xs-12 col-sm-12 filescont
        <cfif isDefined("variables.FileFourUploadErrorCode") && variables.FileFourUploadErrorCode EQ 1>has-error
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
                <div class="col-xs-12 col-sm-12 filescont
        <cfif isDefined("variables.FileFiveUploadErrorCode") && variables.FileFiveUploadErrorCode EQ 1>has-error
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
        <div class="col-xs-12 col-sm-12 filescont hide"><input type="checkbox"
        <cfif (isDefined("variables.FileOneUploadErrorCode") || isDefined("variables.FileTwoUploadErrorCode") || isDefined("variables.FileThreeUploadErrorCode") || isDefined("variables.FileFourUploadErrorCode") || isDefined("variables.FileFiveUploadErrorCode") && IsDefined("form.submit")) &&
        (variables.FileOneUploadErrorCode EQ 1 || variables.FileTwoUploadErrorCode EQ 1 || variables.FileThreeUploadErrorCode EQ 1 || variables.FileFourUploadErrorCode EQ 1 || variables.FileFiveUploadErrorCode EQ 1)> </cfif>
                                                               value="Signature" id="Signature" name="Signature"> In
                                                                   submitting this protest, I declare that I have
                                                                   reviewed the information I have submitted, that it is
                                                                   true to the best of my knowledge, and that I
                                                                   understand that it will be used to adjudicate my
                                                                   protest.<span class="red"><sup>*</sup></span> </div>
       </div>
       </div>

           <div class="form-submit-button hide">
               <div class="text-center">
               <a id="cnlBtn" class="btn btn-primary" href="/debtprotest/debtprotestform/" data-toggle="tooltip" data-placement="top"
                  title="Return to Select your reason for protest">
                   CANCEL </a>
               <input class="btn btn-primary"
                      data-toggle="tooltip"
                      data-placement="top"
                      title="Send the Protest Form to LDRP business."
                      type="submit" id="submit"
                      name="submit" value="Submit">
               </div>
           </div>

          <!--- <div class="col-sm-offset-2 col-xs-6 col-sm-4"
                style="padding-bottom: 20px;">

               <div class="form-submit-button hide">
                   <a id="cnlBtn"
                      class="btn btn-danger btn-block"
                      href="/debtprotest/debtprotestform/"
                      data-toggle="tooltip" data-placement="top"
                      title="Return to Select your reason for protest">
                       CANCEL </a>
               </div>
           </div>
           <div class="col-xs-6 col-sm-4"
                style="padding-bottom: 20px;">

               <div class="form-submit-button hide">
                   <input class="btn btn-primary btn-block"
                          data-toggle="tooltip"
                          data-placement="top"
                          title="Send the Protest Form to LDRP business."
                          type="submit" id="submit"
                          name="submit" value="Submit">
               </div>
           </div>--->

       </div>
    </cfform>
    <div id="messageHolderBottom" class="hide"></div>
</cfif>



<!---<script src="/comptroller/includes/display_objects/custom/DebtProtest/assets/js/bootstrap-datepicker.min.js"></script>--->
<script src="/comptroller/includes/display_objects/custom/DebtProtest/assets/js/jquery.masked-input.js"></script>
<script src="/comptroller/includes/display_objects/custom/DebtProtest/assets/js/jquery.plugin.min.js"></script>
<script src="/comptroller/includes/display_objects/custom/DebtProtest/assets/js/jquery.maxlength.min.js"></script>
<script src="/comptroller/includes/display_objects/custom/DebtProtest/assets/js/Validate.js"></script>
