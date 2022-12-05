table 60053 "Calibration Header"
{
    // version B2B1.0

    DrillDownPageID = "Calibration List";
    LookupPageID = "Calibration List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Name; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Equipment Type"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Calibration Next Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(5; Frequency; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Notice Period"; DateFormula)
        {
            TableRelation = "Status Parameters"."Document Type";
            DataClassification = CustomerContent;
        }
        field(7; "Current Status"; Option)
        {
            OptionMembers = " ",Calibrated,Scrapped,"Out of Calibration";
            DataClassification = CustomerContent;
        }
        field(8; Remarks; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Inspection Party"; Option)
        {
            OptionMembers = Internal,External;
            DataClassification = CustomerContent;
        }
        field(10; Agency; Text[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(11; "Purpose of Instrument"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Usage Type"; Option)
        {
            OptionMembers = Master,Instrument;
            DataClassification = CustomerContent;
        }
        field(13; "Least Count"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(14; UOM; Code[10])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        FixedAsset: Record "Fixed Asset";


    procedure TenderAttachments();
    var
        Attachments: Record Attachments;
    begin
        Attachments.Reset;
        Attachments.SetRange("Table ID", DATABASE::"Calibration Header");
        Attachments.SetRange("Document No.", "No.");

        PAGE.Run(PAGE::"ESPL Attachments", Attachments);
    end;
}

