table 33000922 "Lot wise Item Availability"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "LOT No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Total Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Allocated Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; Location; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No", "LOT No", Location)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        /* Mail_From := 'noreply@efftronics.com';
        Mail_To := 'pranavi@efftronics.com';
        Subject := 'ERP-Lot Wise Item Avail Deleted';
        Body := '<html><BODY><h3><center>Lot Wise Item Avail Modification Details!<BR>';
        Body += '</center></h3>';
        Body += '<br><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
        Body += 'border="1" align="Center">';
        Body += '<tr><td align="center">Field</td><td align="center">New Value</td><td align="center">Old Value</td></tr>';
        Body += '<tr><td>Item No</td><td align="right">' + Format("Item No") + '</td><td align="right">' + Format(xRec."Item No") + '</td></tr>';
        Body += '<tr><td>Lot No</td><td align="right">' + "LOT No" + '</td><td align="right">' + xRec."LOT No" + '</td></tr>';
        Body += '<tr><td>Total Qty</td><td align="right">' + Format("Total Qty") + '</td><td align="right">' + Format(xRec."Total Qty") + '</td></tr>';
        Body += '<tr><td>Allocated Qty</td><td align="right">' + Format("Allocated Qty") + '</td><td align="right">' + Format(xRec."Allocated Qty") + '</td></tr>';
        Body += '<tr><td>Location</td><td align="right">' + Location + '</td><td align="right">' + xRec.Location + '</td></tr>';
        Body += '<tr><td>User ID</td><td colspan=2; align="right">' + UserId + '</td></tr></table><br>';
        Body += '<br><p><center>            ****  Automatic Mail Generated From ERP  ****       </center></p></BODY></html>';
        SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, true);
        SMTP_MAIL.Send; */   //B2B UPG

        Subject := 'ERP-Lot Wise Item Avail Deleted';
        Body := '<html><BODY><h3><center>Lot Wise Item Avail Modification Details!<BR>';
        Body += '</center></h3>';
        Body += '<br><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
        Body += 'border="1" align="Center">';
        Body += '<tr><td align="center">Field</td><td align="center">New Value</td><td align="center">Old Value</td></tr>';
        Body += '<tr><td>Item No</td><td align="right">' + Format("Item No") + '</td><td align="right">' + Format(xRec."Item No") + '</td></tr>';
        Body += '<tr><td>Lot No</td><td align="right">' + "LOT No" + '</td><td align="right">' + xRec."LOT No" + '</td></tr>';
        Body += '<tr><td>Total Qty</td><td align="right">' + Format("Total Qty") + '</td><td align="right">' + Format(xRec."Total Qty") + '</td></tr>';
        Body += '<tr><td>Allocated Qty</td><td align="right">' + Format("Allocated Qty") + '</td><td align="right">' + Format(xRec."Allocated Qty") + '</td></tr>';
        Body += '<tr><td>Location</td><td align="right">' + Location + '</td><td align="right">' + xRec.Location + '</td></tr>';
        Body += '<tr><td>User ID</td><td colspan=2; align="right">' + UserId + '</td></tr></table><br>';
        Body += '<br><p><center>            ****  Automatic Mail Generated From ERP  ****       </center></p></BODY></html>';
        Recipients.Add('pranavi@efftronics.com');
        EmailMessage.Create(Recipients, Subject, Body, true);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    trigger OnInsert();
    begin
        /* Mail_From := 'noreply@efftronics.com';
        Mail_To := 'pranavi@efftronics.com';
        Subject := 'ERP-Lot Wise Item Avail Inserted';
        Body := '<html><BODY><h3><center>Lot Wise Item Avail Modification Details!<BR>';
        Body += '</center></h3>';
        Body += '<br><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
        Body += 'border="1" align="Center">';
        Body += '<tr><td align="center">Field</td><td align="center">New Value</td><td align="center">Old Value</td></tr>';
        Body += '<tr><td>Item No</td><td align="right">' + Format("Item No") + '</td><td align="right">' + Format(xRec."Item No") + '</td></tr>';
        Body += '<tr><td>Lot No</td><td align="right">' + "LOT No" + '</td><td align="right">' + xRec."LOT No" + '</td></tr>';
        Body += '<tr><td>Total Qty</td><td align="right">' + Format("Total Qty") + '</td><td align="right">' + Format(xRec."Total Qty") + '</td></tr>';
        Body += '<tr><td>Allocated Qty</td><td align="right">' + Format("Allocated Qty") + '</td><td align="right">' + Format(xRec."Allocated Qty") + '</td></tr>';
        Body += '<tr><td>Location</td><td align="right">' + Location + '</td><td align="right">' + xRec.Location + '</td></tr>';
        Body += '<tr><td>User ID</td><td colspan=2; align="right">' + UserId + '</td></tr></table><br>';
        Body += '<br><p><center>            ****  Automatic Mail Generated From ERP  ****       </center></p></BODY></html>';
        SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, true);
        SMTP_MAIL.Send; */    //B2B UPG

        Subject := 'ERP-Lot Wise Item Avail Inserted';
        Body := '<html><BODY><h3><center>Lot Wise Item Avail Modification Details!<BR>';
        Body += '</center></h3>';
        Body += '<br><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
        Body += 'border="1" align="Center">';
        Body += '<tr><td align="center">Field</td><td align="center">New Value</td><td align="center">Old Value</td></tr>';
        Body += '<tr><td>Item No</td><td align="right">' + Format("Item No") + '</td><td align="right">' + Format(xRec."Item No") + '</td></tr>';
        Body += '<tr><td>Lot No</td><td align="right">' + "LOT No" + '</td><td align="right">' + xRec."LOT No" + '</td></tr>';
        Body += '<tr><td>Total Qty</td><td align="right">' + Format("Total Qty") + '</td><td align="right">' + Format(xRec."Total Qty") + '</td></tr>';
        Body += '<tr><td>Allocated Qty</td><td align="right">' + Format("Allocated Qty") + '</td><td align="right">' + Format(xRec."Allocated Qty") + '</td></tr>';
        Body += '<tr><td>Location</td><td align="right">' + Location + '</td><td align="right">' + xRec.Location + '</td></tr>';
        Body += '<tr><td>User ID</td><td colspan=2; align="right">' + UserId + '</td></tr></table><br>';
        Body += '<br><p><center>            ****  Automatic Mail Generated From ERP  ****       </center></p></BODY></html>';
        Recipients.Add('pranavi@efftronics.com');
        EmailMessage.Create(Recipients, Subject, Body, true);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    trigger OnModify();
    begin

        /* Mail_From := 'noreply@efftronics.com';
        Mail_To := 'pranavi@efftronics.com';
        Subject := 'ERP-Lot Wise Item Avail Modified';
        Body := '<html><BODY><h3><center>Lot Wise Item Avail Modification Details!<BR>';
        Body += '</center></h3>';
        Body += '<br><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
        Body += 'border="1" align="Center">';
        Body += '<tr><td align="center">Field</td><td align="center">New Value</td><td align="center">Old Value</td></tr>';
        Body += '<tr><td>Item No</td><td align="right">' + Format("Item No") + '</td><td align="right">' + Format(xRec."Item No") + '</td></tr>';
        Body += '<tr><td>Lot No</td><td align="right">' + "LOT No" + '</td><td align="right">' + xRec."LOT No" + '</td></tr>';
        Body += '<tr><td>Total Qty</td><td align="right">' + Format("Total Qty") + '</td><td align="right">' + Format(xRec."Total Qty") + '</td></tr>';
        Body += '<tr><td>Allocated Qty</td><td align="right">' + Format("Allocated Qty") + '</td><td align="right">' + Format(xRec."Allocated Qty") + '</td></tr>';
        Body += '<tr><td>Location</td><td align="right">' + Location + '</td><td align="right">' + xRec.Location + '</td></tr>';
        Body += '<tr><td>User ID</td><td colspan=2; align="right">' + UserId + '</td></tr></table><br>';
        Body += '<br><p><center>            ****  Automatic Mail Generated From ERP  ****       </center></p></BODY></html>';
        SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, true);
        SMTP_MAIL.Send; */      //B2B UPG

        Subject := 'ERP-Lot Wise Item Avail Modified';
        Body := '<html><BODY><h3><center>Lot Wise Item Avail Modification Details!<BR>';
        Body += '</center></h3>';
        Body += '<br><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
        Body += 'border="1" align="Center">';
        Body += '<tr><td align="center">Field</td><td align="center">New Value</td><td align="center">Old Value</td></tr>';
        Body += '<tr><td>Item No</td><td align="right">' + Format("Item No") + '</td><td align="right">' + Format(xRec."Item No") + '</td></tr>';
        Body += '<tr><td>Lot No</td><td align="right">' + "LOT No" + '</td><td align="right">' + xRec."LOT No" + '</td></tr>';
        Body += '<tr><td>Total Qty</td><td align="right">' + Format("Total Qty") + '</td><td align="right">' + Format(xRec."Total Qty") + '</td></tr>';
        Body += '<tr><td>Allocated Qty</td><td align="right">' + Format("Allocated Qty") + '</td><td align="right">' + Format(xRec."Allocated Qty") + '</td></tr>';
        Body += '<tr><td>Location</td><td align="right">' + Location + '</td><td align="right">' + xRec.Location + '</td></tr>';
        Body += '<tr><td>User ID</td><td colspan=2; align="right">' + UserId + '</td></tr></table><br>';
        Body += '<br><p><center>            ****  Automatic Mail Generated From ERP  ****       </center></p></BODY></html>';
        Recipients.Add('pranavi@efftronics.com');
        EmailMessage.Create(Recipients, Subject, Body, true);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    trigger OnRename();
    begin
        /* Mail_From := 'noreply@efftronics.com';
        Mail_To := 'pranavi@efftronics.com';
        Subject := 'ERP-Lot Wise Item Avail Renamed';
        Body := '<html><BODY><h3><center>Lot Wise Item Avail Modification Details!<BR>';
        Body += '</center></h3>';
        Body += '<br><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
        Body += 'border="1" align="Center">';
        Body += '<tr><td align="center">Field</td><td align="center">New Value</td><td align="center">Old Value</td></tr>';
        Body += '<tr><td>Item No</td><td align="right">' + Format("Item No") + '</td><td align="right">' + Format(xRec."Item No") + '</td></tr>';
        Body += '<tr><td>Lot No</td><td align="right">' + "LOT No" + '</td><td align="right">' + xRec."LOT No" + '</td></tr>';
        Body += '<tr><td>Total Qty</td><td align="right">' + Format("Total Qty") + '</td><td align="right">' + Format(xRec."Total Qty") + '</td></tr>';
        Body += '<tr><td>Allocated Qty</td><td align="right">' + Format("Allocated Qty") + '</td><td align="right">' + Format(xRec."Allocated Qty") + '</td></tr>';
        Body += '<tr><td>Location</td><td align="right">' + Location + '</td><td align="right">' + xRec.Location + '</td></tr>';
        Body += '<tr><td>User ID</td><td colspan=2; align="right">' + UserId + '</td></tr></table><br>';
        Body += '<br><p><center>            ****  Automatic Mail Generated From ERP  ****       </center></p></BODY></html>';
        SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, true);
        SMTP_MAIL.Send; */      //B2B UPG

        Subject := 'ERP-Lot Wise Item Avail Renamed';
        Body := '<html><BODY><h3><center>Lot Wise Item Avail Modification Details!<BR>';
        Body += '</center></h3>';
        Body += '<br><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
        Body += 'border="1" align="Center">';
        Body += '<tr><td align="center">Field</td><td align="center">New Value</td><td align="center">Old Value</td></tr>';
        Body += '<tr><td>Item No</td><td align="right">' + Format("Item No") + '</td><td align="right">' + Format(xRec."Item No") + '</td></tr>';
        Body += '<tr><td>Lot No</td><td align="right">' + "LOT No" + '</td><td align="right">' + xRec."LOT No" + '</td></tr>';
        Body += '<tr><td>Total Qty</td><td align="right">' + Format("Total Qty") + '</td><td align="right">' + Format(xRec."Total Qty") + '</td></tr>';
        Body += '<tr><td>Allocated Qty</td><td align="right">' + Format("Allocated Qty") + '</td><td align="right">' + Format(xRec."Allocated Qty") + '</td></tr>';
        Body += '<tr><td>Location</td><td align="right">' + Location + '</td><td align="right">' + xRec.Location + '</td></tr>';
        Body += '<tr><td>User ID</td><td colspan=2; align="right">' + UserId + '</td></tr></table><br>';
        Body += '<br><p><center>            ****  Automatic Mail Generated From ERP  ****       </center></p></BODY></html>';
        Recipients.Add('pranavi@efftronics.com');
        EmailMessage.Create(Recipients, Subject, Body, true);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    var
        Body: Text;
        Subject: Text;
        Mail_To: Text;
        Mail_From: Text;
        //Mail: Codeunit Mail;
        //SMTP_MAIL: Codeunit "SMTP Mail";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
}

