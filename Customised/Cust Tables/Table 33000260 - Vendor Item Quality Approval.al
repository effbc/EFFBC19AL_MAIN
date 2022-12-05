table 33000260 "Vendor Item Quality Approval"
{
    DataClassification = CustomerContent;
    // version QC1.0


    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(2; "Item No."; Code[20])
        {
            TableRelation = Item WHERE("QC Enabled" = CONST(true));
            DataClassification = CustomerContent;
        }
        field(3; "Starting Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Starting Date" > "Ending Date") and ("Ending Date" <> 0D) then
                    Error(Text000, FieldCaption("Starting Date"), FieldCaption("Ending Date"));
            end;
        }
        field(4; "Ending Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Starting Date");
            end;
        }
        field(5; "Certified Agency"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(6; Attachment; BLOB)
        {
            DataClassification = CustomerContent;
        }
        field(7; "File Extension"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Spec Id"; Code[20])
        {
            TableRelation = "Specification Header";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Vendor No.", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        TestField("Item No.");
    end;

    var
        Text000: Label '%1 cannot be after %2';
}

