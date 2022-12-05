tableextension 70153 DimensionSetEntryExt extends "Dimension Set Entry"
{

    fields
    {


    }

    trigger OnModify()
    begin
        /*  OldDim.RESET;
                 OldDim.SETFILTER(OldDim."Dimension Code","Dimension Code");
                 OldDim.SETFILTER(OldDim.Code,"Dimension Value Code");
                 IF OldDim.FINDFIRST THEN
                   OldDimValName := OldDim.Name;
                 NewDim.RESET;
                 NewDim.SETFILTER(NewDim."Dimension Code","Dimension Code");
                 NewDim.SETFILTER(NewDim.Code,"Dimension Value Code");
                 IF NewDim.FINDFIRST THEN
                   NewDimValName := NewDim.Name;
                 NewDim.RESET;
                 Mail_From:='noreply@efftronics.com';
                 Mail_To:='erp@efftronics.com';
                 Subject:='ERP-Dimension Set Entry Changes';
                 Body:='<html><BODY><h3><center>Dimension Set Entry Changes Details!<BR>';
                 Body+= '</center></h3>';
                 Body+='<br><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
                 Body+='border="1" align="Center">';
                 Body+='<tr><td align="center">Field</td><td align="center">New Value</td><td align="center">Old Value</td></tr>';
                 Body+='<tr><td>Dimension  Set ID</td><td align="right">'+FORMAT("Dimension Set ID")+'</td><td align="right">'+FORMAT(xRec."Dimension Set ID")+'</td></tr>';
                 Body+='<tr><td>Dimension Code</td><td align="right">'+"Dimension Code"+'</td><td align="right">'+xRec."Dimension Code"+'</td></tr>';
                 Body+='<tr><td>Dimension Value Code</td><td align="right">'+"Dimension Value Code"+'</td><td align="right">'+xRec."Dimension Value Code"+'</td></tr>';
                 Body+='<tr><td>Dimension Value Id</td><td align="right">'+FORMAT("Dimension Value ID")+'</td><td align="right">'+FORMAT(xRec."Dimension Value ID")+'</td></tr>';
                 Body+='<tr><td>Dimension Name</td><td align="right">'+"Dimension Name"+'</td><td align="right">'+xRec."Dimension Name"+'</td></tr>';
                 Body+='<tr><td>Dimension Value Name</td><td align="right">'+OldDimValName+'</td><td align="right">'+NewDimValName+'</td></tr>';
                 Body+='<tr><td>User ID</td><td colspan=2; align="right">'+USERID+'</td></tr></table><br>';
                 Body+='<br><p><center>            ****  Automatic Mail Generated From ERP  ****       </center></p></BODY></html>';
                 SMTP_MAIL.CreateMessage('ERP',Mail_From,Mail_To,Subject,Body,TRUE);
                 IF "Dimension Set ID" <> 0 THEN
                   SMTP_MAIL.Send;}// commented by SUJANI on 091018 */
    end;

    trigger OnRename()
    begin
        if not (UserId in ['EFFTRONICS\SUJANI']) then
            Error('You Donot have Right to Rename ' + Format("Dimension Set ID"));
    end;
}

