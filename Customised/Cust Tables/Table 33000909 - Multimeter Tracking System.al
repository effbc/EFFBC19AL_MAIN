table 33000909 "Multimeter Tracking System"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Multimeter No"; Code[20])
        {
            TableRelation = Item."No." WHERE("Product Group Code Cust" = FILTER('MULTIMETER'));
            DataClassification = CustomerContent;
        }
        field(2; "Serial No."; Code[20])
        {
        }
        field(3; "Lot No."; Code[20])
        {
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(6; Status; Option)
        {
            OptionMembers = Calibrated,"Under Calibration";
        }
        field(7; "Responsible Person"; Code[50])
        {
            // TableRelation = User."User Name" WHERE(Field60103 = FILTER(No));
            TableRelation = "User setup"."User ID" WHERE(Blocked = FILTER(false));
        }
        field(8; "Next Calibration Date"; Date)
        {
        }
        field(9; Verified; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Multimeter No", "Serial No.", "Lot No.")
        {
        }
        key(Key2; "Next Calibration Date", "Serial No.")
        {
        }
    }

    fieldgroups
    {
    }


    procedure Validate();
    var
        IleLRec: Record "Item Ledger Entry";
    begin
    end;
}

