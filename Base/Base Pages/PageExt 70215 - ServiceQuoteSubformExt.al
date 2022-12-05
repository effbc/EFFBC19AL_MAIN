pageextension 70215 ServiceQuoteSubformExt extends "Service Quote Subform"
{


    layout
    {


        /*  modify("Control1")
          {

              ShowCaption = false;
          }*/


    }
    actions
    {


        modify("Resource &Allocations")
        {



            ShortCutKey = 'Shift+Ctrl+A';
        }



        addafter(ServiceLines)
        {
            action("&Attachments")
            {
                Caption = '&Attachments';
                ApplicationArea = All;

                trigger OnAction();
                begin

                    OpenAttachments;

                end;
            }
        }
        addafter(ServiceLines)
        {
            action(Action1903970104)
            {
                Caption = '&Attachments';
                ApplicationArea = All;

                trigger OnAction();
                begin

                    OpenAttachments;

                end;
            }
        }
    }





    procedure "---B2B--"();
    begin
    end;


    procedure OpenAttachments();
    var
        Attachments: Record Attachments;
    begin
        Attachments.RESET;
        Attachments.SETRANGE("Table ID", DATABASE::"Service Header");
        Attachments.SETRANGE("Document No.", Rec."Document No.");
        Attachments.SETRANGE("Document Type", Rec."Document Type");

        PAGE.RUN(PAGE::"ESPL Attachments", Attachments);
    end;



}

