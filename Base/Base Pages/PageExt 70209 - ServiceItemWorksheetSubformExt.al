pageextension 70209 ServiceItemWorksheetSubformExt extends 5907
{




    layout
    {



        /*modify(Control1)
        {

            

            ShowCaption = false;
        }*/


        modify("Fault Area Code")
        {



            CaptionML = ENU = 'Product-Module';


        }


        addafter(Type)
        {
            field(Levels; Rec.Levels)
            {
                ApplicationArea = All;
            }
        }
        addafter("Fault Area Code")
        {
            field("Fault Area Description"; Rec."Fault Area Description")
            {
                Caption = 'Product-Module Desc';
                Editable = false;
                Visible = false;
                ApplicationArea = All;
            }
            field("Sub Module Code"; Rec."Sub Module Code")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Sub Module Descrption"; Rec."Sub Module Descrption")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
            }
        }
        addafter("Fault Code")
        {
            field("Fault Code Description"; Rec."Fault Code Description")
            {
                Caption = 'Problem description';
                Editable = true;
                ApplicationArea = All;
            }
            field("Fault Reason Description"; Rec."Fault Reason Description")
            {
                Caption = 'Cause identified';
                ApplicationArea = All;
            }
        }
        addafter("Resolution Code")
        {
            field("Resolution Description"; Rec."Resolution Description")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Symptom Description"; Rec."Symptom Description")
            {
                ApplicationArea = All;
            }
            field(Observations; Rec.Observations)
            {
                ApplicationArea = All;
            }
            field("Component Legending"; Rec."Component Legending")
            {
                ApplicationArea = All;
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
            }
        }

    }







    var
        "Reservation entry": Record "Reservation Entry";
        status: Record "Repair Status";
        "ITEMLEDGER ENTRY": Record "Item Ledger Entry";
        "TRACKING SPE": Record "Tracking Specification";
        "SERIAL NO": Code[10];
        "line no": Integer;
        text: Text[30];


    trigger OnModifyRecord(): Boolean

    var

    begin
        //added by pranavi to make the fault code, cause, resolution code, symptom code fields to be mandatory to enter on 10-01-2015
        IF Rec.Type <> Rec.Type::Resource THEN BEGIN
            Rec.TESTFIELD("Fault Code");
            Rec.TESTFIELD("Fault Reason Code");
            Rec.TESTFIELD("Resolution Code");
            Rec.TESTFIELD("Symptom Code");
        END;
        //end by pranavi
    end;



}
