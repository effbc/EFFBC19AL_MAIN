page 60279 "Released Prod Orders Editable"
{
    ApplicationArea = Manufacturing;
    Caption = 'Released Prod Orders Editable';
    CardPageID = "Released Production Order";
    Editable = true;
    PageType = List;
    SourceTable = "Production Order";
    SourceTableView = WHERE(Status = CONST(Released));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(Filters)
            {
                Caption = '';

                field(ProdStartDat; ProdStartDat)
                {
                    Caption = 'Prod Start Date';
                    Visible = Visibl;

                    trigger OnValidate();
                    begin

                        /*IF NOT FilterChanged THEN
                          BEGIN
                            Variable1 := SumofUnits(xRec);
                          END
                        ELSE
                          BEGIN
                            //Rec.SETRANGE("Prod Start date","Prod Start date","Prod Start date");
                             Rec.SETRANGE("Prod Start date",GETRANGEMIN(Rec."Prod Start date"),GETRANGEMAX(Rec."Prod Start date"));
                            Variable1 := SumofUnits(xRec);
                          END;
                         CurrPage.UPDATE;
                         */

                    end;
                }
                field(SupToPlan; SupToPlan)
                {
                    Caption = 'Suppose To Plan';
                    Visible = Visibl;
                }
                field(PlnndDisptchDate; PlnndDisptchDate)
                {
                    Caption = 'Planned Dispatch Date';
                }
                field(FILTEREDUNITSSUMS; FILTEREDUNITSSUMS)
                {
                    Caption = 'Filtered Units';
                }
                field("Sum of Total units"; "Sum of Total units")
                {
                    Caption = 'Total Units';
                }
                field("Total Benchmarks"; "Total Benchmarks")
                {
                    Caption = 'Total Time';
                }
                field(FilteredPOs; FilteredPOs)
                {
                    Caption = 'Filtered Time';
                }


            }

            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; "No.")
                {
                    ApplicationArea = Manufacturing;
                    Lookup = false;
                    Style = StrongAccent;
                    StyleExpr = "No.Emphasize";
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Description)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the description of the production order.';
                    Style = Ambiguous;
                    StyleExpr = refreshbool;
                }
                field("Source No."; "Source No.")
                {
                    ApplicationArea = Manufacturing;
                    Style = Unfavorable;
                    StyleExpr = BackDateBool;
                    ToolTip = 'Specifies the number of the source document that the entry originates from.';
                }
                field("Routing No."; "Routing No.")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the routing number used for this production order.';
                    Visible = false;
                    Editable = false;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = Manufacturing;
                    Editable = false;
                    ToolTip = 'Specifies how many units of the item or the family to produce (production quantity).';
                }
                field("Benchmarks(in Min)"; "Benchmarks(in Min)")
                {
                    Caption = 'Benchmarks(in Hrs)';
                }
                field("<Total Benchmarks>"; "Total Time")
                {
                    Caption = 'Total Benchmarks';
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                    Editable = false;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = Location;
                    ToolTip = 'Specifies the location code to which you want to post the finished product from this production order.';
                    Visible = false;
                    Editable = false;
                }
                field("Starting Time"; StartingTime)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Starting Time';
                    ToolTip = 'Specifies the starting time of the production order.';
                    Visible = DateAndTimeFieldVisible;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Starting Date-Time field should be used instead.';
                    ObsoleteTag = '17.0';
                }
                field("Starting Date"; StartingDate)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Starting Date';
                    ToolTip = 'Specifies the starting date of the production order.';
                    Visible = DateAndTimeFieldVisible;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Starting Date-Time field should be used instead.';
                    ObsoleteTag = '17.0';
                }
                field("Ending Time"; EndingTime)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Ending Time';
                    ToolTip = 'Specifies the ending time of the production order.';
                    Visible = DateAndTimeFieldVisible;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Ending Date-Time field should be used instead.';
                    ObsoleteTag = '17.0';
                }
                field("Ending Date"; EndingDate)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Ending Date';
                    ToolTip = 'Specifies the ending date of the production order.';
                    Visible = DateAndTimeFieldVisible;
                    ObsoleteState = Pending;
                    ObsoleteReason = 'Ending Date-Time field should be used instead.';
                    ObsoleteTag = '17.0';
                }
                field("Starting Date-Time"; "Starting Date-Time")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the starting date and starting time of the production order.';
                }
                field("Ending Date-Time"; "Ending Date-Time")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the ending date and ending time of the production order.';
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the due date of the production order.';
                }
                field("Assigned User ID"; "Assigned User ID")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the ID of the user who is responsible for the document.';
                }
                field("Finished Date"; "Finished Date")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the actual finishing date of a finished production order.';
                    Visible = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the status of the production order.';
                    Editable = false;
                }

                field("Search Description"; "Search Description")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the search description.';
                }
                field("Sales Order No."; "Sales Order No.")
                {
                    Editable = false;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    Editable = false;
                }
                field("Sales Order Line No."; "Sales Order Line No.")
                {
                    Editable = false;
                }
                field("Schedule Line No."; "Schedule Line No.")
                {
                    Editable = false;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies when the production order card was last modified.';
                    Visible = false;
                }
                field("Bin Code"; "Bin Code")
                {
                    ApplicationArea = Warehouse;
                    ToolTip = 'Specifies a bin to which you want to post the finished items.';
                    Visible = false;
                }
                field("Prod Start date"; "Prod Start date")
                {
                    Editable = true;

                    trigger OnValidate();
                    begin
                        /*
                        MESSAGE('hi');
                        IF USERID IN ['EFFTRONICS\PADMAJA','EFFTRONICS\PRANAVI','EFFTRONICS\ANILKUMAR'] THEN
                        BEGIN
                        MESSAGE('hi');
                          IF Item.GET("Source No.") THEN
                            Item.TESTFIELD(Item."No.of Units");
                          IF "Prod Start date">=0D THEN
                          BEGIN

                           {
                            IF (Planned_Units("Prod Start date")>10) AND (Planned_Units("Prod Start date")<12) THEN
                              MESSAGE('YOU ARE EXCEEDING THE 10 UNITS PLAN ON '+FORMAT("Prod Start date"))
                            ELSE IF (Planned_Units("Prod Start date")>16) THEN
                              ERROR('YOU ARE EXCEEDING THE 16 UNITS PLAN ON '+FORMAT("Prod Start date"));
                           }
                            "Prod. Order Component".SETRANGE("Prod. Order Component"."Prod. Order No.","No.");
                            IF "Prod. Order Component".FINDSET THEN
                            BEGIN
                            REPEAT
                              "Prod. Order Component"."Production Plan Date":="Prod Start date";
                              "Prod. Order Component".MODIFY;
                            UNTIL "Prod. Order Component".NEXT=0;
                            END ELSE
                            ERROR('PLEASE REFRESH THE PRODUCTION ORDER PROPERLY');
                          END
                            //coded by anil
                          ELSE
                          BEGIN
                            "Prod. Order Component".SETRANGE("Prod. Order Component"."Prod. Order No.","No.");
                            IF "Prod. Order Component".FINDSET THEN
                            REPEAT
                              "Prod. Order Component"."Production Plan Date":="Prod Start date";
                              "Prod. Order Component".MODIFY;
                            UNTIL "Prod. Order Component".NEXT=0;
                          END;

                        END
                        ELSE
                          ERROR('You Dont have rights to perform this operation');
                        */
                    end;
                }


                field("Suppose to Plan"; "Suppose to Plan")
                {
                    Editable = false;
                }
                field("Planned Dispatch Date"; "Planned Dispatch Date")
                {
                    Editable = false;
                }
                field(Remarks; Remarks)
                {
                }
                field("Product Group Code"; "Product Group Code")
                {
                    Editable = false;
                }
                field("Item Sub Group Code"; "Item Sub Group Code")
                {
                    Editable = false;
                }
                field("Production Order Status"; "Production Order Status")
                {
                }
                field(Itm_card_No_of_Units; Itm_card_No_of_Units)
                {
                    Editable = false;
                }
                field(Itm_Card_ttl_units; Itm_Card_ttl_units)
                {
                    Editable = false;
                }
                field(Blocked; Blocked)
                {
                }
                field("Shortage Verified"; "Shortage Verified")
                {
                }

            }
            group(Test)
            {
                Editable = false;
                Caption = '';
                grid(Test2)
                {
                    Caption = '';
                    group(Test3)
                    {
                        Caption = '';
                        field(xRec_Count; xRec.Count)
                        {
                            Editable = false;
                            Caption = '';
                        }
                    }
                    group(Test4)
                    {
                        Caption = '';
                        field(Color_No_Issues; Color_No_Issues)
                        {
                            Editable = false;
                            Style = StrongAccent;
                            StyleExpr = TRUE;
                            Caption = '';
                        }
                    }
                    group(Test5)
                    {
                        Caption = '';
                        field(Color_Refresh; Color_Refresh)
                        {
                            Editable = false;
                            Style = Ambiguous;
                            StyleExpr = TRUE;
                            Caption = '';
                        }
                    }
                    group(Test6)
                    {
                        Caption = '';
                        field(Color_BachDate; Color_BachDate)
                        {
                            Editable = false;
                            Style = Unfavorable;
                            StyleExpr = TRUE;
                            Caption = '';
                        }
                    }
                }
            }

        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Pro&d. Order")
            {
                Caption = 'Pro&d. Order';
                Image = "Order";
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    Image = Entries;
                    action("Item Ledger E&ntries")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Item Ledger E&ntries';
                        Image = ItemLedger;
                        RunObject = Page "Item Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                        ShortCutKey = 'Ctrl+F7';
                        ToolTip = 'View the item ledger entries of the item on the document or journal line.';
                    }
                    action("Capacity Ledger Entries")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Capacity Ledger Entries';
                        Image = CapacityLedger;
                        RunObject = Page "Capacity Ledger Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                        ToolTip = 'View the capacity ledger entries of the involved production order. Capacity is recorded either as time (run time, stop time, or setup time) or as quantity (scrap quantity or output quantity).';
                    }
                    action("Value Entries")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Value Entries';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Order Type" = CONST(Production),
                                      "Order No." = FIELD("No.");
                        RunPageView = SORTING("Order Type", "Order No.");
                        ToolTip = 'View the value entries of the item on the document or journal line.';
                    }
                    action("&Warehouse Entries")
                    {
                        ApplicationArea = Warehouse;
                        Caption = '&Warehouse Entries';
                        Image = BinLedger;
                        RunObject = Page "Warehouse Entries";
                        RunPageLink = "Source Type" = FILTER(83 | 5407),
                                      "Source Subtype" = FILTER("3" | "4" | "5"),
                                      "Source No." = FIELD("No.");
                        RunPageView = SORTING("Source Type", "Source Subtype", "Source No.");
                        ToolTip = 'View the history of quantities that are registered for the item in warehouse activities. ';
                    }
                }
                action("Co&mments")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Prod. Order Comment Sheet";
                    RunPageLink = Status = FIELD(Status),
                                  "Prod. Order No." = FIELD("No.");
                    ToolTip = 'View or add comments for the record.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        ShowDocDim;
                    end;
                }
                action(Statistics)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Production Order Statistics";
                    RunPageLink = Status = FIELD(Status),
                                  "No." = FIELD("No."),
                                  "Date Filter" = FIELD("Date Filter");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Change &Status")
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Change &Status';
                    Ellipsis = true;
                    Image = ChangeStatus;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit "Prod. Order Status Management";
                    ToolTip = 'Change the production order to another status, such as Released.';
                }
                action("Move Production Start Date")
                {
                    Image = CalendarWorkcenter;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction();
                    begin
                        // REPORT.RUN(10720);
                    end;
                }
                action(SupposeToPLan)
                {
                    Caption = 'Suppose To PLan';
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        //Added by Pranavi ON 27-Nov-2015 for auto suppose to plan
                        PO.RESET;
                        PO.COPYFILTERS(Rec);
                        /*IF ProdStartDat <> '' THEN
                          PO.SETFILTER(PO."Prod Start date",ProdStartDat);*/
                        IF PO.FINDSET THEN
                            REPEAT
                                PMIH.RESET;
                                PMIH.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
                                PMIH.SETFILTER(PMIH."Prod. Order No.", PO."No.");
                                IF NOT PMIH.FINDFIRST THEN BEGIN
                                    IF PO."Prod Start date" <> 0D THEN BEGIN
                                        PO."Suppose to Plan" := SupToPlan;
                                        PO.VALIDATE("Suppose to Plan");
                                        PO.MODIFY;
                                    END
                                    ELSE
                                        ERROR('Please select Prod. start date for' + PO."No.");
                                END;
                            UNTIL PO.NEXT = 0;
                        //END by Pranavi ON 27-Nov-2015

                    end;
                }
                action(GiveProdStartDate)
                {
                    Caption = 'Asign Prod Start Date';
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        //Added by Pranavi ON 27-Nov-2015 for auto PROD. Start Date
                        IF ProdStartDat = 0D THEN
                            ERROR('Please enter Planned Dispatch Date!');
                        TEMPDATE := ProdStartDat;
                        PO.RESET;
                        PO.COPYFILTERS(Rec);
                        IF PO.FINDSET THEN
                            REPEAT
                                PMIH.RESET;
                                PMIH.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
                                PMIH.SETFILTER(PMIH."Prod. Order No.", PO."No.");
                                IF NOT PMIH.FINDFIRST THEN BEGIN
                                    PO."Prod Start date" := TEMPDATE;
                                    PO.VALIDATE("Prod Start date");
                                    PO.MODIFY;
                                END;
                            UNTIL PO.NEXT = 0;
                        //END by Pranavi ON 27-Nov-2015
                    end;
                }
                action(AsignPlnndDisptchDate)
                {
                    Caption = 'Asign Planned Dispatch Date';
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    begin
                        //Added by Pranavi ON 27-Nov-2015 for auto PROD. Start Date
                        IF PlnndDisptchDate = 0D THEN
                            ERROR('Please enter Planned Dispatch Date!');
                        PO.RESET;
                        PO.COPYFILTERS(Rec);
                        IF PO.FINDSET THEN
                            REPEAT
                                PMIH.RESET;
                                PMIH.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
                                PMIH.SETFILTER(PMIH."Prod. Order No.", PO."No.");
                                IF NOT PMIH.FINDFIRST THEN BEGIN
                                    PO."Planned Dispatch Date" := PlnndDisptchDate;
                                    PO.VALIDATE("Planned Dispatch Date");
                                    PO.MODIFY;
                                END;
                            UNTIL PO.NEXT = 0;
                        //END by Pranavi ON 27-Nov-2015
                    end;
                }
                action(FilterNoIssuesRPOs)
                {

                    trigger OnAction();
                    begin
                        RESET;
                        RPO.RESET;
                        RPO.SETRANGE(RPO.Status, RPO.Status::Released);
                        IF RPO.FINDSET THEN
                            REPEAT
                                PMIH.RESET;
                                PMIH.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
                                PMIH.SETFILTER(PMIH."Prod. Order No.", RPO."No.");
                                IF NOT PMIH.FINDFIRST THEN BEGIN
                                    SETRANGE("No.", RPO."No.");
                                    IF FINDFIRST THEN
                                        MARK(TRUE);
                                END;
                            UNTIL RPO.NEXT = 0;

                        SETRANGE("No.");
                        MARKEDONLY(TRUE);
                        CurrPage.UPDATE;
                    end;
                }
                action("&Update Unit Cost")
                {
                    ApplicationArea = Manufacturing;
                    Caption = '&Update Unit Cost';
                    Ellipsis = true;
                    Image = UpdateUnitCost;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Update the cost of the parent item per changes to the production BOM or routing.';

                    trigger OnAction()
                    var
                        ProdOrder: Record "Production Order";
                    begin
                        ProdOrder.SetRange(Status, Status);
                        ProdOrder.SetRange("No.", "No.");

                        REPORT.RunModal(REPORT::"Update Unit Cost", true, true, ProdOrder);
                    end;
                }
                action("Create Inventor&y Put-away/Pick/Movement")
                {
                    ApplicationArea = Warehouse;
                    Caption = 'Create Inventor&y Put-away/Pick/Movement';
                    Ellipsis = true;
                    Image = CreatePutAway;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Prepare to create inventory put-aways, picks, or movements for the parent item or components on the production order.';

                    trigger OnAction()
                    begin
                        CreateInvtPutAwayPick;
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Prod. Order - Detail Calc.")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Prod. Order - Detail Calc.';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Prod. Order - Detailed Calc.";
                ToolTip = 'View a list of the production orders. This list contains the expected costs and the quantity per production order or per operation of a production order.';
            }
            action("Prod. Order - Precalc. Time")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Prod. Order - Precalc. Time';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Prod. Order - Precalc. Time";
                ToolTip = 'View a list of information about capacity requirement, starting and ending time, etc. per operation, per production order, or per production order line.';
            }
            action("Production Order - Comp. and Routing")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Production Order - Comp. and Routing';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Prod. Order Comp. and Routing";
                ToolTip = 'View information about components and operations in production orders. For released production orders, the report shows the remaining quantity if parts of the quantity have been posted as output.';
            }
            action(ProdOrderJobCard)
            {
                ApplicationArea = Manufacturing;
                Caption = 'Production Order Job Card';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                ToolTip = 'View a list of the work in progress of a production order. Output, Scrapped Quantity and Production Lead Time are shown or printed depending on the operation.';

                trigger OnAction()
                begin
                    ManuPrintReport.PrintProductionOrder(Rec, 0);
                end;
            }
            action("Production Order - Picking List")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Production Order - Picking List';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Prod. Order - Picking List";
                ToolTip = 'View a detailed list of items that must be picked for a particular production order, from which location (and bin, if the location uses bins) they must be picked, and when the items are due for production.';
            }
            action(ProdOrderMaterialRequisition)
            {
                ApplicationArea = Manufacturing;
                Caption = 'Production Order - Material Requisition';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'View a list of material requirements per production order. The report shows you the status of the production order, the quantity of end items and components with the corresponding required quantity. You can view the due date and location code of each component.';

                trigger OnAction()
                begin
                    ManuPrintReport.PrintProductionOrder(Rec, 1);
                end;
            }
            action("Production Order List")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Production Order List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Prod. Order - List";
                ToolTip = 'View a list of the production orders contained in the system. Information such as order number, number of the item to be produced, starting/ending date and other data are shown or printed.';
            }
            action(ProdOrderShortageList)
            {
                ApplicationArea = Manufacturing;
                Caption = 'Production Order - Shortage List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'View a list of the missing quantity per production order. You are shown how the inventory development is planned from today until the set day - for example whether orders are still open.';

                trigger OnAction()
                begin
                    ManuPrintReport.PrintProductionOrder(Rec, 2);
                end;
            }
            action("Production Order Statistics")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Production Order Statistics';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Production Order Statistics";
                ToolTip = 'View statistical information about the production order''s direct material and capacity costs and overhead as well as its capacity need in the time unit of measure.';
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        GetStartingEndingDateAndTime(StartingTime, StartingDate, EndingTime, EndingDate);
        NoC2OnFormat;

        // added by vishnu on 06-05-2019
        //"Sum of Total units" += Itm_Card_ttl_units;

        /*CALCSUMS(Itm_Card_ttl_units);
        "Sum of Total units" := Itm_Card_ttl_units;*/

        RPO.RESET;
        RPO.COPYFILTERS(Rec);
        RPO.CALCSUMS(Itm_Card_ttl_units);
        RPO.CALCSUMS("Total Time");
        FILTEREDUNITSSUMS := 0;
        FILTEREDUNITSSUMS += RPO.Itm_Card_ttl_units;
        FilteredPOs := 0;
        FilteredPOs += RPO."Total Time";



        /*
        Day := 0;
        Month := 0;
        Year := 0;
        IF (NOT FilterChanged)   THEN  // when no filters  applied
          BEGIN
            Variable1 := SumofUnits(xRec);
          END
          ELSE IF GETFILTER("Prod Start date" )=''  THEN  // when prod start date is blank
           BEGIN
            Variable1 := SumofUnits(xRec);
          END
          ELSE IF (COPYSTR(GETFILTER("Prod Start date"),1,1) = '>' ) AND (COPYSTR(GETFILTER("Prod Start date"),2,1) = '=' ) THEN  // when the filter is like  >=
            BEGIN
              EVALUATE(Day,COPYSTR(GETFILTER("Prod Start date"),3,2));
              EVALUATE(Month,COPYSTR(GETFILTER("Prod Start date"),6,2));
              EVALUATE(Year,COPYSTR(GETFILTER("Prod Start date"),9,2));
              Year := Year + 2000;
              Datetypevariable1 := DMY2DATE(Day,Month,Year);
              Rec.SETFILTER("Prod Start date",'>=%1',Datetypevariable1);
              Variable1 := SumofUnits(xRec);
            END
            ELSE IF (COPYSTR(GETFILTER("Prod Start date"),1,1) = '>' ) AND (COPYSTR(GETFILTER("Prod Start date"),2,1) <> '=' ) THEN  // when the filter is like  >
            BEGIN
              EVALUATE(Day,COPYSTR(GETFILTER("Prod Start date"),2,2));
              EVALUATE(Month,COPYSTR(GETFILTER("Prod Start date"),5,2));
              EVALUATE(Year,COPYSTR(GETFILTER("Prod Start date"),8,2));
              Year := Year + 2000;
              Datetypevariable1 := DMY2DATE(Day,Month,Year);
              Rec.SETFILTER("Prod Start date",'>%1',Datetypevariable1);
              Variable1 := SumofUnits(xRec);
            END
            ELSE IF (COPYSTR(GETFILTER("Prod Start date"),1,1) = '<' ) AND (COPYSTR(GETFILTER("Prod Start date"),2,1) = '=' ) THEN  // when the filter is like  <=
            BEGIN
              EVALUATE(Day,COPYSTR(GETFILTER("Prod Start date"),3,2));
              EVALUATE(Month,COPYSTR(GETFILTER("Prod Start date"),6,2));
              EVALUATE(Year,COPYSTR(GETFILTER("Prod Start date"),9,2));
              Year := Year + 2000;
              Datetypevariable1 := DMY2DATE(Day,Month,Year);
              Rec.SETFILTER("Prod Start date",'<=%1',Datetypevariable1);
              Variable1 := SumofUnits(xRec);
            END
            ELSE IF (COPYSTR(GETFILTER("Prod Start date"),1,1) = '<' ) AND (COPYSTR(GETFILTER("Prod Start date"),2,1) <> '=' ) THEN  // when the filter is like  <
            BEGIN
              EVALUATE(Day,COPYSTR(GETFILTER("Prod Start date"),2,2));
              EVALUATE(Month,COPYSTR(GETFILTER("Prod Start date"),5,2));
              EVALUATE(Year,COPYSTR(GETFILTER("Prod Start date"),8,2));
              Year := Year + 2000;
              Datetypevariable1 := DMY2DATE(Day,Month,Year);
              Rec.SETFILTER("Prod Start date",'<%1',Datetypevariable1);
              Variable1 := SumofUnits(xRec);
            END
            ELSE IF (COPYSTR(GETFILTER("Prod Start date"),9,2) = '..' ) THEN
              BEGIN
                Rec.SETRANGE("Prod Start date",GETRANGEMIN(Rec."Prod Start date"),GETRANGEMAX(Rec."Prod Start date")); // when the filter is like  between
                Variable1 := SumofUnits(xRec);
              END
            ELSE
            BEGIN
              Rec.SETFILTER("Prod Start date",'%1',Rec."Prod Start date");
              Variable1 := SumofUnits(xRec);
            END;
          // end by vishnu on 06-05-2019



        */

    end;

    trigger OnInit()
    begin
        DateAndTimeFieldVisible := false;
    end;

    trigger OnOpenPage()
    begin
        DateAndTimeFieldVisible := false;
        "Sum of Total units" := 0;  // Nav 2016 Oninit trigger code moved to onopen page
        "Total Benchmarks" := 0;// Nav 2016 Oninit trigger code moved to onopen page
                                //CurrPage.EDITABLE := FALSE;
        IF CurrPage.EDITABLE = TRUE THEN
            Visibl := TRUE
        ELSE
            Visibl := FALSE;

        Visibl := true;//EFFUG1.6


        // added by vishnu on 06-05-2019
        /*Variable1 := SumofUnits(xRec);
        IF NOT FilterChanged THEN
          BEGIN
            Variable1 := SumofUnits(xRec);
          END
        ELSE
          BEGIN
            Rec.SETRANGE("Prod Start date","Prod Start date","Prod Start date");
            Variable1 := SumofUnits(xRec);
          END;
        */
        // end by vishnu on 06-05-2019

        //Added by Vishnu Priya
        RPO1.RESET;
        RPO1.SETCURRENTKEY("Prod Start date");
        RPO1.SETFILTER("Prod Start date", '>=%1', TODAY);
        RPO1.SETFILTER(Itm_card_No_of_Units, '%1', 0);
        RPO1.SETFILTER("Benchmarks(in Min)", '%1', 0);
        IF RPO1.FINDSET THEN
            REPEAT
            BEGIN
                ItmTable.RESET;
                ItmTable.SETFILTER("No.", RPO1."Source No.");
                IF ItmTable.FINDFIRST THEN BEGIN
                    RPO1.Itm_card_No_of_Units := ItmTable."No.of Units";
                    RPO1.Itm_Card_ttl_units := ItmTable."No.of Units" * RPO1.Quantity;
                    RPO1."Benchmarks(in Min)" := ItmTable."Benchmarks(in Min)";
                    RPO1."Total Time" := ItmTable."Benchmarks(in Min)" * RPO1.Quantity;
                    RPO1.MODIFY;
                    MESSAGE(ItmTable.Description);
                END
            END
            UNTIL RPO1.NEXT = 0;

        //Added by Vishnu Priya




        RPO.RESET;
        RPO.COPYFILTERS(Rec);
        RPO.CALCSUMS(Itm_Card_ttl_units);
        RPO.CALCSUMS("Total Time");
        "Sum of Total units" += RPO.Itm_Card_ttl_units;
        "Total Benchmarks" += RPO."Total Time";
        /*Item1.RESET;
        Item1.SETFILTER("No.","Source No.");
        IF Item1.FINDFIRST THEN
          Rec."Benchmarks(in Min)" := Item1."Benchmarks(in Min)";
          Rec.MODIFY;*/

    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        // added by Vishnu Priya on 
        IF SearchinPostedMaterial("No.") THEN
            ERROR('You Can not delete this RPO Because, Material Requests are alredy existed on thsi RPO');

    end;

    local procedure NoC2OnFormat();
    begin
        // Added by Anil on 21-Feb-15
        refreshbool := FALSE;
        BackDateBool := FALSE;
        PMIH.RESET;
        PMIH.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
        PMIH.SETFILTER(PMIH."Prod. Order No.", "No.");
        IF NOT PMIH.FINDFIRST THEN BEGIN
            "No.Emphasize" := TRUE;
            IF Refreshdate = 0D THEN
                refreshbool := TRUE
            ELSE
                refreshbool := FALSE;
            IF ("Prod Start date" < TODAY()) AND ("Prod Start date" <> 0D) THEN
                BackDateBool := TRUE
            ELSE
                BackDateBool := FALSE;
        END
        ELSE
            "No.Emphasize" := FALSE;
        // end

        /*
        BEGIN
           "No.Emphasize" :=TRUE;
        END ELSE
           "No.Emphasize" := FALSE;
        anil */

    end;

    local procedure SumofUnits("RPOS Page": Record 5405) Units: Decimal;
    var
        Units_per: Decimal;
        "Ttl Units": Decimal;
        "Sum of Units": Decimal;
        "Production Order1": Record 5405;
    begin
        Units := 0;
        "RPOS Page".RESET;
        "RPOS Page".SETCURRENTKEY(Status, "Prod Start date", "No.");
        "RPOS Page".SETFILTER(Status, FORMAT(3));
        "RPOS Page".COPYFILTERS(Rec);
        IF "RPOS Page".FINDSET THEN BEGIN
            "RPOS Page".CALCSUMS(Itm_Card_ttl_units);
            Units := Itm_Card_ttl_units;
        END;
        /*
        //
        //Units+= Total_Units;

        REPEAT

          Units := Itm_Card_ttl_units + Units;
          {Item.RESET;
          Item.SETFILTER("No.","RPOS Page"."Source No.");
          IF Item.FINDFIRST THEN
          BEGIN
             Units_per := Item."No.of Units";
             "Ttl Units" := "RPOS Page".Quantity * Units_per;
             Units := Units + "Ttl Units"; }
          END
        UNTIL "RPOS Page".NEXT = 0;
      END;*/
        //

    end;

    procedure FilterChanged(): Boolean;
    begin
        IF LastRecFilter <> GETFILTERS THEN BEGIN
            LastRecFilter := GETFILTERS;
            EXIT(TRUE);
        END ELSE
            EXIT(FALSE);
    end;

    local procedure SearchinPostedMaterial(RPO: Text) exis: Boolean;
    var
        MIH: Record 50001;
        PMIH: Record 50003;
    begin
        MIH.RESET;
        MIH.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
        MIH.SETFILTER("Prod. Order No.", RPO);
        IF MIH.FINDFIRST THEN
            exis := TRUE
        ELSE BEGIN
            PMIH.RESET;
            PMIH.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
            PMIH.SETFILTER("Prod. Order No.", RPO);
            IF PMIH.FINDFIRST THEN
                exis := TRUE
            ELSE
                exis := FALSE;
        END;
    end;





    var
        ManuPrintReport: Codeunit "Manu. Print Report";
        StartingTime: Time;
        EndingTime: Time;
        StartingDate: Date;
        EndingDate: Date;
        DateAndTimeFieldVisible: Boolean;
        "No.Emphasize": Boolean;
        PMIH: Record 50003;
        Form_Editable: Boolean;
        Item: Record 27;
        "Prod. Order Component": Record 5407;
        Color_No_Issues: Label 'No Material Issues';
        Color_OutPut: Label 'Output Posted';
        Color_Refresh: Label 'Not Refreshed';
        refreshcount: Integer;
        refreshbool: Boolean;
        TEMPDATE: Date;
        ProdStartDat: Date;
        SupToPlan: Boolean;
        PO: Record 5405;
        Visibl: Boolean;
        BackDateBool: Boolean;
        Color_BachDate: Label 'Prod Start Date < Today';
        PlnndDisptchDate: Date;
        RPO: Record 5405;
        No_of_Units: Decimal;
        Total_Units: Decimal;
        LastRecFilter: Text;
        Variable1: Decimal;
        "Sum of Total units": Decimal;
        Variable2: Decimal;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        Datetypevariable1: Date;
        FILTEREDUNITSSUMS: Decimal;
        RPO1: Record 5405;
        ItmTable: Record 27;
        Item1: Record 27;
        "Total Benchmarks": Decimal;
        FilteredPOs: Decimal;





}

