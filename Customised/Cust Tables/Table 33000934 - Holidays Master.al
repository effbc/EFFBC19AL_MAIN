table 33000934 "Holidays Master"
{
    DrillDownPageID = Holidays;
    LookupPageID = Holidays;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Date Of Holiday"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(2; Reason; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Holiday Type"; Option)
        {
            OptionCaption = '" ,DECLARED,OPTIONAL,SELECTED,Sunday"';
            OptionMembers = " ",DECLARED,OPTIONAL,SELECTED,Sunday;
            DataClassification = CustomerContent;
        }
        field(4; "Working Sunday"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Holiday Type", "Holiday Type"::Sunday);

                if Date2DWY("Date Of Holiday", 1) <> 7 then
                    Error('The date you selected is not sunday.');
            end;
        }
    }

    keys
    {
        key(Key1; "Date Of Holiday")
        {
        }
    }

    fieldgroups
    {
    }
}

