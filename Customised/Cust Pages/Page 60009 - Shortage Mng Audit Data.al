page 60009 "Shortage Mng Audit Data"
{
    // version Rev01

    PageType = Worksheet;
    SourceTable = "Shortage Management Audit Data";

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field(Control1102154004; '')
                {
                    CaptionClass = Text19071437;
                    ShowCaption = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("Total Plan"; "Total Plan")
                {
                    ApplicationArea = All;
                }
                field(No_Of_Week; No_Of_Week)
                {
                    Caption = 'No. Of Week';
                    ApplicationArea = All;
                }
                field(Choice; Choice)
                {
                    Caption = 'Week Period';
                    OptionCaption = 'Purchase,Shortage';
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Choice = Choice::Shortage THEN
                            ShortageChoiceOnValidate;
                        IF Choice = Choice::Purchase THEN
                            PurchaseChoiceOnValidate;
                    end;
                }
                field(Control1102154010; '')
                {
                    CaptionClass = Text19047480;
                    ShowCaption = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Week_Period; Week_Period)
                {
                    ApplicationArea = All;
                }
                field(Control1102154092; '')
                {
                    CaptionClass = Text19013679;
                    ShowCaption = false;
                    ApplicationArea = All;
                }
                field(Control1102154093; '')
                {
                    CaptionClass = Text19056018;
                    ShowCaption = false;
                    ApplicationArea = All;
                }
                field(Control1102154011; '')
                {
                    CaptionClass = Text19047485;
                    ShowCaption = false;
                    Style = Standard;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Control1102154017; '')
                {
                    CaptionClass = Text19056231;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field("WeekPlan[1]"; WeekPlan[1])
                {
                    ApplicationArea = All;
                }
                field("WeekPlan[2]"; WeekPlan[2])
                {
                    ApplicationArea = All;
                }
                field("WeekPlan[3]"; WeekPlan[3])
                {
                    ApplicationArea = All;
                }
                field("WeekPlan[4]"; WeekPlan[4])
                {
                    ApplicationArea = All;
                }
                field("Week_Purchase_Value[1]"; Week_Purchase_Value[1])
                {
                    ApplicationArea = All;
                }
                field("Week_Purchase_Value[2]"; Week_Purchase_Value[2])
                {
                    ApplicationArea = All;
                }
                field("Week_Purchase_Value[3]"; Week_Purchase_Value[3])
                {
                    ApplicationArea = All;
                }
                field("Customer Type"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                }
                field("WeekPlan[5]"; WeekPlan[5])
                {
                    ApplicationArea = All;
                }
                field("WeekPlan[6]"; WeekPlan[6])
                {
                    ApplicationArea = All;
                }
                field("WeekPlan[7]"; WeekPlan[7])
                {
                    ApplicationArea = All;
                }
                field("Week_Purchase_Value[4]"; Week_Purchase_Value[4])
                {
                    ApplicationArea = All;
                }
                field("WeekPlan[8]"; WeekPlan[8])
                {
                    ApplicationArea = All;
                }
                field("Week_Purchase_Value[5]"; Week_Purchase_Value[5])
                {
                    ApplicationArea = All;
                }
                field("WeekPlan[9]"; WeekPlan[9])
                {
                    ApplicationArea = All;
                }
                field("Week_Purchase_Value[6]"; Week_Purchase_Value[6])
                {
                    ApplicationArea = All;
                }
                field("WeekPlan[10]"; WeekPlan[10])
                {
                    ApplicationArea = All;
                }
                field("Week_Purchase_Value[7]"; Week_Purchase_Value[7])
                {
                    ApplicationArea = All;
                }
                field("Week_Purchase_Value[8]"; Week_Purchase_Value[8])
                {
                    ApplicationArea = All;
                }
                field("Week_Purchase_Value[9]"; Week_Purchase_Value[9])
                {
                    ApplicationArea = All;
                }
                field("Week_Purchase_Value[10]"; Week_Purchase_Value[10])
                {
                    ApplicationArea = All;
                }
            }
            repeater(Control1102154000)
            {
                ShowCaption = false;
                field(Week; Rec.Week)
                {
                    ApplicationArea = All;
                }
                field("Sale Order"; Rec."Sale Order")
                {
                    ApplicationArea = All;
                }
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = All;
                }
                field(Prod; Rec.Prod)
                {
                    ApplicationArea = All;
                }
                field(Config; Rec.Config)
                {
                    ApplicationArea = All;
                }
                field(Qty; Rec.Qty)
                {
                    ApplicationArea = All;
                }
                field("Prod Start Date"; Rec."Prod Start Date")
                {
                    ApplicationArea = All;
                }
                field("Prod Final Date"; Rec."Prod Final Date")
                {
                    ApplicationArea = All;
                }
                field("Production Plan"; Rec."Production Plan")
                {
                    ApplicationArea = All;
                }
                field("No. Of Units"; Rec."No. Of Units")
                {
                    ApplicationArea = All;
                }
                field("<Customer Type2>"; Rec."Customer Type")
                {
                    ApplicationArea = All;
                }
                field("Order Type"; Rec."Order Type")
                {
                    ApplicationArea = All;
                }
                field("2 Days_S"; Rec."2 Days_S")
                {
                    Visible = "2 Days_SVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;

                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                       Shortage_Details.Product,
                                                       Shortage_Details.Authorisation,
                                                       Shortage_Details."Lead Time2",
                                                       Shortage_Details."Item No",
                                                       Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '2D');

                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("2 Days"; Rec."2 Days")
                {
                    Visible = "2 DaysVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                                   Shortage_Details.Authorisation::Authorised,
                                                                                   Shortage_Details.Authorisation::indent);

                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '2D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("4 Days_S"; Rec."4 Days_S")
                {
                    Visible = "4 Days_SVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");
                        MESSAGE('hi');
                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");

                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '4D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        MESSAGE(FORMAT(Shortage_Details.COUNT));
                        PAGE.RUN(5140);
                    end;
                }
                field("4 Days"; Rec."4 Days")
                {
                    Visible = "4 DaysVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                                   Shortage_Details.Authorisation::Authorised,
                                                                                   Shortage_Details.Authorisation::indent);

                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '4D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("7 Days_S"; Rec."7 Days_S")
                {
                    Visible = "7 Days_SVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");
                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");

                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '7D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("7 Days"; Rec."7 Days")
                {
                    Visible = "7 DaysVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                       Shortage_Details.Product,
                                                       Shortage_Details.Authorisation,
                                                       Shortage_Details."Lead Time2",
                                                       Shortage_Details."Item No",
                                                       Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                                   Shortage_Details.Authorisation::Authorised,
                                                                                   Shortage_Details.Authorisation::indent);

                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '7D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("15 Dyas_S"; Rec."15 Dyas_S")
                {
                    Visible = "15 Dyas_SVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");

                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '15D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("15 Dyas"; Rec."15 Dyas")
                {
                    Visible = "15 DyasVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                                   Shortage_Details.Authorisation::Authorised,
                                                                                   Shortage_Details.Authorisation::indent);

                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '15D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("21 Days_S"; Rec."21 Days_S")
                {
                    Visible = "21 Days_SVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                        Shortage_Details.Product,
                                                        Shortage_Details.Authorisation,
                                                        Shortage_Details."Lead Time2",
                                                        Shortage_Details."Item No",
                                                        Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");

                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '21D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("21 Days"; Rec."21 Days")
                {
                    Visible = "21 DaysVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                        Shortage_Details.Product,
                                                        Shortage_Details.Authorisation,
                                                        Shortage_Details."Lead Time2",
                                                        Shortage_Details."Item No",
                                                        Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '21D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;

                    trigger OnValidate();
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
                        Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                                   Shortage_Details.Authorisation::Authorised,
                                                                                   Shortage_Details.Authorisation::indent);

                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '21D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("25 Dyas_S"; Rec."25 Dyas_S")
                {
                    Visible = "25 Dyas_SVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '25D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("25 Dyas"; Rec."25 Dyas")
                {
                    Visible = "25 DyasVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                                   Shortage_Details.Authorisation::Authorised,
                                                                                   Shortage_Details.Authorisation::indent);

                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '25D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;

                    trigger OnValidate();
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
                        Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                                   Shortage_Details.Authorisation::Authorised,
                                                                                   Shortage_Details.Authorisation::indent);

                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '25D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("30 Dyas_S"; Rec."30 Dyas_S")
                {
                    Visible = "30 Dyas_SVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '30D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("30 Dyas"; Rec."30 Dyas")
                {
                    Visible = "30 DyasVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                                   Shortage_Details.Authorisation::Authorised,
                                                                                   Shortage_Details.Authorisation::indent);

                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '30D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("45 Days_S"; Rec."45 Days_S")
                {
                    Visible = "45 Days_SVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '45D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("45 Days"; Rec."45 Days")
                {
                    Visible = "45 DaysVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                                   Shortage_Details.Authorisation::Authorised,
                                                                                   Shortage_Details.Authorisation::indent);

                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '45D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("60 Days_S"; Rec."60 Days_S")
                {
                    Visible = "60 Days_SVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '60D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("60 Days"; Rec."60 Days")
                {
                    Visible = "60 DaysVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                                   Shortage_Details.Authorisation::Authorised,
                                                                                   Shortage_Details.Authorisation::indent);

                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '60D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("90 Days_S"; Rec."90 Days_S")
                {
                    Visible = "90 Days_SVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '90D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
                field("90 Days"; Rec."90 Days")
                {
                    Visible = "90 DaysVisible";
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        Shortage_Details.RESET;
                        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                      Shortage_Details.Product,
                                                      Shortage_Details.Authorisation,
                                                      Shortage_Details."Lead Time2",
                                                      Shortage_Details."Item No",
                                                      Shortage_Details."Planned Date");

                        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
                        Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
                        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Rec."Prod Start Date", Rec."Prod Final Date");
                        Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                                   Shortage_Details.Authorisation::Authorised,
                                                                                   Shortage_Details.Authorisation::indent);

                        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '90D');
                        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
                        PAGE.RUN(5140);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("10")
            {
                Caption = '10';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    No_Of_Week := 8;
                    Rec.SETRANGE(Week, No_Of_Week);
                end;
            }
            action("9")
            {
                Caption = '9';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    No_Of_Week := 8;
                    Rec.SETRANGE(Week, No_Of_Week);
                end;
            }
            action("8")
            {
                Caption = '8';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    No_Of_Week := 8;
                    Rec.SETRANGE(Week, No_Of_Week);
                end;
            }
            action("7")
            {
                Caption = '7';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    No_Of_Week := 7;
                    Rec.SETRANGE(Week, No_Of_Week);
                end;
            }
            action("6")
            {
                Caption = '6';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    No_Of_Week := 6;
                    Rec.SETRANGE(Week, No_Of_Week);
                end;
            }
            action("5")
            {
                Caption = '5';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    No_Of_Week := 5;
                    Rec.SETRANGE(Week, No_Of_Week);
                end;
            }
            action("4")
            {
                Caption = '4';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    No_Of_Week := 4;
                    Rec.SETRANGE(Week, No_Of_Week);
                end;
            }
            action("3")
            {
                Caption = '3';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    No_Of_Week := 3;
                    Rec.SETRANGE(Week, No_Of_Week);
                end;
            }
            action("2")
            {
                Caption = '2';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    No_Of_Week := 2;
                    Rec.SETRANGE(Week, No_Of_Week);
                end;
            }
            action("1")
            {
                Caption = '1';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    No_Of_Week := 1;
                    Rec.SETRANGE(Week, No_Of_Week);
                end;
            }
            action("Next Period")
            {
                Caption = 'Next Period';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Next Period';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    No_Of_Week += 1;
                    Rec.SETRANGE(Week, No_Of_Week);
                end;
            }
            action("Previous Period")
            {
                Caption = 'Previous Period';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Previous Period';
                ApplicationArea = All;

                trigger OnAction();
                begin

                    No_Of_Week -= 1;
                    IF No_Of_Week < 0 THEN
                        MESSAGE('Please Select the Correct Week');
                    Rec.SETRANGE(Week, No_Of_Week);
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        "G\L".GET;
        Dum_Sale_Order := 'EFF/SAL/' + Rec."Sale Order";
        //  Prd:=
        "Production Order".RESET;
        "Production Order".SETCURRENTKEY("Production Order".Week, "Production Order"."Sales Order No.", "Production Order"."Source No.");
        "Production Order".SETRANGE("Production Order".Week, Rec.Week);
        "Production Order".SETFILTER("Production Order"."Prod Start date", '>%1', ("G\L"."Shortage. Calc. Date"));
        "Production Order".SETRANGE("Production Order"."Sales Order No.", Rec.Sale_Order);
        "Production Order".SETRANGE("Production Order"."Source No.", Rec.Product);
        IF "Production Order".FINDFIRST THEN BEGIN
            Start_Date := "Production Order"."Prod Start date";
            Rec."Prod Start Date" := "Production Order"."Prod Start date";
        END;
        "Production Order".RESET;
        "Production Order".SETCURRENTKEY("Production Order".Week, "Production Order"."Sales Order No.", "Production Order"."Source No.");
        "Production Order".SETRANGE("Production Order".Week, Rec.Week);
        "Production Order".SETFILTER("Production Order"."Prod Start date", '>%1', ("G\L"."Shortage. Calc. Date"));
        "Production Order".SETRANGE("Production Order"."Sales Order No.", Rec.Sale_Order);
        "Production Order".SETRANGE("Production Order"."Source No.", Rec.Product);
        IF "Production Order".FINDLAST THEN BEGIN
            Final_Date := "Production Order"."Prod Start date";
            Rec."Prod Final Date" := "Production Order"."Prod Start date";
        END;
        IF Start_Date = Final_Date THEN
            "Date Filter" := Indian_Date(Start_Date)
        ELSE
            "Date Filter" := Indian_Date(Start_Date) + '..' + Indian_Date(Final_Date);
        Rec."Production Plan" := "Date Filter";
        Color := '';
        "G\L".GET;
        Time_Gap := Start_Date - ("G\L"."Shortage. Calc. Date" + 2);
        No_Of_Week := Rec.Week;
        Week_Start_Date := ("G\L"."Shortage. Calc. Date" + 1 + (Rec.Week * 7));
        Week_Final_Date := ("G\L"."Shortage. Calc. Date" + 8 + (Rec.Week * 7));
        Week_Period := Indian_Date(Week_Start_Date) + ' to ' + Indian_Date(Week_Final_Date);


        IF Choice = Choice::Purchase THEN BEGIN
            Shortage_Details.RESET;
            Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                           Shortage_Details.Product,
                                           Shortage_Details.Authorisation,
                                           Shortage_Details."Lead Time2",
                                           Shortage_Details."Item No",
                                           Shortage_Details."Planned Date");
            Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
            Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
            Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
            Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                       Shortage_Details.Authorisation::Authorised,
                                                                       Shortage_Details.Authorisation::indent);

            Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '2D');
            Shortage_Details.CALCSUMS(Shortage_Details.Total);
            IF Shortage_Details.Total > 0 THEN
                Rec."2 Days" := FORMAT(ROUND(Shortage_Details.Total, 1));

            IF Rec."2 Days" <> '' THEN BEGIN
                IF Time_Gap < 2 THEN
                    Color := 'RED'
                ELSE
                    IF Time_Gap < 9 THEN
                        Color := 'YELLOW';
            END;

            Shortage_Details.RESET;
            Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                           Shortage_Details.Product,
                                           Shortage_Details.Authorisation,
                                           Shortage_Details."Lead Time2",
                                           Shortage_Details."Item No",
                                           Shortage_Details."Planned Date");

            Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
            Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
            Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
            Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                      Shortage_Details.Authorisation::Authorised,
                                                                      Shortage_Details.Authorisation::indent);

            Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '4D');
            Shortage_Details.CALCSUMS(Shortage_Details.Total);
            IF Shortage_Details.Total > 0 THEN
                Rec."4 Days" := FORMAT(ROUND(Shortage_Details.Total));

            IF Rec."4 Days" <> '' THEN BEGIN
                IF Time_Gap < 4 THEN
                    Color := 'RED'
                ELSE
                    IF Time_Gap < 11 THEN
                        Color := 'YELLOW';
            END;


            Shortage_Details.RESET;
            Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                           Shortage_Details.Product,
                                           Shortage_Details.Authorisation,
                                           Shortage_Details."Lead Time2",
                                           Shortage_Details."Item No",
                                           Shortage_Details."Planned Date");

            Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
            Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
            Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
            Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                      Shortage_Details.Authorisation::Authorised,
                                                                      Shortage_Details.Authorisation::indent);
            Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '7D');
            Shortage_Details.CALCSUMS(Shortage_Details.Total);
            IF Shortage_Details.Total > 0 THEN
                Rec."7 Days" := FORMAT(ROUND(Shortage_Details.Total));

            IF Rec."7 Days" <> '' THEN BEGIN
                IF Time_Gap < 7 THEN
                    Color := 'RED'
                ELSE
                    IF Time_Gap < 14 THEN
                        Color := 'YELLOW';
            END;

            Shortage_Details.RESET;
            Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                           Shortage_Details.Product,
                                           Shortage_Details.Authorisation,
                                           Shortage_Details."Lead Time2",
                                           Shortage_Details."Item No",
                                           Shortage_Details."Planned Date");

            Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
            Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
            Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
            Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                       Shortage_Details.Authorisation::Authorised,
                                                                       Shortage_Details.Authorisation::indent);
            Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '15D');
            Shortage_Details.CALCSUMS(Shortage_Details.Total);
            IF Shortage_Details.Total > 0 THEN
                Rec."15 Dyas" := FORMAT(ROUND(Shortage_Details.Total));

            IF Rec."15 Dyas" <> '' THEN BEGIN
                IF Time_Gap < 15 THEN
                    Color := 'RED'
                ELSE
                    IF Time_Gap < 22 THEN
                        Color := 'YELLOW';
            END;


            Shortage_Details.RESET;
            Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                           Shortage_Details.Product,
                                           Shortage_Details.Authorisation,
                                           Shortage_Details."Lead Time2",
                                           Shortage_Details."Item No",
                                           Shortage_Details."Planned Date");

            Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
            Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
            Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
            Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                       Shortage_Details.Authorisation::Authorised,
                                                                       Shortage_Details.Authorisation::indent);
            Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '21D');
            Shortage_Details.CALCSUMS(Shortage_Details.Total);
            IF Shortage_Details.Total > 0 THEN
                Rec."21 Days" := FORMAT(ROUND(Shortage_Details.Total));
            IF Rec."21 Days" <> '' THEN BEGIN
                IF Time_Gap < 21 THEN
                    Color := 'RED'
                ELSE
                    IF Time_Gap < 28 THEN
                        Color := 'YELLOW';
            END;


            Shortage_Details.RESET;
            Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                           Shortage_Details.Product,
                                           Shortage_Details.Authorisation,
                                           Shortage_Details."Lead Time2",
                                           Shortage_Details."Item No",
                                           Shortage_Details."Planned Date");

            Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
            Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
            Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
            Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                       Shortage_Details.Authorisation::Authorised,
                                                                       Shortage_Details.Authorisation::indent);
            Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '25D');
            Shortage_Details.CALCSUMS(Shortage_Details.Total);
            IF Shortage_Details.Total > 0 THEN
                Rec."25 Dyas" := FORMAT(ROUND(Shortage_Details.Total));

            IF Rec."25 Dyas" <> '' THEN BEGIN
                IF Time_Gap < 25 THEN
                    Color := 'RED'
                ELSE
                    IF Time_Gap < 32 THEN
                        Color := 'YELLOW';
            END;


            Shortage_Details.RESET;
            Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                           Shortage_Details.Product,
                                           Shortage_Details.Authorisation,
                                           Shortage_Details."Lead Time2",
                                           Shortage_Details."Item No",
                                           Shortage_Details."Planned Date");

            Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
            Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
            Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
            Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA,
                                                                       Shortage_Details.Authorisation::Authorised,
                                                                       Shortage_Details.Authorisation::indent);
            Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '30D');
            Shortage_Details.CALCSUMS(Shortage_Details.Total);
            IF Shortage_Details.Total > 0 THEN
                Rec."30 Dyas" := FORMAT(ROUND(Shortage_Details.Total));
            IF Rec."30 Dyas" <> '' THEN BEGIN
                IF Time_Gap < 30 THEN
                    Color := 'RED'
                ELSE
                    IF Time_Gap < 37 THEN
                        Color := 'YELLOW';
            END;

            Shortage_Details.RESET;
            Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                           Shortage_Details.Product,
                                           Shortage_Details.Authorisation,
                                           Shortage_Details."Lead Time2",
                                           Shortage_Details."Item No",
                                           Shortage_Details."Planned Date");

            Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
            Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
            Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
            Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA
                                                                       , Shortage_Details.Authorisation::Authorised,
                                                                       Shortage_Details.Authorisation::indent);
            Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '45D');
            Shortage_Details.CALCSUMS(Shortage_Details.Total);
            IF Shortage_Details.Total > 0 THEN
                Rec."45 Days" := FORMAT(ROUND(Shortage_Details.Total));

            IF Rec."45 Days" <> '' THEN BEGIN
                IF Time_Gap < 45 THEN
                    Color := 'RED'
                ELSE
                    IF Time_Gap < 52 THEN
                        Color := 'YELLOW';
            END;

            Shortage_Details.RESET;
            Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                           Shortage_Details.Product,
                                           Shortage_Details.Authorisation,
                                           Shortage_Details."Lead Time2",
                                           Shortage_Details."Item No",
                                           Shortage_Details."Planned Date");

            Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
            Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
            Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
            Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA
                                                                       , Shortage_Details.Authorisation::Authorised,
                                                                       Shortage_Details.Authorisation::indent);
            Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '60D');
            Shortage_Details.CALCSUMS(Shortage_Details.Total);
            IF Shortage_Details.Total > 0 THEN
                Rec."60 Days" := FORMAT(ROUND(Shortage_Details.Total));
            IF Rec."60 Days" <> '' THEN BEGIN
                IF Time_Gap < 60 THEN
                    Color := 'RED'
                ELSE
                    IF Time_Gap < 67 THEN
                        Color := 'YELLOW';
            END;


            Shortage_Details.RESET;
            Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                           Shortage_Details.Product,
                                           Shortage_Details.Authorisation,
                                           Shortage_Details."Lead Time2",
                                           Shortage_Details."Item No",
                                           Shortage_Details."Planned Date");

            Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Rec.Sale_Order);
            Shortage_Details.SETRANGE(Shortage_Details.Product, Rec.Product);
            Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
            Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA
                                                                       , Shortage_Details.Authorisation::Authorised,
                                                                       Shortage_Details.Authorisation::indent);

            Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '90D');
            Shortage_Details.CALCSUMS(Shortage_Details.Total);
            IF Shortage_Details.Total > 0 THEN
                Rec."90 Days" := FORMAT(ROUND(Shortage_Details.Total));
            IF Rec."90 Days" <> '' THEN BEGIN
                IF Time_Gap < 90 THEN
                    Color := 'RED'
                ELSE
                    IF Time_Gap < 97 THEN
                        Color := 'YELLOW';
            END;
        END ELSE BEGIN
            "G\L".GET;
            //  if (Start_Date-("G\L"."Shortage. Calc. Date"+2))>


        END;
        IF (FORMAT(Rec."90 Days") = '') AND (FORMAT(Rec."2 Days") = '') AND (FORMAT(Rec."4 Days") = '') AND (FORMAT(Rec."7 Days") = '')
           AND (FORMAT(Rec."15 Dyas") = '') AND (FORMAT(Rec."21 Days") = '') AND (FORMAT(Rec."25 Dyas") = '') AND
           (FORMAT(Rec."30 Dyas") = '') AND (FORMAT(Rec."45 Days") = '') AND (FORMAT(Rec."60 Days") = '') THEN
            Color := 'GREY';

        //  MESSAGE(FORMAT(Shortage_Details.Total));
        WeekPlan1OnFormat;
        WeekPurchaseValue1OnFormat;
        SaleOrderOnFormat;
        DaysSOnFormat;
    end;

    trigger OnInit();
    begin
        "90 Days_SVisible" := TRUE;
        "60 Days_SVisible" := TRUE;
        "45 Days_SVisible" := TRUE;
        "30 Dyas_SVisible" := TRUE;
        "25 Dyas_SVisible" := TRUE;
        "21 Days_SVisible" := TRUE;
        "15 Dyas_SVisible" := TRUE;
        "7 Days_SVisible" := TRUE;
        "4 Days_SVisible" := TRUE;
        "2 Days_SVisible" := TRUE;
        "90 DaysVisible" := TRUE;
        "60 DaysVisible" := TRUE;
        "45 DaysVisible" := TRUE;
        "30 DyasVisible" := TRUE;
        "25 DyasVisible" := TRUE;
        "21 DaysVisible" := TRUE;
        "15 DyasVisible" := TRUE;
        "7 DaysVisible" := TRUE;
        "4 DaysVisible" := TRUE;
        "2 DaysVisible" := TRUE;
    end;

    trigger OnOpenPage();
    begin
        // "No. Of Week":=1;
        // SETFILTER(Week,'>%1',0);
        "G\L".GET;

        "Production Order".RESET;
        "Production Order".SETCURRENTKEY("Production Order"."Prod Start date");
        "Production Order".SETFILTER("Production Order"."Prod Start date", '>%1', "G\L"."Shortage. Calc. Date");
        IF "Production Order".FINDFIRST THEN
            Production_Strat_Date := "Production Order"."Prod Start date";


        "Production Order".RESET;
        "Production Order".SETCURRENTKEY("Production Order"."Prod Start date");
        "Production Order".SETFILTER("Production Order"."Prod Start date", '>=%1', "G\L"."Shortage. Calc. Date");
        IF "Production Order".FINDLAST THEN
            Production_Ending_Date := "Production Order"."Prod Start date";
        "Total Plan" := Indian_Date(Production_Strat_Date) + '..' + Indian_Date(Production_Ending_Date);

        CalculateWeekPlan;
        IF (USERID = 'EFFTRONICS\PADMAJA') OR (USERID = '07TE024') THEN
            Choice := Choice::Shortage;
        Form_SHow;
    end;

    var
        "Matrix Header": Text[30];
        "Date Filter": Text[30];
        "No. Of Week": Integer;
        Time_Gap: Integer;
        "Production Order": Record "Production Order";
        Start_Date: Date;
        Final_Date: Date;
        "G\L": Record "General Ledger Setup";
        Shortage_Details: Record "Item Lot Numbers";
        Color: Code[10];
        Max_Lead_Time: Text[30];
        Month: Code[10];
        "Overall Production": Integer;
        Production_Strat_Date: Date;
        Production_Ending_Date: Date;
        "Total Plan": Text[30];
        No_Of_Week: Integer;
        Week_Period: Text[50];
        Dum_Sale_Order: Code[30];
        Prd: Code[30];
        wk: Integer;
        WeekPlan: array[11] of Decimal;
        Item: Record Item;
        I: Integer;
        Choice: Option Purchase,Shortage;
        Shortage_Temp: Record "Shortage Temp";
        Week_Purchase_Value: array[10] of Decimal;
        SMAD: Record "Shortage Management Audit Data";
        Week_Start_Date: Date;
        Week_Final_Date: Date;
        [InDataSet]
        "Sale OrderEmphasize": Boolean;
        [InDataSet]
        "2 Days_SEmphasize": Boolean;
        [InDataSet]
        "2 DaysEmphasize": Boolean;
        [InDataSet]
        "4 Days_SEmphasize": Boolean;
        [InDataSet]
        "4 DaysEmphasize": Boolean;
        [InDataSet]
        "7 Days_SEmphasize": Boolean;
        [InDataSet]
        "7 DaysEmphasize": Boolean;
        [InDataSet]
        "15 Dyas_SEmphasize": Boolean;
        [InDataSet]
        "15 DyasEmphasize": Boolean;
        [InDataSet]
        "21 Days_SEmphasize": Boolean;
        [InDataSet]
        "21 DaysEmphasize": Boolean;
        [InDataSet]
        "25 Dyas_SEmphasize": Boolean;
        [InDataSet]
        "25 DyasEmphasize": Boolean;
        [InDataSet]
        "30 Dyas_SEmphasize": Boolean;
        [InDataSet]
        "30 DyasEmphasize": Boolean;
        [InDataSet]
        "45 Days_SEmphasize": Boolean;
        [InDataSet]
        "45 DaysEmphasize": Boolean;
        [InDataSet]
        "60 Days_SEmphasize": Boolean;
        [InDataSet]
        "60 DaysEmphasize": Boolean;
        [InDataSet]
        "90 Days_SEmphasize": Boolean;
        [InDataSet]
        "90 DaysEmphasize": Boolean;
        [InDataSet]
        "2 DaysVisible": Boolean;
        [InDataSet]
        "4 DaysVisible": Boolean;
        [InDataSet]
        "7 DaysVisible": Boolean;
        [InDataSet]
        "15 DyasVisible": Boolean;
        [InDataSet]
        "21 DaysVisible": Boolean;
        [InDataSet]
        "25 DyasVisible": Boolean;
        [InDataSet]
        "30 DyasVisible": Boolean;
        [InDataSet]
        "45 DaysVisible": Boolean;
        [InDataSet]
        "60 DaysVisible": Boolean;
        [InDataSet]
        "90 DaysVisible": Boolean;
        [InDataSet]
        "2 Days_SVisible": Boolean;
        [InDataSet]
        "4 Days_SVisible": Boolean;
        [InDataSet]
        "7 Days_SVisible": Boolean;
        [InDataSet]
        "15 Dyas_SVisible": Boolean;
        [InDataSet]
        "21 Days_SVisible": Boolean;
        [InDataSet]
        "25 Dyas_SVisible": Boolean;
        [InDataSet]
        "30 Dyas_SVisible": Boolean;
        [InDataSet]
        "45 Days_SVisible": Boolean;
        [InDataSet]
        "60 Days_SVisible": Boolean;
        [InDataSet]
        "90 Days_SVisible": Boolean;
        Text19071437: Label 'Total Plan';
        Text19047480: Label 'Problematic';
        Text19013679: Label 'Planned Units';
        Text19056018: Label 'Purchasing Value (Lakhs)';
        Text19047485: Label 'With Out  Buffer No Problem';
        Text19056231: Label 'No Problem';

    
    procedure Indian_Date("Foriegn Date": Date) "Indian Date": Text[30];
    begin
        CASE DATE2DMY("Foriegn Date", 2) OF
            1:
                BEGIN
                    Month := 'JAN';

                END;
            2:
                BEGIN
                    Month := 'FEB';

                END;
            3:
                BEGIN
                    Month := 'MAR';

                END;
            4:
                BEGIN
                    Month := 'APR';

                END;
            5:
                BEGIN
                    Month := 'MAY';

                END;
            6:
                BEGIN
                    Month := 'JUN';

                END;
            7:
                BEGIN
                    Month := 'JUL';

                END;
            8:
                BEGIN
                    Month := 'AUG';

                END;
            9:
                BEGIN
                    Month := 'SEP';

                END;
            10:
                BEGIN
                    Month := 'OCt';

                END;
            11:
                BEGIN
                    Month := 'NOV';

                END;
            12:
                BEGIN
                    Month := 'DEC';

                END;
        END;

        "Indian Date" := FORMAT(DATE2DMY("Foriegn Date", 1)) + '/' + Month + '/' + COPYSTR(FORMAT(DATE2DMY("Foriegn Date", 3)), 3, 2);
    end;


    procedure CalculateWeekPlan();
    begin
        FOR I := 1 TO 10 DO BEGIN
            "Production Order".RESET;
            "Production Order".SETRANGE("Production Order".Week, I);
            IF "Production Order".FINDSET THEN
                REPEAT
                    Item.RESET;
                    IF Item.GET("Production Order"."Source No.") THEN
                        WeekPlan[I] += "Production Order".Quantity * Item."No.of Units";
                UNTIL "Production Order".NEXT = 0;
            SMAD.RESET;
            SMAD.SETRANGE(SMAD.Week, I);
            IF SMAD.FINDSET THEN
                REPEAT
                    "Production Order".RESET;
                    "Production Order".SETCURRENTKEY("Production Order".Week, "Production Order"."Sales Order No.", "Production Order"."Source No.")
                ;
                    "Production Order".SETRANGE("Production Order".Week, SMAD.Week);
                    "Production Order".SETFILTER("Production Order"."Prod Start date", '>%1', ("G\L"."Shortage. Calc. Date"));
                    "Production Order".SETRANGE("Production Order"."Sales Order No.", SMAD.Sale_Order);
                    "Production Order".SETRANGE("Production Order"."Source No.", SMAD.Product);
                    IF "Production Order".FINDFIRST THEN
                        Start_Date := "Production Order"."Prod Start date";

                    "Production Order".RESET;
                    "Production Order".SETCURRENTKEY("Production Order".Week, "Production Order"."Sales Order No.", "Production Order"."Source No.")
                ;
                    "Production Order".SETRANGE("Production Order".Week, SMAD.Week);
                    "Production Order".SETFILTER("Production Order"."Prod Start date", '>%1', ("G\L"."Shortage. Calc. Date"));
                    "Production Order".SETRANGE("Production Order"."Sales Order No.", SMAD.Sale_Order);
                    "Production Order".SETRANGE("Production Order"."Source No.", SMAD.Product);
                    IF "Production Order".FINDLAST THEN
                        Final_Date := "Production Order"."Prod Start date";

                    Shortage_Details.RESET;
                    Shortage_Details.RESET;
                    Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                                   Shortage_Details.Product,
                                                   Shortage_Details.Authorisation,
                                                   Shortage_Details."Lead Time2",
                                                   Shortage_Details."Item No",
                                                   Shortage_Details."Planned Date");
                    Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", SMAD.Sale_Order);
                    Shortage_Details.SETRANGE(Shortage_Details.Product, SMAD.Product);
                    Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
                    Shortage_Details.SETFILTER(Shortage_Details.Authorisation, '%1|%2|%3', Shortage_Details.Authorisation::WFA
                                                                               , Shortage_Details.Authorisation::Authorised,
                                                                               Shortage_Details.Authorisation::indent);
                    Shortage_Details.CALCSUMS(Shortage_Details.Total);
                    // MESSAGE(FORMAT(Shortage_Details.Total));
                    Week_Purchase_Value[I] += Shortage_Details.Total;
                UNTIL SMAD.NEXT = 0;
            Week_Purchase_Value[I] := Week_Purchase_Value[I] / 100000;

        END;
    end;

    procedure Form_SHow();
    begin
        IF Choice = Choice::Purchase THEN BEGIN
            "2 DaysVisible" := TRUE;
            "4 DaysVisible" := TRUE;
            "7 DaysVisible" := TRUE;
            "15 DyasVisible" := TRUE;
            "21 DaysVisible" := TRUE;
            "25 DyasVisible" := TRUE;
            "30 DyasVisible" := TRUE;
            "45 DaysVisible" := TRUE;
            "60 DaysVisible" := TRUE;
            "90 DaysVisible" := TRUE;
            "2 Days_SVisible" := FALSE;
            "4 Days_SVisible" := FALSE;
            "7 Days_SVisible" := FALSE;
            "15 Dyas_SVisible" := FALSE;
            "21 Days_SVisible" := FALSE;
            "25 Dyas_SVisible" := FALSE;
            "30 Dyas_SVisible" := FALSE;
            "45 Days_SVisible" := FALSE;
            "60 Days_SVisible" := FALSE;
            "90 Days_SVisible" := FALSE;
        END ELSE BEGIN
            "2 DaysVisible" := FALSE;
            "4 DaysVisible" := FALSE;
            "7 DaysVisible" := FALSE;
            "15 DyasVisible" := FALSE;
            "21 DaysVisible" := FALSE;
            "25 DyasVisible" := FALSE;
            "30 DyasVisible" := FALSE;
            "45 DaysVisible" := FALSE;
            "60 DaysVisible" := FALSE;
            "90 DaysVisible" := FALSE;
            "2 Days_SVisible" := TRUE;
            "4 Days_SVisible" := TRUE;
            "7 Days_SVisible" := TRUE;
            "15 Dyas_SVisible" := TRUE;
            "21 Days_SVisible" := TRUE;
            "25 Dyas_SVisible" := TRUE;
            "30 Dyas_SVisible" := TRUE;
            "45 Days_SVisible" := TRUE;
            "60 Days_SVisible" := TRUE;
            "90 Days_SVisible" := TRUE;
        END;
    end;


    local procedure PurchaseChoiceOnPush();
    begin
        Form_SHow;
    end;


    local procedure ShortageChoiceOnPush();
    begin
        Form_SHow;
    end;

    
    local procedure WeekPlan1OnFormat();
    begin
        IF WeekPlan[1] > 42 THEN;
    end;


    local procedure WeekPurchaseValue1OnFormat();
    begin
        IF WeekPlan[1] > 42 THEN;
    end;

    
    local procedure SaleOrderOnFormat();
    begin
        IF Choice = Choice::Purchase THEN BEGIN
            IF Color = 'RED' THEN BEGIN
                "Sale OrderEmphasize" := TRUE;
            END ELSE
                IF Color = 'YELLOW' THEN BEGIN
                    "Sale OrderEmphasize" := TRUE;
                END ELSE
                    IF Color = 'GREY' THEN BEGIN
                        "Sale OrderEmphasize" := TRUE;

                    END ELSE BEGIN
                        "Sale OrderEmphasize" := TRUE;
                    END;
        END ELSE BEGIN
            IF Rec."90 Days_S" <> '' THEN BEGIN
                IF (Start_Date - "G\L"."Shortage. Calc. Date") <= 90 THEN BEGIN
                    "Sale OrderEmphasize" := TRUE;
                END ELSE
                    IF (Start_Date - "G\L"."Shortage. Calc. Date") < 97 THEN BEGIN
                        "Sale OrderEmphasize" := TRUE;
                    END ELSE
                        IF (Start_Date - "G\L"."Shortage. Calc. Date") = 97 THEN BEGIN
                            "Sale OrderEmphasize" := TRUE;
                        END ELSE BEGIN
                            "Sale OrderEmphasize" := TRUE;
                        END;

            END ELSE
                IF Rec."60 Days_S" <> '' THEN BEGIN
                    IF (Start_Date - "G\L"."Shortage. Calc. Date") <= 60 THEN BEGIN
                        "Sale OrderEmphasize" := TRUE;
                    END ELSE
                        IF (Start_Date - "G\L"."Shortage. Calc. Date") < 67 THEN BEGIN
                            "Sale OrderEmphasize" := TRUE;
                        END ELSE
                            IF (Start_Date - "G\L"."Shortage. Calc. Date") = 67 THEN BEGIN
                                "Sale OrderEmphasize" := TRUE;
                            END ELSE BEGIN
                                "Sale OrderEmphasize" := TRUE;
                            END;

                END ELSE
                    IF Rec."45 Days_S" <> '' THEN BEGIN
                        IF (Start_Date - "G\L"."Shortage. Calc. Date") <= 45 THEN BEGIN
                            "Sale OrderEmphasize" := TRUE;
                        END ELSE
                            IF (Start_Date - "G\L"."Shortage. Calc. Date") < 52 THEN BEGIN
                                "Sale OrderEmphasize" := TRUE;
                            END ELSE
                                IF (Start_Date - "G\L"."Shortage. Calc. Date") = 52 THEN BEGIN
                                    "Sale OrderEmphasize" := TRUE;
                                END ELSE BEGIN
                                    "Sale OrderEmphasize" := TRUE;
                                END;

                    END ELSE
                        IF Rec."30 Dyas_S" <> '' THEN BEGIN
                            IF (Start_Date - "G\L"."Shortage. Calc. Date") <= 30 THEN BEGIN
                                "Sale OrderEmphasize" := TRUE;
                            END ELSE
                                IF (Start_Date - "G\L"."Shortage. Calc. Date") < 37 THEN BEGIN
                                    "Sale OrderEmphasize" := TRUE;
                                END ELSE
                                    IF (Start_Date - "G\L"."Shortage. Calc. Date") = 37 THEN BEGIN
                                        "Sale OrderEmphasize" := TRUE;
                                    END ELSE BEGIN
                                        "Sale OrderEmphasize" := TRUE;
                                    END;

                        END ELSE
                            IF Rec."25 Dyas_S" <> '' THEN BEGIN
                                IF (Start_Date - "G\L"."Shortage. Calc. Date") <= 25 THEN BEGIN
                                    "Sale OrderEmphasize" := TRUE;
                                END ELSE
                                    IF (Start_Date - "G\L"."Shortage. Calc. Date") < 32 THEN BEGIN
                                        "Sale OrderEmphasize" := TRUE;
                                    END ELSE
                                        IF (Start_Date - "G\L"."Shortage. Calc. Date") = 32 THEN BEGIN
                                            "Sale OrderEmphasize" := TRUE;
                                        END ELSE BEGIN
                                            "Sale OrderEmphasize" := TRUE;
                                        END;

                            END ELSE
                                IF Rec."21 Days_S" <> '' THEN BEGIN
                                    IF (Start_Date - "G\L"."Shortage. Calc. Date") <= 21 THEN BEGIN
                                        "Sale OrderEmphasize" := TRUE;
                                    END ELSE
                                        IF (Start_Date - "G\L"."Shortage. Calc. Date") < 28 THEN BEGIN
                                            "Sale OrderEmphasize" := TRUE;
                                        END ELSE
                                            IF (Start_Date - "G\L"."Shortage. Calc. Date") = 28 THEN BEGIN
                                                "Sale OrderEmphasize" := TRUE;
                                            END ELSE BEGIN
                                                "Sale OrderEmphasize" := TRUE;
                                            END;

                                END ELSE
                                    IF Rec."15 Dyas_S" <> '' THEN BEGIN
                                        IF (Start_Date - "G\L"."Shortage. Calc. Date") <= 15 THEN BEGIN
                                            "Sale OrderEmphasize" := TRUE;
                                        END ELSE
                                            IF (Start_Date - "G\L"."Shortage. Calc. Date") < 22 THEN BEGIN
                                                "Sale OrderEmphasize" := TRUE;
                                            END ELSE
                                                IF (Start_Date - "G\L"."Shortage. Calc. Date") = 22 THEN BEGIN
                                                    "Sale OrderEmphasize" := TRUE;
                                                END ELSE BEGIN
                                                    "Sale OrderEmphasize" := TRUE;
                                                END;

                                    END ELSE
                                        IF Rec."7 Days_S" <> '' THEN BEGIN
                                            IF (Start_Date - "G\L"."Shortage. Calc. Date") <= 7 THEN BEGIN
                                                "Sale OrderEmphasize" := TRUE;
                                            END ELSE
                                                IF (Start_Date - "G\L"."Shortage. Calc. Date") < 14 THEN BEGIN
                                                    "Sale OrderEmphasize" := TRUE;
                                                END ELSE
                                                    IF (Start_Date - "G\L"."Shortage. Calc. Date") = 14 THEN BEGIN
                                                        "Sale OrderEmphasize" := TRUE;
                                                    END ELSE BEGIN
                                                        "Sale OrderEmphasize" := TRUE;
                                                    END;

                                        END ELSE
                                            IF Rec."4 Days_S" <> '' THEN BEGIN
                                                IF (Start_Date - "G\L"."Shortage. Calc. Date") <= 4 THEN BEGIN
                                                    "Sale OrderEmphasize" := TRUE;
                                                END ELSE
                                                    IF (Start_Date - "G\L"."Shortage. Calc. Date") < 11 THEN BEGIN
                                                        "Sale OrderEmphasize" := TRUE;
                                                    END ELSE
                                                        IF (Start_Date - "G\L"."Shortage. Calc. Date") = 11 THEN BEGIN
                                                            "Sale OrderEmphasize" := TRUE;
                                                        END ELSE BEGIN
                                                            "Sale OrderEmphasize" := TRUE;
                                                        END;

                                            END ELSE
                                                IF Rec."2 Days_S" <> '' THEN BEGIN
                                                    IF (Start_Date - "G\L"."Shortage. Calc. Date") <= 2 THEN BEGIN
                                                        "Sale OrderEmphasize" := TRUE;
                                                    END ELSE
                                                        IF (Start_Date - "G\L"."Shortage. Calc. Date") < 9 THEN BEGIN
                                                            "Sale OrderEmphasize" := TRUE;
                                                        END ELSE
                                                            IF (Start_Date - "G\L"."Shortage. Calc. Date") = 9 THEN BEGIN
                                                                "Sale OrderEmphasize" := TRUE;
                                                            END ELSE BEGIN
                                                                "Sale OrderEmphasize" := TRUE;
                                                            END;

                                                END;
        END;
    end;

    
    local procedure DaysSOnFormat();
    begin

        "G\L".GET;
        IF (Start_Date - "G\L"."Shortage. Calc. Date") <= 2 THEN BEGIN
            "2 Days_SEmphasize" := TRUE;
        END ELSE
            IF (Start_Date - "G\L"."Shortage. Calc. Date") < 9 THEN BEGIN
                "2 Days_SEmphasize" := TRUE;
            END ELSE
                IF (Start_Date - "G\L"."Shortage. Calc. Date") = 9 THEN BEGIN
                    "2 Days_SEmphasize" := TRUE;

                END ELSE BEGIN
                    "2 Days_SEmphasize" := TRUE;

                END;
    end;

    
    local procedure PurchaseChoiceOnValidate();
    begin
        PurchaseChoiceOnPush;
    end;


    local procedure ShortageChoiceOnValidate();
    begin
        ShortageChoiceOnPush;
    end;
}

