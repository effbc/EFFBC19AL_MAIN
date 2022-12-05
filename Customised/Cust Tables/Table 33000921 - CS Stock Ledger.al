table 33000921 "CS Stock Ledger"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Posted By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(4; Received; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Transaction ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Transaction Type"; Option)
        {
            OptionCaption = ',Change Status,Card Transfer,Custmer card Transfer,Open';
            OptionMembers = ,"Change Status","Card Transfer","Custmer card Transfer",Open;
            DataClassification = CustomerContent;
        }
        field(7; Location; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = FILTER(false));
            DataClassification = CustomerContent;
        }
        field(8; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(9; Remarks; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Mode of Transport"; Option)
        {
            OptionMembers = " ",Courier,Train,Bus,"By Hand",VRL,Lorry,ANL;
            DataClassification = CustomerContent;
        }
        field(11; "Courier Details"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Item No"; Code[20])
        {
            TableRelation = Item."No.";
            DataClassification = CustomerContent;
        }
        field(14; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(15; Reason; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(16; "Card Status"; Option)
        {
            OptionMembers = ,Working,"Non Working";
            DataClassification = CustomerContent;
        }
        field(17; Station; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(18; "Received By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(19; "Received Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(20; NonReturnable; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(22; "DC No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(23; "Customer No"; Code[20])
        {
            Description = 'for led cards process';
            DataClassification = CustomerContent;
        }
        field(24; "Responsible Persion"; Code[30])
        {
            Description = 'For LED Cards';
            DataClassification = CustomerContent;
        }
        field(25; Stock_Adjusted; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

