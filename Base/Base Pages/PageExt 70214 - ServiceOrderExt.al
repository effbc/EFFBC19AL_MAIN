pageextension 70214 ServiceOrderExt extends 5900
{


    layout
    {


        modify("Bill-to Post Code")
        {



            CaptionML = ENU = 'Bill-to Post Code/City';


        }

        modify("Ship-to Post Code")
        {


            CaptionML = ENU = 'Ship-to Post Code/City';


        }


        modify("Order Time")
        {
            trigger OnBeforeValidate()
            begin
                OrderTimeC1000000005OnAfterVal;
            end;
        }





        addafter("Responsibility Center")
        {
            field("No. of Archived Versions"; Rec."No. of Archived Versions")
            {
                ApplicationArea = All;
            }
        }
        addafter("Assigned User ID")
        {
            field(Purpose; Rec.Purpose)
            {
                ApplicationArea = All;
            }
            field("Material Issue no."; Rec."Material Issue no.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Release Status")
        {
            field("Customer Cards"; Rec."Customer Cards")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Transation ID"; Rec."Transation ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Max. Labor Unit Price")
        {
            field("<Service Order Type2>"; Rec."Service Order Type")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to E-Mail")
        {
            field("Shipping No. Series"; Rec."Shipping No. Series")
            {
                ApplicationArea = All;
            }
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


        modify(Statistics)
        {
            Promoted = true;
        }



        modify("S&hipments")
        {



            Promoted = true;


        }



        /*modify("Create Whse Shipment")
        {

      

            Promoted = true;

           

        }*/







        modify("Release to Ship")
        {
            Promoted = true;



        }
        modify(Reopen)
        {
            Promoted = true;
        }
        modify("Create Whse Shipment")
        {



            Promoted = true;
        }



        modify(Post)
        {


            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Post and &Print")
        {



            Promoted = true;
            PromotedIsBig = true;



        }



        modify("&Print")
        {



            Promoted = true;



        }
        addafter("Update Reference Invoice No.")
        {
            action("Archi&ve Document")
            {
                Caption = 'Archi&ve Document';
                ApplicationArea = All;

                trigger OnAction();
                var
                    ArchiveManagement: Codeunit 5063;
                    ServiceHeaderArchive: Record "Service Header Archive";
                    TC: Codeunit "Custom Events";
                begin
                    TC.ArchiveServiceDocument(Rec);
                    CurrPage.UPDATE(FALSE);
                end;
            }
        }
    }




    local procedure OrderTimeC1000000005OnAfterVal();
    begin
        Rec.UpdateResponseDateTime;
        CurrPage.UPDATE;
    end;


}

