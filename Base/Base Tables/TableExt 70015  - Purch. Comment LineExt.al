tableextension 70015 PurchCommentLineExt extends "Purch. Comment Line"
{


    fields
    {


        field(50001; Type; Enum "Puch Comment Line Enum")
        {
            DataClassification = CustomerContent;

        }
        field(50002; "Comment1"; Text[100])
        {
            DataClassification = CustomerContent;
        }

    }
}

