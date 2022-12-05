pageextension 70246 TroubleshootingSetupExt extends 5993
{


    layout
    {



        /*modify("Control1")
        {

         

            ShowCaption = false;
        }*/


        addafter(Type)
        {
            field("Service Order No"; Rec."Service Order No")
            {
                ApplicationArea = All;
            }
        }
        addafter("Service Order No")
        {
            field(Date; Rec.Date)
            {
                ApplicationArea = All;
            }
        }
        addafter("Troubleshooting Description")
        {
            field(Comment; Rec.Comment)
            {
                ApplicationArea = All;
            }
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {


        addafter(Card)
        {
            action("Copy Comments")
            {
                Caption = 'Copy Comments';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.Date := WORKDATE;
                    TroubleshootingLine.SETRANGE("No.", Rec."Troubleshooting No.");
                    IF TroubleshootingLine.FINDSET THEN
                        REPEAT
                            Rec."Line No." := TroubleshootingLine."Line No.";
                            Rec.Comment := TroubleshootingLine.Comment;
                            Rec."Troubleshooting No." := Rec."Troubleshooting No.";
                            Rec.Type := Rec.Type;
                            Rec.INSERT;
                        UNTIL TroubleshootingLine.NEXT = 0;
                    MESSAGE('Records Inserted');
                    TroubleshootingLine.SETRANGE("No.", Rec."Troubleshooting No.");
                    TroubleShootingSetUp.RESET;
                    TroubleShootingSetUp.SETFILTER("Line No.", '=0');
                    IF TroubleShootingSetUp.FINDFIRST THEN
                        TroubleShootingSetUp.DELETEALL;
                end;
            }
        }
    }




    var
        "---b2b EFF---": Integer;
        TroubleshootingLine: Record "Troubleshooting Line";
        TroubleShootingSetUp: Record "Troubleshooting Setup";



}

