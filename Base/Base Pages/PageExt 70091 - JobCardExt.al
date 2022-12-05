pageextension 70091 JobCardExt extends "Job Card"
{
    layout
    {
        modify("Bill-to Post Code")
        {
            Caption = 'Bill-to Post Code/City';
        }
        addbefore(Posting)
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                Caption = 'Departments Code';
                ApplicationArea = All;
            }
        }
        addafter("Ending Date")
        {
            field("Ending Time"; Rec."Ending Time")
            {
                ApplicationArea = All;
            }
            field("Starting Time"; Rec."Starting Time")
            {
                ApplicationArea = All;
            }
        }
        addafter("Calc. Recog. Costs G/L Amount")
        {
            group(Details)
            {
                Caption = 'Details';
                field("Status Code"; Rec."Status Code")
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Order Line No."; Rec."Sales Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Product Qty"; Rec."Product Qty")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        /* modify("Job &Task Lines")
        {
            Promoted = true;
            PromotedIsBig = true;
        } */
        modify("&Statistics")
        {
            Promoted = true;
        }
        /* modify("&Resource")
        {
            Promoted = true;
        }
        modify("&Item")
        {
            Promoted = true;
        }
        modify("&G/L Account")
        {
            Promoted = true;
            PromotedIsBig = true;
        } */
        modify("Ledger E&ntries")
        {
            Promoted = true;
        }
        modify("Copy Job Tasks &from...")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Copy Job Tasks &to...")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Job Actual to Budget")
        {
            Promoted = true;
        }
        modify("Job Analysis")
        {
            Promoted = true;
        }
        modify("Job - Planning Lines")
        {
            Promoted = true;
        }
        modify("Job - Suggested Billing")
        {
            Promoted = true;
        }
        addafter("Copy Job Tasks &from...")
        {
            separator(Action1102152014)
            {
            }
            action("Network Dataloger/Display Board")
            {
                Caption = 'Network Dataloger/Display Board';
                RunObject = Page "Item Wise Min. Req. Qty at Loc";
                ApplicationArea = All;
                //RunPageLink = "Last Date Modified" = FIELD("No.");
            }
            action("&Attachments")
            {
                Caption = '&Attachments';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.JobAttachments;
                end;
            }
            separator(Action1102152000)
            {
            }
            action("Pre Site Visit")
            {
                Caption = 'Pre Site Visit';
                RunObject = Page "Inst. PreSite Check List";
                RunPageLink = "Sales Order No." = FIELD("Sales Order No."), "Sales Order Line No." = FIELD("Sales Order Line No.");
                ApplicationArea = All;
            }
        }
    }



}

