tableextension 70003 GLAccoountExt extends "G/L Account"
{
    fields
    {
        field(60001; "Cash Account"; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "TDS Account"; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; "Work Tax Account"; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60004; "Excise Prod. Posting Group2"; Code[10])
        {
            DataClassification = CustomerContent;
            // TableRelation = "Excise Prod. Posting Group".Code;
        }
        field(60005; "Excise Accounting Type"; Option)
        {
            OptionCaption = 'With CENTVAT,Without CENTVAT';
            OptionMembers = "With CENTVAT","Without CENTVAT";
            DataClassification = CustomerContent;
        }
        field(60006; "PL Minor Head"; Text[60])
        {
            DataClassification = CustomerContent;
        }
        field(60007; "PL Minor Head SNO"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60008; "PL IncomeType"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60009; "PL IncomeType Sort"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60010; "PL Income Type Summary"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60011; "PL Income Expenditure"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60012; "PL Head"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Reflected_in_pl_datetime := CurrentDateTime;
                Reflected_in_pl_userid := UserId;
            end;
        }
        field(60013; EntryType; Option)
        {
            OptionCaption = ',JounalVoucher,Purchase Inovice,Purchase Invocie/Journal voucher,Not Required,Payment Voucher';
            OptionMembers = ,JounalVoucher,"Purchase Inovice","Purchase Invocie/Journal voucher","Not Required","Payment Voucher";
            DataClassification = CustomerContent;
        }
        field(60014; Created_Date_time; Date)
        {
            Description = 'added on 10-jul-18  by sujani';
            DataClassification = CustomerContent;
        }
        field(60015; "Type of GL"; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(60016; "Nature of GL"; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(60017; "GL Group"; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(60018; "GL Sub Group"; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(60019; Reflected_in_pl_userid; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(60020; Reflected_in_pl_datetime; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60021; "Reflect in P&L"; Option)
        {
            OptionCaption = '" ,Yes,No"';
            OptionMembers = " ",Yes,No;
            DataClassification = CustomerContent;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin

        Rec.Created_Date_time := Today;
        begin
            Subject := 'New G_L Account Head-' + Rec."No." + ' Added';

            Recipients.Add('erp@efftronics.com');
            Recipients.Add('sitarajyam@efftronics.com');



            Body += ('<html><body><table>');
            Body += ('<th>G_L Account Head Details</th>');
            Body += ('<tr><td>G/L No: </td><td>' + Rec."No." + '</td></tr>');
            Body += ('<tr><td>Name: </td><td>' + Rec.Name + '</td></tr>');
            Body += ('<tr><td>Created Date: </td><td>' + Format(Rec.Created_Date_time) + '</td></tr>');
            Body += ('<tr><td>Created By: </td><td>' + UserId + '</td></tr>');
            Body += ('</table>');
            Body += ('<br/><br/>*********** This is auto generated mail from ERP ************</body></html>');
            //Email.Send(EmailMessage);
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        end;
    end;


    var
        Subject: Text[100];
        Email: Codeunit Email;
        Body: Text;
        Recipients: List of [Text];
        EmailMessage: Codeunit "Email Message";
}

