table 60045 "Alternate Items"
{
    // version B2B1.0

    DataCaptionFields = "Proudct Type", "Item No.";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Proudct Type"; Code[20])
        {
            TableRelation = "Item Sub Group".Code WHERE("Product Group Code" = FILTER('FPRODUCT' | 'CPCB'));
            DataClassification = CustomerContent;
        }
        field(3; "Item No."; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                if Item.Get("Item No.") then
                    "Item Description" := Item.Description;
            end;
        }
        field(4; "Item Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Alternative Item No."; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Item.Get("Alternative Item No.") then
                    "Alternative Item Description" := Item.Description;
            end;
        }
        field(6; "Alternative Item Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; Make; Code[30])
        {
            TableRelation = Make;
            DataClassification = CustomerContent;
        }
        field(8; "Priority Order"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Proudct Type", "Item No.", "Alternative Item No.")
        {
        }
        key(Key2; "Item No.")
        {
        }
        key(Key3; "Proudct Type", "Item No.", "Priority Order")
        {
        }
        key(Key4; "Alternative Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        if (not SMTP_MAIL.Permission_Checking(UserId, 'ALTERNATEITEMS')) then
            Error('YOU DONT HAVE SUFFICIENT PERMISSIONS');
    end;

    trigger OnInsert();
    begin
        if (not SMTP_MAIL.Permission_Checking(UserId, 'ALTERNATEITEMS')) then
            Error('YOU DONT HAVE SUFFICIENT PERMISSIONS');
    end;

    trigger OnModify();
    begin
        if (not SMTP_MAIL.Permission_Checking(UserId, 'ALTERNATEITEMS')) then
            Error('YOU DONT HAVE SUFFICIENT PERMISSIONS');
    end;

    trigger OnRename();
    begin
        //IF NOT (USERID IN['EFFTRONICS\JHANSI','EFFTRONICS\VANIDEVI','EFFTRONICS\VIJAYA','EFFTRONICS\ANILKUMAR']) THEN
        //ERROR('YOU DONT HAVE SUFFICIENT PERMISSIONS');
        if (not SMTP_MAIL.Permission_Checking(UserId, 'ALTERNATEITEMS')) then
            Error('YOU DONT HAVE SUFFICIENT PERMISSIONS');
    end;

    var
        "Production Bom header": Record "Production BOM Header";
        Item: Record Item;
        SMTP_MAIL: Codeunit "Custom Events";
}

