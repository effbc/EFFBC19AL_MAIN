table 33000907 "PCB Version Control"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "PCB No"; Code[20])
        {
            TableRelation = Item."No." WHERE("Product Group Code Cust" = FILTER('PCB'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "PCB No" = "PCB No2" then
                    Error('PCB1 and PCB2 cannot be same');
                if Item.Get("PCB No") then
                    "PCB1 Descrption" := Item.Description;
            end;
        }
        field(2; "PCB1 Descrption"; Text[50])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("PCB No");
            end;
        }
        field(3; "PCB No2"; Code[20])
        {
            TableRelation = Item."No." WHERE("Product Group Code Cust" = FILTER('PCB'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "PCB No" = "PCB No2" then
                    Error('PCB1 and PCB2 cannot be same');

                PCB := "PCB No";
                repeat
                    PVC.Reset;
                    PVC.SetFilter(PVC."PCB No2", PCB);
                    if PVC.FindFirst then begin
                        PCB := PVC."PCB No";
                        if PVC."PCB No" = "PCB No2" then
                            Error('In Correct Entry');
                    end
                    else
                        k := 10;
                until k = 10;
                if Item.Get("PCB No2") then
                    "PCB2 Descrption" := Item.Description;
            end;
        }
        field(4; "PCB2 Descrption"; Text[50])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("PCB No2");
            end;
        }
    }

    keys
    {
        key(Key1; "PCB No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PVC: Record "PCB Version Control";
        k: Integer;
        PCB: Code[20];
        Item: Record Item;
}

