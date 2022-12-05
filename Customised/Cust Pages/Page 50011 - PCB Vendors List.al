page 50011 "PCB Vendors List"
{
    PageType = List;
    Permissions =;
    SourceTable = "PCB Vendors";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("No. of Sides"; Rec."No. of Sides")
                {
                    ApplicationArea = All;
                }
                field("PCB Thickness"; Rec."PCB Thickness")
                {
                    ApplicationArea = All;
                }
                field("Copper Clad Thickness"; Rec."Copper Clad Thickness")
                {
                    ApplicationArea = All;
                }
                field("Min PCB Qty"; Rec."Min PCB Qty")
                {
                    ApplicationArea = All;
                }
                field("Max PCB Qty"; Rec."Max PCB Qty")
                {
                    ApplicationArea = All;
                }
                field("Min PCB Area"; Rec."Min PCB Area")
                {
                    ApplicationArea = All;
                }
                field("Max PCB Area"; Rec."Max PCB Area")
                {
                    ApplicationArea = All;
                }
                field("Price per Sq.m"; Rec."Price per Sq.m")
                {
                    ApplicationArea = All;
                }
                field("Fast Price"; Rec."Fast Price")
                {
                    ApplicationArea = All;
                }
                field("Super Fast Price"; Rec."Super Fast Price")
                {
                    ApplicationArea = All;
                }
                field("Fast Lead Time"; Rec."Fast Lead Time")
                {
                    ApplicationArea = All;
                }
                field("Super Fast Lead Time"; Rec."Super Fast Lead Time")
                {
                    ApplicationArea = All;
                }
                field("Quotation Date"; Rec."Quotation Date")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(White; Rec.White)
                {
                    ApplicationArea = All;
                }
                field(Green; Rec.Green)
                {
                    ApplicationArea = All;
                }
                field(Black; Rec.Black)
                {
                    ApplicationArea = All;
                }
                field(Blue; Rec.Blue)
                {
                    ApplicationArea = All;
                }
            }
            group(Control1102152023)
            {
                ShowCaption = false;
                field("Total Items"; xRec.COUNT)
                {
                    Caption = 'Total Items';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean;
    begin
         IF NOT (USERID IN ['EFFTRONICS\PRANAVI','EFFTRONICS\JHANSI','EFFTRONICS\SUVARCHALADEVI']) THEN
                       ERROR('You do not right to delete!');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
         IF NOT (USERID IN ['EFFTRONICS\PRANAVI','EFFTRONICS\JHANSI','EFFTRONICS\VANIDEVI','EFFTRONICS\RENUKACH','EFFTRONICS\SUVARCHALADEVI']) THEN
                       ERROR('You do not right to insert!');
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        IF NOT (USERID IN ['EFFTRONICS\PRANAVI','EFFTRONICS\JHANSI','EFFTRONICS\VANIDEVI','EFFTRONICS\RENUKACH','EFFTRONICS\SUVARCHALADEVI']) THEN
                       ERROR('You do not right to modify!');
    end;
}

