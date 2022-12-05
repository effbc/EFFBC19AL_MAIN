pageextension 70301 ProductionBOMExt extends 99000786
{
    layout
    {
        modify(Status)
        {
            trigger OnBeforeValidate()
            begin
                IF (COPYSTR("No.", 1, 8) <> 'ECMPBPCB') AND (Status = Status::Certified) AND NOT (USERID IN ['EFFTRONICS\JHANSI', 'EFFTRONICS\ANILKUMAR', 'ERPSERVER\ADMINISTRATOR', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\MANOJA', 'EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\NVSIVAKUMARI', 'EFFTRONICS\BHARAT', 'EFFTRONICS\BHAVANI']) THEN
                    ERROR('You dont have permissions to Certify the BOM');

                IF (COPYSTR("No.", 1, 8) = 'ECMPBPCB') AND NOT (USERID IN ['EFFTRONICS\JHANSI', 'EFFTRONICS\RSILPARANI', 'EFFTRONICS\RATNARAVALI', 'EFFTRONICS\UBEDULLA', 'EFFTRONICS\ANILKUMAR', 'ERPSERVER\ADMINISTRATOR', 'EFFTRONICS\MANOJA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\NVSIVAKUMARI', 'EFFTRONICS\BHARAT', 'EFFTRONICS\BHAVANI']) THEN
                    ERROR('You dont have permissions to Certify the MASTER BOM');

                //Added by Vishnu Priya to restrict the modifications to certified BOMs on 04-06-2020
                IF ((Status = Rec.Status::"Under Development") OR (Status = Rec.Status::New)) AND (xRec.Status = xRec.Status::Certified) AND NOT (USERID IN ['EFFTRONICS\VANIDEVI', 'ERPSERVER\ADMINISTRATOR', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\MANOJA', 'EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\NVSIVAKUMARI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\BHARAT', 'EFFTRONICS\BHAVANI']) THEN
                    ERROR('You dont have permissions to change the Certified BOM');
            end;
        }
        modify(Description)
        {
            trigger OnAfterValidate()
            begin
                IF Status = Status::Certified THEN// Added by Suvarchaladevi on 20-08-2022 with DQA input
                              BEGIN
                    IF NOT (USERID IN ['EFFTRONICS\SUVARCHALADEVI']) THEN
                        ERROR('Description can not be changed when BOM is Certified');
                END
            end;
        }
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;

            }
        }
        addafter(Status)
        {
            field("Total Soldering Points SMD"; Rec."Total Soldering Points SMD")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Total Soldering Points DIP"; Rec."Total Soldering Points DIP")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Total Soldering Points"; Rec."Total Soldering Points")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BOM Cost"; Rec."BOM Cost")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Stranded BOM"; Rec."Stranded BOM")
            {
                Caption = 'Stranded BOM';
                ApplicationArea = All;
            }
        }
        addafter("Last Date Modified")
        {
            field("Bench Mark Time(In Hours)"; Rec."Bench Mark Time(In Hours)")
            {
                ApplicationArea = All;

            }
            field("Total No. of Fixing Holes"; Rec."Total No. of Fixing Holes")
            {
                ApplicationArea = All;

            }
            field("User Id"; Rec."User Id")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("BOM Type"; Rec."BOM Type")
            {
                ApplicationArea = All;

            }
            field("Modified User ID"; Rec."Modified User ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = All;

            }
            field("Total Qtyper SMD"; "Total Qtyper SMD")
            {
                Caption = 'Total SMD Qty per';
                ApplicationArea = All;
            }
            field("Total Qtyper DIP"; "Total Qtyper DIP")
            {
                Caption = 'Total DIP Qty per';
                ApplicationArea = All;
            }
            field("Total Qtyper"; "Total Qtyper")
            {
                Caption = 'Total Qty per';
                ApplicationArea = All;
            }
            field("Update in PRM"; Rec."Update in PRM")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(Certify; Rec.Certify)
            {
                Editable = edit;
                ApplicationArea = All;
            }
            field("BOM Running Status"; Rec."BOM Running Status")
            {
                ApplicationArea = All;

            }
            field("Inherited From"; Rec."Inherited From")
            {
                ApplicationArea = All;

            }
            field(Configuration; Rec.Configuration)
            {
                ApplicationArea = All;

            }
            field("Remarks/Reason"; Rec."Remarks/Reason")
            {
                ApplicationArea = All;

            }
            field("BOM Category"; Rec."BOM Category")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        addafter("Where-used")
        {
            action(Boughtout)
            {
                Caption = 'Boughtout';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Bout.SETRANGE(Bout.Code, Rec."No.");
                    PAGE.RUN(7306, Bout);
                end;
            }
        }
        addafter("Copy &BOM")
        {
            separator(Action1000000004)
            {

            }
            action("Import PAD Software Data")
            {
                Caption = 'Import PAD Software Data';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CLEAR(PADSoftware);
                    PordBOMLineRec.SETRANGE("Production BOM No.", Rec."No.");
                    PADSoftware.Initilize(Rec."No.");
                    PADSoftware.RUN;
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action("Calculate Soldering Points")
            {
                Caption = 'Calculate Soldering Points';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    IF Rec.Status <> Rec.Status::Certified THEN BEGIN
                        Rec.StatusCheck3_Solder(Rec."No.");
                        Rec.SolderingPointsUpdate(Rec."No.");
                    END
                    ELSE
                        ERROR('Status must be released to modify');
                end;
            }
            action("BOM Authorization")
            {
                Caption = 'BOM Authorization';
                ApplicationArea = All;
                trigger OnAction()
                var
                    BOMLine: Record "Production BOM Line";
                    PrevItem: Text[30];
                    PrevPosition: Text;
                    PrevDescription: Text;
                    ProdBOMHeader: Record "Production BOM Header";
                begin
                    PrevItem := '';
                    PrevDescription := '';
                    PrevPosition := '';
                    BOMLine.RESET;
                    BOMLine.SETCURRENTKEY(Type, "No.");
                    BOMLine.SETRANGE("Version Code", '');
                    BOMLine.SETRANGE("Production BOM No.", Rec."No.");
                    IF BOMLine.FINDSET THEN
                        REPEAT
                            IF (PrevItem = BOMLine."No.") AND (PrevDescription = BOMLine.Description) AND (PrevPosition = BOMLine.Position) THEN
                                ERROR('BOM having Duplicate Item :: ', BOMLine."No.");
                            PrevItem := BOMLine."No.";
                        UNTIL BOMLine.NEXT = 0;
                    IF NOT (Rec."BOM Category" IN [Rec."BOM Category"::Final, Rec."BOM Category"::Tentative]) THEN
                        ERROR('Please Specify BOM Category Tentative or Final');
                    IF Rec."Remarks/Reason" = '' THEN
                        ERROR('Please fill the Reason/Remarks field with proper Reason for the BOM Approval. This will be carried to the approval mails.');


                    /* ProdBOMHeader.RESET;
                    ProdBOMHeader.SETFILTER(ProdBOMHeader."No.", "No.");
                    IF ProdBOMHeader.FINDSET THEN
                        REPORT.RUN(50025, TRUE, FALSE, ProdBOMHeader); */ // commented by sujani on 26-JUL-19 for adding BOM Type restriction
                    sucs := FALSE;
                    ProdBOMHeader.RESET;
                    ProdBOMHeader.SETFILTER(ProdBOMHeader."No.", Rec."No.");
                    IF ProdBOMHeader.FINDSET THEN
                        ITEM.RESET;
                    ITEM.SETCURRENTKEY("No.");
                    ITEM.SETFILTER(ITEM."No.", ProdBOMHeader."No.");
                    IF ITEM.FINDSET THEN BEGIN
                        IF ITEM."Product Group Code Cust" IN ['FPRODUCT'] THEN  //   ,'CPCB'  commented by vishnu on 10-08-2019
                          BEGIN
                            BOMLine.RESET;
                            BOMLine.SETCURRENTKEY(Type, "No.");
                            BOMLine.SETRANGE(BOMLine."Production BOM No.", Rec."No.");
                            IF BOMLine.FINDSET THEN
                                REPEAT
                                BEGIN
                                    ITM2.RESET;
                                    ITM2.SETCURRENTKEY("No.");
                                    ITM2.SETFILTER(ITM2."No.", BOMLine."No.");
                                    IF ITM2.FINDSET THEN BEGIN
                                        IF NOT (ITM2."Product Group Code Cust" IN ['FPRODUCT', 'CPCB']) THEN // for individual items
                                          BEGIN
                                            IF NOT (BOMLine."BOM Type" IN [BOMLine."BOM Type"::Mechanical, BOMLine."BOM Type"::Packing, BOMLine."BOM Type"::Testing, BOMLine."BOM Type"::Wiring]) THEN
                                                ERROR('Specify BOM Type for individual BOM   ' + BOMLine."No.")
                                            ELSE
                                                sucs := TRUE;

                                        END
                                        ELSE
                                            /* BEGIN
                                                IF NOT (BOMLine."BOM Type" IN [BOMLine."BOM Type"::Mechanical, BOMLine."BOM Type"::Packing, BOMLine."BOM Type"::Testing, BOMLine."BOM Type"::Wiring]) THEN
                                                    ERROR('Specify BOM Type for Production BOM   ' + BOMLine."No.")
                                                ELSE
                                                    sucs := FALSE; */
                                sucs := TRUE;
                                        //REPORT.RUN(50025,TRUE,FALSE,ProdBOMHeader);
                                        // END;
                                    END // itm2 ends
                                    ELSE BEGIN
                                        IF NOT (BOMLine."BOM Type" IN [BOMLine."BOM Type"::Mechanical, BOMLine."BOM Type"::Packing, BOMLine."BOM Type"::Testing, BOMLine."BOM Type"::Wiring]) THEN // for mechanical ,wiring BOM
                                            ERROR('Specify BOM Type for production BOM  ' + BOMLine."No.")
                                        ELSE
                                            sucs := FALSE;
                                        sucs := TRUE;
                                        // REPORT.RUN(50025,TRUE,FALSE,ProdBOMHeader);
                                    END;
                                END;
                                UNTIL BOMLine.NEXT = 0;

                        END  //mark --  to else
                        ELSE
                            IF ITEM."Product Group Code CUst" IN ['CPCB'] THEN sucs := TRUE;  // else case was added by Vishnu Priya on 10-08-2019
                        IF (sucs) THEN
                            REPORT.RUN(50025, TRUE, FALSE, ProdBOMHeader);
                    END
                    ELSE //ITEM NOT FOUND
                                     BEGIN
                        IF NOT (ProdBOMHeader."BOM Type" IN [ProdBOMHeader."BOM Type"::Mechanical, ProdBOMHeader."BOM Type"::Wiring]) THEN
                            ERROR('Specify the BOM Type in Header')
                        ELSE BEGIN
                            BOMLine.RESET;
                            BOMLine.SETCURRENTKEY(Type, "No.");
                            BOMLine.SETRANGE(BOMLine."Production BOM No.", Rec."No.");
                            IF BOMLine.FINDSET THEN
                                REPEAT
                                    IF NOT (BOMLine."BOM Type" IN [BOMLine."BOM Type"::Mechanical, BOMLine."BOM Type"::Packing, BOMLine."BOM Type"::Testing, BOMLine."BOM Type"::Wiring]) THEN
                                        ERROR('Specify the BOM Type in Line for Item :' + BOMLine."No.")
                                    ELSE
                                        sucs := TRUE;
                                UNTIL BOMLine.NEXT = 0;
                            IF (sucs) THEN
                                REPORT.RUN(50025, TRUE, FALSE, ProdBOMHeader);


                        END;
                    END;



                    /* PrevItem := '';
                    PrevDescription := '';
                    PrevPosition := '';
                    BOMLine.RESET;
                    BOMLine.SETCURRENTKEY(Type, "No.");
                    BOMLine.SETRANGE("Version Code", '');
                    BOMLine.SETRANGE("Production BOM No.", "No.");
                    IF BOMLine.FINDSET THEN
                        REPEAT
                            IF (PrevItem = BOMLine."No.") AND (PrevDescription = BOMLine.Description) AND (PrevPosition = BOMLine.Position) THEN
                                ERROR('BOM having Duplicate Item :: ', BOMLine."No.");
                            PrevItem := BOMLine."No.";
                        UNTIL BOMLine.NEXT = 0;
                    ProdBOMHeader.RESET;
                    ProdBOMHeader.SETFILTER(ProdBOMHeader."No.", "No.");
                    IF ProdBOMHeader.FINDSET THEN
                        REPORT.RUN(50025, TRUE, FALSE, ProdBOMHeader); */ // Old code before adding the BOM Type restriction
                end;
            }
            action("Forward to PRM")
            {
                Caption = 'Forward to PRM';
                ApplicationArea = All;
                trigger OnAction()
                var
                    PRMIntegration: Codeunit SQLIntegration;
                    PBH: Record "Production BOM Header";
                begin

                    /* PBH.RESET;
                    PBH.SETFILTER(PBH.Status, '%1', PBH.Status::Certified);
                    IF PBH.FINDFIRST THEN
                        REPEAT
                            StatusCheck3_PRM(PBH."No.");//"No."
                            PRMIntegration.ProdBOMHeadertoPRM(PBH);//Rec
                            PBH."Update in PRM" := TRUE;
                            PBH.MODIFY;
                        UNTIL PBH.NEXT = 0;
                    MESSAGE('cOMPLETED'); */


                    Rec.StatusCheck3_PRM(Rec."No.");    //"No."
                    PRMIntegration.ProdBOMHeadertoPRM(Rec);//Rec
                    Rec."Update in PRM" := TRUE;
                    Rec.MODIFY;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF UPPERCASE(USERID) IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\VIJAYA'] THEN
            edit := TRUE
        ELSE
            edit := FALSE;
        IF Rec.Status = Rec.Status::Certified THEN BEGIN
            IF USERID IN ['EFFTRONICS\ANANDA'] THEN
                edit := FALSE;
        END
    end;

    trigger OnAfterGetRecord()
    begin
        IF ITEM.GET(Rec."No.") THEN
            CurrPage.ProdBOMLine.PAGE.Showform(ITEM."Product Group Code Cust" = 'FPRODUCT');
        "Total Qtyper SMD" := 0;
        "Total Qtyper DIP" := 0;
        "Total Qtyper" := 0;

        PordBOMLineRec.RESET;
        PordBOMLineRec.SETFILTER(PordBOMLineRec."Production BOM No.", Rec."No.");
        PordBOMLineRec.SETRANGE(PordBOMLineRec."Version Code", '');
        IF PordBOMLineRec.FIND('-') THEN
            REPEAT
                IF PordBOMLineRec."Type of Solder" = PordBOMLineRec."Type of Solder"::DIP THEN
                    "Total Qtyper SMD" := "Total Qtyper SMD" + ROUND(PordBOMLineRec."Quantity per" + 0.49, 1)
                ELSE
                    IF PordBOMLineRec."Type of Solder" = PordBOMLineRec."Type of Solder"::SMD THEN
                        "Total Qtyper DIP" := "Total Qtyper DIP" + ROUND(PordBOMLineRec."Quantity per" + 0.49, 1);
            UNTIL PordBOMLineRec.NEXT = 0;
        "Total Qtyper" := "Total Qtyper DIP" + "Total Qtyper SMD";
        NoOnFormat;
        DescriptionOnFormat;

        // added by sujani for itms modified data reflection in bom lines
        PordBOMLineRec.RESET;
        PordBOMLineRec.SETFILTER(PordBOMLineRec."Production BOM No.", Rec."No.");
        IF PordBOMLineRec.FIND('-') THEN
            REPEAT
                ITEM.RESET;
                ITEM.SETRANGE("No.", PordBOMLineRec."No.");
                IF ITEM.FINDFIRST THEN BEGIN
                    PordBOMLineRec."Part number" := ITEM."Part Number";
                    PordBOMLineRec.Package := ITEM.Package;
                    PordBOMLineRec.Make := ITEM.Make;
                    PordBOMLineRec."Unit of Measure Code" := ITEM."Base Unit of Measure";
                    PordBOMLineRec.Description := ITEM.Description;
                    PordBOMLineRec."Description 2" := ITEM."Description 2";
                    PordBOMLineRec."Storage Temperature" := ITEM."Storage Temperature";
                    PordBOMLineRec."Scrap %" := ITEM."Scrap %";
                    PordBOMLineRec."No. of Fixing Holes" := ITEM."No.of Fixing Holes";
                    PordBOMLineRec."No. of Opportunities" := ITEM."No. of Opportunities";
                    PordBOMLineRec."No. of Soldering Points" := ITEM."No. of Soldering Points";
                    PordBOMLineRec."No. of Pins" := ITEM."No. of Pins";

                END;
                PordBOMLineRec.MODIFY;

            UNTIL PordBOMLineRec.NEXT = 0;
        COMMIT;
    end;

    var
        PordBOMLineRec: Record "Production BOM Line";
        PADSoftware: XMLport "PAD Software Data Integration1";
        Bout: Record "Bin Type";
        ITEM: Record Item;
        "Total Qtyper SMD": Decimal;
        "Total Qtyper DIP": Decimal;
        "Total Qtyper": Decimal;
        edit: Boolean;
        ITM2: Record Item;
        sucs: Boolean;

    LOCAL PROCEDURE DescriptionOnInputChange(VAR Text: Text[1024]);
    BEGIN
        IF (USERID <> 'EFFTRONICS\JHANSI') AND (USERID <> 'EFFTRONICS\ANILKUMAR') AND (USERID <> 'EFFTRONICS\RSILPARANI') AND (USERID <> 'EFFTRONICS\RATNARAVALI') AND (USERID <> 'EFFTRONICS\SUVARCHALADEVI') THEN
            ERROR('YOU Have no rights to Change The Description');
    END;


    LOCAL PROCEDURE NoOnFormat();
    BEGIN
        IF ITEM.GET(Rec."No.") THEN BEGIN
            IF ITEM."Product Group Code Cust" = 'FPRODUCT' THEN BEGIN

            END ELSE
                IF ITEM."Product Group Code Cust" = 'CPCB' THEN;
        END;
    END;

    LOCAL PROCEDURE DescriptionOnFormat();
    BEGIN
        IF ITEM.GET(Rec."No.") THEN BEGIN
            IF ITEM."Product Group Code Cust" = 'FPRODUCT' THEN BEGIN

            END ELSE
                IF ITEM."Product Group Code Cust" = 'CPCB' THEN;
        END;
    END;
}