page 60102 "Mile Stone Payments"
{
    // version MSPT1.0,Rev01

    // B2B Software Technologies
    // ---------------------------------------------------
    // Project : Mile Stone Payment Terms
    // B2B
    // No. sign   Description
    // ---------------------------------------------------
    // 01  B2B    Mile Stone Payments

    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "MSPT Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
               
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part(Control1102152006; "MSPT Subform")
            {
                SubPageLink = "MSPT Header Code"= FIELD(Code);
    ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Line)
            {
                Caption = '&Line';
                Visible = false;
                action(List)
                {
                    Caption = 'List';
                    Image = List;
                    RunObject = Page "MSPT Line List";
                    ShortCutKey = 'F5';
                    ApplicationArea = All;
                }
            }
        }
    }
}

