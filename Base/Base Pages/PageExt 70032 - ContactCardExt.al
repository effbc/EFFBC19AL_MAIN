pageextension 70032 ContactCardExt extends "Contact Card"
{

    layout
    {


        modify("Post Code")
        {


            CaptionML = ENU = 'Post Code/City';


        }


        addafter("Foreign Trade")
        {
            group(Details)
            {
                Caption = 'Details';
                field("Contact Status"; Rec."Contact Status")
                {
                    ApplicationArea = All;
                }
                field("Initiated By"; Rec."Initiated By")
                {
                    ApplicationArea = All;
                }
                field("Enquiry Type"; Rec."Enquiry Type")
                {
                    ApplicationArea = All;
                }
                field("Govt./Private"; Rec."Govt./Private")
                {
                    ApplicationArea = All;
                }
                field("Domestic/Foreign"; Rec."Domestic/Foreign")
                {
                    ApplicationArea = All;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                }
                field("Product Category Code"; Rec."Product Category Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {


        modify(SalesQuotes)
        {


            Promoted = true;



        }



        modify(Statistics)
        {


            Promoted = true;

        }

        modify("Apply Template")
        {



            Promoted = true;


        }
        modify("Create &Interaction")
        {



            Promoted = true;



        }


        modify(ContactCoverSheet)
        {
            Promoted = true;


        }
    }



}

