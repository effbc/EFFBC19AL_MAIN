page 60243 "CS Transaction List"
{
    CardPageID = "CS Transaction Card";
    Editable = false;
    PageType = List;
    SourceTable = "CS Transaction Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                ApplicationArea = All;
            }
            repeater(Group)
            {
                field("Transaction ID"; Rec."Transaction ID")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transfer From Location"; Rec."Transfer From Location")
                {
                    ApplicationArea = All;
                }
                field("Transfer To Location"; Rec."Transfer To Location")
                {
                    ApplicationArea = All;
                }
                field("Mode of Transport"; Rec."Mode of Transport")
                {
                    ApplicationArea = All;
                }
                field("Courier Details"; Rec."Courier Details")
                {
                    ApplicationArea = All;
                }
                field("Transaction Status"; Rec."Transaction Status")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Customer No"; Rec."Customer No")
                {
                    ApplicationArea = All;
                }
                /*field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = All;
                }*/
                field("DC No"; Rec."DC No")
                {
                    ApplicationArea = All;
                }
                field("Responsible Persion";"Responsible Persion")
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

