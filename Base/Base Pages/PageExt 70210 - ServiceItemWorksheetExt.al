pageextension 70210 ServiceItemWorksheetExt extends "Service Item Worksheet"
{


    layout
    {



        addafter("Resolution Code")
        {
            field("CS Product"; Rec."CS Product")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("CS model"; Rec."CS model")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("CS Module"; Rec."CS Module")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {



        modify("&Print")
        {



            Promoted = true;



        }
        addafter("Demand Overview")
        {
            action("T&roubleshooting Setup")
            {
                Caption = 'T&roubleshooting Setup';
                Image = Troubleshoot;
                RunObject = page 5993;
                RunPageLink = "No." = FIELD("Service Item No.");
                ApplicationArea = All;
            }
        }
        addafter("Demand Overview")
        {
            action("Get Issued Material")
            {
                Caption = 'Get Issued Material';
                ApplicationArea = All;

                trigger OnAction();
                var
                    testvar: Text;
                begin
                    UserEmpID := '';
                    UserSetupGrec.RESET;
                    UserSetupGrec.SETFILTER(UserSetupGrec."User ID", USERID);
                    IF UserSetupGrec.FINDFIRST THEN
                        UserEmpID := UserSetupGrec."Current UserId"
                    ELSE
                        ERROR('Current user id is not defined Contact ERP team');
                    Rec_Found := FALSE;
                    c := 0;

                    "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."Transfer-to Code", 'CST');
                    "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."Service Order No.", Rec."Document No.");
                    "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."Service Item", Rec."Service Item No.");
                    "Posted Material Issues Header".SETFILTER("Posted Material Issues Header"."Transfer-from Code", '%1|%2', 'STR', 'CS STR');
                    IF NOT (USERID IN ['EFFTRONICS\DURGAMAHESWARI']) THEN
                        "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."User ID", USERID);
                    IF "Posted Material Issues Header".FINDSET THEN BEGIN
                        //c:="Posted Material Issues Header".COUNT;
                        REPEAT
                            "Service Invoice Line".RESET;
                            "Service Invoice Line".SETRANGE("Service Invoice Line"."Document No.", Rec."Document No.");
                            // "Service Invoice Line".SETRANGE("Service Invoice Line"."Service Item No.","Service Item No.");
                            IF "Service Invoice Line".FINDLAST THEN BEGIN
                                "PostedServiceInvLineNo." := "Service Invoice Line"."Line No.";
                            END ELSE
                                "PostedServiceInvLineNo." := 0;

                            "Posted Material Issues Line".SETRANGE("Posted Material Issues Line"."Document No.", "Posted Material Issues Header"."No.");
                            "Posted Material Issues Line".SETFILTER("Posted Material Issues Line".Quantity, '>%1', 0);
                            IF "Posted Material Issues Line".FINDSET THEN
                                REPEAT
                                    ServLineGrec.RESET;
                                    ServLineGrec.SETFILTER(ServLineGrec."Material Issue No", "Posted Material Issues Line"."Document No.");
                                    ServLineGrec.SETFILTER(ServLineGrec."Material Issue Line No", '%1', "Posted Material Issues Line"."Line No.");
                                    ServLineGrec.SETFILTER(ServLineGrec."Document No.", Rec."Document No.");
                                    IF NOT ServLineGrec.FINDFIRST THEN BEGIN
                                        ItemLedgerEntry.SETCURRENTKEY(ItemLedgerEntry."Document No.", ItemLedgerEntry."Item No.", ItemLedgerEntry."Posting Date");
                                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Document No.", "Posted Material Issues Header"."No.");
                                        ItemLedgerEntry.SETRANGE(ItemLedgerEntry."Item No.", "Posted Material Issues Line"."Item No.");
                                        ItemLedgerEntry.SETFILTER(ItemLedgerEntry."Remaining Quantity", '>%1', 0);
                                        IF ItemLedgerEntry.FINDFIRST THEN BEGIN
                                            SrceRefNo := 0;
                                            temprec.RESET;
                                            temprec.SETFILTER(temprec."Document No.", Rec."Document No.");
                                            temprec.SETFILTER(temprec."Service Item No.", Rec."Service Item No.");
                                            temprec.SETFILTER(temprec."No.", "Posted Material Issues Line"."Item No.");
                                            IF NOT temprec.FINDLAST THEN BEGIN
                                                "Service Invoice Line".INIT;
                                                "Service Invoice Line"."Document Type" := "Service Invoice Line"."Document Type"::Order;
                                                "Service Invoice Line"."Document No." := Rec."Document No.";
                                                "PostedServiceInvLineNo." += 10000;
                                                "Service Invoice Line"."Line No." := "PostedServiceInvLineNo.";
                                                "Service Invoice Line".VALIDATE("Service Invoice Line"."Service Item No.", Rec."Service Item No.");
                                                SrceRefNo := "PostedServiceInvLineNo.";
                                                "Service Invoice Line".VALIDATE("Service Invoice Line".Type, "Service Invoice Line".Type::Item);
                                                "Service Invoice Line".VALIDATE("Service Invoice Line"."No.", "Posted Material Issues Line"."Item No.");
                                                "Service Invoice Line".VALIDATE("Service Invoice Line".Quantity, "Posted Material Issues Line".Quantity);
                                                "Service Invoice Line"."Location Code" := 'CST';
                                                "Service Invoice Line".VALIDATE("Service Invoice Line"."Location Code", 'CST');
                                                IF UPPERCASE("Posted Material Issues Header"."User ID") IN ['EFFTRONICS\AASALATHA', 'EFFTRONICS\RPRASANTHI', 'EFFTRONICS\NAGALAKSHMI', 'EFFTRONICS\SOWJANYA'] THEN BEGIN
                                                    "Service Invoice Line"."Fault Code" := 'FC00018';
                                                    "Service Invoice Line"."Fault Code Description" := 'PHYSICAL OBSERVATIONS';
                                                    //added by pranavi on 27-01-2015
                                                    "Service Invoice Line"."Symptom Code" := 'SY00233';
                                                    "Service Invoice Line"."Symptom Description" := 'Component Breakages';
                                                    "Service Invoice Line"."Resolution Code" := 'RE00001';
                                                    "Service Invoice Line"."Resolution Description" := 'COMPONENTS REPLACED';
                                                    "Service Invoice Line"."Fault Reason Code" := 'FRC0176';
                                                    "Service Invoice Line"."Fault Reason Description" := 'Physical Observation';
                                                    //end pranavi
                                                END;
                                                "Service Invoice Line"."Fault Area Code" := Rec."Fault Area Code";
                                                "Service Invoice Line"."Fault Area Description" := Rec."Fault Area Description";
                                                "Service Invoice Line"."Sub Module Code" := Rec."Sub Module Code";
                                                "Service Invoice Line"."Sub Module Descrption" := Rec."Sub Module Descrption";

                                                "Service Invoice Line".INSERT;
                                                Rec_Found := TRUE;
                                                c := c + 1;
                                            END ELSE BEGIN
                                                /*      // Added by Pranavi on 16-Jan-2017 for solving qty wrong updated
                                                temprec.VALIDATE(temprec.Quantity,temprec.Quantity + "Posted Material Issues Line".Quantity);
                                                SrceRefNo := temprec."Line No.";
                                                temprec.MODIFY;
                                                */
                                            END;    // End by Pranavi

                                            "Reservation Entry".RESET;
                                            IF "Reservation Entry".FINDLAST THEN
                                                "No. of Items" := "Reservation Entry"."Entry No.";
                                            "No. of Items" += 1;
                                            "Reservation Entry".INIT;
                                            "Reservation Entry"."Entry No." := "No. of Items";
                                            "Reservation Entry"."Created By" := USERID;
                                            "Reservation Entry"."Creation Date" := WORKDATE;

                                            "Reservation Entry".Positive := TRUE;
                                            "Reservation Entry"."Item No." := "Posted Material Issues Line"."Item No.";
                                            "Reservation Entry".VALIDATE("Reservation Entry"."Item No.", "Posted Material Issues Line"."Item No.");
                                            "Reservation Entry"."Location Code" := 'CST';
                                            //"Reservation Entry".VALIDATE("Quantity (Base)":=ItemLedgerEntry.Quantity;
                                            "Reservation Entry".VALIDATE("Quantity (Base)", -ItemLedgerEntry.Quantity);
                                            "Reservation Entry".VALIDATE("Location Code", 'CST');
                                            "Reservation Entry".VALIDATE("Reservation Status", "Reservation Entry"."Reservation Status"::Prospect);

                                            "Reservation Entry"."Reservation Status" := "Reservation Entry"."Reservation Status"::Prospect;
                                            "Reservation Entry"."Source Type" := 5902;
                                            "Reservation Entry"."Source Subtype" := 1;
                                            "Reservation Entry"."Source ID" := Rec."Document No.";

                                            //"Reservation Entry"."Source Ref. No.":="Service Invoice Line"."Line No.";
                                            "Reservation Entry"."Source Ref. No." := SrceRefNo;

                                            "Reservation Entry"."Lot No." := ItemLedgerEntry."Lot No.";
                                            "Reservation Entry"."Serial No." := ItemLedgerEntry."Serial No.";
                                            "Reservation Entry".VALIDATE("Expected Receipt Date", WORKDATE);
                                            "Reservation Entry".VALIDATE("Qty. per Unit of Measure", ItemLedgerEntry."Qty. per Unit of Measure");
                                            "Reservation Entry".VALIDATE("Suppressed Action Msg.", FALSE);
                                            "Reservation Entry".VALIDATE("Planning Flexibility", "Reservation Entry"."Planning Flexibility"::Unlimited);
                                            "Reservation Entry".INSERT;
                                        END;
                                    END;
                                UNTIL "Posted Material Issues Line".NEXT = 0;
                        UNTIL "Posted Material Issues Header".NEXT = 0;
                    END ELSE
                        ERROR('There Is no Material Issues For this Service Item & Service Order No.');

                    IF Rec_Found = TRUE THEN BEGIN
                        "Service Invoice Line".INIT;
                        "Service Invoice Line"."Document Type" := "Service Invoice Line"."Document Type"::Order;
                        "Service Invoice Line"."Document No." := Rec."Document No.";
                        "PostedServiceInvLineNo." += 10000;
                        "Service Invoice Line"."Line No." := "PostedServiceInvLineNo.";
                        "Service Invoice Line".VALIDATE("Service Invoice Line"."Service Item No.", Rec."Service Item No.");
                        "Service Invoice Line".VALIDATE("Service Invoice Line"."Location Code", 'CST');
                        "Service Invoice Line".VALIDATE("Service Invoice Line".Type, "Service Invoice Line".Type::Resource);
                        "Service Invoice Line".VALIDATE("Service Invoice Line"."No.", UserEmpID);   //Changed by sundar ("Posted Material Issues Header"."User ID"-->UserEmpID) for NAV2013
                        IF UPPERCASE("Posted Material Issues Header"."User ID") IN ['EFFTRONICS\AASALATHA', 'EFFTRONICS\RPRASANTHI', 'EFFTRONICS\NAGALAKSHMI', 'EFFTRONICS\SOWJANYA'] THEN BEGIN
                            "Service Invoice Line"."Fault Code" := 'FC00018';
                            "Service Invoice Line"."Fault Code Description" := 'PHYSICAL OBSERVATIONS';
                            //added by pranavi on 27-01-2015
                            "Service Invoice Line"."Symptom Code" := 'SY00233';
                            "Service Invoice Line"."Symptom Description" := 'Component Breakages';
                            "Service Invoice Line"."Resolution Code" := 'RE00001';
                            "Service Invoice Line"."Resolution Description" := 'COMPONENTS REPLACED';
                            "Service Invoice Line"."Fault Reason Code" := 'FRC0176';
                            "Service Invoice Line"."Fault Reason Description" := 'Physical Observation';
                            //end pranavi
                        END;
                        "Service Invoice Line"."Fault Area Code" := Rec."Fault Area Code";
                        "Service Invoice Line"."Fault Area Description" := Rec."Fault Area Description";
                        "Service Invoice Line"."Sub Module Code" := Rec."Sub Module Code";
                        "Service Invoice Line"."Sub Module Descrption" := Rec."Sub Module Descrption";
                        "Service Invoice Line".INSERT;
                    END
                    ELSE
                        MESSAGE('All Materials posted against this service order are dumped already');

                    /*
                    if c=0 then
                      MESSAGE('All Materials posted against this service order are dumped already');
                    */

                end;
            }
        }
        addafter("&Print")
        {
            action(IPBarchart)
            {
                Caption = 'Bar Chart';
                // Enabled = IPBarchartEnable;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
            }
        }
    }


    var
        "Posted Material Issues Header": Record "Posted Material Issues Header";
        "Posted Material Issues Line": Record "Posted Material Issues Line";
        "Service Invoice Line": Record "Service Line";
        "PostedServiceInvLineNo.": Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        "Tracking Specification": Record "Tracking Specification";
        "No. of Items": Integer;
        "Reservation Entry": Record "Reservation Entry";
        Rec_Found: Boolean;

    var
        UserEmpID: Code[20];
        UserSetupGrec: Record "User Setup";
        ServLineGrec: Record "Service Line";
        c: Integer;
        temppage: Page "Service Item Worksheet Subform";
        temprec: Record "Service Line";
        SrceRefNo: Integer;
        SLTemp: Record "Service Line";




}

