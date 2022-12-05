table 50001 "Material Issues Header"
{
    // version MI1.0,DIM1.0,Rev01

    // PROJECT : Efftronics
    // *****************************************************************************************************************************
    // SIGN
    // *****************************************************************************************************************************
    // B2B     : B2B Software Technologies
    // *****************************************************************************************************************************
    // VER      SIGN   USERID                 DATE                       DESCRIPTION
    // *****************************************************************************************************************************
    // 1.0       DIM   Sivaramakrishna.A      24-May-13             -> Added New Field 480 ("Dimension Set ID") it Will assign the Dimension Set ID
    //                                                                 specific Combination of "Shorcut Dimension Code 1","Shorcut Dimension Code 2"
    //                                                                 These combinations are stored in the new Dimension Set Entry
    //                                                              -> Added New ShowDocDim() it simply shows the data from the database against the
    //                                                                 Dimension Set ID
    //                                                              -> Added new function MatIssueLinesExist() Function Returns Boolean if Material issue
    //                                                                 Lines are exist it returns the True other wise false.
    //                                                              -> Added New UpdateAllLineDim() For Update the all the Material Issue Lines against the
    //                                                                 Material Issue Header.
    //                                                              -> Code has been Commented in the ValidateShortcutDimCode() and Added new code for the Each combination
    //                                                                 of Dimensions to get a Dimension Set ID.
    //                                                              -> Code has been Commented in Delete()Trigger because of Function does not exist in NAV 2013

    DrillDownPageID = "Material Issue List(STR)";
    LookupPageID = "Material Issue List(STR)";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                IF "No." <> xRec."No." THEN BEGIN
                  InvtSetup.GET;
                  NoSeriesMgt.TestManual(InvtSetup."Posted Material Issue Nos.");
                  "No. Series" := '';
                END;
                */

            end;
        }
        field(2; "Transfer-from Code"; Code[10])
        {
            Caption = 'Transfer-from Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false), "Subcontracting Location" = CONST(false));
            DataClassification = CustomerContent;
            trigger OnValidate();
            var
                Location: Record Location;
                Confirmed: Boolean;
            begin
                IF (NOT (USERID IN ['EFFTRONICS\ANANDA', 'EFFTRONICS\RRAHUL', 'EFFTRONICS\VSNGEETHA', 'EFFTRONICS\SUVARCHALADEVI'])) AND ("Transfer-from Code" IN ['CS STR', 'R&D STR', 'MAGSTR', 'STR GEN']) THEN
                    ERROR('PLEASE SELECT STR');

                TestStatusOpen;

                IF ("Transfer-from Code" = "Transfer-to Code") AND
                   ("Transfer-from Code" <> '')
                THEN
                    ERROR(
                      Text001,
                      FIELDCAPTION("Transfer-from Code"), FIELDCAPTION("Transfer-to Code"),
                      TABLECAPTION, "No.");

                IF (xRec."Transfer-from Code" <> "Transfer-from Code") THEN BEGIN
                    IF HideValidationDialog OR
                      (xRec."Transfer-from Code" = '')
                    THEN
                        Confirmed := TRUE
                    ELSE
                        Confirmed := CONFIRM(Text002, FALSE, FIELDCAPTION("Transfer-from Code"));
                    IF Confirmed THEN BEGIN
                        IF Location.GET("Transfer-from Code") THEN BEGIN
                            "Transfer-from Name" := Location.Name;
                            "Transfer-from Name 2" := Location."Name 2";
                            "Transfer-from Address" := Location.Address;
                            "Transfer-from Address 2" := Location."Address 2";
                            "Transfer-from Post Code" := Location."Post Code";
                            "Transfer-from City" := Location.City;
                            "Transfer-from County" := Location.County;
                            "Transfer-from Country Code" := Location."Country/Region Code";
                            "Transfer-from Contact" := Location.Contact;
                        END;
                        UpdateTransLines(FIELDNO("Transfer-from Code"));
                    END ELSE BEGIN
                        "Transfer-from Code" := xRec."Transfer-from Code";
                        EXIT;
                    END;
                END;
                //Added by rakesh for stationary items on 26-03-14
                //begin
                /*
                IF "Prod. Order No." = 'EFF14STA01' THEN
                BEGIN
                  IF "Transfer-from Code" <> 'STR' THEN
                    ERROR('Transfer-from Code should be STR');
                END;
                */
                //end
                //Added by rakesh for stationary items on 26-03-14

            end;
        }
        field(3; "Transfer-from Name"; Text[50])
        {
            Caption = 'Transfer-from Name';
            DataClassification = CustomerContent;
        }
        field(4; "Transfer-from Name 2"; Text[50])
        {
            Caption = 'Transfer-from Name 2';
            DataClassification = CustomerContent;
        }
        field(5; "Transfer-from Address"; Text[50])
        {
            Caption = 'Transfer-from Address';
            DataClassification = CustomerContent;
        }
        field(6; "Transfer-from Address 2"; Text[50])
        {
            Caption = 'Transfer-from Address 2';
            DataClassification = CustomerContent;
        }
        field(7; "Transfer-from Post Code"; Code[20])
        {
            Caption = 'Transfer-from Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                //>>B2B1.0 Since Function doesn't exist in Nav 2013
                //PostCode.LookUpPostCode("Transfer-from City","Transfer-from Post Code",TRUE);
                //<<B2B1.0
            end;

            trigger OnValidate();
            begin
                PostCode.ValidatePostCode("Transfer-from City", "Transfer-from Post Code", "Transfer-to County", "Transfer-to Country Code", TRUE);//B2B
            end;
        }
        field(8; "Transfer-from City"; Text[30])
        {
            Caption = 'Transfer-from City';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                //>>B2B1.0 Since Function doesn't exist in Nav 2013
                //PostCode.LookUpCity("Transfer-from City","Transfer-from Post Code",TRUE);
                //<<B2B1.0
            end;

            trigger OnValidate();
            begin
                PostCode.ValidateCity("Transfer-from City", "Transfer-from Post Code", "Transfer-to County", "Transfer-to Country Code", TRUE);//B2B
            end;
        }
        field(9; "Transfer-from County"; Text[30])
        {
            Caption = 'Transfer-from County';
            DataClassification = CustomerContent;
        }
        field(10; "Transfer-from Country Code"; Code[10])
        {
            Caption = 'Transfer-from Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(11; "Transfer-to Code"; Code[10])
        {
            Caption = 'Transfer-to Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false), "Subcontracting Location" = CONST(false));

            trigger OnValidate();
            var
                Location: Record Location;
                Confirmed: Boolean;
            begin
                IF (NOT (USERID IN ['EFFTRONICS\ANANDA', 'EFFTRONICS\VSNGEETHA', 'EFFTRONICS\SUVARCHALADEVI'])) AND ("Transfer-to Code" IN ['CS STR', 'R&D STR']) THEN
                    ERROR('PLEASE SELECT STR');

                TestStatusOpen;
                IF ("Transfer-from Code" = "Transfer-to Code") AND
                   ("Transfer-to Code" <> '')
                THEN
                    ERROR(
                      Text001,
                      FIELDCAPTION("Transfer-from Code"), FIELDCAPTION("Transfer-to Code"),
                      TABLECAPTION, "No.");
                IF (xRec."Transfer-to Code" <> "Transfer-to Code") THEN BEGIN
                    IF HideValidationDialog OR
                      (xRec."Transfer-to Code" = '')
                    THEN
                        Confirmed := TRUE
                    ELSE
                        Confirmed := CONFIRM(Text002, FALSE, FIELDCAPTION("Transfer-to Code"));
                    IF Confirmed THEN BEGIN
                        IF Location.GET("Transfer-to Code") THEN BEGIN
                            "Transfer-to Name" := Location.Name;
                            "Transfer-to Name 2" := Location."Name 2";
                            "Transfer-to Address" := Location.Address;
                            "Transfer-to Address 2" := Location."Address 2";
                            "Transfer-to Post Code" := Location."Post Code";
                            "Transfer-to City" := Location.City;
                            "Transfer-to County" := Location.County;
                            "Transfer-to Country Code" := Location."Country/Region Code";
                            "Transfer-to Contact" := Location.Contact;
                            MODIFY;
                        END;
                        UpdateTransLines(FIELDNO("Transfer-to Code"));
                    END ELSE BEGIN
                        "Transfer-to Code" := xRec."Transfer-to Code";
                        EXIT;
                    END;
                END;
            end;
        }
        field(12; "Transfer-to Name"; Text[50])
        {
            Caption = 'Transfer-to Name';
        }
        field(13; "Transfer-to Name 2"; Text[50])
        {
            Caption = 'Transfer-to Name 2';
        }
        field(14; "Transfer-to Address"; Text[50])
        {
            Caption = 'Transfer-to Address';
        }
        field(15; "Transfer-to Address 2"; Text[50])
        {
            Caption = 'Transfer-to Address 2';
        }
        field(16; "Transfer-to Post Code"; Code[20])
        {
            Caption = 'Transfer-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup();
            begin
                //B2B1.0>> Since Function doesn't exist in Nav 2013
                //PostCode.LookUpPostCode("Transfer-to City","Transfer-to Post Code",TRUE);
                //B2B1.0<<
            end;

            trigger OnValidate();
            begin
                PostCode.ValidatePostCode("Transfer-to City", "Transfer-to Post Code", "Transfer-to County", "Transfer-to Country Code", TRUE);//B2B
            end;
        }
        field(17; "Transfer-to City"; Text[30])
        {
            Caption = 'Transfer-to City';

            trigger OnLookup();
            begin
                //B2B1.0>> Since Function doesn't exist in Nav 2013
                //PostCode.LookUpCity("Transfer-to City","Transfer-to Post Code",TRUE);
                //B2B1.0<<
            end;

            trigger OnValidate();
            begin
                PostCode.ValidateCity("Transfer-to City", "Transfer-to Post Code", "Transfer-to County", "Transfer-to Country Code", TRUE);//B2B
            end;
        }
        field(18; "Transfer-to County"; Text[30])
        {
            Caption = 'Transfer-to County';
        }
        field(19; "Transfer-to Country Code"; Code[10])
        {
            Caption = 'Transfer-to Country Code';
            TableRelation = "Country/Region";
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(21; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';

            trigger OnValidate();
            begin
                TestStatusOpen;
                UpdateTransLines(FIELDNO("Receipt Date"));
            end;
        }
        field(22; Status; Option)
        {
            Caption = 'Status';
            Editable = true;
            OptionCaption = 'Open,Released,Sent for Authorization,Rejected';
            OptionMembers = Open,Released,"Sent for Authorization",Rejected;

            trigger OnValidate();
            begin
                UpdateTransLines(FIELDNO(Status));
            end;
        }
        field(23; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(24; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = FILTER(false));

            trigger OnValidate();
            begin
                //ValidateShortcutDimCode(2,xRec."Shortcut Dimension 2 Code");
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(25; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(26; "Last Receipt No."; Code[20])
        {
            Caption = 'Last Receipt No.';
            Editable = false;
            TableRelation = "Transfer Receipt Header";
        }
        field(27; "Transfer-from Contact"; Text[30])
        {
            Caption = 'Transfer-from Contact';
        }
        field(28; "Transfer-to Contact"; Text[30])
        {
            Caption = 'Transfer-to Contact';
        }
        field(29; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(30; "Completely Received"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Min("Transfer Line"."Completely Received" WHERE("Document No." = FIELD("No."), "Receipt Date" = FIELD("Date Filter"), "Transfer-to Code" = FIELD("Location Filter")));
            Caption = 'Completely Received';
            Editable = false;

        }
        field(31; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(32; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(36; "Prod. Order No."; Code[20])
        {
            TableRelation = "Production Order"."No." WHERE(Blocked = CONST(false), Status = FILTER(Released));

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                IF ("Prod. Order No." <> '') AND ("Prod. Order Line No." <> 0) THEN BEGIN
                    ProdOrderLine.SETRANGE("Prod. Order No.", "Prod. Order No.");
                    ProdOrderLine.SETRANGE("Line No.", "Prod. Order Line No.");
                    IF ProdOrderLine.FINDFIRST THEN BEGIN
                        "Due Date" := ProdOrderLine."Due Date";
                        "Proj Description" := ProdOrderLine.Description;
                        "Prod. BOM No." := ProdOrderLine."Item No.";
                    END;
                END;

                //Added by rakesh for stationary items on 26-03-14
                //begin
                /*
                IF "Prod. Order No." = 'EFF14STA01' THEN
                BEGIN
                  IF "Transfer-from Code" <> 'STR' THEN
                    ERROR('Transfer-from Code: should be STR');
                END;
                */
                //end
                //Added by rakesh for stationary items on 26-03-14

            end;
        }
        field(37; "Prod. Order Line No."; Integer)
        {
            TableRelation = "Prod. Order Line"."Line No." WHERE("Prod. Order No." = FIELD("Prod. Order No."));

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
                ProdOrderLine.SETRANGE("Prod. Order No.", "Prod. Order No.");
                ProdOrderLine.SETRANGE("Line No.", "Prod. Order Line No.");
                IF ProdOrderLine.FINDFIRST THEN BEGIN
                    "Due Date" := ProdOrderLine."Due Date";
                    "Proj Description" := ProdOrderLine.Description;
                    "Prod. BOM No." := ProdOrderLine."Item No.";
                END;
            end;
        }
        field(38; "Prod. BOM No."; Code[20])
        {
            TableRelation = "Production BOM Header"."No." WHERE(Status = FILTER(Certified));

            trigger OnLookup();
            var
                ProductionOrderLine: Record "Prod. Order Line";
                ProductionBOMHeader: Record "Production BOM Header";
            begin
            end;
        }
        field(39; "Operation No."; Code[20])
        {

            trigger OnLookup();
            var
                ProductionOrderLine: Record "Prod. Order Line";
            begin
                /*
                ProductionOrderLine.SETRANGE("Prod. Order No.","Prod. Order No.");
                ProductionOrderLine.SETRANGE("Line No.","Prod. Order Line No.");
                IF ProductionOrderLine.findfirst THEN
                  ProdOrderRoutingLine.SETRANGE(Status,ProductionOrderLine.Status);
                  ProdOrderRoutingLine.SETRANGE("Prod. Order No.",ProductionOrderLine."Prod. Order No.");
                  ProdOrderRoutingLine.SETRANGE("Routing Reference No.",ProductionOrderLine."Line No.");
                  IF ProdOrderRoutingLine.findfirst THEN
                    IF PAGE.RUNMODAL(0,ProdOrderRoutingLine) = ACTION::LookupOK THEN BEGIN
                      "Operation No." := ProdOrderRoutingLine."Operation No.";
                      //"Due Date" := ProdOrderRoutingLine."Starting Date";
                    END;
                */

            end;
        }
        field(40; "Sales Order No."; Code[20])
        {
            TableRelation = IF ("Transfer-from Code" = CONST('CS STR'), "Reason Code" = CONST('INSTALLA')) "Sales Header"."No." WHERE("Document Type" = CONST(Order), Status = CONST(Released)) ELSE
            IF ("Transfer-from Code" = CONST('CS STR'), "Reason Code" = CONST('AMC')) "Sales Header"."No." WHERE(SaleDocType = CONST(Amc), Status = CONST(Released)) ELSE
            IF ("Transfer-from Code" = FILTER(<> 'CS STR'), "Reason Code" = CONST('AMC')) "Sales Header"."No." WHERE("Document Type" = CONST(Order), Status = CONST(Released)) ELSE   //EFFUPG1.5
            "Sales Header"."No." WHERE(Status = CONST(Released));
        }
        field(41; "Resource Name"; Text[50])
        {
            Editable = false;
        }
        field(42; "User ID"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = "User Setup"."User ID";

            trigger OnLookup();
            begin
                UserGrec.RESET;
                IF PAGE.RUNMODAL(9800, UserGrec) = ACTION::LookupOK THEN BEGIN
                    "User ID" := UserGrec."User ID";

                    VALIDATE("User ID");
                END;

            end;

            trigger OnValidate();
            begin
                //Rev01 Start
                //Code Commented
                /*
                User.SETRANGE(User."User Security ID","User ID");//B2B
                IF User.FINDFIRST THEN
                  "Resource Name":=User."User Name";//B2B
                */

                //Rev01 End
                UserGrecUPG.RESET;
                UserGrecUPG.SETRANGE("User Name", "User ID");
                IF UserGrecUPG.FINDFIRST THEN
                    "Resource Name" := UserGrecUPG."Full Name";


                USER_SETUP.SETRANGE(USER_SETUP."User ID", "User ID");
                IF USER_SETUP.FINDFIRST THEN BEGIN
                    IF (USER_SETUP."Transfer- From Code" = 'STR') OR (UPPERCASE(USER_SETUP."User ID") IN ['20MT002', '99P2005']) THEN BEGIN
                        "Transfer-from Code" := USER_SETUP."Transfer- From Code";
                        "Transfer-to Code" := USER_SETUP."Transfer- To Code";
                        //VALIDATE("Prod. Order No.",USER_SETUP."Production Order");
                        //VALIDATE("Prod. Order Line No.",10000);
                    END;
                END;

            end;
        }
        field(43; "Required Date"; Date)
        {
        }
        field(44; "Released Date"; Date)
        {
            Editable = true;
        }
        field(45; "Released By"; Code[50])
        {
            Description = 'Rev01';
            Editable = true;
            TableRelation = User."User Name";
        }
        field(46; "Service Order No."; Code[20])
        {
            TableRelation = "Service Header"."No.";

            trigger OnValidate();
            begin
                /*
                  Service_Item_Line.SETRANGE(Service_Item_Line."Document No.","Service Order No.");
                 IF Service_Item_Line.findfirst THEN
                 BEGIN
                   "Service Item":=Service_Item_Line.Description;
                   "Service Item Serial No.":=Service_Item_Line."Serial No.";
                   MODIFY;
                 END;        */

            end;
        }
        field(47; "Reason Code"; Code[20])
        {
            TableRelation = "Reason Code".Code;
        }
        field(48; "Due Date"; Date)
        {
        }
        field(49; "Released Time"; Time)
        {
            Editable = false;
        }
        field(50; "Production BOM No."; Code[20])
        {
            TableRelation = "Production BOM Header" WHERE(Status = CONST(Certified));
        }
        field(51; "Devide By Qty."; Decimal)
        {
        }
        field(60; "PCB Item"; Code[20])
        {
            Editable = false;
            TableRelation = Item;
        }
        field(61; Reason; Code[20])
        {
        }
        field(62; "Sales Schedule Line No"; Integer)
        {
            Editable = true;
            TableRelation = Schedule2."Line No." WHERE("Document No." = FIELD("Sales Order No."), "Document Line No." = FIELD("Sales Order Line No."), "Document Type" = CONST(Order));
        }
        field(63; "Service Item Line No."; Integer)
        {
            TableRelation = "Service Item Line"."Line No." WHERE("Document No." = FIELD("Service Order No."));
        }
        field(64; "Sales Order Line No."; Integer)
        {
            TableRelation = "Sales Line"."Line No." WHERE("Document No." = FIELD("Sales Order No."));
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Description = 'DIM1.0';
            Editable = true;

            trigger OnLookup();
            begin
                ShowDocDim
            end;
        }
        field(60000; "BOM Type"; Option)
        {
            Description = 'B2B';
            OptionCaption = '" ,Mechanical,Wiring,SMD,DIP,Testing,Packing"';
            OptionMembers = " ",Mechanical,Wiring,SMD,DIP,Testing,Packing;

            trigger OnValidate();
            var
                MaterialIssueLine: Record "Material Issues Line";
            begin
                IF xRec."BOM Type" <> "BOM Type" THEN BEGIN
                    MaterialIssueLine.RESET;
                    MaterialIssueLine.SETRANGE("Document No.", "No.");
                    IF MaterialIssueLine.FINDFIRST THEN
                        ERROR(Text005);
                END;
            end;
        }
        field(60006; "Type of Solder"; Option)
        {
            Description = 'B2B';
            OptionMembers = " ",SMD,DIP;
        }
        field(60007; "Creation DateTime"; DateTime)
        {
            Editable = true;
        }
        field(60008; "AMC Order No"; Code[30])
        {
            TableRelation = "Service Contract Header"."Contract No.";
        }
        field(60009; "Proj Description"; Text[50])
        {
        }
        field(60010; Tem_Status; Boolean)
        {
        }
        field(60011; "Service Item"; Text[50])
        {
        }
        field(60012; "Service Item Serial No."; Code[20])
        {
        }
        field(60013; "Service Item Description"; Text[100])
        {
        }
        field(60014; Remarks; Text[200])
        {
        }
        field(60021; "Authorised By"; Option)
        {
            OptionMembers = Prasanthi," P. Murali Mohan Rao","V.S.L.Shilpa",Padmasree,Ramasamy," Bala Krishna"," Bhavani Shankar","Krishna Rao";
        }
        field(60022; Purpose; Option)
        {
            OptionMembers = AMC,Waranty,Replacement,"R&D Testing",Demo,Installation;
        }
        field(60027; "Authorized Date"; Date)
        {
        }
        field(60028; Rejected; Boolean)
        {
        }
        field(60029; "Request for Authorization"; Code[50])
        {
            Description = 'Rev01';
            Editable = false;

            trigger OnLookup();
            begin
                UserGrec.RESET;
                UserGrec.SETRANGE(levels, TRUE);
                IF PAGE.RUNMODAL(9800, UserGrec) = ACTION::LookupOK THEN
                    "Request for Authorization" := UserGrec."User ID";
            end;
        }
        field(60030; "Auto Post"; Boolean)
        {
        }
        field(60031; "Person Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('EMPLOYEE CODES'));
        }
        field(60032; "Mode of Transport"; Option)
        {
            OptionMembers = " ",Courier,Train,Bus,"By Hand",VRL,Lorry,ANL;
        }
        field(60033; Multiple; Integer)
        {
            InitValue = 1;
        }
        field(60034; Priority; Option)
        {
            OptionMembers = " ",High,Medium,Low;
        }
        field(60035; "Vendor No."; Code[20])
        {
            Description = 'for Purchase DC purpose';
            TableRelation = Vendor."No.";
        }
        field(60036; "Released DateTime"; DateTime)
        {
        }
        field(60037; "Transaction ID"; Code[20])
        {
            Description = 'For CS Transaction ID';
        }
        field(60038; "Customer No"; Code[20])
        {
            Description = 'For CS LED Cards Process';
            TableRelation = Customer."No.";
        }
        field(60039; Alert_Mail_Sent_date; Date)
        {
        }
        field(60090; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
        }
        field(60091; "OLD Dim Set ID"; Integer)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));


        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Prod. Order No.", "Prod. Order Line No.")
        {
        }
        key(Key3; "Required Date", "Released Time")
        {
        }
        key(Key4; "Released Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TESTFIELD(Status, Status::Open);

        IF NOT (UPPERCASE(USERID) IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\DMADHAVI', 'EFFTRONICS\PADMASRI', 'ERPSERVER\ADMINISTRATOR', 'EFFTRONICS\MARY', 'EFFTRONICS\BHAVANIP',
                                            'EFFTRONICS\VARALAKSHMI', 'EFFTRONICS\RAMADEVI', 'EFFTRONICS\GRAVI', 'EFFTRONICS\PKOTESWARARAO', 'EFFTRONICS\TULASI', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\SUVARCHALADEVI']) THEN
       /*BEGIN
         IF NOT ("User ID" = USERID) THEN
           ERROR('U Dont Have Permissions to Delete');
       END;*/
       // added by sujani on 05-feb-2018 to delete only empty material requests
       BEGIN
            UserGrec.RESET;
            UserGrec.SETRANGE("User ID", USERID);
            IF UserGrec.FINDSET THEN BEGIN
                IF UserGrec.Dept = 'STR' THEN BEGIN
                    MaterialIssueLine.RESET;
                    MaterialIssueLine.SETRANGE("Document No.", "No.");
                    IF MaterialIssueLine.FINDFIRST THEN
                        ERROR('You Do Not Have Right to delete Material Requests');
                END ELSE
                    ERROR('You Do Not Have Right to delete Material Requests');
            END ELSE
                ERROR('You Do Not Have Right to delete Material Requests');
        END;


        MaterialIssueLine.SETRANGE("Document No.", "No.");
        MaterialIssueLine.DELETEALL(TRUE);

        TrackingSpecifications.RESET;
        TrackingSpecifications.SETRANGE("Order No.", "No.");
        IF TrackingSpecifications.FINDSET THEN
            REPEAT
                TrackingSpecifications.DELETE;
            UNTIL TrackingSpecifications.NEXT = 0;


        InvtCommentLine.SETRANGE("Document Type", InvtCommentLine."Document Type"::"Material Issues");
        InvtCommentLine.SETRANGE("No.", "No.");
        InvtCommentLine.DELETEALL;


        //DIM1.0  Since this Function doesn't exist in Nav 2013.
        //DimMgt.DeleteDocDim(DATABASE::"Material Issues Header",DocDim."Document Type"::" ","No.",0);
        //DIM1.0<<

    end;

    trigger OnInsert();
    begin
        //B2B UD  >>
        IF "No." = '' THEN
            "No." := GetNextNo;
        //B2B UD  <<

        InvtSetup.GET;
        IF "No." = '' THEN BEGIN
            InvtSetup.TESTFIELD(InvtSetup."Material Issue Nos.");
            NoSeriesMgt.InitSeries(InvtSetup."Material Issue Nos.", xRec."No. Series", "Posting Date", "No.", "No. Series");
        END;
        InitRecord;
        VALIDATE("Receipt Date", WORKDATE);

        PostedMISHeader.RESET;
        PostedMISHeader.SETRANGE("Material Issue No.", "No.");
        IF PostedMISHeader.FINDFIRST THEN
            ERROR(Text004, "No.");
        VALIDATE("User ID", USERID);
        "Creation DateTime" := CREATEDATETIME(WORKDATE, TIME)//CURRENTDATETIME;
    end;

    trigger OnModify();
    begin
        /*MaterialIssueLine.SETFILTER(MaterialIssueLine."Document No.",xRec."No.");
        IF MaterialIssueLine.findfirst THEN
        ERROR('You donot modify the Record');*/
        //TESTFIELD(Status,Status::Open);

    end;

    trigger OnRename();
    begin
        PostedMISHeader.RESET;
        PostedMISHeader.SETRANGE("Material Issue No.", "No.");
        IF PostedMISHeader.FINDFIRST THEN
            ERROR(Text004, "No.");
    end;

    var
        PostCode: Record "Post Code";
        InvtSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit 396;
        Text000: Label 'You cannot rename a %1.';
        Text001: Label '%1 and %2 cannot be the same in %3 %4.';
        Text002: Label 'Do you want to change %1?';
        Text003: Label 'The Material Issues %1 has been deleted.';
        HideValidationDialog: Boolean;
        MaterialIssueHeader: Record "Material Issues Header";
        DimMgt: Codeunit 408;
        ProdOrderLine: Record "Prod. Order Line";
        MaterialIssueLine: Record "Material Issues Line";
        InvtCommentLine: Record "Inventory Comment Line";
        PostedMISHeader: Record "Posted Material Issues Header";
        Text004: Label 'Posted Material Issue already existed against this Material Issue number %1';
        Text005: Label 'you can not change Type when lines already existed.';
        Item: Record Item;
        productionbomversion: Record "Production BOM Version";
        Service_Item_Line: Record "Service Item Line";
        Stat: Record Station;
        USER_SETUP: Record "User Setup";
        UserGrec: Record "User Setup";
        "-DIM1.0-": Integer;
        MaterIssLine: Record "Material Issues Line";
        Text051: TextConst ENU = 'You may have changed a dimension.\\Do you want to update the lines?', ENN = 'You may have changed a dimension.\\Do you want to update the lines?';
        TrackingSpecifications: Record "Mat.Issue Track. Specification";
        UserGrecUpg: Record User;


    procedure InitRecord();
    var
        "Material Issues Line": Record "Material Issues Line";
    begin
        /*
        IF ("Posting Date" = 0D) THEN
          VALIDATE("Posting Date",WORKDATE);
        */

    end;


    local procedure TestStatusOpen();
    begin
        TESTFIELD(Status, Status::Open);
    end;


    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean);
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;


    local procedure UpdateTransLines(FieldRef: Integer);
    var
        MaterialIssueLine: Record "Material Issues Line";
    begin
        MaterialIssueLine.LOCKTABLE;
        MaterialIssueLine.SETRANGE("Document No.", "No.");
        IF MaterialIssueLine.FINDFIRST THEN BEGIN
            REPEAT
                CASE FieldRef OF
                    FIELDNO("Transfer-from Code"):
                        BEGIN
                            MaterialIssueLine.VALIDATE("Transfer-from Code", "Transfer-from Code");
                            MaterialIssueLine.VALIDATE("Receipt Date", "Receipt Date");
                        END;
                    FIELDNO("Transfer-to Code"):
                        BEGIN
                            MaterialIssueLine.VALIDATE("Transfer-to Code", "Transfer-to Code");
                            MaterialIssueLine.VALIDATE("Receipt Date", "Receipt Date");
                        END;
                    FIELDNO(Status):
                        MaterialIssueLine.VALIDATE(Status, Status);
                END;
                MaterialIssueLine.MODIFY(TRUE);
            UNTIL MaterialIssueLine.NEXT = 0;
        END;
    end;


    procedure AssistEdit(OldMaterialIssueHeader: Record "Material Issues Header"): Boolean;
    begin
        MaterialIssueHeader := Rec;
        InvtSetup.GET;
        InvtSetup.TESTFIELD(InvtSetup."Posted Material Issue Nos.");
        IF NoSeriesMgt.SelectSeries(InvtSetup."Posted Material Issue Nos.", OldMaterialIssueHeader."No. Series", MaterialIssueHeader."No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries(MaterialIssueHeader."No.");
            Rec := MaterialIssueHeader;
            EXIT(TRUE);
        END;
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    var
        OldDimSetID: Integer;
    begin

        //DIM1.0>> Since function doesn't exist in Nav 2013
        //Code Comment
        /*
        DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        IF "No." <> '' THEN BEGIN
          DimMgt.SaveDocDim(
            DATABASE::"Material Issues Header",DocDim."Document Type"::" ","No.",0,FieldNumber,ShortcutDimCode);
          MODIFY;
        END ELSE
          DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);
        */


        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF "No." <> '' THEN
            MODIFY;

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            IF MatIssueLinesExist THEN
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
            MODIFY;
        END
        //DIM1.0 End

    end;


    procedure CopyRequisition();
    var
        IndentHeader: Record "Indent Header";
        IndentLine: Record "Indent Line";
        MaterialIssueLines: Record "Material Issues Line";
    begin
        TESTFIELD("Transfer-from Code");
        TESTFIELD("Transfer-to Code");

        IF PAGE.RUNMODAL(0, IndentHeader) = ACTION::LookupOK THEN BEGIN
            IndentLine.SETRANGE("Document No.", IndentHeader."No.");
            IF IndentLine.FINDFIRST THEN BEGIN
                REPEAT
                    MaterialIssueLines.INIT;
                    MaterialIssueLines."Document No." := "No.";
                    MaterialIssueLines."Line No." := IndentLine."Line No.";
                    MaterialIssueLines."Item No." := IndentLine."No.";
                    MaterialIssueLines.Description := IndentLine.Description;
                    MaterialIssueLines.Quantity := IndentLine.Quantity;
                    MaterialIssueLines."Unit of Measure" := IndentLine."Unit of Measure";
                    MaterialIssueLines."Transfer-from Code" := "Transfer-from Code";
                    MaterialIssueLines."Transfer-to Code" := "Transfer-to Code";
                    MaterialIssueLines.INSERT;
                UNTIL IndentLine.NEXT = 0;
            END;
        END;
    end;


    procedure CopyProductionOrder();
    var
        ProdOrderLines: Record "Prod. Order Line";
        MaterialIssueLine: Record "Material Issues Line";
        LineNo: Integer;
        ProdOrderComp: Record "Prod. Order Component";
        Item: Record Item;
        BOMHeader: Record "Production BOM Header";
        BOMLine: Record "Production BOM Line";
        ProdOrderLineRec: Record "Prod. Order Line";
    begin
        TESTFIELD("No.");
        TESTFIELD("Prod. Order No.");
        TESTFIELD("Prod. Order Line No.");
        TESTFIELD(Status, Status::Open);
        MaterialIssueLine.SETRANGE("Document No.", "No.");
        IF MaterialIssueLine.FINDLAST THEN
            LineNo := MaterialIssueLine."Line No."
        ELSE
            LineNo := 0;

        ProdOrderComp.RESET;
        ProdOrderComp.SETRANGE(Status, ProdOrderComp.Status::Released);
        ProdOrderComp.SETRANGE("Prod. Order No.", "Prod. Order No.");
        ProdOrderComp.SETRANGE("Prod. Order Line No.", "Prod. Order Line No.");
        //211207
        IF FORMAT("BOM Type") <> ' ' THEN
            ProdOrderComp.SETRANGE("BOM Type", "BOM Type");
        // MESSAGE(FORMAT(ProdOrderComp.COUNT));
        IF "Type of Solder" <> 0 THEN
            ProdOrderComp.SETRANGE("Type of Solder", "Type of Solder");//added
                                                                       // MESSAGE(FORMAT(ProdOrderComp.COUNT));


        //MESSAGE(FORMAT(ProdOrderComp.COUNT));
        IF ProdOrderComp.FINDFIRST THEN BEGIN
            REPEAT
                // MESSAGE(FORMAT(ProdOrderComp."Item No."));
                IF Item.GET(ProdOrderComp."Item No.") THEN;
                MaterialIssueLine.INIT;
                LineNo := LineNo + 10000;
                MaterialIssueLine."Document No." := "No.";
                MaterialIssueLine."Item No." := ProdOrderComp."Item No.";
                MaterialIssueLine.VALIDATE(MaterialIssueLine."Item No.");
                MaterialIssueLine."Line No." := LineNo;
                MaterialIssueLine."Unit of Measure" := ProdOrderComp."Unit of Measure Code";
                ProdOrderComp.CALCFIELDS(ProdOrderComp."Qty. in Material Issues", ProdOrderComp."Qty. in Posted Material Issues");
                MaterialIssueLine.Copy := TRUE;
                //MaterialIssueLine.Quantity := ProdOrderComp."Remaining Quantity" - (
                //ProdOrderComp."Qty. in Material Issues" + ProdOrderComp."Qty. in Posted Material Issues");
                //  MaterialIssueLine.Quantity := ProdOrderComp."Expected Quantity" - (
                //  ProdOrderComp."Qty. in Material Issues" + ProdOrderComp."Qty. in Posted Material Issues");
                MaterialIssueLine.Quantity := ProdOrderComp.Quantity;
                MaterialIssueLine.VALIDATE(Quantity);
                MaterialIssueLine."Prod. Order No." := ProdOrderComp."Prod. Order No.";
                MaterialIssueLine."Prod. Order Line No." := ProdOrderComp."Prod. Order Line No.";
                MaterialIssueLine."Prod. Order Comp. Line No." := ProdOrderComp."Line No.";
                ProdOrderLineRec.SETRANGE("Prod. Order No.", MaterialIssueLine."Prod. Order No.");
                ProdOrderLineRec.SETRANGE(ProdOrderLineRec."Line No.", MaterialIssueLine."Prod. Order Line No.");
                IF ProdOrderLineRec.FINDFIRST THEN BEGIN
                    BOMLine.SETRANGE("Production BOM No.", ProdOrderLineRec."Production BOM No.");
                    BOMLine.SETRANGE("No.", MaterialIssueLine."Item No.");
                    IF BOMLine.FINDFIRST THEN BEGIN
                        IF (BOMLine."Allow Excess Qty.") THEN
                            MaterialIssueLine."Allow Excess Qty." := TRUE;
                    END;
                END;
                //  IF MaterialIssueLine.Quantity > 0 THEN
                //    MaterialIssueLine.INSERT;

                IF ProdOrderComp."Expected Quantity" - (
                  ProdOrderComp."Qty. in Material Issues" + ProdOrderComp."Qty. in Posted Material Issues") > 0 THEN
                    MaterialIssueLine.INSERT;
            UNTIL ProdOrderComp.NEXT = 0;

        END;
    end;


    procedure CopySalesOrder();
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        MaterialIssueLine: Record "Material Issues Line";
        LineNo: Integer;
    begin
        MaterialIssueLine.SETRANGE("Document No.", "No.");
        IF MaterialIssueLine.FINDLAST THEN
            LineNo := MaterialIssueLine."Line No."
        ELSE
            LineNo := 0;

        SalesHeader.SETRANGE("No.", "Sales Order No.");
        IF SalesHeader.FINDFIRST THEN
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        IF SalesLine.FINDFIRST THEN
            REPEAT
                MaterialIssueLine.INIT;
                LineNo := LineNo + 10000;
                MaterialIssueLine."Document No." := "No.";
                MaterialIssueLine."Item No." := SalesLine."No.";
                MaterialIssueLine.VALIDATE(MaterialIssueLine."Item No.");
                MaterialIssueLine."Line No." := LineNo;
                MaterialIssueLine."Unit of Measure" := SalesLine."Unit of Measure";
                MaterialIssueLine.Quantity := SalesLine.Quantity;
                MaterialIssueLine.VALIDATE(Quantity);
                MaterialIssueLine.INSERT;
            UNTIL SalesLine.NEXT = 0;
    end;


    procedure DeleteOrder(var MaterialIssuesHeader2: Record "Material Issues Header"; var MaterialIssuesLine2: Record "Material Issues Line"): Boolean;
    var
        InvtCommentLine: Record "Inventory Comment Line";
        No: Code[20];
        DoNotDelete: Boolean;
        TrackingSpecification: Record "Mat.Issue Track. Specification";
    begin
        No := MaterialIssuesHeader2."No.";
        IF MaterialIssuesLine2.FINDFIRST THEN BEGIN
            REPEAT
                IF (MaterialIssuesLine2.Quantity <> MaterialIssuesLine2."Quantity Received") OR
                   (MaterialIssuesLine2."Quantity (Base)" <> MaterialIssuesLine2."Qty. Received (Base)")
                THEN
                    DoNotDelete := TRUE;
            UNTIL MaterialIssuesLine2.NEXT = 0;
        END;

        IF NOT DoNotDelete THEN BEGIN
            InvtCommentLine.SETRANGE("Document Type", InvtCommentLine."Document Type"::"Material Issues");
            InvtCommentLine.SETRANGE("No.", "No.");
            InvtCommentLine.DELETEALL;

            IF MaterialIssuesLine2.FINDFIRST THEN BEGIN
                REPEAT
                    //B2b1.0>> Since Function doesn't exist in Nav 2013
                    //DimMgt.DeleteDocDim(DATABASE::"Material Issues Line",DocDim."Document Type"::" ",No,MaterialIssuesLine2."Line No.");
                    //B2b1.0<<
                    TrackingSpecification.SETRANGE("Order No.", MaterialIssuesLine2."Document No.");
                    TrackingSpecification.SETRANGE("Order Line No.", MaterialIssuesLine2."Line No.");
                    IF TrackingSpecification.FINDFIRST THEN
                        REPEAT
                            TrackingSpecification.DELETE;
                        UNTIL TrackingSpecification.NEXT = 0;
                    MaterialIssuesLine2.DELETE;
                UNTIL MaterialIssuesLine2.NEXT = 0;
            END;
            //B2b1.0>> Since Function doesn't exist in Nav 2013
            //DimMgt.DeleteDocDim(DATABASE::"Material Issues Header",DocDim."Document Type"::" ",No,0);
            //B2b1.0<<
            MaterialIssuesHeader2.DELETE;
            //MESSAGE(Text003,No);
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;


    procedure CopyProductionBOM();
    var
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMLine: Record "Production BOM Line";
        MaterialIssueLine: Record "Material Issues Line";
        LineNo: Integer;
    begin
        /* //ck commented to add dip & SMD 220408
        MaterialIssueLine.SETRANGE("Document No.","No.");
        IF MaterialIssueLine.findlast THEN
          LineNo := MaterialIssueLine."Line No."
        ELSE
          LineNo := 0;
        
        ProductionBOMHeader.SETRANGE("No.","Production BOM No.");
        IF ProductionBOMHeader.findfirst THEN
            ProductionBOMLine.SETRANGE("Production BOM No.",ProductionBOMHeader."No.");
            ProductionBOMLine.SETRANGE(Type,ProductionBOMLine.Type :: Item);
            IF ProductionBOMLine.findfirst THEN
              REPEAT
                MaterialIssueLine.INIT;
                LineNo := LineNo + 10000;
                MaterialIssueLine."Document No." := "No.";
                MaterialIssueLine.VALIDATE("Item No.",ProductionBOMLine."No.");
                MaterialIssueLine."Line No." := LineNo;
                MaterialIssueLine.VALIDATE(Quantity,ProductionBOMLine."Quantity per");
                MaterialIssueLine.INSERT;
              UNTIL ProductionBOMLine.NEXT = 0;
        */     //ck commented to add dip & SMD 220408

        MaterialIssueLine.SETRANGE("Document No.", "No.");
        IF MaterialIssueLine.FINDLAST THEN
            LineNo := MaterialIssueLine."Line No."
        ELSE
            LineNo := 0;

        ProductionBOMHeader.SETRANGE("No.", "Production BOM No.");
        IF ProductionBOMHeader.FINDFIRST THEN
            ProductionBOMLine.SETRANGE("Production BOM No.", ProductionBOMHeader."No.");
        productionbomversion.SETRANGE(productionbomversion."Production BOM No.", ProductionBOMHeader."No.");
        // ProductionBOMLine.SETRANGE(ProductionBOMLine."Version Code",productionbomversion."Version Code");
        IF productionbomversion.COUNT > 0 THEN
            IF productionbomversion.FINDFIRST THEN
                REPEAT
                    IF productionbomversion.Status = productionbomversion.Status::Certified THEN BEGIN
                        productionbomversion.SETRANGE(productionbomversion.Status, productionbomversion.Status::Certified);
                        ProductionBOMLine.SETRANGE(ProductionBOMLine."Version Code", productionbomversion."Version Code");
                    END
                    ELSE
                        ProductionBOMLine.SETRANGE(ProductionBOMLine."Version Code", '');
                UNTIL productionbomversion.NEXT = 0;
        IF FORMAT("Type of Solder") <> ' ' THEN
            IF FORMAT("Type of Solder") = 'SMD' THEN
                ProductionBOMLine.SETRANGE(ProductionBOMLine."Type of Solder", "Type of Solder")
            ELSE
                IF FORMAT("Type of Solder") = 'DIP' THEN
                    ProductionBOMLine.SETFILTER(ProductionBOMLine."Type of Solder", '<>%1', "Type of Solder"::SMD);
        ProductionBOMLine.SETRANGE(Type, ProductionBOMLine.Type::Item);
        IF ProductionBOMLine.FINDSET THEN
            REPEAT


                IF (("BOM Type" = "BOM Type"::Mechanical) OR ("BOM Type" = "BOM Type"::Wiring)) THEN BEGIN
                    MaterialIssueLine.INIT;
                    LineNo := LineNo + 10000;
                    MaterialIssueLine."Document No." := "No.";
                    MaterialIssueLine.VALIDATE("Item No.", ProductionBOMLine."No.");
                    MaterialIssueLine."Line No." := LineNo;
                    MaterialIssueLine.VALIDATE(Quantity, (ProductionBOMLine."Quantity per" * Multiple));
                    MaterialIssueLine."BOM Quantity" := ProductionBOMLine."Quantity per";
                    MaterialIssueLine.INSERT;



                    //UNTIL ProductionBOMLine.NEXT = 0
                END ELSE
                    IF ("BOM Type" = "BOM Type"::SMD) THEN BEGIN
                        //REPEAT
                        Item.SETRANGE("No.", ProductionBOMLine."No.");
                        IF Item.FINDFIRST THEN BEGIN
                            Item.SETRANGE("Type of Solder", Item."Type of Solder"::SMD);
                            IF Item.FINDFIRST THEN BEGIN
                                MaterialIssueLine.INIT;
                                LineNo := LineNo + 10000;
                                MaterialIssueLine."Document No." := "No.";
                                MaterialIssueLine.VALIDATE("Item No.", ProductionBOMLine."No.");
                                MaterialIssueLine."Line No." := LineNo;
                                MaterialIssueLine.VALIDATE(Quantity, (ProductionBOMLine."Quantity per" * Multiple));
                                MaterialIssueLine."BOM Quantity" := ProductionBOMLine."Quantity per";

                                MaterialIssueLine.INSERT;



                            END;
                            //  UNTIL ProductionBOMLine.NEXT = 0
                        END;
                    END ELSE
                        IF ("BOM Type" = "BOM Type"::DIP) THEN BEGIN
                            Item.SETRANGE("No.", ProductionBOMLine."No.");
                            IF Item.FINDFIRST THEN BEGIN
                                //   Item.SETRANGE("Type of Solder",Item."Type of Solder"::DIP);
                                IF Item.FINDFIRST THEN
                                     // REPEAT
                                     BEGIN
                                    MaterialIssueLine.INIT;
                                    LineNo := LineNo + 10000;
                                    MaterialIssueLine."Document No." := "No.";
                                    MaterialIssueLine.VALIDATE("Item No.", ProductionBOMLine."No.");
                                    MaterialIssueLine."Line No." := LineNo;
                                    MaterialIssueLine.VALIDATE(Quantity, (ProductionBOMLine."Quantity per" * Multiple));
                                    MaterialIssueLine."BOM Quantity" := ProductionBOMLine."Quantity per";
                                    MaterialIssueLine.INSERT;


                                END;
                            END;
                        END
                        ELSE
               /*IF (("BOM Type" <>"BOM Type"::Mechanical) AND ("BOM Type" <>"BOM Type"::Wiring) AND
                   ("BOM Type" <>"BOM Type"::SMD) AND ("BOM Type" <>"BOM Type"::DIP)) THEN */       //<<ANIL
               BEGIN
                            MaterialIssueLine.INIT;
                            LineNo := LineNo + 10000;
                            MaterialIssueLine."Document No." := "No.";
                            MaterialIssueLine.VALIDATE("Item No.", ProductionBOMLine."No.");
                            MaterialIssueLine."Line No." := LineNo;
                            MaterialIssueLine.VALIDATE(Quantity, (ProductionBOMLine."Quantity per" * Multiple));
                            MaterialIssueLine."BOM Quantity" := ProductionBOMLine."Quantity per";
                            MaterialIssueLine.INSERT;
                            //UNTIL ProductionBOMLine.NEXT = 0
                        END;


            UNTIL ProductionBOMLine.NEXT = 0;

    end;


    procedure "*-*-"();
    begin
    end;

    procedure GetNextNo() NumberValue: Code[20];
    var
        DateValue: Text[30];
        MonthValue: Text[30];
        YearValue: Text[30];
        MaterialIssuesHeaderLocal: Record "Material Issues Header";
        PostedMatIssHeaderLocal: Record "Posted Material Issues Header";
        LastNumber: Code[20];
    begin
        IF DATE2DMY(WORKDATE, 1) < 10 THEN
            DateValue := '0' + FORMAT(DATE2DMY(WORKDATE, 1))
        ELSE
            DateValue := FORMAT(DATE2DMY(WORKDATE, 1));

        IF DATE2DMY(WORKDATE, 2) < 10 THEN
            MonthValue := '0' + FORMAT(DATE2DMY(WORKDATE, 2))
        ELSE
            MonthValue := FORMAT(DATE2DMY(WORKDATE, 2));

        IF DATE2DMY(WORKDATE, 2) <= 12 THEN
            YearValue := COPYSTR(FORMAT(DATE2DMY(WORKDATE, 3)), 3, 2);
        //IF TODAY=010910D THEN
        //  NumberValue := 'V'+YearValue+MonthValue+DateValue
        //ELSE
        NumberValue := 'R' + YearValue + MonthValue + DateValue;

        LastNumber := NumberValue + '0000';
        MaterialIssuesHeaderLocal.RESET;
        MaterialIssuesHeaderLocal.SETFILTER("No.", NumberValue + '*');
        IF MaterialIssuesHeaderLocal.FINDLAST THEN
            LastNumber := MaterialIssuesHeaderLocal."No.";

        PostedMatIssHeaderLocal.RESET;
        PostedMatIssHeaderLocal.SETCURRENTKEY("Material Issue No.");
        PostedMatIssHeaderLocal.SETFILTER("Material Issue No.", NumberValue + '*');
        IF PostedMatIssHeaderLocal.FINDLAST THEN
            IF LastNumber < PostedMatIssHeaderLocal."Material Issue No." THEN
                LastNumber := PostedMatIssHeaderLocal."Material Issue No.";
        //LastNumber:='R1012010106';
        NumberValue := INCSTR(LastNumber);
    end;


    procedure CopyFromSalesSchedule();
    var
        MaterialIssueLine: Record "Material Issues Line";
        LineNo: Integer;
        SalesSchedule: Record Schedule2;
    begin
        MaterialIssueLine.SETRANGE("Document No.", "No.");
        IF MaterialIssueLine.FINDLAST THEN
            LineNo := MaterialIssueLine."Line No."
        ELSE
            LineNo := 0;
        SalesSchedule.RESET;
        SalesSchedule.SETRANGE("Document Type", SalesSchedule."Document Type"::Order);
        SalesSchedule.SETRANGE("Document No.", "Sales Order No.");
        SalesSchedule.SETRANGE("Document Line No.", "Sales Order Line No.");
        SalesSchedule.SETRANGE(SalesSchedule.Type, SalesSchedule.Type::Item);
        IF SalesSchedule.FINDFIRST THEN
            REPEAT
                MaterialIssueLine.INIT;
                LineNo := LineNo + 10000;
                MaterialIssueLine."Document No." := "No.";
                MaterialIssueLine.VALIDATE("Item No.", SalesSchedule."No.");
                MaterialIssueLine."Line No." := LineNo;
                MaterialIssueLine.VALIDATE(Quantity, SalesSchedule.Quantity);
                MaterialIssueLine.INSERT;
            UNTIL SalesSchedule.NEXT = 0;
    end;


    procedure UpdateItemsInventory();
    var
        MaterialIssuesLine: Record "Material Issues Line";
        ItemStock: Codeunit "item stock at stores1";
    begin
        MaterialIssuesLine.SETRANGE(MaterialIssuesLine."Document No.", "No.");
        IF MaterialIssuesLine.FINDSET THEN
            REPEAT
                MaterialIssuesLine.Inventory := MaterialIssuesLine.Item_Stock(MaterialIssuesLine."Item No.", MaterialIssuesLine."Transfer-from Code");
            //  MaterialIssuesLine.MODIFY;
            UNTIL MaterialIssuesLine.NEXT = 0;
    end;


    procedure "---DIM1.0---"();
    begin
    end;


    procedure ShowDocDim();
    var
        OldDimSetID: Integer;
    begin
        //DIM 1.0 Start
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1', "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
            IF MatIssueLinesExist THEN
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;
        //DIM 1.0  End
    end;


    procedure MatIssueLinesExist(): Boolean;
    begin
        //DIM 1.0 Start
        MaterIssLine.RESET;
        MaterIssLine.SETRANGE("Document No.", "No.");
        EXIT(MaterIssLine.FINDFIRST);

        //DIM 1.0 End
    end;


    local procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer);
    var
        NewDimSetID: Integer;
    begin
        // Update all lines with changed dimensions.
        //DIM 1.0 Start
        IF NewParentDimSetID = OldParentDimSetID THEN
            EXIT;
        IF NOT CONFIRM(Text051) THEN
            EXIT;

        MaterIssLine.RESET;
        MaterIssLine.SETRANGE("Document No.", "No.");
        IF MaterIssLine.FIND('-') THEN
            REPEAT
                NewDimSetID := DimMgt.GetDeltaDimSetID(MaterIssLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                IF MaterIssLine."Dimension Set ID" <> NewDimSetID THEN BEGIN
                    MaterIssLine."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                      MaterIssLine."Dimension Set ID", MaterIssLine."Shortcut Dimension 1 Code", MaterIssLine."Shortcut Dimension 2 Code");
                    MaterIssLine.MODIFY;
                END;
            UNTIL MaterIssLine.NEXT = 0;
        //DIM 1.0 End
    end;
}

