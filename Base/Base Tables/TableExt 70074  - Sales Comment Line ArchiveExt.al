tableextension 70074 SalesCommentLineArchiveExt extends "Sales Comment Line Archive"
{
    fields
    {
        field(60001; "User ID"; Code[40])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                User.Reset;
                if PAGE.RunModal(9800, User) = ACTION::LookupOK then
                    Rec."User ID" := User."User Name";
            end;
        }
        field(60002; "Responsible Person"; Code[40])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                User.Reset;
                if PAGE.RunModal(9800, User) = ACTION::LookupOK then
                    "Responsible Person" := User."User Name";
            end;
        }
        field(60003; Status; Enum CustStatus)
        {
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(60004; "Exp Completion Date"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60005; Priority; Enum Priority)
        {
            DataClassification = CustomerContent;
        }
        field(60006; Product; Code[50])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                ISGC.Reset;
                if PAGE.RunModal(60263, ISGC) = ACTION::LookupOK then
                    Rec.Product := ISGC.Code;
            end;
        }
        field(60007; "Customer Number"; Code[30])
        {
            DataClassification = CustomerContent;
            Description = 'Added by Vishnu Priya for the IREPS Purpose';
            TableRelation = Customer."No.";
        }
        field(60008; "Customer Name"; Text[60])
        {
            DataClassification = CustomerContent;
            Description = 'Added by Vishnu Priya for the IREPS Purpose';
        }
        field(60009; "Remainder Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'Added by Vishnu Priya for the IREPS Purpose';
        }
        field(60010; "Quote Status"; Enum QuoteStatus)
        {
            DataClassification = CustomerContent;
            Description = 'Added by Vishnu Priya for the IREPS Purpose';
        }
        field(60011; Convert; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'Added by Vishnu Priya for the IREPS Purpose';
        }
        field(60012; "Converted Order Number"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'Added by Vishnu Priya for the IREPS Purpose';
        }
        field(60013; Code1; Code[15])
        {
            DataClassification = CustomerContent;
        }
    }
    var
        Itm: Record Item;
        ISGC: Record "Item Sub Group";
        User: Record User;
}

