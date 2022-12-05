page 60085 "Tender list"
{
    // version B2B1.0

    CardPageID = Tender;
    Editable = false;
    PageType = List;
    SourceTable = "Tender Header";
    SourceTableView = WHERE("Old Tender" = CONST(false));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                ApplicationArea = All;
            }
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                }
                field(TenderType; Rec.TenderType)
                {
                    ApplicationArea = All;
                }
                field("Tender Description"; Rec."Tender Description")
                {
                    ApplicationArea = All;
                }
                field(Product; Rec.Product)
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Tender Status"; Rec."Tender Status")
                {
                    ApplicationArea = All;
                }
                field("EMD Status"; Rec."EMD Status")
                {
                    ApplicationArea = All;
                }
                field("EMD Amount"; Rec."EMD Amount")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Tender No."; Rec."Customer Tender No.")
                {
                    ApplicationArea = All;
                }
                field("Minimum Bid Amount"; Rec."Minimum Bid Amount")
                {
                    ApplicationArea = All;
                }
                field("Tender Dated"; Rec."Tender Dated")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Tender doc Issue From"; Rec."Tender doc Issue From")
                {
                    ApplicationArea = All;
                }
                field("Tender doc Issue To"; Rec."Tender doc Issue To")
                {
                    ApplicationArea = All;
                }
                field("Submission Due Date"; Rec."Submission Due Date")
                {
                    ApplicationArea = All;
                }
                field("Submission Due Time"; Rec."Submission Due Time")
                {
                    ApplicationArea = All;
                }
                field("Tech. Bid Opening Date"; Rec."Tech. Bid Opening Date")
                {
                    ApplicationArea = All;
                }
                field("Sent For Auth"; Rec."Sent For Auth")
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

