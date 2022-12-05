page 60266 "Quote LookUp Types"
{
    // version B2BQTO

    Caption = 'Quote LookUp Types';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Quote LookUp Type";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

