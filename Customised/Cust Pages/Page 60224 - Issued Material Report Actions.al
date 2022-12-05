page 60224 "Issued Material Report Actions"
{
    // version Rev01

    Caption = 'Issued Material Report';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Control1102152002; '')
                {
                    Caption = 'SINGLE BUTTON RETURN PROCEDURE';
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(RETURN_ITEM1; RETURN_ITEM1)
                {
                    Caption = 'RETURN ITEM 1';
                    ApplicationArea = All;
                }
                field(REQUESTED_QTY; REQUESTED_QTY)
                {
                    Caption = 'REQUIRED QTY';
                    ApplicationArea = All;
                }
                field(PO_FILTER; PO_FILTER)
                {
                    Caption = 'PRODUCTION ORDER FILTER';
                    ApplicationArea = All;
                }
                field(PO_LINE_NO; PO_LINE_NO)
                {
                    Caption = 'PRODUCTION ORDER LINE NO.';
                    ApplicationArea = All;
                }
                field(Location; Location)
                {
                    Caption = 'LOCATION';
                    ApplicationArea = All;
                }
            }

            /* group("Return To Stock")
             {
                 Caption = 'Return To Stock';
                 field("NOTE : REPLACEMENT REQUEST WILL CREATE & POST IF ALL READY THERE IS ISSUES & IT WILL NOT RETURNED"; '')
                 {
                     Caption = 'NOTE : REPLACEMENT REQUEST WILL CREATE & POST IF ALL READY THERE IS ISSUES & IT WILL NOT RETURNED';
                     ColumnSpan = 5;
                     Style = Attention;
                     StyleExpr = TRUE;
                     ApplicationArea = All;
                 }
             }*/
            group(Damage)
            {
                Caption = 'Damage';
                field("NOTE : DAMAGE OPTION ONLY FOR SINGLE ITEM ONLY"; '')
                {
                    Caption = 'NOTE : DAMAGE OPTION ONLY FOR SINGLE ITEM ONLY';
                    RowSpan = 5;
                    Style = Attention;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("SINGLE BUTTON RETURN PROCEDURE")
            {
                Caption = 'SINGLE BUTTON RETURN PROCEDURE';
                action("RETURN TO STOCK")
                {
                    Caption = 'RETURN TO STOCK';
                    Image = ReturnShipment;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        IF (NOT (UPPERCASE(USERID) IN ['EFFTRONICS\PADMASRI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\JYOTHSNA', 'EFFTRONICS\GRAVI', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'])) THEN
                            ERROR('YOU DONT HAVE PERMISSION TO EXECUTE THIS FUNCTIONALIYT');
                        IF (RETURN_ITEM1 = '') THEN
                            ERROR('PLEASE ENTER THE ITEM');

                        IF PO_FILTER = '' THEN
                            ERROR('PLEASE ENTER THE PRODUCTION ORDER INFORMATION');
                        IF PO_LINE_NO = 0 THEN
                            ERROR('PLEASE ENTER THE ORDER LINE NO. INFORMATION');


                        PO.SETFILTER(PO."No.", PO_FILTER);
                        IF PO.FINDSET THEN
                            REPEAT
                                ILE.RESET;
                                ILE.SETCURRENTKEY("Entry Type", "Item No.", "Location Code", Open, "Lot No.", "Serial No.",
                                         "ITL Doc No.", "ITL Doc Line No.", "ITL Doc Ref Line No.");
                                ILE.SETRANGE("Entry Type", ILE."Entry Type"::Transfer);
                                ILE.SETRANGE("Item No.", RETURN_ITEM1);
                                ILE.SETRANGE("Location Code", 'PROD');
                                ILE.SETRANGE(Open, TRUE);
                                ILE.SETRANGE("ITL Doc No.", PO."No.");
                                ILE.SETRANGE(ILE."ITL Doc Line No.", PO_LINE_NO);
                                ILE.SETFILTER(ILE."Remaining Quantity", '>%1', 0);
                                IF ILE.FINDLAST THEN              //anil added for last item
                                BEGIN
                                    MATERIAL_ISSUES_HEADER.INIT;
                                    MATERIAL_ISSUES_HEADER."No." := GetNextNo;
                                    MATERIAL_ISSUES_HEADER.INSERT;
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-from Code", 'PROD');
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-to Code", FORMAT(Location));
                                    MATERIAL_ISSUES_HEADER."Receipt Date" := TODAY;
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order No.", ILE."ITL Doc No.");
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order Line No.", ILE."ITL Doc Line No.");
                                    MATERIAL_ISSUES_HEADER."User ID" := USERID;
                                    //user.GET(USERID);
                                    user.RESET;
                                    user.SETRANGE("User Name", USERID);
                                    IF user.FINDFIRST THEN; //Rev01
                                    MATERIAL_ISSUES_HEADER."Resource Name" := user."Full Name";
                                    MATERIAL_ISSUES_HEADER."Creation DateTime" := CURRENTDATETIME;
                                    MATERIAL_ISSUES_HEADER."Sales Order No." := PO."Sales Order No.";
                                    MATERIAL_ISSUES_HEADER.MODIFY;
                                    LineNo := 10000;
                                END;
                                REPEAT
                                    Item.GET(ILE."Item No.");
                                    MATERIAL_ISSUES_LINE.INIT;
                                    MATERIAL_ISSUES_LINE."Document No." := MATERIAL_ISSUES_HEADER."No.";
                                    MATERIAL_ISSUES_LINE.VALIDATE("Item No.", ILE."Item No.");
                                    MATERIAL_ISSUES_LINE."Line No." := LineNo;
                                    MATERIAL_ISSUES_LINE.VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
                                    MATERIAL_ISSUES_LINE.VALIDATE(Quantity, REQUESTED_QTY);
                                    MATERIAL_ISSUES_LINE.VALIDATE("Qty. to Receive", REQUESTED_QTY);
                                    MATERIAL_ISSUES_LINE.VALIDATE("Outstanding Quantity", REQUESTED_QTY);
                                    MATERIAL_ISSUES_LINE."Prod. Order No." := ILE."ITL Doc No.";
                                    MATERIAL_ISSUES_LINE."Prod. Order Line No." := ILE."ITL Doc Line No.";
                                    MATERIAL_ISSUES_LINE."Prod. Order Comp. Line No." := ILE."ITL Doc Ref Line No.";
                                    LineNo := LineNo + 10000;
                                    MATERIAL_ISSUES_LINE.INSERT;

                                    TrackingSpecification.INIT;
                                    TrackingSpecification."Order No." := MATERIAL_ISSUES_LINE."Document No.";
                                    TrackingSpecification."Order Line No." := MATERIAL_ISSUES_LINE."Line No.";
                                    TrackingSpecification."Item No." := MATERIAL_ISSUES_LINE."Item No.";
                                    TrackingSpecification."Location Code" := ILE."Location Code";
                                    TrackingSpecification."Lot No." := ILE."Lot No.";
                                    TrackingSpecification."Serial No." := ILE."Serial No.";
                                    TrackingSpecification."Actual Quantity" := MATERIAL_ISSUES_LINE.Quantity;
                                    TrackingSpecification."Actual Qty to Receive" := MATERIAL_ISSUES_LINE."Qty. to Receive";
                                    TrackingSpecification.Description := MATERIAL_ISSUES_LINE.Description;
                                    TrackingSpecification."Creation Date" := TODAY;
                                    TrackingSpecification."Appl.-to Item Entry" := ILE."Entry No.";
                                    TrackingSpecification."Warranty date" := ILE."Warranty Date";
                                    TrackingSpecification."Expiration Date" := ILE."Expiration Date";
                                    TrackingSpecification."Prod. Order No." := MATERIAL_ISSUES_LINE."Prod. Order No.";
                                    TrackingSpecification."Prod. Order Line No." := MATERIAL_ISSUES_LINE."Prod. Order Line No.";
                                    TrackingSpecification.Quantity := REQUESTED_QTY;
                                    TrackingSpecification.VALIDATE(TrackingSpecification.Quantity);
                                    TrackingSpecification.INSERT;
                                UNTIL ILE.NEXT = 0;
                                MATERIAL_ISSUES_LINE.RESET;
                                MATERIAL_ISSUES_LINE.SETRANGE("Document No.", MATERIAL_ISSUES_HEADER."No.");
                                MATERIAL_ISSUES_LINE.SETFILTER(Quantity, '<>0');
                                IF NOT MATERIAL_ISSUES_LINE.FINDFIRST THEN
                                    ERROR(Text002, MATERIAL_ISSUES_HEADER."No.");
                                MATERIAL_ISSUES_LINE.RESET;
                                MATERIAL_ISSUES_HEADER.VALIDATE(Status, MATERIAL_ISSUES_HEADER.Status::Released);
                                MATERIAL_ISSUES_HEADER.VALIDATE("Released Date", WORKDATE);
                                MATERIAL_ISSUES_HEADER.VALIDATE("Released Time", TIME);
                                MATERIAL_ISSUES_HEADER.VALIDATE("Released By", USERID);
                                MATERIAL_ISSUES_HEADER."Posting Date" := TODAY;
                                IF MATERIAL_ISSUES_HEADER."Authorized Date" = 0D THEN
                                    MATERIAL_ISSUES_HEADER."Authorized Date" := TODAY;
                                MATERIAL_ISSUES_HEADER.MODIFY;
                                Issue_Post.Issues_Post(MATERIAL_ISSUES_HEADER);
                            UNTIL PO.NEXT = 0;
                    end;
                }
                action("POST DAMAGES")
                {
                    Caption = 'POST DAMAGES';
                    Image = DefaultFault;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        IF NOT (UPPERCASE(USERID) IN ['EFFTRONICS\GRAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
                            ERROR('YOU DONT HAVE PERMISSION TO EXECUTE THIS FUNCTIONALITY');


                        IF (RETURN_ITEM1 = '') THEN
                            ERROR('PLEASE ENTER THE ITEM');

                        IF PO_FILTER = '' THEN
                            ERROR('PLEASE ENTER THE PRODUCTION ORDER INFORMATION');
                        IF PO_LINE_NO = 0 THEN
                            ERROR('PLEASE ENTER THE ORDER LINE NO. INFORMATION');



                        PO.SETFILTER(PO."No.", PO_FILTER);
                        IF PO.FINDSET THEN
                            REPEAT
                                ILE.RESET;
                                ILE.SETCURRENTKEY("Entry Type", "Item No.", "Location Code", Open, "Lot No.", "Serial No.",
                                         "ITL Doc No.", "ITL Doc Line No.", "ITL Doc Ref Line No.");
                                ILE.SETRANGE("Entry Type", ILE."Entry Type"::Transfer);
                                ILE.SETRANGE("Item No.", RETURN_ITEM1);
                                ILE.SETRANGE("Location Code", 'PROD');
                                ILE.SETRANGE(Open, TRUE);
                                ILE.SETRANGE("ITL Doc No.", PO."No.");
                                ILE.SETRANGE(ILE."ITL Doc Line No.", PO_LINE_NO);
                                ILE.SETFILTER(ILE."Remaining Quantity", '>%1', 0);
                                IF ILE.FINDSET THEN BEGIN
                                    MATERIAL_ISSUES_HEADER.INIT;
                                    MATERIAL_ISSUES_HEADER."No." := GetNextNo;
                                    MATERIAL_ISSUES_HEADER.INSERT;
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-from Code", 'PROD');
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-to Code", 'DAMAGE');
                                    MATERIAL_ISSUES_HEADER."Receipt Date" := TODAY;
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order No.", ILE."ITL Doc No.");
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order Line No.", ILE."ITL Doc Line No.");
                                    MATERIAL_ISSUES_HEADER."User ID" := USERID;
                                    //user.GET(USERID);
                                    user.RESET;
                                    user.SETRANGE("User Name", USERID);
                                    IF user.FINDFIRST THEN; //Rev01
                                    MATERIAL_ISSUES_HEADER."Resource Name" := user."Full Name";
                                    MATERIAL_ISSUES_HEADER."Creation DateTime" := CURRENTDATETIME;
                                    MATERIAL_ISSUES_HEADER."Sales Order No." := PO."Sales Order No.";
                                    MATERIAL_ISSUES_HEADER.MODIFY;
                                    LineNo := 10000;


                                    Item.GET(ILE."Item No.");
                                    MATERIAL_ISSUES_LINE.INIT;
                                    MATERIAL_ISSUES_LINE."Document No." := MATERIAL_ISSUES_HEADER."No.";
                                    MATERIAL_ISSUES_LINE.VALIDATE("Item No.", ILE."Item No.");
                                    MATERIAL_ISSUES_LINE."Line No." := LineNo;
                                    MATERIAL_ISSUES_LINE.VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
                                    IF REQUESTED_QTY = 0 THEN BEGIN
                                        MATERIAL_ISSUES_LINE.VALIDATE(Quantity, ILE.Quantity);
                                        MATERIAL_ISSUES_LINE.VALIDATE("Qty. to Receive", ILE.Quantity);
                                        MATERIAL_ISSUES_LINE.VALIDATE("Outstanding Quantity", ILE.Quantity);

                                    END ELSE BEGIN
                                        MATERIAL_ISSUES_LINE.VALIDATE(Quantity, REQUESTED_QTY);
                                        MATERIAL_ISSUES_LINE.VALIDATE("Qty. to Receive", REQUESTED_QTY);
                                        MATERIAL_ISSUES_LINE.VALIDATE("Outstanding Quantity", REQUESTED_QTY);
                                    END;
                                    MATERIAL_ISSUES_LINE."Prod. Order No." := ILE."ITL Doc No.";
                                    MATERIAL_ISSUES_LINE."Prod. Order Line No." := ILE."ITL Doc Line No.";
                                    MATERIAL_ISSUES_LINE."Prod. Order Comp. Line No." := ILE."ITL Doc Ref Line No.";
                                    LineNo := LineNo + 10000;
                                    MATERIAL_ISSUES_LINE.INSERT;

                                    TrackingSpecification.INIT;
                                    TrackingSpecification."Order No." := MATERIAL_ISSUES_LINE."Document No.";
                                    TrackingSpecification."Order Line No." := MATERIAL_ISSUES_LINE."Line No.";
                                    TrackingSpecification."Item No." := MATERIAL_ISSUES_LINE."Item No.";
                                    TrackingSpecification."Location Code" := ILE."Location Code";
                                    TrackingSpecification."Lot No." := ILE."Lot No.";
                                    TrackingSpecification."Serial No." := ILE."Serial No.";
                                    TrackingSpecification."Actual Quantity" := MATERIAL_ISSUES_LINE.Quantity;
                                    TrackingSpecification."Actual Qty to Receive" := MATERIAL_ISSUES_LINE."Qty. to Receive";
                                    TrackingSpecification.Description := MATERIAL_ISSUES_LINE.Description;
                                    TrackingSpecification."Creation Date" := TODAY;
                                    TrackingSpecification."Appl.-to Item Entry" := ILE."Entry No.";
                                    TrackingSpecification."Warranty date" := ILE."Warranty Date";
                                    TrackingSpecification."Expiration Date" := ILE."Expiration Date";
                                    TrackingSpecification."Prod. Order No." := MATERIAL_ISSUES_LINE."Prod. Order No.";
                                    TrackingSpecification."Prod. Order Line No." := MATERIAL_ISSUES_LINE."Prod. Order Line No.";
                                    IF REQUESTED_QTY = 0 THEN
                                        TrackingSpecification.Quantity := ILE.Quantity
                                    ELSE
                                        TrackingSpecification.Quantity := REQUESTED_QTY;
                                    TrackingSpecification.VALIDATE(TrackingSpecification.Quantity);
                                    TrackingSpecification.INSERT;

                                    MATERIAL_ISSUES_LINE.RESET;
                                    MATERIAL_ISSUES_LINE.SETRANGE("Document No.", MATERIAL_ISSUES_HEADER."No.");
                                    MATERIAL_ISSUES_LINE.SETFILTER(Quantity, '<>0');
                                    IF NOT MATERIAL_ISSUES_LINE.FINDFIRST THEN
                                        ERROR(Text002, MATERIAL_ISSUES_HEADER."No.");

                                    MATERIAL_ISSUES_LINE.RESET;
                                    MATERIAL_ISSUES_HEADER.VALIDATE(Status, MATERIAL_ISSUES_HEADER.Status::Released);
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Released Date", WORKDATE);
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Released Time", TIME);
                                    MATERIAL_ISSUES_HEADER.VALIDATE("Released By", USERID);
                                    MATERIAL_ISSUES_HEADER."Posting Date" := TODAY;
                                    IF MATERIAL_ISSUES_HEADER."Authorized Date" = 0D THEN
                                        MATERIAL_ISSUES_HEADER."Authorized Date" := TODAY;
                                    MATERIAL_ISSUES_HEADER.MODIFY;
                                    Issue_Post.Issues_Post(MATERIAL_ISSUES_HEADER);

                                    /*    // CRETION OF NEW MATERIAL REQUEST
                                        MATERIAL_ISSUES_HEADER.RESET;
                                        MATERIAL_ISSUES_HEADER.INIT;
                                        MATERIAL_ISSUES_HEADER."No.":=GetNextNo;
                                        MATERIAL_ISSUES_HEADER.INSERT;
                                        MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-from Code",'STR');
                                        MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-to Code",'PROD');
                                        MATERIAL_ISSUES_HEADER."Receipt Date":=TODAY;
                                        MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order No.", ILE."ITL Doc No.");
                                        MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order Line No.",ILE."ITL Doc Line No.");
                                        MATERIAL_ISSUES_HEADER."User ID" := USERID;
                                        user.GET(USERID);
                                        MATERIAL_ISSUES_HEADER."Resource Name":=user.Name;
                                        MATERIAL_ISSUES_HEADER."Creation DateTime":=CURRENTDATETIME;
                                        MATERIAL_ISSUES_HEADER."Sales Order No.":=PO."Sales Order No.";
                                        MATERIAL_ISSUES_HEADER.MODIFY;
                                        LineNo:=10000;

                                        Item.GET(RETURN_ITEM1);
                                        MATERIAL_ISSUES_LINE.INIT;
                                        MATERIAL_ISSUES_LINE."Document No." :=MATERIAL_ISSUES_HEADER."No." ;
                                        MATERIAL_ISSUES_LINE.VALIDATE("Item No.",RETURN_ITEM1);
                                        MATERIAL_ISSUES_LINE."Line No." := LineNo ;
                                        MATERIAL_ISSUES_LINE.VALIDATE("Unit of Measure Code",Item."Base Unit of Measure");
                                        MATERIAL_ISSUES_LINE.VALIDATE(Quantity,ILE.Quantity);
                                        MATERIAL_ISSUES_LINE.VALIDATE("Qty. to Receive", ILE.Quantity);
                                        MATERIAL_ISSUES_LINE.VALIDATE("Outstanding Quantity",ILE.Quantity);
                                        MATERIAL_ISSUES_LINE."Prod. Order No." := ILE."ITL Doc No.";
                                        MATERIAL_ISSUES_LINE."Prod. Order Line No." :=ILE."ITL Doc Line No.";
                                        MATERIAL_ISSUES_LINE."Prod. Order Comp. Line No." := ILE."ITL Doc Ref Line No.";
                                        LineNo := LineNo + 10000;
                                        MATERIAL_ISSUES_LINE.INSERT;  */
                                END;
                            UNTIL PO.NEXT = 0;

                    end;
                }
                action("CREATE SINGLE REQUESTS")
                {
                    Caption = 'CREATE SINGLE REQUESTS';
                    Image = CreateInteraction;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        IF (NOT (UPPERCASE(USERID) IN ['EFFTRONICS\PADMASRI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\GRAVI', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'])) THEN
                            ERROR('YOU DONT HAVE PERMISSION TO EXECUTE THIS FUNCTIONALITY');

                        IF (RETURN_ITEM1 = '') THEN
                            ERROR('PLEASE ENTER THE ITEM');

                        IF REQUESTED_QTY = 0 THEN
                            ERROR('PLEASE ENTER THE REQUESTED QUANTITY');
                        IF PO_FILTER = '' THEN
                            ERROR('PLEASE ENTER THE PRODUCTION ORDER INFORMATION');
                        IF PO_LINE_NO = 0 THEN
                            ERROR('PLEASE ENTER THE ORDER LINE NO. INFORMATION');


                        PO.SETFILTER(PO."No.", PO_FILTER);
                        IF PO.FINDSET THEN
                            REPEAT
                                MATERIAL_ISSUES_HEADER.INIT;
                                MATERIAL_ISSUES_HEADER."No." := GetNextNo;
                                MATERIAL_ISSUES_HEADER.INSERT;
                                MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-from Code", 'STR');
                                MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-to Code", 'PROD');
                                MATERIAL_ISSUES_HEADER."Receipt Date" := TODAY;
                                MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order No.", PO."No.");
                                MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order Line No.", PO_LINE_NO);
                                MATERIAL_ISSUES_HEADER."User ID" := USERID;
                                //user.GET(USERID);
                                user.RESET;
                                user.SETRANGE("User Name", USERID);
                                IF user.FINDFIRST THEN; //Rev01
                                MATERIAL_ISSUES_HEADER."Resource Name" := user."Full Name";
                                MATERIAL_ISSUES_HEADER."Creation DateTime" := CURRENTDATETIME;
                                MATERIAL_ISSUES_HEADER."Sales Order No." := PO."Sales Order No.";
                                MATERIAL_ISSUES_HEADER.MODIFY;
                                LineNo := 10000;

                                Item.GET(RETURN_ITEM1);
                                MATERIAL_ISSUES_LINE.INIT;
                                MATERIAL_ISSUES_LINE."Document No." := MATERIAL_ISSUES_HEADER."No.";
                                MATERIAL_ISSUES_LINE.VALIDATE("Item No.", RETURN_ITEM1);
                                MATERIAL_ISSUES_LINE."Line No." := LineNo;
                                MATERIAL_ISSUES_LINE.VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
                                MATERIAL_ISSUES_LINE.VALIDATE(Quantity, REQUESTED_QTY);
                                MATERIAL_ISSUES_LINE.VALIDATE("Qty. to Receive", REQUESTED_QTY);
                                MATERIAL_ISSUES_LINE.VALIDATE("Outstanding Quantity", REQUESTED_QTY);
                                MATERIAL_ISSUES_LINE."Prod. Order No." := PO."No.";
                                MATERIAL_ISSUES_LINE."Prod. Order Line No." := PO_LINE_NO;
                                LineNo := LineNo + 10000;
                                MATERIAL_ISSUES_LINE.INSERT;

                                MATERIAL_ISSUES_LINE.RESET;
                                MATERIAL_ISSUES_LINE.SETRANGE("Document No.", MATERIAL_ISSUES_HEADER."No.");
                                MATERIAL_ISSUES_LINE.SETFILTER(Quantity, '<>0');
                                IF NOT MATERIAL_ISSUES_LINE.FINDFIRST THEN
                                    ERROR(Text002, MATERIAL_ISSUES_HEADER."No.");

                                MATERIAL_ISSUES_LINE.RESET;
                                MATERIAL_ISSUES_HEADER.VALIDATE(Status, MATERIAL_ISSUES_HEADER.Status::Released);
                                MATERIAL_ISSUES_HEADER.VALIDATE("Released Date", WORKDATE);
                                MATERIAL_ISSUES_HEADER.VALIDATE("Released Time", TIME);
                                MATERIAL_ISSUES_HEADER.VALIDATE("Released By", USERID);
                                MATERIAL_ISSUES_HEADER."Posting Date" := TODAY;
                                IF MATERIAL_ISSUES_HEADER."Authorized Date" = 0D THEN
                                    MATERIAL_ISSUES_HEADER."Authorized Date" := TODAY;
                                MATERIAL_ISSUES_HEADER.MODIFY;
                            UNTIL PO.NEXT = 0;
                    end;
                }
                action("Run Report")
                {
                    Caption = 'Run Report';
                    Image = Report2;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "Issued Material Report";
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        Text002: Label 'There is nothing to release for MaterialIssue order %1.';
        QTY: Decimal;
        "material issues line": Record "Material Issues Line";
        Reason: Code[100];
        Choice1: Option Normal,Damage,Return;
        Choice2: Option Used,NotUsed;
        ILE: Record "Item Ledger Entry";
        Lot: Code[100];
        Item: Record Item;
        UC: Decimal;
        Total: Decimal;
        "Serial no": Code[100];
        Choice3: Option Issue,Project,WRET,Summary;
        "Project Total": Decimal;
        Project_Desc: Text[100];
        PO: Record "Production Order";
        "R&D total": Decimal;
        ILE2: Record "Item Ledger Entry";
        "Prod. Order Description": Text[50];
        "Bench-Mark": Integer;
        "Issued Date": Date;
        Total_Qty: Decimal;
        PRL: Record "Purch. Rcpt. Line";
        ITEMLED: Record "Item Ledger Entry";
        vendor: Text[50];
        PRH: Record "Purch. Rcpt. Header";
        "BILLNO.": Code[20];
        BillDate: Date;
        Desc: Text[50];
        Value: Decimal;
        "Total Value": Decimal;
        Ret_Qty: Decimal;
        PMIL: Record "Posted Material Issues Line";
        PMIH: Record "Posted Material Issues Header";
        PIL: Record "Purch. Inv. Line";
        Consider_Return: Boolean;
        Issued_Qty: Decimal;
        ILE3: Record "Item Ledger Entry";
        RETURN_ITEM1: Code[20];
        PO_FILTER: Text[100];
        PO_LINE_NO: Integer;
        POR_LINE_CONFIRM: Boolean;
        MATERIAL_ISSUES_HEADER: Record "Material Issues Header";
        MATERIAL_ISSUES_LINE: Record "Material Issues Line";
        PO_FORM: Page "Released Production Order";
        user: Record User;
        REPLACE_ITEM_FILTER: Text[100];
        TrackingSpecification: Record "Mat.Issue Track. Specification";
        LineNo: Integer;
        "Release MaterialIssue Document": Codeunit "Release MaterialIssue Document";
        Issue_Post: Codeunit "MaterialIssueOrde-Post Receipt";
        REQUESTED_QTY: Decimal;
        Sales_Order_No: Code[30];
        Item_No: Code[30];
        Posting_From_Date: Date;
        ItemLotNumbers: Record "Item Lot Numbers" temporary;
        PO1: Code[20];
        Posting_To_Date: Date;
        ileref: Code[30];
        Item_Batch: Record Old_Pur_Invoices;
        Location: Option STR,MCH;

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

        //IF DATE2DMY(WORKDATE,3) < 99 THEN
        YearValue := COPYSTR(FORMAT(DATE2DMY(WORKDATE, 3)), 3, 2);
        //IF ((TODAY=010810D) OR (TODAY=010910D) OR (TODAY=011010D))THEN
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

        NumberValue := INCSTR(LastNumber);
    end;
}

