pageextension 70194 SalesQuoteArchiveExt extends "Sales Quote Archive"
{


    layout
    {

        addafter(Version)
        {
            group(Others)
            {
                Caption = 'Others';
                field("Document Position"; Rec."Document Position")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Sell-to Customer Templ. Code")
        {
            field("Enquiry Status"; Rec."Enquiry Status")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Sell-to Contact No."; "Sell-to Customer Name")
    }
    actions
    {



        modify(Restore)
        {



            Promoted = true;
        }
        addafter(Restore)
        {
            action("Customer/Contact List")
            {
                Caption = 'Customer/Contact List';
                Image = ContactFilter;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Customer/Contact Archive  List";
                RunPageLink = "Sales Quote No." = FIELD("No."), "Version No." = FIELD("Version No.");
                ApplicationArea = All;
            }
        }
    }

}

