page 60233 "Site Stock Updation"
{
    PageType = List;
    SourceTable = "DC Header";
    SourceTableView = WHERE("No." = FILTER('CUS*'));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group("Yesterday DC'S")
            {
                Caption = 'Yesterday DC''S';
                Visible = DcVisible;
                repeater(Control1102154025)
                {
                    Caption = 'Yesterday DC''S';
                    field("Created Date"; "Created Date")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("No."; "No.")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Location Name"; "Location Name")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(Remarks; Remarks)
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Reciver Name"; "Reciver Name")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("L.R Number"; "L.R Number")
                    {
                        ApplicationArea = All;
                    }
                    field("Mode Of Transport"; "Mode Of Transport")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field(Charges; Charges)
                    {
                        Editable = true;
                        ApplicationArea = All;
                    }
                }
            }
            group("Site Stock Updation")
            {
                Caption = 'Site Stock Updation';
                field(Location; Location)
                {
                    Caption = 'Location';
                    Lookup = true;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SRIVALLI', 'EFFTRONICS\RATNA', 'EFFTRONICS\RAMADEVI', 'EFFTRONICS\SUJANI',
                                           'EFFTRONICS\JYOTHSNA', 'EFFTRONICS\PRIYADARSINI', 'EFFTRONICS\BHAVANIP', 'EFFTRONICS\RAMADEVI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\MPUJITHA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN BEGIN
                            UserGRec.RESET;
                            UserGRec.SETFILTER(UserGRec."User ID", USERID);
                            IF UserGRec.FINDFIRST THEN BEGIN
                                DivisionGRec.RESET;
                                DivisionGRec.SETFILTER(DivisionGRec.Code, Location);
                                IF DivisionGRec.FINDFIRST THEN BEGIN
                                    IF UserGRec.EmployeeID <> DivisionGRec."Project Manager" THEN
                                        ERROR('You are not Authorised to change the stock of this location');
                                END
                                ELSE
                                    ERROR('NOT A VALID LOCATION.CONTACT ERP TEAM');
                            END;
                        END;
                    end;
                }
                field(Item; Item)
                {
                    Caption = 'Item';
                    Lookup = true;
                    TableRelation = Item;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Present_Location := '';
                        IF (Item <> '') THEN BEGIN
                            ItemGRec.RESET;
                            IF ItemGRec.GET(Item) THEN
                                ItemDescrption := ItemGRec.Description;

                            IF ("Serial No." <> '') THEN BEGIN
                                ILE.RESET;
                                ILE.SETFILTER(ILE."Item No.", Item);
                                ILE.SETFILTER(ILE."Serial No.", "Serial No.");
                                ILE.SETFILTER(ILE.Open, '%1', TRUE);
                                IF ILE.FINDFIRST THEN BEGIN
                                    IF ILE."Location Code" IN ['SITE', 'OLD STOCK'] THEN BEGIN
                                        DV.RESET;
                                        DV.SETFILTER(DV.Code, ILE."Global Dimension 2 Code");
                                        IF DV.FINDFIRST THEN
                                            Present_Location := DV.Name + ' ' + ILE."Location Code"
                                        ELSE
                                            Present_Location := ILE."Global Dimension 2 Code" + ' ' + ILE."Location Code";
                                    END
                                    ELSE
                                        Present_Location := ILE."Location Code";
                                END;
                            END;
                        END
                        ELSE
                            Present_Location := '';
                    end;
                }
                field("Serial No."; "Serial No.")
                {
                    Caption = 'Serial No.';
                    Lookup = false;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Present_Location := '';
                        IF ("Serial No." <> '') AND (Item <> '') THEN BEGIN
                            ILE.RESET;
                            ILE.SETFILTER(ILE."Item No.", Item);
                            ILE.SETFILTER(ILE."Serial No.", "Serial No.");
                            ILE.SETFILTER(ILE.Open, '%1', TRUE);
                            IF ILE.FINDFIRST THEN BEGIN
                                IF ILE."Location Code" IN ['SITE', 'OLD STOCK'] THEN BEGIN
                                    DV.RESET;
                                    DV.SETFILTER(DV.Code, ILE."Global Dimension 2 Code");
                                    IF DV.FINDFIRST THEN
                                        Present_Location := DV.Name + ' ' + ILE."Location Code"
                                    ELSE
                                        Present_Location := ILE."Global Dimension 2 Code" + ' ' + ILE."Location Code";
                                    Posting_Date := ILE."Posting Date";
                                END
                                ELSE
                                    Present_Location := ILE."Location Code";
                            END;
                        END
                        ELSE
                            Present_Location := '';
                    end;
                }
                field("Working Status"; "Working Status")
                {
                    Caption = 'Working Status';
                    Lookup = false;
                    ApplicationArea = All;
                }
                field(Present_Location; Present_Location)
                {
                    Caption = 'Present_Location';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(ItemDescrption; ItemDescrption)
                {
                    Caption = 'Item Description';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Posting_Date; Posting_Date)
                {
                    Caption = 'Posting_Date';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Control1102152012)
            {
                Caption = 'Site Transfers';
                Visible = STVisible;
                field(Location1; Location1)
                {
                    Caption = 'Location';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        LocationDesc := '';
                        IF (Location1 <> '') THEN BEGIN
                            DV.RESET;
                            DV.SETFILTER(DV.Code, Location1);
                            IF DV.FINDFIRST THEN
                                LocationDesc := DV.Name;
                            IF NOT (USERID IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SRIVALLI', 'EFFTRONICS\RATNA', 'EFFTRONICS\PRIYADARSINI', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\JYOTHSNA',
                                              'EFFTRONICS\BHAVANIP', 'EFFTRONICS\RAMADEVI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\MPUJITHA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN BEGIN
                                UserGRec.RESET;
                                UserGRec.SETFILTER(UserGRec."User ID", USERID);
                                IF UserGRec.FINDFIRST THEN BEGIN
                                    DivisionGRec.RESET;
                                    DivisionGRec.SETFILTER(DivisionGRec.Code, Location1);
                                    IF DivisionGRec.FINDFIRST THEN BEGIN
                                        IF UserGRec.EmployeeID <> DivisionGRec."Project Manager" THEN
                                            ERROR('You are not Authorised to change the stock of this location');
                                    END
                                    ELSE
                                        ERROR('NOT A VALID LOCATION.CONTACT ERP TEAM');
                                END;
                            END;
                        END;
                    end;
                }
                field(Item1; Item1)
                {
                    Caption = 'Item';
                    TableRelation = Item;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ItemDescrption := '';
                        IF (Item1 <> '') THEN BEGIN
                            ItemGRec.RESET;
                            IF ItemGRec.GET(Item1) THEN
                                ItemDescrption := ItemGRec.Description;
                            OLD := FALSE;
                            IF ("Old Card Serial No." <> '') AND (Item1 <> '') THEN BEGIN
                                ILE.RESET;
                                ILE.SETFILTER(ILE."Item No.", Item1);
                                ILE.SETFILTER(ILE."Serial No.", "Old Card Serial No.");
                                ILE.SETFILTER(ILE."Global Dimension 2 Code", Location1);
                                ILE.SETFILTER(ILE.Open, '%1', TRUE);
                                IF ILE.FINDFIRST THEN BEGIN
                                    IF ILE."Location Code" IN ['SITE', 'OLD STOCK'] THEN BEGIN
                                        OLD := TRUE;
                                        OldStatus := ILE."Location Code";
                                    END
                                    ELSE BEGIN
                                        MESSAGE('Entered item %2 with %3 Serial No. in not Present in %1 Location', Location1, Item1, "Old Card Serial No.");
                                        OLD := FALSE;
                                    END;
                                END;
                            END;
                            // MESSAGE('new card %1 %2 %3 %4 ', "Old Card Serial No.","New Card Serial No.",Location1,OLD);
                            New := FALSE;
                            IF ("New Card Serial No." <> '') AND (Item1 <> '') AND OLD THEN BEGIN
                                ILE.RESET;
                                ILE.SETFILTER(ILE."Item No.", Item1);
                                ILE.SETFILTER(ILE."Serial No.", "New Card Serial No.");
                                ILE.SETFILTER(ILE."Global Dimension 2 Code", Location1);
                                ILE.SETFILTER(ILE.Open, '%1', TRUE);
                                IF ILE.FINDFIRST THEN BEGIN
                                    IF ILE."Location Code" IN ['SITE', 'OLD STOCK'] THEN BEGIN
                                        New := TRUE;
                                        //  MESSAGE('%1',New);
                                        NewStatus := ILE."Location Code";
                                    END
                                    ELSE BEGIN
                                        MESSAGE('Entered item %2 with %3 Serial No. in not Present in %1 Location', Location1, Item1, "New Card Serial No.");
                                        New := FALSE;
                                    END;
                                END;
                            END;
                            // MESSAGE('%1',New);
                        END;
                    end;
                }
                field("Old Card Serial No."; "Old Card Serial No.")
                {
                    Caption = 'Old Card Serial No.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        OLD := FALSE;
                        IF ("Old Card Serial No." <> '') AND (Item1 <> '') THEN BEGIN
                            ILE.RESET;
                            ILE.SETFILTER(ILE."Item No.", Item1);
                            ILE.SETFILTER(ILE."Serial No.", "Old Card Serial No.");
                            ILE.SETFILTER(ILE."Global Dimension 2 Code", Location1);
                            ILE.SETFILTER(ILE.Open, '%1', TRUE);
                            IF ILE.FINDFIRST THEN BEGIN
                                IF ILE."Location Code" IN ['SITE', 'OLD STOCK'] THEN BEGIN
                                    OLD := TRUE;
                                    OldStatus := ILE."Location Code";
                                END
                                ELSE BEGIN
                                    MESSAGE('Entered item %2 with %3 Serial No. in not Present in %1 Location', Location1, Item1, "Old Card Serial No.");
                                    OLD := FALSE;
                                END;
                            END;
                        END;
                    end;
                }
                field(LocationDesc; LocationDesc)
                {
                    Caption = 'Location Description';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(ItemDescrption1; ItemDescrption)
                {
                    Caption = 'Item Descrption';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("New Card Serial No."; "New Card Serial No.")
                {
                    Caption = 'New Card Serial No.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //MESSAGE('new card %1 %2 %3 %4 ', "Old Card Serial No.","New Card Serial No.",Location1,OLD);
                        New := FALSE;
                        IF ("New Card Serial No." <> '') AND (Item1 <> '') AND OLD THEN BEGIN
                            ILE.RESET;
                            ILE.SETFILTER(ILE."Item No.", Item1);
                            ILE.SETFILTER(ILE."Serial No.", "New Card Serial No.");
                            ILE.SETFILTER(ILE."Global Dimension 2 Code", Location1);
                            ILE.SETFILTER(ILE.Open, '%1', TRUE);
                            IF ILE.FINDFIRST THEN BEGIN
                                IF ILE."Location Code" IN ['SITE', 'OLD STOCK'] THEN BEGIN
                                    New := TRUE;
                                    // MESSAGE('%1',New);
                                    NewStatus := ILE."Location Code";
                                END
                                ELSE BEGIN
                                    MESSAGE('Entered item %2 with %3 Serial No. in not Present in %1 Location', Location1, Item1, "New Card Serial No.");
                                    New := FALSE;
                                END;
                            END;
                        END;
                        //MESSAGE('%1',New);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Make To the Stock")
            {
                Caption = 'Make To the Stock';
                Image = CreateSKU;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    IF (Location = '') OR (Item = '') OR ("Serial No." = '') THEN
                        ERROR('please enter the Details')
                    ELSE BEGIN
                        DivisionGRec.RESET;
                        DivisionGRec.SETFILTER(DivisionGRec.Code, Location);
                        IF DivisionGRec.FINDFIRST THEN BEGIN
                            IF DivisionGRec."Stock Verified" THEN
                                ERROR('You are not Authorised to change the stock of this location');
                        END;
                        Connection.Item_Availability(Item, "Serial No.", Location, "Working Status");
                        MESSAGE('Trasaction Completed');
                    END;
                    //Location:='';
                    //Item:='';
                    "Serial No." := '';
                    CurrPage.UPDATE;
                end;
            }
            action("Remove from Stock")
            {
                Caption = 'Remove from Stock';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF (Location = '') OR (Item = '') OR ("Serial No." = '') THEN
                        ERROR('please enter the Details')
                    ELSE BEGIN
                        DivisionGRec.RESET;
                        DivisionGRec.SETFILTER(DivisionGRec.Code, Location);
                        IF DivisionGRec.FINDFIRST THEN BEGIN
                            IF DivisionGRec."Stock Verified" THEN
                                ERROR('You are not Authorised to change the stock of this location');
                        END;

                        Connection.Item_Removal(Item, "Serial No.", Location, "Working Status");
                        MESSAGE('Trasaction Completed');
                    END;
                    "Serial No." := '';
                    CurrPage.UPDATE;
                end;
            }
            action("Site Transfers")
            {
                Caption = 'Site Transfers';
                Image = ResetStatus;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF (NOT OLD) OR (NOT New) OR (Item1 = '') THEN
                        ERROR('Please Verify the Details You Have Entered')
                    ELSE BEGIN
                        //Connection.Move_Item_To_Site_OR_Old_Stock(Item1,Location1,"Old Card Serial No.",OldStatus,"New Card Serial No.",NewStatus);
                    END;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SETRANGE(Type, Type::Site);
        SETRANGE(Charges, 0);
        SETFILTER("Mode Of Transport", '<>%1', 'By Hand');
        ASCENDING(TRUE);
        IF USERID IN ['EFFTRONICS\SUNDAR'] THEN BEGIN
            DcVisible := FALSE;
            STVisible := TRUE;
        END
        ELSE BEGIN
            DcVisible := TRUE;
            STVisible := FALSE;
        END;

        New := FALSE;
        OLD := FALSE;
    end;

    var
        Location: Code[10];
        Item: Code[20];
        "Serial No.": Code[50];
        "Working Status": Enum WORKINGSTATUS;
        Connection: Codeunit "Cash Flow Connection";
        Present_Location: Code[50];
        ILE: Record "Item Ledger Entry";
        DV: Record "Dimension Value";
        Text19037993: Label 'Location';
        Text19011378: Label 'Item';
        Text19005951: Label 'Serial No.';
        Text19025311: Label 'Working Status';
        Text19056763: Label 'Present Location';
        DcVisible: Boolean;
        UserGRec: Record "User Setup";
        DivisionGRec: Record "Employee Statistics Group";
        ItemDescrption: Code[50];
        ItemGRec: Record Item;
        Posting_Date: Date;
        "Old Card Serial No.": Code[20];
        "New Card Serial No.": Code[20];
        OLD: Boolean;
        Location1: Code[10];
        Item1: Code[20];
        OldStatus: Code[10];
        New: Boolean;
        NewStatus: Code[10];
        LocationDesc: Code[50];
        STVisible: Boolean;
}

