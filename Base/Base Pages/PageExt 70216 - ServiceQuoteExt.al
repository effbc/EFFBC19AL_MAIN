pageextension 70216 ServiceQuoteExt extends 5964
{


    layout
    {



        modify("Post Code")
        {


            CaptionML = ENU = 'Post Code/City';



        }


        modify("Phone No. 2")
        {



            CaptionML = ENU = 'Phone No./Phone No. 2';


        }



        modify("Bill-to Post Code")
        {


            CaptionML = ENU = 'Bill-to Post Code/City';



        }



        modify("Ship-to Post Code")
        {



            CaptionML = ENU = 'Ship-to Post Code/City';



        }



        addbefore(ServItemLine)
        {
            field("No. of Archived Versions"; Rec."No. of Archived Versions")
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


        /* modify("Action 33")
         {
             Promoted = true;



         }
         modify("Action 40")
         {



             Promoted = true;


         }*/
        addbefore("F&unctions")
        {
            separator(Action1102152000)
            {
            }
            action("Archi&ve Document")
            {
                Caption = 'Archi&ve Document';
                ApplicationArea = All;

                trigger OnAction();
                var
                    ArchiveManagement: Codeunit "Custom Events";
                    ServiceHeaderArchive: Record "Service Header Archive";
                begin
                    ArchiveManagement.ArchiveServiceDocument(Rec);
                    CurrPage.UPDATE(FALSE);
                end;
            }
        }
        addafter("Make &Order")
        {
            action(Action1102152047)
            {
                Caption = 'Archi&ve Document';
                ApplicationArea = All;

                trigger OnAction();
                var
                    ArchiveManagement: Codeunit "Custom Events";
                    ServiceHeaderArchive: Record "Service Header Archive";
                begin
                    ArchiveManagement.ArchiveServiceDocument(Rec);
                    CurrPage.UPDATE(FALSE);
                end;
            }
            group("&Make To")
            {
                Caption = '&Make To';
                Visible = false;
                action("Blanket Order")
                {
                    Caption = 'Blanket Order';
                    RunObject = Codeunit "PO Automation";
                    ApplicationArea = All;
                }
                action("Order")
                {
                    Caption = 'Order';
                    RunObject = Codeunit "Sales-Quote to Order (Yes/No)";
                    ApplicationArea = All;
                }
            }
        }
    }




}

