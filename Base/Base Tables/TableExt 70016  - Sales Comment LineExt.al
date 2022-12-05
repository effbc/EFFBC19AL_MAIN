tableextension 70016 SalesCommentLineExt extends "Sales Comment Line"
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
                    "User ID" := User."User Name";
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
        field(60013; "Code1"; Code[15])
        {
            DataClassification = CustomerContent;
        }
        field(60003; Status; Enum "Sales Comment Line Enum")
        {
            Editable = true;
            DataClassification = CustomerContent;

        }
        field(60004; "Exp Completion Date"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60005; Priority; Enum "Sale Comment Line Priority")
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
                    Product := ISGC.Code;
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
        field(60010; "Quote Status"; Option)
        {
            DataClassification = CustomerContent;
            Description = 'Added by Vishnu Priya for the IREPS Purpose';
            OptionCaption = '" ,Win,Loose,None"';
            OptionMembers = " ",Win,Loose,"None";
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
    }
    keys
    {



    }

    var
        User: Record User;
        Itm: Record Item;
        ISGC: Record "Item Sub Group";
}

