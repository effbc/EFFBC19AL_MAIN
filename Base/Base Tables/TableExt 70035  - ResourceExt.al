tableextension 70035 "ResourceExt Temp" extends Resource
{


    fields
    {


        field(60090; "User Id"; Code[50])
        {
            Description = 'b2b';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60100; Department; Code[10])
        {
            Editable = true;
            TableRelation = "Work Center"."No.";
            DataClassification = CustomerContent;
        }
    }

}

