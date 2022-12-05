pageextension 70211 ServiceListCustExt extends 5901
{


    layout
    {


        /* modify("Control1")
         {



             ShowCaption = false;
         }*/


        addafter(Name)
        {
            field("Posting Date"; Rec."Posting Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Control1")
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        // Add changes to page actions here
        addafter("&Line")
        {
            action(CardEdit)
            {
                ApplicationArea = Service;
                Caption = 'Card';
                Image = EditLines;
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or change detailed information about the record on the document or journal line.';

                trigger OnAction()
                var
                    PageManagement: Codeunit "Page Management";
                begin
                    PageManagement.PageRun(Rec);
                end;

            }
        }

        modify(Card)
        {
            Visible = false;
        }


    }




}

