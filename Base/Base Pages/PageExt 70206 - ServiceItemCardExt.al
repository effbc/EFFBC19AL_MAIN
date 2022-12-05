pageextension 70206 ServiceItemCardExt extends "Service Item Card"
{


    layout
    {



        modify("Post Code")
        {



            CaptionML = ENU = 'Post Code/City';


        }



        modify("Ship-to Post Code")
        {


            CaptionML = ENU = 'Ship-to Post Code/City';



        }



        addafter("Service Item Components")
        {
            field(ITLSNO; Rec.ITLSNO)
            {
                ApplicationArea = All;
            }
            field("SO No."; Rec."SO No.")
            {
                ApplicationArea = All;
            }
            field("SO Line No."; Rec."SO Line No.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Priority)
        {
            /* field("Sales Date"; Rec."Sales Date")
            {
                ApplicationArea = All;
            } */
            field("Creation Date"; Rec."Creation Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Preferred Resource")
        {
            field("WORKING STATUS"; Rec."WORKING STATUS")
            {
                ApplicationArea = All;
            }
            field("Present Location"; Rec."Present Location")
            {
                ApplicationArea = All;
            }
            field("Changed Location"; Rec."Changed Location")
            {
                ApplicationArea = All;

                trigger OnValidate();
                var
                    Dimension_Value: Record "Dimension Value";
                    "Item Ledger Entry": Record "Item Ledger Entry";


                begin
                    Rec.TESTFIELD(ITLSNO);
                    IF ((Rec."Changed Location" <> 'H-OFF') AND (Rec."Changed Location" <> 'SERVICE') AND (Rec."Changed Location" <> 'DAMAGE') AND
                        (Rec."Changed Location" <> 'OLD STOCK') AND (Rec."Changed Location" <> 'PRODUCT') AND (Rec."Changed Location" <> 'DUMMY')) THEN BEGIN
                        Dimension_Value.RESET;
                        Dimension_Value.SETRANGE(Dimension_Value."Dimension Code", 'LOCATIONS');
                        Dimension_Value.SETRANGE(Dimension_Value.Code, Rec."Changed Location");
                        IF Dimension_Value.FINDFIRST THEN
                            Rec."Present Location" := Dimension_Value.Name;

                        IF "Item Ledger Entry".GET(Rec.ITLSNO) THEN BEGIN
                            "Item Ledger Entry"."Location Code" := 'SITE';
                            "Item Ledger Entry"."Global Dimension 2 Code" := Rec."Changed Location";
                            "Item Ledger Entry".MODIFY;
                        END;
                    END;
                end;
            }
        }
        addafter("Ship-to Phone No.")
        {
            field("No. Series"; Rec."No. Series")
            {
                ApplicationArea = All;
            }
        }
        addafter("Installation Date")
        {
            field("Installed Location"; Rec."Installed Location")
            {
                ApplicationArea = All;
            }
            field(Territory; Rec.Territory)
            {
                ApplicationArea = All;
            }
            field(Position; Rec.Position)
            {
                ApplicationArea = All;
            }
            field("Power Supply"; Rec."Power Supply")
            {
                ApplicationArea = All;
            }
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = All;
            }
            field("Job Installation Date"; Rec."Job Installation Date")
            {
                ApplicationArea = All;
            }
            field("Software Code"; Rec."Software Code")
            {
                ApplicationArea = All;
            }
            field("Software Version"; Rec."Software Version")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {



        modify("Co&mments")
        {



            Promoted = true;



        }



        modify("Action39")
        {

            Promoted = true;



        }


        modify("Ser&vice Contracts")
        {



            Promoted = true;



        }



        modify("New Item")
        {



            Promoted = true;



        }


        modify("Service Line Item Label")
        {



            Promoted = false;



        }
        addfirst(Documents)
        {
            action("Service Orders")
            {
                Caption = 'Service Orders';
                Image = Document;
                RunObject = Page 5903;
                RunPageLink = "Service Item No." = FIELD("No.");
                RunPageView = SORTING("Service Item No.") ORDER(Ascending);
                ApplicationArea = All;
            }
        }
        addbefore(New)
        {
            separator(Action1102152000)
            {
            }
            action("Network Dataloger/Display Board")
            {
                Caption = 'Network Dataloger/Display Board';
                RunObject = Page "Service Item DataLoggers";

                RunPageLink = "Creation Date" = Filter('04/01/09'), "Base Location" = FIELD("No.");
                ApplicationArea = All;

            }

            action("&Attachments")
            {
                Caption = '&Attachments';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Attachments;
                end;
            }
        }
    }




    var
        "location code": Record "Location of service item";
        "Item Ledger Entry": Record "Item Ledger Entry";
        Dimension_Value: Record "Dimension Value";
        Err: Boolean;

        "Item No.Editable": Boolean;
        CreationD: Date;



    local procedure ItemNoOnFormat();
    begin

        IF "Item No." <> '' THEN
            "Item No.Editable" := FALSE
        ELSE
            "Item No.Editable" := TRUE;

        RESET;
    end;


}

