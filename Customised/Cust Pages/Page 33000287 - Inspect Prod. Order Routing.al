page 33000287 "Inspect Prod. Order Routing"
{
    // version WIP1.0

    Caption = 'Prod. Order Routing';
    DataCaptionExpression = Rec.Caption;
    PageType = ListPart;
    SourceTable = "Ins Prod. Order Routing Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Schedule Manually"; Rec."Schedule Manually")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = All;
                }
                field("Previous Operation No."; Rec."Previous Operation No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Next Operation No."; Rec."Next Operation No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Starting Date-Time"; Rec."Starting Date-Time")
                {
                    ApplicationArea = All;
                }
                field("Starting Time"; Rec."Starting Time")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        StartingTimeOnAfterValidate;
                    end;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        StartingDateOnAfterValidate;
                    end;
                }
                field("Ending Date-Time"; Rec."Ending Date-Time")
                {
                    ApplicationArea = All;
                }
                field("Ending Time"; Rec."Ending Time")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        EndingTimeOnAfterValidate;
                    end;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        EndingDateOnAfterValidate;
                    end;
                }
                field("Setup Time"; Rec."Setup Time")
                {
                    ApplicationArea = All;
                }
                field("Run Time"; Rec."Run Time")
                {
                    ApplicationArea = All;
                }
                field("Wait Time"; Rec."Wait Time")
                {
                    ApplicationArea = All;
                }
                field("Move Time"; Rec."Move Time")
                {
                    ApplicationArea = All;
                }
                field("Fixed Scrap Quantity"; Rec."Fixed Scrap Quantity")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Scrap Factor %"; Rec."Scrap Factor %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Send-Ahead Quantity"; Rec."Send-Ahead Quantity")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Concurrent Capacities"; Rec."Concurrent Capacities")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Cost per"; Rec."Unit Cost per")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Expected Operation Cost Amt."; Rec."Expected Operation Cost Amt.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Expected Capacity Ovhd. Cost"; Rec."Expected Capacity Ovhd. Cost")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Expected Capacity Need"; Rec."Expected Capacity Need")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Routing Status"; Rec."Routing Status")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }


    local procedure StartingTimeOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;


    local procedure StartingDateOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;


    local procedure EndingTimeOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;


    local procedure EndingDateOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;
}

