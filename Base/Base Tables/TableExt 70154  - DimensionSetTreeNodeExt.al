tableextension 70154 DimensionSetTreeNodeExt extends "Dimension Set Tree Node"
{


    fields
    {

    }

    trigger OnModify()
    begin
        /* Mail_From:='noreply@efftronics.com';
               Mail_To:='ERP@efftronics.com';
               Subject:='ERP-Dimension Set Tree Node Changes';
               Body:='<html><BODY><h3><center>Dimension Set Tree Node Changes Details!<BR>';
               Body+= '</center></h3>';
               Body+='<br><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
               Body+='border="1" align="Center">';
               Body+='<tr><td align="center">Field</td><td align="center">New Value</td><td align="center">Old Value</td></tr>';
               Body+='<tr><td>Parent Dimension  Set ID</td><td align="right">'+Format("Parent Dimension Set ID")+'</td><td align="right">'+Format(xRec."Parent Dimension Set ID")+'</td></tr>';
               Body+='<tr><td>Dimension Value Id</td><td align="right">'+Format("Dimension Value ID")+'</td><td align="right">'+Format(xRec."Dimension Value ID")+'</td></tr>';
               Body+='<tr><td>Dimension Set ID</td><td align="right">'+Format("Dimension Set ID")+'</td><td align="right">'+Format(xRec."Dimension Set ID")+'</td></tr>';
               Body+='<tr><td>In Use</td><td align="right">'+Format("In Use")+'</td><td align="right">'+Format(xRec."In Use")+'</td></tr>';
               Body+='<tr><td>User ID</td><td colspan=2; align="right">'+UserId+'</td></tr></table><br>';
               Body+='<br><p><center>              ****  Automatic Mail Generated From ERP  ****       <center></p></BODY></html>';
               SMTP_MAIL.CreateMessage('ERP',Mail_From,Mail_To,Subject,Body,true);
               SMTP_MAIL.Send; */

        Recipients.Add('noreply@efftronics.com');
        Recipients.Add('ERP@efftronics.com');
        Subject := 'ERP-Dimension Set Tree Node Changes';
        Body := '<html><BODY><h3><center>Dimension Set Tree Node Changes Details!<BR>';
        Body += '</center></h3>';
        Body += '<br><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
        Body += 'border="1" align="Center">';
        Body += '<tr><td align="center">Field</td><td align="center">New Value</td><td align="center">Old Value</td></tr>';
        Body += '<tr><td>Parent Dimension  Set ID</td><td align="right">' + Format("Parent Dimension Set ID") + '</td><td align="right">' + Format(xRec."Parent Dimension Set ID") + '</td></tr>';
        Body += '<tr><td>Dimension Value Id</td><td align="right">' + Format("Dimension Value ID") + '</td><td align="right">' + Format(xRec."Dimension Value ID") + '</td></tr>';
        Body += '<tr><td>Dimension Set ID</td><td align="right">' + Format("Dimension Set ID") + '</td><td align="right">' + Format(xRec."Dimension Set ID") + '</td></tr>';
        Body += '<tr><td>In Use</td><td align="right">' + Format("In Use") + '</td><td align="right">' + Format(xRec."In Use") + '</td></tr>';
        Body += '<tr><td>User ID</td><td colspan=2; align="right">' + UserId + '</td></tr></table><br>';
        Body += '<br><p><center>              ****  Automatic Mail Generated From ERP  ****       <center></p></BODY></html>';
        EmailMessage.Create(Recipients, Subject, Body, true);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;


    var
        Subject: Text;
        Body: Text;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
}

