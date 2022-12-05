table 60106 "PCB Cost Details"
{
    Caption = 'PCB Area Caluculation';
    DataCaptionFields = "Vendor No.";
    DrillDownPageID = "PCB Cost Details List";
    LookupPageID = "PCB Cost Details List";
    Permissions = TableData "PCB Cost Details" = rimd;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            TableRelation = Vendor WHERE("Updated in Cashflow" = CONST(true));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                VENDOR.SetFilter(VENDOR."No.", "Vendor No.");
                if VENDOR.FindFirst then
                    Name := VENDOR.Name;
            end;
        }
        field(2; Name; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "PCB Thickness"; Code[10])
        {
            Caption = 'PCB Thickness(In mm)';
            DataClassification = CustomerContent;
        }
        field(4; "Copper Clad Thickness"; Code[10])
        {
            Caption = 'Copper Clad Thickness(In Microns)';
            DataClassification = CustomerContent;
        }
        field(5; "Min.Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Max.Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Min.Area"; Decimal)
        {
            Caption = 'Min.Area(In Sq.mt)';
            DataClassification = CustomerContent;
        }
        field(8; "Max.Area"; Decimal)
        {
            Caption = 'Max.Area(In Sq.mt)';
            DataClassification = CustomerContent;
        }
        field(9; Cost; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Area"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(11; Date; Date)
        {
            DataClassification = CustomerContent;
        }
        field(12; "PCB TYPE"; Code[10])
        {
            TableRelation = "Item Sub Group".Code WHERE("Product Group Code" = CONST('PCB'));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Vendor No.", "PCB Thickness", "Copper Clad Thickness", "Min.Quantity", "Max.Quantity", "Max.Area", "Min.Area", "Area", "PCB TYPE")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        Date := Today;

        if "Min.Quantity" > "Max.Quantity" then
            Error('Min.Quantity should not be greater than Max.Quantity');

        if "Min.Area" > "Max.Area" then
            Error('Min.Area should not be greater than Max.Area');
    end;

    trigger OnModify();
    begin
        /* IF USERID<>'' THEN
         ERROR('YOU HAVE NO RIGHTS TO MODIFY THE RECORD');
         EXIT;
        */

    end;

    trigger OnRename();
    begin
        /* IF USERID<>'' THEN
         ERROR('YOU HAVE NO RIGHTS TO RENAME THE RECORD');
         EXIT;
        */

    end;

    var
        ITEM: Record Item;
        VENDOR: Record Vendor;
        PCB: Record "PCB Cost Details";
}

